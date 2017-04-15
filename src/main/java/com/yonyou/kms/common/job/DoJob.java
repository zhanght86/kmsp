package com.yonyou.kms.common.job;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.google.common.collect.Lists;
import com.yonyou.kms.common.utils.CacheUtils;
import com.yonyou.kms.modules.cms.service.ArticleCountService;
import com.yonyou.kms.modules.cms.service.DepartContributionService;
import com.yonyou.kms.modules.cms.service.LabelService;
import com.yonyou.kms.modules.cms.service.PersonContributionService;
import com.yonyou.kms.modules.sys.dao.StatusDao;
import com.yonyou.kms.modules.sys.entity.UserSchema;
import com.yonyou.kms.modules.sys.service.OfficeService;
import com.yonyou.kms.modules.sys.service.SystemService;
import com.yonyou.kms.modules.sys.utils.SchemaUtils;


/**
 * 
 * @author luqibao
 *
 */
@Service
@Lazy(false)
public class DoJob {
	
	
	@Autowired
	private StatusDao statusDao;
	@Autowired
	private PersonContributionService personContributionService;
	@Autowired
	private DepartContributionService departContributionService;
	@Autowired
	private ArticleCountService articleCountService;
	@Autowired
	private LabelService labelService;
	
	@Autowired
	SystemService systemService;
	@Autowired
	OfficeService officeService;
	Executor executor = Executors.newFixedThreadPool(100);
	@Scheduled(cron="0 0 2 * * ?")

	public void doJob(){
		
//	//Status s=new Status();
//		//s.setId("7");
//		//s.setTs(new Date().toLocaleString());
//		//s.setFromSys("user");
//		//statusDao.insertStatus(s);
//		//String date=statusDao.selectStatus("user");
//		//System.out.println("瀹氭椂浠诲姟------------------銆�"+date);
////		
//		List<Status> list=new ArrayList<Status>();
//		Status s=null;
//		for(int i=0;i<10;i++){
//			s=new Status();
//			s.setId("ssss1"+i);
//			s.setFromSys("user");
//			s.setTs(new Date().toLocaleString());
//			list.add(s);
//		}
//		statusDao.batchInsert(list);
//		System.out.println("鎻掑叆鏁版嵁缁撴潫锛侊紒");
//		ISynchroNCInfoLocator service = new ISynchroNCInfoLocator();
//		try {
//			ISynchroNCInfoPortType client = service.getISynchroNCInfoSOAP11port_http();
//			OuterSystemRetVO out=client.getNCUserInfo("design", "", "", "");
//			String str=out.getData();
//			System.out.println(str);
//			Gson gson=new Gson();
//	        List<NCUser> retList = gson.fromJson(str,  
//	                new TypeToken<List<NCUser>>() {  
//	                }.getType());
//	        System.out.println(retList.toString());
//	        
//		} catch (ServiceException e) {
//			e.printStackTrace();
//		}catch(RemoteException e){
//			e.printStackTrace();
//		}
//		//ss.synchroNCInfo();
//		try {
//			officeService.synchroNCInfo();
//			systemService.synchroNCInfo();
//		} catch (ServiceException e) {
//			e.printStackTrace();
//		}
//		
		//add by yangshw6
		//取出数据库中最新的schema列表
		Map<String, UserSchema> allUserSchema =null;
		allUserSchema=new HashMap<String,UserSchema>();
		String sql="select login_name,user_id,ent_id,tenant_schema_name,id from \"Sys_Schema\".user_ent";
		List<UserSchema> all=Lists.newArrayList();
		try {
			all = SchemaUtils.queryPublicSchema(sql,UserSchema.class,null,new String[]{"loginName","userId","entId","tenantSchemaName","id"},new Class[]{String.class,String.class,String.class,String.class,String.class});
		} catch (Exception e) {
			e.printStackTrace();
		}
		for(UserSchema us:all){
			allUserSchema.put(us.getLoginName(), us);
		}
		//去重
		Set<String> schemas=new HashSet<String>();
		for(Map.Entry<String, UserSchema> v:allUserSchema.entrySet()){
			schemas.add(v.getValue().getTenantSchemaName());
		}
		//队列大小
		long start=System.currentTimeMillis();
		CountDownLatch downLatch=new CountDownLatch(schemas.size());
		for(String schema:schemas){
			DoSync doSync = new DoSync(schema,downLatch);
			executor.execute(doSync);
		}
		try {  
            downLatch.await();
            long end=System.currentTimeMillis();
            System.out.println("service time:"+(end-start)+"ms");
        } catch (InterruptedException e) {
        	
        }
		System.out.println("=============Queue===============");
		//end by yangshw6
	}
	
	//异步队列
	class DoSync implements Runnable{
		
		private String schema;
		private CountDownLatch downLatch;
		public DoSync(String schema, CountDownLatch downLatch) {
			super();
			this.schema = schema;
			this.downLatch = downLatch;
		}
		@Override
		public void run() {
			
			try{
				personContributionService.saveData(this.schema);
				articleCountService.saveData(this.schema);
				departContributionService.saveData(this.schema);
				labelService.saveData(this.schema);
			}catch(Exception e){
				//e.printStackTrace();
			}
			this.downLatch.countDown();
		}
	}
}
