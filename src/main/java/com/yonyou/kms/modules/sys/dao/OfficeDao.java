/**
 * 
 */
package com.yonyou.kms.modules.sys.dao;

import java.util.List;

import com.yonyou.kms.common.persistence.TreeDao;
import com.yonyou.kms.common.persistence.annotation.MyBatisDao;
import com.yonyou.kms.modules.sys.entity.Office;

/**
 * 机构DAO接口
 * 
 * @author hotsum
 * @version 2014-05-16
 */
@MyBatisDao
public interface OfficeDao extends TreeDao<Office> {

	/**
	 * 批量增加机构
	 * 
	 * @author xiongbo
	 * @param list
	 * @return
	 */
	public int batchInsert(List<Office> list);

	/**
	 * 批量更新
	 * 
	 * @author xiongbo
	 * @param list
	 * @return
	 */
	public int batchUpdate(List<Office> list);

	/**
	 * 查询所有机构
	 * 
	 * @return
	 */
	public List<Office> findAll();

}
