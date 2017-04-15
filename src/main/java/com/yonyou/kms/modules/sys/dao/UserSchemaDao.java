package com.yonyou.kms.modules.sys.dao;

import com.yonyou.kms.common.persistence.CrudDao;
import com.yonyou.kms.common.persistence.annotation.MyBatisDao;
import com.yonyou.kms.modules.sys.entity.User;
import com.yonyou.kms.modules.sys.entity.UserSchema;

/**
 * vo的一些基本操作
 * @author Hotusm
 *
 */
@MyBatisDao
public interface UserSchemaDao extends CrudDao<UserSchema>{
	
	public Integer isSchemaExist (String schemaName);

	//根据登录名取得对应的实体,然后得到tenantSchemaName
	public UserSchema getUserSchemaByLoginName(String LoginName);
	
	//根据UserSchema实体得到user实体
	//public User getUserByUserSchema(UserSchema userSchema);
	
	

	public UserSchema findByUserId(String userId);

}
