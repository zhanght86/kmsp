package com.yonyou.kms.modules.pub.utils;

import javax.sql.DataSource;

import com.yonyou.kms.common.utils.SpringContextHolder;

/**
 * 
 * @author Hotusm
 *
 */
public class DataSourceUtils {
	
	private static DataSource simpleDataSource=SpringContextHolder.getBean("dataSource");
	private static DataSource schemaDataSource=SpringContextHolder.getBean("schemaDataSource");
	
	public static DataSource getSimpleDataSource(){
		return simpleDataSource;
	}
	
	public static DataSource getSchemaDataSource(){
		return schemaDataSource;
	}
	
	
}
