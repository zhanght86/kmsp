/**
 * 
 */
package com.yonyou.kms.modules.sys.service;

import java.net.URL;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.rpc.ServiceException;

import nc.itf.kms.ISynchroNCInfo.ISynchroNCInfoLocator;
import nc.itf.kms.ISynchroNCInfo.ISynchroNCInfoPortType;
import nc.vo.kms.entity.NCOffice;
import nc.vo.kms.entityN.OuterSystemRetVO;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.yonyou.kms.common.service.TreeService;
import com.yonyou.kms.common.utils.IdGen;
import com.yonyou.kms.modules.sys.dao.OfficeDao;
import com.yonyou.kms.modules.sys.dao.StatusDao;
import com.yonyou.kms.modules.sys.entity.Area;
import com.yonyou.kms.modules.sys.entity.ECompany;
import com.yonyou.kms.modules.sys.entity.EOffice;
import com.yonyou.kms.modules.sys.entity.Office;
import com.yonyou.kms.modules.sys.entity.Status;
import com.yonyou.kms.modules.sys.entity.User;
import com.yonyou.kms.modules.sys.utils.SynchroNCUtil;
import com.yonyou.kms.modules.sys.utils.UserUtils;

/**
 * 机构Service
 * 
 * @author hotsum
 * @version 2014-05-16
 */
@Service
public class OfficeService extends TreeService<OfficeDao, Office> {

	/**
	 * 数据正常
	 */
	public static String DATA_NORMAL = "0";

	/**
	 * 数据异常
	 */
	public static String DATA_EXCEPTION = "1";

	/**
	 * 数据为空
	 */
	public static String DATA_NULL = "2";
	
	//excel中三种操作进行
	public static String DEL_OFFCIE="删除";
	public static String UPDATE_OFFCIE="更新";
	public static String SIMPLE_OFFCIE="不变";
	
	@Autowired
	private StatusDao statusDao;
	//注入数据源
	@Value("${nc.datasource}")
	private String dataSource;
	//nc远程连接口的信息
	@Value("${nc.romateService}")
	private String romateService;

	public List<Office> findAll() {
		return UserUtils.getOfficeList();
	}

	public List<Office> findList(Boolean isAll) {
		if (isAll != null && isAll) {
			return UserUtils.getOfficeAllList();
		} else {
			return UserUtils.getOfficeList();
		}
	}

	@Override
	@Transactional(readOnly = true)
	public List<Office> findList(Office office) {
		office.setParentIds(office.getParentIds() + "%");
		return dao.findByParentIdsLike(office);
	}

	@Override
	@Transactional(readOnly = false)
	public String save(Office office) {
		super.save(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
		return "";
	}

	@Override
	@Transactional(readOnly = false)
	public void delete(Office office) {
		super.delete(office);
		UserUtils.removeCache(UserUtils.CACHE_OFFICE_LIST);
	}

	@Transactional(readOnly = false)
	public void synchroNCInfo() throws ServiceException {
		Gson gson = new Gson();
		Logger logger = LoggerFactory.getLogger(getClass());

		try {
			/** ************获取同步记录表数据(用于判断是否第一次同步)************** */
			String maxTs = statusDao.selectStatus("ORG_GROUP");
			// 存储key:机构id // value:机构的所有parentId
			Map<String, String> relations = new HashMap<String, String>();

			List<Office> addOfficeList = new ArrayList<Office>();
			List<Office> updateOfficeList = new ArrayList<Office>();
			List<Status> statusList = new ArrayList<Status>();
			
			//集团同步记录
			Status groupStatus = null;
			//业务单元同步记录
			Status orgStatus = null;
			//部门同步记录
			Status deptStatus = null;
			//连接nc远程服务   调取数据
			ISynchroNCInfoLocator service = new ISynchroNCInfoLocator();
			URL url=new URL(romateService);
			if (StringUtils.isEmpty(maxTs)) {// 第一次同步，所取数据为新增的数据
				Office office = null;
				Office parent = null;
				NCOffice ncOffice = null;
				
				ISynchroNCInfoPortType client =service.getISynchroNCInfoSOAP11port_http(url);
				/** *******************获取NC集团************** */
				//ISynchroNCInfoPortType client = service.getISynchroNCInfoSOAP11port_http();
				OuterSystemRetVO group = client.getNCGroupInfo(dataSource,"");//调用接口getNCGroupInfo获得数据
				logger.debug("============结束调用NC远程接口,返回GROUP数据" + group.getData()
						+ "========================");
				List<NCOffice> groupAddList = new ArrayList<NCOffice>();
				// 调用接口成功且数据正常
				if ((group.isSuccess())
						&& (DATA_NORMAL.equals(group.getDataState()))) {//判断取得数据的状态
					// 获取传过来的集团数据
					groupAddList = gson.fromJson(group.getData(),
							new TypeToken<List<NCOffice>>() {
							}.getType());
					// 将NC集团数据转换成Office并设置父子关系
					ncOffice2Office(groupAddList, addOfficeList, relations);
					//记录同步时间
					groupStatus = new Status();
					groupStatus.setId(IdGen.uuid());
					groupStatus.setTs(group.getMaxTs());//获得数据中的最大时间
					groupStatus.setFromSys("ORG_GROUP");//"设置从ORG_GROUP这个表获得的数据"
				} else {
					return;
				}

				/** *************获取NC业务单元************** */
				OuterSystemRetVO org = client.getNCOrgInfo(dataSource,"");
				logger.debug("============结束调用NC远程接口,返回ORG数据:" + org.getData()
						+ "========================");
				List<NCOffice> orgAddList = new ArrayList<NCOffice>();
				// 调用接口成功且数据正常
				if ((org.isSuccess())
						&& (DATA_NORMAL.equals(org.getDataState()))) {
					// 获取传过来的业务数据
					orgAddList = gson.fromJson(org.getData(),
							new TypeToken<List<NCOffice>>() {
							}.getType());

					// 将NC业务单元数据转换成Office
					ncOffice2Office(orgAddList, addOfficeList, relations);
					//记录同步时间
					orgStatus = new Status();
					orgStatus.setId(""+System.currentTimeMillis()+Math.random());
					orgStatus.setTs(org.getMaxTs());
					orgStatus.setFromSys("ORG_ORGS");
				} else {
					return;
				}

				/** *************获取NC部门************** */
				//String maxTsDept = statusDao.selectStatus("org_dept");
				OuterSystemRetVO dept = client.getNCDeptInfo(dataSource,"");
				logger.debug("============结束调用NC远程接口,返回DEPT数据:" + dept.getData()
						+ "========================");
				List<NCOffice> deptAddList = new ArrayList<NCOffice>();
				// 调用接口成功且数据正常
				if ((dept.isSuccess())
						&& (DATA_NORMAL.equals(dept.getDataState()))) {
					// 获取传过来的部门数据
					deptAddList = gson.fromJson(dept.getData(),
							new TypeToken<List<NCOffice>>() {
							}.getType());

					// 将NC部门数据转换成Office
					ncOffice2Office(deptAddList, addOfficeList, relations);
					//记录同步时间
					deptStatus = new Status();
					deptStatus.setId(System.currentTimeMillis()+Math.random()+"");
					deptStatus.setTs(dept.getMaxTs());
					deptStatus.setFromSys("ORG_DEPT");
				}

			} else {
				// 第N次同步，所取数据为两种：新增的数据、修改的数据
				/** ************获取知识库所有机构数据************** */
				List<Office> allOffice = dao.findAll();//从数据库中找出所有数据

				/** ************获取office父子关系************** */
				Map<String, Office> officeRelation = new HashMap<String, Office>();
				for (int i = 0; i < allOffice.size(); i++) {
					relations.put(allOffice.get(i).getId(), allOffice.get(i)
							.getParentIds());//key id;value pid
					officeRelation.put(allOffice.get(i).getId(), allOffice
							.get(i));//key  id;vlaue 这条数据
				}

				/** *******************获取NC集团************** **/
				
				//获取上次同步记录
				
				ISynchroNCInfoPortType client =service.getISynchroNCInfoSOAP11port_http(url);
				//ISynchroNCInfoLocator service = new ISynchroNCInfoLocator();
				//ISynchroNCInfoPortType client = service.getISynchroNCInfoSOAP11port_http();
				String groupTs =statusDao.selectStatus("ORG_GROUP");
				OuterSystemRetVO group =client.getNCGroupInfo(dataSource,groupTs); ;//调用接口getNCGroupInfo
				List<NCOffice> groupList = new ArrayList<NCOffice>();
				logger.debug("============结束调用NC远程接口,返回ORG_GROUP数据:" + group.getData()
						+ "========================");
				// 调用接口成功且数据正常
				if ((group.isSuccess())
						&& (DATA_NORMAL.equals(group.getDataState()))) {
					// 获取传过来的集团数据
					groupList = gson.fromJson(group.getData(),
							new TypeToken<List<NCOffice>>() {
							}.getType());

					// 将NC集团数据转换成Office
					ncOffice2Office(groupList, addOfficeList, updateOfficeList,
							relations, officeRelation);
					//记录同步时间
					deptStatus = new Status();
					deptStatus.setId(System.currentTimeMillis()+Math.random()+"");
					deptStatus.setTs(group.getMaxTs());
					deptStatus.setFromSys("ORG_GROUP");
				}

				/** *******************获取业务单元************** */
				String orgTs=statusDao.selectStatus("ORG_ORGS");
				OuterSystemRetVO org = client.getNCOrgInfo(dataSource,orgTs);
				List<NCOffice> orgList = new ArrayList<NCOffice>();
				logger.debug("============结束调用NC远程接口,返回ORG_ORGS数据:" + org.getData()
						+ "========================");
				// 调用接口成功且数据正常
				if ((org.isSuccess())
						&& (DATA_NORMAL.equals(org.getDataState()))) {
					// 获取传过来的业务单元数据
					orgList = gson.fromJson(org.getData(),
							new TypeToken<List<NCOffice>>() {
							}.getType());

					// 将NC业务单元数据转换成Office
					ncOffice2Office(orgList, addOfficeList, updateOfficeList,
							relations, officeRelation);
					//记录同步时间
					deptStatus = new Status();
					deptStatus.setId(System.currentTimeMillis()+Math.random()+"");
					deptStatus.setTs(org.getMaxTs());
					deptStatus.setFromSys("ORG_ORGS");
				}

				/** *******************获取部门************** */
				String deptTs=statusDao.selectStatus("ORG_DEPT");
				OuterSystemRetVO dept = client.getNCDeptInfo(dataSource,deptTs);
				List<NCOffice> deptList = new ArrayList<NCOffice>();
				logger.debug("============结束调用NC远程接口,返回DEPT数据:" + dept.getData()
						+ "========================");
				// 调用接口成功且数据正常
				if ((dept.isSuccess())
						&& (DATA_NORMAL.equals(dept.getDataState()))) {
					// 获取传过来的业务单元数据
					deptList = gson.fromJson(org.getData(),
							new TypeToken<List<NCOffice>>() {
							}.getType());

					// 将NC业务单元数据转换成Office
					ncOffice2Office(deptList, addOfficeList, updateOfficeList,
							relations, officeRelation);
					//记录同步时间
					deptStatus = new Status();
					deptStatus.setId(System.currentTimeMillis()+Math.random()+"");
					deptStatus.setTs(dept.getMaxTs());
					deptStatus.setFromSys("ORG_DEPT");
				}

			}

			/** ************组织新增数据的parent_ids************** */
			Map<String, String> newRelations = new HashMap<String, String>(); // 存储key:机构id
			// value:机构的所有parentIds","分割
			String parentIds = "";

			for (Office temp : addOfficeList) {
				parentIds = SynchroNCUtil.getParentIds(temp.getParentId(),
						relations);
				temp.setParentIds(parentIds);
				newRelations.put(temp.getId(), parentIds);
			}
			
			/** ************NC同步过来的数据保存************** */
			if((addOfficeList != null) && (!addOfficeList.isEmpty())){
				//调用Office批量插入接口
				dao.batchInsert(addOfficeList);
			}
			
			if((updateOfficeList != null) && (!updateOfficeList.isEmpty())){
				//调用Office批量更新接口
				//dao.batchUpdate(updateOfficeList);
				for(Office office:updateOfficeList){
					dao.update(office);
				}
			}
			
			
			
			/** ************保存同步记录************** */

			//保存状态
			if(groupStatus!=null){statusList.add(groupStatus);}
			if(deptStatus!=null){statusList.add(deptStatus);}
			if(orgStatus!=null){statusList.add(orgStatus);}
			if(!statusList.isEmpty()){
				statusDao.batchInsert(statusList);
			}
			
			//以下代码不要
//			ISynchroNCInfoLocator service = new ISynchroNCInfoLocator();
//			ISynchroNCInfoPortType client = service
//					.getISynchroNCInfoSOAP11port_http();
//			logger
//					.debug("============开始调用NC远程接口：getNCOrgInfo()========================");
//			//OrgInfo[] orgs = (OrgInfo[]) client.getNCOrgInfo("design");
//			//logger.debug("============结束调用NC远程接口,返回数据size:" + orgs.length
//					+ "========================");
//			//end

		} catch (RemoteException e) {
			logger.error("调用NC远程接口getNCOrgInfo()失败");
			throw new ServiceException("调用NC远程接口getNCOrgInfo()失败:"
					+ e.getStackTrace());
		} catch (ServiceException e) {
			logger
					.error("获取远程接口失败:ISynchroNCInfoPortType client = service.getISynchroNCInfoSOAP11port_http()");
			throw new ServiceException(
					"获取远程接口失败:ISynchroNCInfoPortType client = service.getISynchroNCInfoSOAP11port_http():"
							+ e.getStackTrace());
		}catch(Exception e){
			 e.printStackTrace();
		}

	}

	/**
	 * * 获取新增数据
	 * 
	 * @param ncOfficeList
	 *            来源NC端的数据
	 * @param officeList
	 *            新增的机构
	 * @param relations
	 */
	private void ncOffice2Office(List<NCOffice> ncOfficeList,
			List<Office> officeList, Map<String, String> relations) {
		Office office = null;
		Office parent = null;
		NCOffice ncOffice = null;

		for (int i = 0; i < ncOfficeList.size(); i++) {

			ncOffice = ncOfficeList.get(i);
			office = new Office();
			office.setId(ncOffice.getId());

			parent = new Office();
			parent.setId(ncOffice.getParent_id());
			office.setParent(parent);

			office.setCode(ncOffice.getCode());
			office.setName(ncOffice.getName());

			office.setParentIds(ncOffice.getParent_id());
			office.setSort(10);

			Area area = new Area();
			area.setId("1");
		office
			.setUseable("2".equals(ncOffice.getUseable()) ? "1"
					: "0");
			office.setArea(area);
			office.setType("1");
			office.setGrade("1");
			office.setCreateBy(UserUtils.getUser());
			office.setCreateDate(new Date());
			office.setUpdateBy(UserUtils.getUser());
			office.setUpdateDate(new Date());

			// 设置在上下级关系
			relations.put(office.getId(), ncOffice.getParent_id());//
			officeList.add(office);
		}
	}

	/**
	 * 获取新增、修改Office数据
	 * 
	 * @param ncOfficeList
	 *            来源NC端的数据
	 * @param addOfficeList
	 *            新增的机构
	 * @param updateOfficeList
	 *            更新的机构
	 * @param relations
	 * @param officeRelation
	 */
	private void ncOffice2Office(List<NCOffice> ncOfficeList,
			List<Office> addOfficeList, List<Office> updateOfficeList,
			Map<String, String> relations, Map<String, Office> officeRelation) {// nc传过来的集团信息，新增到知识库的信息，修改的信息，父子关系，知识库关系
		Office office = null;
		Office parent = null;
		NCOffice ncOffice = null;

		for (int i = 0; i < ncOfficeList.size(); i++) {

			ncOffice = ncOfficeList.get(i);

			// 判断数据是新增还是更新
			if (officeRelation.containsKey(ncOffice.getId())) {// 更新的数据
				office = officeRelation.get(ncOffice.getId());

				office.setCode(ncOffice.getCode());
				office.setName(ncOffice.getName());
				office.setDelFlag(ncOffice.getDel_flag());
				office
						.setUseable("2".equals(ncOffice.getUseable()) ? "1"
								: "0");

				updateOfficeList.add(office);
			} else {// 新增的数据
				office = new Office();
				office.setId(ncOffice.getId());

				parent = new Office();
				parent.setId(ncOffice.getParent_id());
				office.setParent(parent);

				office.setCode(ncOffice.getCode());
				office.setName(ncOffice.getName());

				office.setParentIds(ncOffice.getParent_id());
				office.setSort(10);

				Area area = new Area();
				area.setId("1");

				office.setArea(area);
				office.setType("1");
				office.setGrade("1");
				office.setCreateBy(UserUtils.getUser());
				office.setCreateDate(new Date());
				office.setUpdateBy(UserUtils.getUser());
				office.setUpdateDate(new Date());
				office.setDelFlag(ncOffice.getDel_flag());
				office
						.setUseable("2".equals(ncOffice.getUseable()) ? "1"
								: "0");
				// 设置在上下级关系
				relations.put(office.getId(), ncOffice.getParent_id());
				addOfficeList.add(office);
			}

		}
	}
	/**
	 * 将
	 * @param comapnys excel中的公司
	 * @param offices  excel中的部门
	 * @return
	 */
	@Transactional(readOnly = false)
	public List<Office> EOffice2Office(List<ECompany> companys,List<EOffice> offices){
		// 存储key:机构id // value:机构的所有parentId
		Map<String, String> relations = new HashMap<String, String>();
		User currentUser=UserUtils.getUser();
		List<Office> addOffice=Lists.newArrayList();
		List<Office> updateOffice=Lists.newArrayList();
		List<Office> failOffice=Lists.newArrayList();
		List<Office> allOffice = dao.findAll();//从数据库中找出所有数据

		/** ************获取office父子关系************** */
		for (int i = 0; i < allOffice.size(); i++) {
			relations.put(allOffice.get(i).getId(), allOffice.get(i)
					.getParentIds());//key id;value pid
		}
		
		//1.操作公司
		for(ECompany e:companys){
			
			Office o=dao.get(e.getId());
			
			if(UPDATE_OFFCIE.equals(e.getOpertaion())){
				
				//如果数据库中存在的话  那么是更新操作
				if(o!=null){
					o=changeCompany(e,o);
					o.setUpdateBy(currentUser);
					o.setUpdateDate(new Date());
					o.setDelFlag("0");
					updateOffice.add(o);
					relations.put(o.getId(),e.getParentId());
				}else{
					//没有的话 就是更新操作
					o=new Office();
					o=changeCompany(e,o);
					o.setCreateBy(currentUser);
					o.setCreateDate(new Date());
					o.setUpdateBy(currentUser);
					o.setUpdateDate(new Date());
					Area a=new Area();
					a.setId("1");
					o.setArea(a);
					o.setDelFlag("0");
					o.setGrade("1");
					o.setCode("111");
					o.setSort(10);
					o.setType("1");
					o.setUseable("1");
					addOffice.add(o);
					//将上下级关系加入到其中 
					relations.put(o.getId(),e.getParentId());
				}
			}
			//是删除的时候
			if(DEL_OFFCIE.equals(e.getOpertaion())){
				if(o==null){
					//如果删除的那个机构为空 那么加入到错误操作列表
					Office temp=new Office();
					temp.setName(e.getName());
					failOffice.add(temp);continue;
				}
				//删除
				dao.delete(o);
			}
			
		}
		//2.操作部门
		for(EOffice e1:offices){
			Office o=dao.get(e1.getId());
			if(UPDATE_OFFCIE.equals(e1.getOpertaion())){
				
				//如果数据库中存在的话  那么是更新操作
				if(o!=null){
					o=changeOffice(e1,o);
					o.setUpdateBy(currentUser);
					o.setUpdateDate(new Date());
					o.setDelFlag("0");
					updateOffice.add(o);
					relations.put(o.getId(),e1.getParentId());
				}else{
					//没有的话 就是更新操作
					Office o2=new Office();
					Office o1=changeOffice(e1,o2);
					o1.setCreateBy(currentUser);
					o1.setCreateDate(new Date());
					o1.setUpdateBy(currentUser);
					o1.setUpdateDate(new Date());
					Area a=new Area();
					a.setId("1");
					o1.setArea(a);
					o1.setDelFlag("0");
					o1.setGrade("1");
					o1.setCode("111");
					o1.setType("2");
					o1.setSort(10);
					o1.setUseable("1");
					addOffice.add(o1);
					relations.put(o1.getId(),e1.getParentId());
				}
			}
			//是删除的时候
			if(DEL_OFFCIE.equals(e1.getOpertaion())){
				if(o==null){
					//如果删除的那个机构为空 那么加入到错误操作列表
					Office temp=new Office();
					temp.setName(e1.getName());
					failOffice.add(temp);continue;
				}
				//删除
				dao.delete(o);
			}
		}
		
		/** ************组织新增数据的parent_ids************** */
		Map<String, String> newRelations = new HashMap<String, String>(); // 存储key:机构id
		// value:机构的所有parentIds","分割
		String parentIds = "";

		for (Office temp : addOffice) {
			parentIds = SynchroNCUtil.getParentIds(temp.getParentId(),
					relations);
			temp.setParentIds(parentIds);
			newRelations.put(temp.getId(), parentIds);
		}
		if((addOffice != null) && (!addOffice.isEmpty())){
			//调用Office批量插入接口
			//dao.batchInsert(addOffice);
			for(Office o:addOffice){
				dao.insert(o);
			}
		}
		
		for(Office office:updateOffice){
			dao.update(office);
		}
		
		return failOffice;
	}
	
	
	
	//同步公司的数据
	private Office changeCompany(ECompany e,Office o){
		o.setId(e.getId());
		o.setName(e.getName());
		
		Office temp=new Office();
		temp.setId(e.getParentId());
		o.setParent(temp);
		if(e.getRemark()!=null){
			o.setRemarks(e.getRemark());
		}
		return o;
	}
	//同步部门的数据
	private Office changeOffice(EOffice e,Office o){
		o.setId(e.getId());
		o.setName(e.getName());
		
		Office temp=new Office();
		temp.setId(e.getParentId());
		o.setParent(temp);
		if(e.getRemark()!=null){
			o.setRemarks(e.getRemark());
		}	
		return o;
	}
	
}
