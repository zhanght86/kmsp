package com.yonyou.kms.modules.pub.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yonyou.kms.common.mapper.JsonMapper;
import com.yonyou.kms.common.service.CrudService;
import com.yonyou.kms.modules.cms.dao.ArticleLabelDao;
import com.yonyou.kms.modules.cms.entity.ArticleLabel;
import com.yonyou.kms.modules.pub.dao.EnterpriseDao;
import com.yonyou.kms.modules.pub.dao.TenantDao;
import com.yonyou.kms.modules.pub.entity.Enterprise;
import com.yonyou.kms.modules.pub.entity.Tenant;
import com.yonyou.kms.modules.sys.dao.UserSchemaDao;
import com.yonyou.kms.modules.sys.entity.User;
import com.yonyou.kms.modules.sys.entity.UserSchema;
import com.yonyou.kms.modules.sys.utils.SchemaUtils;

@Service
@Transactional(readOnly = false)
public class EnterpriseService extends CrudService<EnterpriseDao, Enterprise>{
	@Autowired
	private EnterpriseDao  edao;
	@Autowired
	private TenantDao tdao;
	@Autowired
	private UserSchemaDao udao;
	//公有的Schema的模式
	private static String schemaName="\"Sys_Schema\"";
	/*
	 * 
	 * 创建企业
	 * 
	 */
	public boolean  createEnterprise(Enterprise ep){
		ep.preInsert();
		String sql="INSERT INTO "+schemaName+".ENTERPRISE(ID,CODE,NAME,TELEPHONE,MOBILE_TELEPHONE,EMAIL,TENANT_ID,CREATE_TIME,DESCS,CREATOR,ADDRESS)   " +
				"VALUES(?,?,?,?,?,?,?,?,?,?,?)";
		Object[] params=new Object[]{ep.getId(),ep.getCode(),ep.getName(),ep.getTelephone(),
									ep.getMobilePhone(),ep.getEmail(),ep.getTenantId(),ep.getCreateDate().toLocaleString(),ep.getDescs(),
									ep.getCreateBy().getName(),ep.getAddress()};
		try {
			SchemaUtils.updatePublicSchema(sql,params);
		} catch (SQLException e) {
			System.out.println("1");
			e.printStackTrace();
			return false;		
		}
		return true;
		//edao.insert(ep);
	}
	//创建企业系统管理员(公共schema下创建企业-用户关系)
	public boolean createSuperadmin(String loginName,String tenantId,String tenantName){
		UserSchema us=new UserSchema();
		//us.setUserId("1001691000000000DPQ7");
		//us.setLoginName(loginName);
		us.preInsert();
		//us.setEntId(tenantId);
		//us.setTenantSchemaName(tenantName);
		String sql="INSERT INTO "+schemaName+".USER_ENT(LOGIN_NAME,USER_ID,ENT_ID,TENANT_SCHEMA_NAME,ID)  " +
				"VALUES(?,?,?,?,?)";
		Object[] params=new Object[]{loginName,"1",tenantId,tenantName,us.getId()};
		try {
			SchemaUtils.updatePublicSchema(sql,params);
		} catch (SQLException e) {
			System.out.println("2");
			e.printStackTrace();
			return false;		
		}
		return true;
		//udao.insert(us);
	}
	//创建企业租户记录
	/*
	 * param:tenantName:租户名
	 * 
	 */
	public String createTenant(String tenantName){
		boolean flag=false;
		int number=getTenantNumber();
		if(number==0){
			return "";
		}
		String tenantId=String.valueOf(number+1);
		Tenant te=new Tenant();
		te.preInsert();
//		te.setTenantSchemaName(tenantName);
//		te.setTenantId(tenantId);
//		te.setSysSchemaName("SYS_SCHEMA");
//		tdao.insert(te);
		
		String sql="INSERT INTO "+schemaName+".TENANT(id,tenant_id,create_time,enable,audi_status,tenant_schema_name,sys_schema_name)    " +
				"VALUES(?,?,?,?,?,?,?)";
		Object[] params=new Object[]{te.getId(),tenantId,te.getCreateDate().toLocaleString(),te.getEnable(),te.getDelFlag(),tenantName,"SYS_SCHEMA"};
		try {
			SchemaUtils.updatePublicSchema(sql,params);
		} catch (SQLException e) {
			System.out.println("3");
			e.printStackTrace();
			
			return "";		
		}
		return tenantId;
	}
	//取得企业表中的企业数,用作编码试用
	public int getNumber(){
		String sql="select code from enterprise";
		int number=0;
		try {
			List<Enterprise> results = SchemaUtils.queryPublicSchema(sql, Enterprise.class, null, new String[]{"code"},new Class[]{String.class});
//			for(int i=0;i<results.size();i++){
//			System.out.println("results:"+JsonMapper.toJsonString(results.get(i)));
//			}
			number=results.size();
		} catch (Exception e) {
			System.out.println("4");
			e.printStackTrace();
		}
		
		return number;
	}
	//取得租户表中的租户数,用作id试用
	public int getTenantNumber(){
		String sql="select tenant_id from "+schemaName+".tenant";
		int number=0;
		try {
			List<Tenant> results = SchemaUtils.queryPublicSchema(sql, Tenant.class, null, new String[]{"tenantId"},new Class[]{String.class});
			number=results.size();
		} catch (Exception e){
			System.out.println("5");
			e.printStackTrace();
		}
		
		return number;
	}
	
}
