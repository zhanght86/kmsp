package com.yonyou.kms.modules.sys.entity;

/**
 * 
 * @author Hotusm
 *excel机构临时对象
 *2016-01-13
 */
public class EOffice {
	
	private String opertaion;//操作
	private String id;		//id
	private String name;	//名称
	private String parentId;	//父级id
	private String companyId;	//公司的id
	private String remark;		//备注
	
	public String getOpertaion() {
		return opertaion;
	}
	public void setOpertaion(String opertaion) {
		this.opertaion = opertaion;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@Override
	public String toString() {
		return "Office [opertaion=" + opertaion + ", id=" + id + ", name="
				+ name + ", parentId="+parentId +", companyId="+companyId+ ", remark=" + remark + "]";
	}
}
