package com.yonyou.kms.modules.cms.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.yonyou.kms.common.service.CrudService;
import com.yonyou.kms.modules.cms.dao.LabelDao;
import com.yonyou.kms.modules.cms.entity.Label;
import com.yonyou.kms.modules.cms.utils.ContributionUtil;
import com.yonyou.kms.modules.sys.utils.UserUtils;
/**
 * 
 * 标签的Service
 * 
 * @author yangshiwei
 *
 */
@Service
@Transactional(readOnly = false)
public class LabelService extends CrudService<LabelDao, Label> {
	@Autowired
	private LabelDao labeldao;
	
	
	/***
	 * 
	 * 
	 * */
	public List<Label> FindAllLabel(){
		List<Label> labelList=Lists.newArrayList();
		 Label label=new Label();
		labelList=labeldao.findList(label);;
		return labelList;
	};
	/*
	 * 取出标签关联知识表中的前5条数据，用于首页显示
	 * 
	 * 
	 */
	public List<Label>  getHotLabelData(){
		return labeldao.getLabelData();
	}
	/*
	 * 显示所有的标签
	 * 
	 */
	public List<Label> getAllLabel(Label la){
		List<Label> label=new ArrayList<Label>();
		label=labeldao.getAllLabel(la);
		return label;
	}
	/*
	 * 获取当前用户增加的未审批的标签
	 * 
	 * 
	 * 
	 */
	public List<Label> getUnexamineLabel(Label la){
		List<Label> label=new ArrayList<Label>();
		if(la.getUserid()==null || la.getUserid().equals("")){
		la.setUserid(UserUtils.getUser().getId());
		}
		label=labeldao.getUserUnexamineLabel(la);
		return label;
	}
	
	/*
	 * 显示所有标签和对应的关联数
	 * 
	 */
//	public List<Label> getLabelCountData(){
//		return labeldao.getLabelCountData();
//	}
	//删除标签
	public void delete(Label label){
		labeldao.delete(label);
	}
	//修改标签
	public void update(Label label){
		label.preUpdate();
		labeldao.update(label);
	}
	//插入标签
	public void insert(Label label){
		label.preInsert();
		System.out.println("id"+label.getId());
		labeldao.insert(label);
	}
//	//取出关联知识的标签
//	public List<Label>  getLabelConnArticle(String id){
//		List<Label> label=new ArrayList<Label>();
//		label=labeldao.getLabelConnArticle(id);
//		return label;
//	}
//	//插入关联知识的标签
//	public void insertLabelConnArticle(List<String> labelvalue,String articleid,String categoryid){
//		StringBuffer labellist=new StringBuffer();
//		for(int i=0;i<labelvalue.size();i++){
//			labellist.append(labelvalue.get(i)+",");
//		}
//		System.out.println("插入将标签转化为列表为"+labellist);
//		Label label=new Label();
//		label.setArticleid(articleid);
//		label.setLabellist(labellist.toString());
//		label.setCategoryid(categoryid);
//		labeldao.insertLabelConnArticle(label);
//	}
//	//更新关联知识的标签
//	public void updateLabelConnArticle(List<String> labelvalue,String articleid){
//		StringBuffer labellist=new StringBuffer();
//		for(int i=0;i<labelvalue.size();i++){
//			labellist.append(labelvalue.get(i)+",");
//		}
//		System.out.println("更新将标签转化为列表为"+labellist);
//		Label label=new Label();
//		label.setArticleid(articleid);
//		label.setLabellist(labellist.toString());
//		labeldao.updateLabelConnArticle(label);
//	}
//	//删除关联知识的单个标签，即为将剩下的标签更新到本标签
//	public void deleteLabelConnArticle(List<String> labelvalue,String articleid){
//		StringBuffer labellist=new StringBuffer();
//		for(int i=0;i<labelvalue.size();i++){
//			labellist.append(labelvalue.get(i)+",");
//		}
//		System.out.println("删除将标签转化为列表为"+labellist);
//		Label label=new Label();
//		label.setArticleid(articleid);
//		label.setLabellist(labellist.toString());
//		labeldao.updateLabelConnArticle(label);
//	}
	//取出用户关联的标签,分页显示
//	public Page<Label>	getLabelConnUser(Page<Label> page,Label label){
//		return findPage(page,label);
//	}
//	public List<Label>	getLabelConnUser(String userid){
//		return labeldao.getLabelConnUser(userid);
//	}
//	public Page<Label> findPage(Page<Label> page,Label entity) {
//			entity.setPage(page);
//			page.setList(dao.findList(entity));
//		return page;
//	}
	
	//取出对应标签下的，权限下的知识id,知识标题
//	public List<Article>	getArticleinLabel(Label label,List<String> categoryid){
//		List<Article> articlelist=new ArrayList<Article>();
//		articlelist=labeldao.getArticleinLabel(label);
//		List<Article> newlist=new ArrayList<Article>();
//		for(int i=0;i<articlelist.size();i++){
//			String id=articlelist.get(i).getCategory().getId();
//			String title=articlelist.get(i).getTitle();
//			for(int j=0;j<categoryid.size();j++){
//				String category=categoryid.get(j);
//				if(category.equals(id)){
//					Article article=new Article();
//					article.setId(articlelist.get(i).getId());
//					article.setTitle(title);
//					newlist.add(article);
//				}
//			}			
//		}
//		return newlist;
//	}
	//插入用户关联的标签
 
//	/*用户增加关注标签，显示用户没有的标签(分页显示)
//	 * @param page:分页对象
//	 * @param label:将userid传入
//	 */
//	public Page<Label> findDiffrentLabel(Page<Label> page,Label label){
//		label.setPage(page);
//		page.setList(dao.getDiffUserConnData(label.getUserid()));
//		return page;
//	}
	
	public void MergeArticle(String originalcategoryId,String categoryId,String articleId){
		dao.MergeArticle(originalcategoryId, categoryId, articleId);
	}
	public void MergeCategory(String originalcategoryId, String categoryId) {
		dao.MergeCategory(originalcategoryId, categoryId);
	}
	/*
	 * 
	 * 将标签的数据存入缓存表(cms_label_count)中,用于首页显示
	 * 
	 */
	public void saveData(String schema){
		List<Label>  list=new ArrayList<Label>();
		List<Label>  insertlist=new ArrayList<Label>();
		List<Label>  updatelist=new ArrayList<Label>();
		list=labeldao.getHotLabelData(schema);//取出计算好的数据
		List<String> idfromCount=new ArrayList<String>();
		idfromCount=labeldao.getAllid(schema);
		List<String> idfromlist=new ArrayList<String>();
		for(Label label:list){
			idfromlist.add(label.getId());
			int count=0;
			String id=label.getId();
			for(int j=0;j<idfromCount.size();j++){
				String did=idfromCount.get(j);
				if(id.equals(did)){
					count++;
					break;
				}
			}
			if(count==0){
				//System.out.println("count==0");
				insertlist.add(label);
				//System.out.println("insertlistpc的值为"+label.toString());
			}else if(count==1){
				//System.out.println("count==1");
				updatelist.add(label);
				//System.out.println("insertlistpc的值为"+label.toString());
			}
			
		}
		//查出差异的id，批量删除，校正数据正误
		List<String> diff=ContributionUtil.getDiffrent(idfromCount, idfromlist);
		if(diff.size()>0){
			labeldao.batchdelete(diff,schema);
		}
		if(insertlist.size()>0){
			//System.out.println("计算LabelCount出的插入数据为:"+insertlist.toString()+"-"+insertlist.size());
			
			labeldao.batchinsert(insertlist,schema);
		}
		if(updatelist.size()>0){
			//System.out.println(updatelist.size()+"---"+"计算LabelCount出的更新数据为:"+updatelist.toString()+"-"+updatelist.size());
			labeldao.batchupdate(updatelist,schema);
		}
	}
	//检查是否是重复的标签名,重复为:true,不重复为:false
	public boolean findRepeatLabelName(String labelName){
		boolean flag=false;
		String judge=labeldao.findRepeatLabelName(labelName);
		if(judge==null){
			return flag;
		}else{
			if(judge.equals(labelName)){
				flag=true;
				return flag;
			}
			return flag;
		}	
	}
	public boolean findRepeatLabelByMerge(String labelName,String id){
		boolean flag=false;
		Label label=labeldao.get(new Label(id));
		String judge=labeldao.findRepeatLabelName(labelName);
		if(judge==null){
			return flag;
		}else if(judge.equals(label.getLabelvalue())){
			return flag;
		}else{
			if(judge.equals(labelName)){
				flag=true;
				return flag;
			}
			return flag;
		}
	}
	//取得未指定的合并的标签
	public List<Label> findUnMergeLabel(String labelid){
		List<Label> labellist=new ArrayList<Label>();
		labellist=labeldao.findUnMergeLabel(labelid);
		return labellist;
	}
	//合并标签
	public void MergeLabel(String secondid,String firstid,String newname){
		List<String> arlist=labeldao.findRepeatMergeLabelByArticle(firstid, secondid);
		List<String> userlist=labeldao.findRepeatMergeLabelByUser(firstid, secondid);			
		if(arlist!=null &&arlist.size()>0){
			Map<String,Object> artmap=new HashMap<String,Object>();
			artmap.put("labelid",secondid);
			artmap.put("articleids", arlist);
			labeldao.deleteMergeLabelbyArticle(artmap);
		}
		if(userlist!=null &&userlist.size()>0){
			Map<String,Object> usermap=new HashMap<String,Object>();
			usermap.put("labelid",secondid);
			usermap.put("userids", userlist);
			labeldao.deleteMergeLabelbyUser(usermap);
		}
		labeldao.updateMergeLabelbyArticle(firstid, secondid);
		labeldao.updateMergeLabelbyUser(firstid, secondid);
		labeldao.updateMergeLabel(firstid, newname);
		labeldao.delete(new Label(secondid));
	}
}
