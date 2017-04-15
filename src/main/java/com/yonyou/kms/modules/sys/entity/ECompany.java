package com.yonyou.kms.modules.sys.entity;
/**
 * 
 * @author Hotusm
 *
 */
public class ECompany {
	
	private String opertaion;	//操作
	private String id;			//id
	private String name;		//名称
	private String parentId;	//父级公司ID
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@Override
	public String toString() {
		return this.id+":"+this.name;
	}
	
	
}
