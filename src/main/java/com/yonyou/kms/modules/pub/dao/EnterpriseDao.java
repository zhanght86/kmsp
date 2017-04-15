package com.yonyou.kms.modules.pub.dao;

import com.yonyou.kms.common.persistence.CrudDao;
import com.yonyou.kms.common.persistence.annotation.MyBatisDao;
import com.yonyou.kms.modules.pub.entity.Enterprise;
import com.yonyou.kms.modules.sys.entity.User;

@MyBatisDao
public interface EnterpriseDao extends CrudDao<Enterprise>{
	public int getNumber();
}
