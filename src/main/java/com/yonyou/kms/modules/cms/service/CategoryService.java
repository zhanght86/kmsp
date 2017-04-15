/**
 * 
 */
package com.yonyou.kms.modules.cms.service;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.yonyou.kms.common.config.Global;
import com.yonyou.kms.common.persistence.Page;
import com.yonyou.kms.common.service.TreeService;
import com.yonyou.kms.modules.cms.dao.ArticleDao;
import com.yonyou.kms.modules.cms.dao.CategoryDao;
import com.yonyou.kms.modules.cms.entity.Article;
import com.yonyou.kms.modules.cms.entity.Category;
import com.yonyou.kms.modules.cms.entity.RoleCategory;
import com.yonyou.kms.modules.cms.entity.Site;
import com.yonyou.kms.modules.cms.entity.UserCategory;
import com.yonyou.kms.modules.cms.utils.CmsUtils;
import com.yonyou.kms.modules.sys.dao.OfficeDao;
import com.yonyou.kms.modules.sys.dao.RoleDao;
import com.yonyou.kms.modules.sys.dao.UserDao;
import com.yonyou.kms.modules.sys.entity.Office;
import com.yonyou.kms.modules.sys.entity.Role;
import com.yonyou.kms.modules.sys.entity.User;
import com.yonyou.kms.modules.sys.utils.UserUtils;

/**
 * 栏目Service
 * @author hotsum
 * @version 2013-5-31
 */
@Service
@Transactional(readOnly = true)
public class CategoryService extends TreeService<CategoryDao, Category> {

	public static final String CACHE_CATEGORY_LIST = "categoryList";
	@Autowired
	private CategoryDao categorydao;
	private Category entity = new Category();
	@Autowired
	private ArticleDao articleDao;
	@Autowired
	private ArticleCountService articlecountService;
	@Autowired
	private OfficeDao officeDao;
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private RoleDao roleDao;
	
	/**
	 * 
	 * @param isCurrentSite  true
	 * @param module article 
	 * @param place 表示在哪里调这个服务  参数是sys/user
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Category> findByUser(boolean isCurrentSite, String module,String place){
		List<String> categoryAll=Lists.newArrayList();
		User user = UserUtils.getUser();
		//List<Category> list = (List<Category>)UserUtils.getCache(CACHE_CATEGORY_LIST);
		List<Category> list =null;
		List<String> tempList=Lists.newArrayList();
		if (list == null){
			Category category = new Category();
			category.setOffice(new Office());
			
			category.setSite(new Site());
			category.setParent(new Category());
			
			if(CATEGORY_PLACE_SYS.equals(place)){			
				category.getSqlMap().put("dsf", dataScopeFilter(user, "o", ""));
				list = dao.findList(category);
			}else{
				category.getSqlMap().put("dsf", dataScopeFilter1(user, "o", ""));
				list = dao.findList(category);
				//add by luqibao 前端除去具有角色的分类 2015-12-30
				boolean flag=false;
				List<Role> roles=user.getRoleList();
				for(Role r:roles){
					if(Role.DATA_SCOPE_ALL.equals(r.getDataScope())){
						flag=true;
					}
				}
				//如果是系统管理员或者是超级管理员  还是走原来的逻辑
				if(!user.isAdmin()){
					if(!flag){
						List<Category> categorys=dao.findCategoryNotSimple();
						if(categorys!=null){
							list.removeAll(categorys);
						}
						//然后在加上本人具有特殊权限的分类
						categorys=dao.findCategoryRoleByUser(user);
						for(Category c:categorys){
							if(!list.contains(c)){
								list.add(c);
							}
						}
					}
					
				}
				
				//end
			}
			
			for(Category c:list){
				tempList.add(c.getId());
			}
			//add by luqibao  修改代码   能够显示
			Set<String> set=new TreeSet<String>();
			for(Category category1:list){
				String parentIds[]=category1.getParentIds().split(",");
				for(String str:parentIds){
					if(!"0".equals(str)){
						set.add(str);
					}
				}
			}
			// test start 
			//查询用户所具有的特殊权限的分类
//			List<Category> categorys=categoryDao.findCategoryRoleByUser(UserUtils.getUser());
//			for(Category c:categorys){
//				System.out.println(c.getName());
//			}
//			//查询所有的特殊分类权限
//			List<Category> categorys=categorydao.findCategoryNotSimple();
//			for(Category c:categorys){
//			System.out.println(c.getName());
//			}
			// test end
			//CmsUtils.hasPermission(null);
			/**categoryAll=findCategoryIdByUser1(user);
			for(String str:categoryAll){
				set.add(str);
			}**/
			categoryAll.clear();
			for(String str:set){
				categoryAll.add(str);
			}
			List<Category> list1=null;
			//判空操作 huangmj 2015 11 23 satrt
			if(categoryAll.size()>0){
				list1=categorydao.findAllByIds(categoryAll);
			}
			//判空操作 huangmj 2015 11 23 end
			if(list1!=null&&list1.size()>0){
				list.addAll(list1);
			}
			List<Category> temp=Lists.newArrayList();
			for(Category c:list){
				if(!temp.contains(c)){
					temp.add(c);
				}
			}
			list=temp;
			for(int i=0;i<list.size();i++){
				if(tempList.contains(list.get(i).getId())){
					list.get(i).setIsAdmin("1");
				}else{
					list.get(i).setIsAdmin("0");
				}
			}
			//end
			// 将没有父节点的节点，找到父节点
			Set<String> parentIdSet = Sets.newHashSet();
			for (Category e : list){
				if (e.getParent()!=null && StringUtils.isNotBlank(e.getParent().getId())){
					boolean isExistParent = false;
					for (Category e2 : list){
						if (e.getParent().getId().equals(e2.getId())){
							isExistParent = true;
							break;
						}
					}
					if (!isExistParent){
						parentIdSet.add(e.getParent().getId());
					}
				}
			}
			if (parentIdSet.size() > 0){
				//FIXME 暂且注释，用于测试
//				dc = dao.createDetachedCriteria();
//				dc.add(Restrictions.in("id", parentIdSet));
//				dc.add(Restrictions.eq("delFlag", Category.DEL_FLAG_NORMAL));
//				dc.addOrder(Order.asc("site.id")).addOrder(Order.asc("sort"));
//				list.addAll(0, dao.find(dc));
			}
		}
		if (isCurrentSite){
			List<Category> categoryList = Lists.newArrayList(); 
			for (Category e : list){
				if (Category.isRoot(e.getId()) || (e.getSite()!=null && e.getSite().getId() !=null 
						&& e.getSite().getId().equals(Site.getCurrentSiteId()))){
					if (StringUtils.isNotEmpty(module)){
						if (module.equals(e.getModule()) || "".equals(e.getModule())){
							categoryList.add(e);
						}
					}else{
						categoryList.add(e);
					}
				}
			}
			return categoryList;
		}
		
		return list;
	}
	/**
	 * 表示具有权限的分类的集合  这个指的是管理权限  不是现实树结构的那些分类
	 * @param isCurrentSite true
	 * @param module	article
	 * @param place		CATEGORY_PLACE_SYS
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Category> findByUser2(boolean isCurrentSite, String module,String place){
		List<String> categoryAll=Lists.newArrayList();
		User user = UserUtils.getUser();
		//List<Category> list = (List<Category>)UserUtils.getCache(CACHE_CATEGORY_LIST);
		List<Category> list =null;
		List<String> tempList=Lists.newArrayList();
		if (list == null){
			Category category = new Category();
			category.setOffice(new Office());
			
			category.setSite(new Site());
			category.setParent(new Category());
			
			if(CATEGORY_PLACE_SYS.equals(place)){			
				category.getSqlMap().put("dsf", dataScopeFilter(user, "o", ""));
				list=Lists.newArrayList();
			}else{
				category.getSqlMap().put("dsf", dataScopeFilter1(user, "o", ""));
				list = dao.findList(category);
				List<Category> categorys=getCategoryByUser(UserUtils.getUser());
				for(Category c:categorys){
					if(!list.contains(c)){
						list.add(c);
					}
				}
				
			}
			//list = dao.findList(category);
//			for(Category c:list){
//				System.out.println(c.getName());
//			}
			//全部的
			
			//add by luqibao  这里单独处理后台管理新增
			try{
				if(CATEGORY_PLACE_SYS.equals(place)){
					list=categorydao.findCategorysByUser(user);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			
			//判断是否是超级管理员  如果是的话  走原来的体系
			boolean flag=false;
			List<Role> roles=user.getRoleList();
			for(Role r:roles){
				if(Role.DATA_SCOPE_ALL.equals(r.getDataScope())){
					flag=true;
				}
			}
			
			//如果是系统管理员  还是走原来的逻辑
			if(user.isAdmin()|flag){
				category.getSqlMap().put("dsf", dataScopeFilter(user, "o", ""));
				list = dao.findList(category);
			}
			
			//end    这里单独处理后台管理新增
			

			for(Category c:list){
				tempList.add(c.getId());
			}
			//add by luqibao  修改代码   能够显示
			Set<String> set=new TreeSet<String>();
			for(Category category1:list){
				String parentIds[]=category1.getParentIds().split(",");
				for(String str:parentIds){
					if(!"0".equals(str)){
						set.add(str);
					}
				}
			}
			
			/**categoryAll=findCategoryIdByUser1(user);
			for(String str:categoryAll){
				set.add(str);
			}**/
			categoryAll.clear();
			for(String str:set){
				categoryAll.add(str);
			}
			List<Category> list1=null;
			//判空操作 huangmj 2015 11 23 satrt
			if(categoryAll.size()>0){
				list1=categorydao.findAllByIds(categoryAll);
			}
			//判空操作 huangmj 2015 11 23 end
			if(list1!=null&&list1.size()>0){
				list.addAll(list1);
			}
			List<Category> temp=Lists.newArrayList();
			for(Category c:list){
				if(!temp.contains(c)){
					temp.add(c);
				}
			}
			list=temp;
			for(int i=0;i<list.size();i++){
				if(tempList.contains(list.get(i).getId())){
					list.get(i).setIsAdmin("1");
				}else{
					list.get(i).setIsAdmin("0");
				}
			}
			//end
			// 将没有父节点的节点，找到父节点
			Set<String> parentIdSet = Sets.newHashSet();
			for (Category e : list){
				if (e.getParent()!=null && StringUtils.isNotBlank(e.getParent().getId())){
					boolean isExistParent = false;
					for (Category e2 : list){
						if (e.getParent().getId().equals(e2.getId())){
							isExistParent = true;
							break;
						}
					}
					if (!isExistParent){
						parentIdSet.add(e.getParent().getId());
					}
				}
			}
			if (parentIdSet.size() > 0){
				//FIXME 暂且注释，用于测试
//				dc = dao.createDetachedCriteria();
//				dc.add(Restrictions.in("id", parentIdSet));
//				dc.add(Restrictions.eq("delFlag", Category.DEL_FLAG_NORMAL));
//				dc.addOrder(Order.asc("site.id")).addOrder(Order.asc("sort"));
//				list.addAll(0, dao.find(dc));
			}
		}
		if (isCurrentSite){
			List<Category> categoryList = Lists.newArrayList(); 
			for (Category e : list){
				if (Category.isRoot(e.getId()) || (e.getSite()!=null && e.getSite().getId() !=null 
						&& e.getSite().getId().equals(Site.getCurrentSiteId()))){
					if (StringUtils.isNotEmpty(module)){
						if (module.equals(e.getModule()) || "".equals(e.getModule())){
							categoryList.add(e);
						}
					}else{
						categoryList.add(e);
					}
				}
			}
			return categoryList;
		}
		
		return list;
	}
	public List<Category> findByParentId(String parentId, String siteId){
		Category parent = new Category();
		parent.setId(parentId);
		entity.setParent(parent);
		Site site = new Site();
		site.setId(siteId);
		entity.setSite(site);
		return dao.findByParentIdAndSiteId(entity);
	}
	
	public Page<Category> find(Page<Category> page, Category category) {
//		DetachedCriteria dc = dao.createDetachedCriteria();
//		if (category.getSite()!=null && StringUtils.isNotBlank(category.getSite().getId())){
//			dc.createAlias("site", "site");
//			dc.add(Restrictions.eq("site.id", category.getSite().getId()));
//		}
//		if (category.getParent()!=null && StringUtils.isNotBlank(category.getParent().getId())){
//			dc.createAlias("parent", "parent");
//			dc.add(Restrictions.eq("parent.id", category.getParent().getId()));
//		}
//		if (StringUtils.isNotBlank(category.getInMenu()) && Category.SHOW.equals(category.getInMenu())){
//			dc.add(Restrictions.eq("inMenu", category.getInMenu()));
//		}
//		dc.add(Restrictions.eq(Category.FIELD_DEL_FLAG, Category.DEL_FLAG_NORMAL));
//		dc.addOrder(Order.asc("site.id")).addOrder(Order.asc("sort"));
//		return dao.find(page, dc);
//		page.setSpringPage(dao.findByParentId(category.getParent().getId(), page.getSpringPage()));
//		return page;
		category.setPage(page);
		category.setInMenu(Global.SHOW);
		page.setList(dao.findModule(category));
		return page;
	}
	
	@Override
	@Transactional(readOnly = false)
	public String save(Category category) {
		String id="";
		if (category.getParent() == null || org.apache.commons.lang3.StringUtils.isBlank(category.getParentId()) 
				|| "0".equals(category.getParentId())||"1".equals(category.getParentId())){
			/*if(categorydao.getMaxImage()!=null){
			String	Maximage=new String(categorydao.getMaxImage());
			System.out.println("------------Maximage------"+Maximage);
			Integer image=Integer.valueOf(Maximage);
			System.out.println("------------image------"+image);
			category.setImage(String.valueOf((image+(int)Math.random()*9)%10));
			}*/
			//取一个3-9的随机数,在新建知识库category时,赋给image字段,测试可用了.(默认的0,1,2分配给技术,作物,岗位)
			int image=0;
			//System.out.println("------------image------"+image);
			category.setImage(String.valueOf(image));
		}
		
		category.setSite(new Site(Site.getCurrentSiteId()));
		if (StringUtils.isNotBlank(category.getViewConfig())){
            category.setViewConfig(StringEscapeUtils.unescapeHtml4(category.getViewConfig()));
        }
		id=super.save(category);
		UserUtils.removeCache(CACHE_CATEGORY_LIST);
		CmsUtils.removeCache("mainNavList_"+category.getSite().getId());
		return id;
	}
	
	@Override
	@Transactional(readOnly = false)
	public void delete(Category category) {
		super.delete(category);
		UserUtils.removeCache(CACHE_CATEGORY_LIST);
		CmsUtils.removeCache("mainNavList_"+category.getSite().getId());
	}
	
	/**
	 * 通过编号获取栏目列表
	 */
	public List<Category> findByIds(String ids) {
		List<Category> list = Lists.newArrayList();
		String[] idss = StringUtils.split(ids,",");
		if (idss.length>0){
//			List<Category> l = dao.findByIdIn(idss);
//			for (String id : idss){
//				for (Category e : l){
//					if (e.getId().equals(id)){
//						list.add(e);
//						break;
//					}
//				}
//			}
			for(String id : idss){
				Category e = dao.get(id);
				if(null != e){
					//System.out.println("e.id:"+e.getId()+",e.name:"+e.getName());
					list.add(e);
				}
				//list.add(dao.get(id));
				
			}
		}
		return list;
	}
	//add by luqibao 重新findByIds,之前的性能有问题
	public List<Category> findByIds(List<String> ids) {
		List<Category> list=Lists.newArrayList();
		if(ids==null){
			ids=Lists.newArrayList();
		}
		list=categorydao.findAllByIds(ids);
		if(list==null){
			list=Lists.newArrayList();
		}
		return list;
	}
	//end
	//add by luqibao
	//获取到当前用户具有的查询权限的知识分类id集合
	/**
	 * 
	 * @param 
	 * @return 当前用户具有查看权限的知识分类的id
	 */
	@SuppressWarnings("unchecked")
	public List<String> findCategoryIdByUser(User user){
		List<String> classifys =null;
		//如果传入空值 那么就使用当前用户
		if(user==null){
			user=UserUtils.getUser();
		}
		//如果当前用户获取不到 那么就返回空值
		if(user.getId()==null){
			return Lists.newArrayList();
		}
		
		classifys=(List<String>) UserUtils.getCache("classifysCache");
		
		
		if(classifys!=null){
			return classifys;
		}
		
			classifys=Lists.newArrayList();
			List<Category> categorys=findByUser(true,"article",CATEGORY_PLACE_USER);
			if(categorys!=null&&categorys.size()>0){
				for(Category c:categorys){
					classifys.add(c.getId());
				}
			}
			//user.getSqlMap().put("dsf", dataScopeFilter(user.getCurrentUser(), "o", "u"));
			//classifys=categorydao.findCategoryIds(user);
			if(classifys==null){
				return Lists.newArrayList();
			}
			UserUtils.putCache("classifysCache",classifys);
		return classifys;
	}
	
	/**
	 * 
	 * @param 
	 * @return 当前用户具有查询权限的知识分类的id
	 */
	@SuppressWarnings("unchecked")
	private List<String> findCategoryIdByUser1(User user){
		List<String> classifys =null;
		//如果传入空值 那么就使用当前用户
		if(user==null){
			user=UserUtils.getUser();
		}
		//如果当前用户获取不到 那么就返回空值
		if(user.getId()==null){
			return Lists.newArrayList();
		}
		
		classifys=(List<String>) UserUtils.getCache("classifysCache1");
		
		
		if(classifys!=null){
			return classifys;
		}
		
			classifys=Lists.newArrayList();
			user.getSqlMap().put("dsf", dataScopeFilter(user.getCurrentUser(), "o", "u"));
			classifys=categorydao.findCategoryIds(user);
			if(classifys==null){
				return Lists.newArrayList();
			}
			UserUtils.putCache("classifysCache1",classifys);
		return classifys;
	}
	
	
	
	
	//根据传入进来的用户  查询该用户所管理的知识库id集合
	//如果该用户不是知识库分类管理员，返回null
	/**
	 * 
	 * 
	 * @param user 当前的用户
	 * @return 管理的知识库id
	 */
	public List<String> findCategoryAsAdmin(User user){
		return null;
	}
	
	
	//根据知识库或者知识分类的id 获取下级
	public List<Category> getChildsByCategoryId(String id){
		List<Category> list=Lists.newArrayList();
		Category category=new Category();
		category.setId(id);
		if(categorydao.get(category)!=null){
			list =categorydao.getChildsByCategoryId(id);
		};
		return list!=null?list:new ArrayList<Category>();
	}
	
	public List<Category> findAllCategory(Category category){
		List<Category> list=Lists.newArrayList();
		if(category==null||category.getSite()==null){
			category=new Category();
			Site site=new Site();
			Category parent=new Category();
			category.setParent(parent);
			category.setSite(site);
		}
		category.setDelFlag("0");
		list=categorydao.findList(category);
		if(list==null){
			list=Lists.newArrayList();
		}
		return list;
	}
	//end
	//通过库id得到一级分类id
	public String getFirstCategoryIdByLibId(String libid){
		List<String> list=Lists.newArrayList();
		if(libid!=null&&!"".equals(libid)){
			list =categorydao.getChildIdByCategoryId(libid);
		};
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<list.size();i++){
			sb.append(list.get(i)+",");
		}
		return sb.toString();
	}
	
	
	
	/**
	 * yinshh3根据一级分类id获取二级分分类id集合(仿照上面)
	 * @param 一级分类id的list集合
	 */
	public String getSecondCategoryIdByFirstId(String firstIdLists){
		List<String> secondIdList=Lists.newArrayList();
		List<List<String>> allSecondIdList=Lists.newArrayList();
			if(firstIdLists!=null&&!"".equals(firstIdLists)){
				//单独一个一级id对应的二级id集合
				String[] strs=firstIdLists.split(",");
				for(String s:strs){
					secondIdList =categorydao.getChildIdByCategoryId(s);
					allSecondIdList.add(secondIdList);
				}
			}
			StringBuffer sb=new StringBuffer();
		for(int i=0;i<allSecondIdList.size();i++){
			for (int j=0;j<allSecondIdList.get(i).size();j++){
				sb.append(allSecondIdList.get(i).get(j)+",");
			}
		}
		return sb.toString();
	}
	
	/**
	 * 
	 * @param flag,判断是库id,一级分类id,还是二级分类id的flag
	 * @return 二级分类用,分隔的String
	 */
	public String getSecondIdByFlag(String categoryids){
		String secondids=new String();
		int flag=getCategoryFlagByID(categoryids);
		if(categoryids!=null){
			//判断得到库id
		if(flag==0){
			//库id得到一级id集合
			String firstIds=new String(getFirstCategoryIdByLibId(categoryids));
			secondids=getSecondCategoryIdByFirstId(firstIds);
		}else if(flag==1)
		{
			//判断得到一级id
			secondids=getSecondCategoryIdByFirstId(categoryids);
		}else
		{
			//判断得到二级id
			secondids=categoryids;
		}
	}
		return secondids;
}


	
	//add hefeng
	/**
	 * 通过id获得parentIds
	 */
	public String findparentIdsById(String id) {
		return dao.findparentIdsById(id);
	}
	
	//end


		//add by yinshh3
	/*
	 * 将传进来的categoryid进行分类获取,确保他传出去的是2级分类的结合.
	 */
	public List<String> getSecondCategoryID(List<String> categoryidlist) {
		List<String> finallist = new ArrayList<String>();
		for (int i = 0; i < categoryidlist.size(); i++) {
			Category category =new Category();
			category =categorydao.get(categoryidlist.get(i));
			//System.out.println("category.........."+JsonMapper.toJsonString(category));
			String parentids = category.getParentIds();
			//System.out.println("category..getParentIds........"+JsonMapper.toJsonString(parentids));
			if(parentids==null){
				//System.out.println("=======parentids为空=============");
			}
			int count = 0;
			for (int j = 0; j < parentids.length(); j++) {	
				if (parentids.charAt(j) == ',') {
					count++;
					//System.out.println("count........"+JsonMapper.toJsonString(count));
				}
				}
			// 如果parentids含有4个,.则确定它是底层的categoryid,就添加到最终的list中去.
			if (count == 4) {
				finallist.add(categoryidlist.get(i));
			}
		}
		return finallist;
	}
	/**
	 * 
	 * @param categoryList
	 * @return categoryMap,用户具有查询的库id的List,一级知识分类的List,二级知识分类id的List.最终装在一个大的List<Map>中
	 */
	public Map<String,Object> categoryMap(List<String> categoryList){
		Map<String,Object> map=new HashMap<String,Object>();
		List<String> libList=Lists.newArrayList();
		List<String> firList=Lists.newArrayList();
		List<String> secList=Lists.newArrayList();
		List<Category> parentids = new ArrayList<Category>();
		if(categoryList!=null&&categoryList.size()>0){
			parentids=dao.parentCategoryIds(categoryList);
		}
		for(Category category:parentids){
			if(category.getParentIds().split(",").length==2){
				libList.add(category.getId());
			}
			if(category.getParentIds().split(",").length==3){
				firList.add(category.getId());
			}
			if(category.getParentIds().split(",").length==4){
				secList.add(category.getId());
			}
		}
		map.put("libList",libList);
		map.put("firList",firList);
		map.put("secList",secList);
		return map;
	}
	//根据传入的当前用户具有的二级分类ID集合,找到对应的delflag的集合
	public List<String> getDelFlagByCategoryID(List<String> secondcategoryid){
		List<String> DelFlagList=Lists.newArrayList();
		//如果这个secondid集合为空,就不传入数据库查询
		if(secondcategoryid.size()==0){
			return DelFlagList;
		}
		DelFlagList=categorydao.getDelFlagByCategoryID(secondcategoryid);
		//从数据库返回为空的数据,内容并不是null,用下面的进行判断.
		/*if(DelFlagList==null){
			System.out.println("-----DelFlagList==null---"+JsonMapper.toJsonString(DelFlagList));
			DelFlagList.add("0");
			System.out.println("-----DelFlagList==null---"+JsonMapper.toJsonString(DelFlagList));
			
		}*/
		//如果为空,添加一条非审核状态的数据.(只要不等于2就行)
		//后来发现不用处理,他的长度等于0,在调用方法的时候,不进入循环,count就不会增加.就是初始值0
/*	if(DelFlagList.size()==0){
			System.out.println("-----DelFlagList.size==0的条件---"+JsonMapper.toJsonString(DelFlagList)+"----DelFlagList.size()---"+DelFlagList.size());
			
			System.out.println("-----DelFlagList.size==0的条件---"+JsonMapper.toJsonString(DelFlagList)+"----DelFlagList.size()---"+DelFlagList.size());
			
		}*/
		return DelFlagList;
	}
	//end
	
	//add by yinshh3 
	/**
	 * 得到categoryid是库id，一级id，还是二级id
	 * @param categoryId 传入的categoryid
	 * @return flag(0：库id;1：一级id;2：二级id;)
	 */
	public Integer getCategoryFlagByID(String categoryId){
		int flag=0;
		if(categoryId!=null&&!"".equals(categoryId)){
			Category category =CmsUtils.getCategory(categoryId);
			if(category==null){
				return flag;
			}
			String parentids=category.getParentIds();
			int count=0;
			for(int i=0;i<parentids.length();i++){
				if(parentids.charAt(i)==','){
					count++;
				}
			}
//			if(parentids.length()==4){
//				count=2;
//			}
//			if(parentids.length()>4&&parentids.length()<25){
//				count=3;
//			}
//			if(parentids.length()>53){
//				count=4;
//			}
			if(count==2){
				//库id
				flag=0;
			}else if(count==3)
			{
				//一级id
				flag=1;
			}else
			{
				//二级id
				flag=2;
			}
		}
		return flag;
	}
	//add by luqibao
	@Transactional(readOnly = false)
	public String changeDelFlag(Article article){
		//add by yangshw6 当知识发布,下架，弃审以后，更新数据到知识统计表里
		if(article.getDelFlag().equals("0")){	
			articlecountService.insertSingleData(article.getId());
		}
		if(article.getDelFlag().equals("1")){	
			articlecountService.deleteSingleData(article.getId());
		}
		if(article.getDelFlag().equals("2")){	
			articlecountService.deleteSingleData(article.getId());
		}
		//end by yangshw6
		articleDao.updateDel(article);
		String categoryId=CmsUtils.getArticlecid(article.getId());
		return categoryId==null?"":categoryId;
	}
	/**
	 * 获取知识分类下有可以分享文章的知识分类的id
	 * @return
	 */
	public List<String> findCategoryIsAllowShare(){
		List<String> list=null;
		list=articleDao.findAllowShareCategoryIds();
		if(list==null){
			list=Lists.newArrayList();
		}
		return list;
	}
	
	/**
	 * 插入管理知识分类关联关系
	 * @param user
	 * @param category
	 * @return
	 */
	@Transactional
	public boolean insertUserCategory(List<User> users,Category category){
		
		//c.setId("687c121212af491483ffc11935324855");
		// end
		//删除 start
		//categorydao.deleteUserCategory(user);
		//end
		//增加 start
		//因为增加的管理员不可能很多 所有for循环进行插入 
		try{
			for(User user:users){
				UserCategory uc=new UserCategory();
				uc.setCategory(category);
				uc.setUser(user);
				uc.preInsert();
				categorydao.insertUserCategory(uc);
			}

		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	/**
	 * 删除管理用户
	 * @param user
	 * @return
	 */
	@Transactional
	public boolean deleteUserCategory(User user,Category c){
		if(user==null|user.getId()==null){return false;}
		try{
			UserCategory uc=new UserCategory();
			uc.setUser(user);
			uc.setCategory(c);
			categorydao.deleteUserCategory(uc);
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	/**
	 * 获取管理这个分类的所有人员
	 * @param category
	 * @return
	 */
	@Transactional
	public List<User> getUserByCategory(Category category){
		Category c=categorydao.get(category);
		List<User> users=Lists.newArrayList();
		if(c==null){
			return users;
		}
		
		if(category==null){
			return users;
		}
		users=userDao.findUsersByCategory(category);
		
//		for(User u:users){
//			System.out.println(u.getName());
//		}
		return users;
	}
	/**
	 * 获取用户所管理的知识分类
	 * @return
	 */
	@Transactional
	public List<Category> getCategoryByUser(User user){
		List<Category> list=Lists.newArrayList();
		list=categorydao.findCategorysByUser(user);
		if(list==null){
			return Lists.newArrayList();
		}
		return list;
	}
	/***
	 * 插入sys_role_category记录
	 */
	@Transactional
	public boolean insertRoleCategory(List<Role> roles,Category category){
		
		try{
			for(Role role:roles){
				RoleCategory rc=new RoleCategory();
				rc.setRole(role);
				rc.setCategory(category);
				categorydao.insertRoleCategory(rc);
			}

		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	/**
	 * 删除sys_role_category表中的记录
	 * @param role
	 * @param c
	 * @return
	 */
	@Transactional
	public boolean deleteRoleCategory(Role role,Category c){
		if(role==null|role.getId()==null){return false;}
		try{
			RoleCategory rc=new RoleCategory();
			rc.setRole(role);
			rc.setCategory(c);
			categorydao.deleteRoleCategory(rc);
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	public List<Category> findCategoryRole(){
		List<Category> list = categorydao.findCategoryRole();
		return list;
	}
	/**
	 * 获取这个分类下面的所有角色
	 * @param category
	 * @return
	 */
	@Transactional
	public List<Role> getRoleByCategory(Category category){
		Category c=categorydao.get(category);
		List<Role> roles=Lists.newArrayList();
		if(c==null){
			return roles;
		}
		
		if(category==null){
			return roles;
		}
		roles=roleDao.findRoleByCategory(category);
		
//		for(User u:users){
//			System.out.println(u.getName());
//		}
		return roles;
	}
	//查询所有的角色  除去系统的
	public List<Role> findAllRole(){
		List<Role> tempRole=Lists.newArrayList();
		Role r=new Role();
		r.setUseable("1");
		r.setDelFlag("0");
		List<Role> roles=roleDao.findList(r);
		for(Role r1:roles){
			if(r1.getDataScope()!=null){
				if(!r1.getSysData().equals("1")&&!r1.getId().equals("6")){
					tempRole.add(r1);
				}
			}
		}
		return tempRole;
	}
	//end	
	
	
	
}
