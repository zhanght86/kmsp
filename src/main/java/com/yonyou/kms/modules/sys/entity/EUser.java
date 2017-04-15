package com.yonyou.kms.modules.sys.entity;

/**
 * 
 * @author Hotusm
 * excel用户临时对象
 *	2016-01-13
 */



public class EUser {
	
	private String opertaion;	//操作
	private String loginName;	//登录名
	private String name;		//姓名
	private String password;	//密码
	private String companyId;	//公司id
	private String officeId;	//部门id
	private String phone;		//电话
	private String mobile;		//手机
	private String email;		//email
	private String address;		//地址
	private String remark;		//备注
	
	
	
	public String getOpertaion() {
		return opertaion;
	}
	public void setOpertaion(String opertaion) {
		this.opertaion = opertaion;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getOfficeId() {
		return officeId;
	}
	public void setOfficeId(String officeId) {
		this.officeId = officeId;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@Override
	public String toString() {
		return "User [opertaion=" + opertaion + ", loginName=" + loginName
				+ ", name=" + name + ", password=" + password + ", companyId="
				+ companyId + ", officeId=" + officeId + ", phone=" + phone
				+ ", mobile=" + mobile + ", email=" + email + ", address="
				+ address + ", remark=" + remark + "]";
	}
}
