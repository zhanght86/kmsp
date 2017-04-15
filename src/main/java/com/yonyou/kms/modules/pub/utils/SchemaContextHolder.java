package com.yonyou.kms.modules.pub.utils;

import com.yonyou.kms.modules.sys.utils.UserUtils;


/**
 * 
 * @author Hotusm
 *
 */
public class SchemaContextHolder {
	
	//将sql切换成私有的公司的schema
	public static void changePrivateSchema(){
		String schema=(String) UserUtils.getCache("schema-private");
		UserUtils.putCache("schema", schema);
	}
	
	//将sql环境切换到公共的schema
	public static void changePublicSchema(){
		UserUtils.putCache("schema", "Sys_Schema");
	}
}
