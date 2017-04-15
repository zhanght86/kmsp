package com.yonyou.kms.modules.pub.entity;

import com.yonyou.kms.common.persistence.DataEntity;
import com.yonyou.kms.modules.sys.entity.User;
/*
 * 企业基本信息
 * 
 */
public class Enterprise extends DataEntity<Enterprise>{
	
	private String code;	//企业编码
	private String name;	//企业名称
	private String telephone;	//企业坐机
	private String mobilePhone;	//企业移动电话
	private String email;		//邮箱
	private String tenantId;	//租户Id
	private String descs;		//简介
	private String address;		//地址
	public Enterprise(String code, String name, String telephone,
			String mobilePhone, String email, String tenantId, String descs,
			String address) {
		super();
		this.code = code;
		this.name = name;
		this.telephone = telephone;
		this.mobilePhone = mobilePhone;
		this.email = email;
		this.tenantId = tenantId;
		this.descs = descs;
		this.address = address;
	}
	public Enterprise() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Enterprise(String id) {
		super(id);
		// TODO Auto-generated constructor stub
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getMobilePhone() {
		return mobilePhone;
	}
	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTenantId() {
		return tenantId;
	}
	public void setTenantId(String tenantId) {
		this.tenantId = tenantId;
	}
	public String getDescs() {
		return descs;
	}
	public void setDescs(String descs) {
		this.descs = descs;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	
	
}
