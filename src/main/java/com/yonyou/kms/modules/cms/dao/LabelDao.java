package com.yonyou.kms.modules.cms.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.yonyou.kms.common.persistence.CrudDao;
import com.yonyou.kms.common.persistence.annotation.MyBatisDao;
import com.yonyou.kms.modules.cms.entity.Article;
import com.yonyou.kms.modules.cms.entity.Label;
@MyBatisDao
public interface LabelDao extends CrudDao<Label>{
	//获取标签排行，按知识数的多少进行排行，取前5条数据
	public List<Label> getHotLabelData(@Param(value="str")String schema);
	//获取知识关联标签,在文章浏览界面使用
//	public List<Label> getLabelConnArticle(String id);
//	//插入知识关联的标签,使用标签列表，将标签装载进去
//	public void insertLabelConnArticle(Label insert);
//	//删除知识关联的标签
//	public void deleteLabelConnArticle(Label label);
//	//更新知识关联的标签
//	public void updateLabelConnArticle(Label label);
//	//获取用户关联的标签，在个人中心显示
//	public List<Label> getLabelConnUser(String userid);
//	//插入用户关联的标签
//	public void insertLabelConnUser(Label insert);
//	//删除知识关联的标签
//	public void deleteLabelConnUser(Label label);
//	//更新用户关联的标签
//	public void updateLabelConnUser(Label label);
	//获取全部标签
	public List<Label> getAllLabel(Label label);
	//检查是否是重复的标签;
	public String findRepeatLabelName(String labelName);
//	//获取单个标签下的知识id
//	public List<Article>	getArticleinLabel(Label label);
//	//插入标签内容
	public int insert(Label label); 
	//更新标签内容
	public int update(Label label);
	//删除标签
	public int  delete(Label label);
	//批量查询，通过id，查标签的标题
	public List<String> batchget(List<String> labelid);
	//批量插入数据到缓存表(cms_label_count)
	public void batchinsert(@Param(value="list")List<Label> list,@Param(value="str")String schema);
	//批量更新数据到缓存表(cms_label_count)
	public void batchupdate(@Param(value="list")List<Label> list,@Param(value="str")String schema);
	//批量删除缓存表中的数据
	public void batchdelete(@Param(value="list")List<String> list,@Param(value="str")String schema);
	//获取缓存表中的所有id
	public List<String>	getAllid(@Param(value="str")String schema);
	//读取缓存表中的数据
	public List<Label> getLabelData();
	//标签的关联用户，知识数
//	public List<Label>	getLabelCountData();
	//是否有当前用户关联知识
//	public String getUserData(String userid);
//	//获取当前用户没有的标签
//	public List<Label> getDiffUserConnData(String userid);
	//获取当前用户未审批的标签
	public List<Label>	getUserUnexamineLabel(Label label);
	//显示未指定合并的标签
	public List<Label> findUnMergeLabel(String id);
	//更新关联文章的合并的标签
	public void updateMergeLabelbyArticle(String firstlabelid,String secondlabelid);
	//更新关联用户的合并的标签
	public void updateMergeLabelbyUser(String firstlabelid,String secondlabelid);
	//把合并后的新名字更新
	public void updateMergeLabel(String firstid,String newname);
	//找出拥有全部合并标签的文章(合并标签时重复)
	public List<String> findRepeatMergeLabelByArticle(String firstlabelid,String secondlabelid);
	//找出拥有全部合并标签的用户(合并标签时重复)
	public List<String> findRepeatMergeLabelByUser(String firstlabelid,String secondlabelid);
	//在关联文章表删除第二个合并的标签
	public void deleteMergeLabelbyArticle(Map map);
	//在关联用户表删除第二个合并的标签
	public void deleteMergeLabelbyUser(Map map);
	
	
	public void MergeArticle(String originalcategoryId,String categoryId,String articleId);
	public void MergeCategory(String originalcategoryId, String categoryId);
	
}
