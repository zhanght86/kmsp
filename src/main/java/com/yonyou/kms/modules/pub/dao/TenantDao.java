package com.yonyou.kms.modules.pub.dao;

import com.yonyou.kms.common.persistence.CrudDao;
import com.yonyou.kms.common.persistence.annotation.MyBatisDao;
import com.yonyou.kms.modules.pub.entity.Tenant;

@MyBatisDao
public interface TenantDao extends CrudDao<Tenant>{
	public int getNumber();
}
