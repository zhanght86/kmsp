/**
 * 
 */
package com.yonyou.kms.modules.cms.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yonyou.kms.common.persistence.CrudDao;
import com.yonyou.kms.common.persistence.annotation.MyBatisDao;
import com.yonyou.kms.modules.cms.entity.Article;
import com.yonyou.kms.modules.cms.entity.Category;
import com.yonyou.kms.modules.sys.entity.User;

/**
 * 文章DAO接口
 * @author hotsum
 * @version 2013-8-23
 */
@MyBatisDao
public interface ArticleDao extends CrudDao<Article> {
	
	public List<Article> findByIdIn(String[] ids);
//	{
//		return find("from Article where id in (:p1)", new Parameter(new Object[]{ids}));
//	}
	
	public int updateHitsAddOne(String id);
//	{
//		return update("update Article set hits=hits+1 where id = :p1", new Parameter(id));
//	}
	
	public int updateExpiredWeight(Article article);
	
	public List<Category> findStats(Category category);
//	{
//		return update("update Article set weight=0 where weight > 0 and weightDate < current_timestamp()");
//	}
	//add by zhengyu
	public void updateDelflag(Article article);
	//end
	
	//add hefeng
	public String findArticleId(String userid);
	public Article findArticleListPage(String id);
	public List<Article> findListPage(Article article);
	public void deleteUserArticle(Article article);
	public void MergeArticle(String originalcategoryId,String categoryId,String articleId);
	//end
	
	//add by yinshh3 10月23 14:58
	/**
	 * 返回只有id和delflag两个属性的Article对象.被list装在
	 */
	public List<Article> getArticleID(User user);
	//end
	//add by luqibao
	public List<Article> findArticlesByCategoryId(String id,String userid);
	//根据SQL语句的拼接 返回文章的集合
	public List<Article> findArticlesBySql(String ids,String userid);
	
	public List<Article> findListByIds(Map	map);
	
	public List<Article> findListByTitle(String param,String userid);
	
	public List<Article> findListByLabelValue(String param,String userid);
	
	public List<Article> findListByContent(String param,String userid);
	
	public List<Article> findListByUser(User user);
	
	public void updateDel(Article article);

	public void revertMsgFlag(String articleId,String MsgFlag);
	
	public List<Article> getNewestArticle(Map map);

	public void MergeCategory(String originalcategoryId, String categoryId);
	
	public List<Article> findAllByCategoryId(Category category);
	//end
 	public List<String> findAllowShareCategoryIds();
//	
//	public String getArticelUserOfficeCompanyName(User user);
 	//add by yangshw6
 	public List<Article> getHotestArticle(Map map);
}
