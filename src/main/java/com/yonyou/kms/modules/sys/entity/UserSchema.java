package com.yonyou.kms.modules.sys.entity;

import com.yonyou.kms.common.persistence.DataEntity;

/**
 * 用户的schema的具体信息
 * @author Hotusm
 *
 */
public class UserSchema extends DataEntity<User>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8327383833239210479L;
	
	private String id;					//表id
	private String userId;				//用户id
	private String loginName;			//用户的登录名
	private String entId;				//企业的id
	private String tenantSchemaName;	//用户所属的模式名字
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getEntId() {
		return entId;
	}
	public void setEntId(String entId) {
		this.entId = entId;
	}
	public String getTenantSchemaName() {
		return tenantSchemaName;
	}
	public void setTenantSchemaName(String tenantSchemaName) {
		this.tenantSchemaName = tenantSchemaName;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((entId == null) ? 0 : entId.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((loginName == null) ? 0 : loginName.hashCode());
		result = prime
				* result
				+ ((tenantSchemaName == null) ? 0 : tenantSchemaName.hashCode());
		result = prime * result + ((userId == null) ? 0 : userId.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final UserSchema other = (UserSchema) obj;
		if (entId == null) {
			if (other.entId != null)
				return false;
		} else if (!entId.equals(other.entId))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (loginName == null) {
			if (other.loginName != null)
				return false;
		} else if (!loginName.equals(other.loginName))
			return false;
		if (tenantSchemaName == null) {
			if (other.tenantSchemaName != null)
				return false;
		} else if (!tenantSchemaName.equals(other.tenantSchemaName))
			return false;
		if (userId == null) {
			if (other.userId != null)
				return false;
		} else if (!userId.equals(other.userId))
			return false;
		return true;
	}
	
	
}
