package com.yonyou.kms.modules.pub.entity;

import com.yonyou.kms.common.persistence.DataEntity;

public class Tenant extends DataEntity<Tenant> {
	private String tenantId;	//租户ID
	private boolean enable;		//是否可用
	private String tenantSchemaName;	//数据库模式名称(每个租户)
	private String sysSchemaName;		//数据库模式名称(系统)
	private String ServerConn;			//备用
	private String resPre;				//备用
	public Tenant(String tenantId, boolean enable, String tenantSchemaName,
			String sysSchemaName, String serverConn, String resPre) {
		super();
		this.tenantId = tenantId;
		this.enable = enable;
		this.tenantSchemaName = tenantSchemaName;
		this.sysSchemaName = sysSchemaName;
		ServerConn = serverConn;
		this.resPre = resPre;
	}
	public Tenant() {
		super();
		this.enable=true;
		// TODO Auto-generated constructor stub
	}
	public Tenant(String id) {
		super(id);
		// TODO Auto-generated constructor stub
	}
	public String getTenantId() {
		return tenantId;
	}
	public void setTenantId(String tenantId) {
		this.tenantId = tenantId;
	}
	public boolean getEnable() {
		return enable;
	}
	public void setEnable(boolean enable) {
		this.enable = enable;
	}
	public String getTenantSchemaName() {
		return tenantSchemaName;
	}
	public void setTenantSchemaName(String tenantSchemaName) {
		this.tenantSchemaName = tenantSchemaName;
	}
	public String getSysSchemaName() {
		return sysSchemaName;
	}
	public void setSysSchemaName(String sysSchemaName) {
		this.sysSchemaName = sysSchemaName;
	}
	public String getServerConn() {
		return ServerConn;
	}
	public void setServerConn(String serverConn) {
		ServerConn = serverConn;
	}
	public String getResPre() {
		return resPre;
	}
	public void setResPre(String resPre) {
		this.resPre = resPre;
	}
	
}
