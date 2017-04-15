package com.yonyou.kms.modules.cms.dao;

import com.yonyou.kms.common.persistence.CrudDao;
import com.yonyou.kms.common.persistence.annotation.MyBatisDao;
import com.yonyou.kms.modules.cms.entity.Share;
import com.yonyou.kms.modules.cms.entity.Store;
/**
 * 分享DAO接口
 * @author zy
 * 
 */
@MyBatisDao
public interface ShareDao extends CrudDao<Share>{
	public Share getShare(String tid);
	public void MergeArticle(String originalcategoryId,String categoryId,String articleId);
	public void MergeCategory(String originalcategoryId, String categoryId);
}
