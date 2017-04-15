package com.yonyou.kms.modules.cms.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yonyou.kms.common.mapper.JsonMapper;
import com.yonyou.kms.common.service.CrudService;
import com.yonyou.kms.modules.cms.dao.ArticleLabelDao;
import com.yonyou.kms.modules.cms.dao.LabelDao;
import com.yonyou.kms.modules.cms.entity.Article;
import com.yonyou.kms.modules.cms.entity.ArticleLabel;
import com.yonyou.kms.modules.cms.entity.Label;
@Service
@Transactional(readOnly = false)
public class ArticleLabelService extends CrudService<ArticleLabelDao, ArticleLabel>{
	@Autowired
	private ArticleLabelDao articlelabeldao;
	@Autowired
	private LabelDao	labeldao;
	
	public List<Label> findLabelByArticle (String articleId){
		List<Label> list = dao.findLabelByArticle(articleId);
		return list;
	}
	
	//保存标签到article表中，同时插入到cms_label_conn_arti表中,必须是知识已经插入到表中
	/*
	 * @param labellist：标签id的集合,
	 * @param article:知识的实体，里面必须有知识id，知识分类id
	 * 
	 */
	public void save(List<String> labellist,Article article){
		//for(int i=0;i<labellist.size();i++)
			//System.out.println("labellist:"+labellist.get(i));
		if(labellist.size()==0||labellist==null){
			articlelabeldao.updateInsertArticle("",article.getId());
			List<String>  newlist=articlelabeldao.findLabelId(article.getId());
			if(newlist==null | newlist.size()==0){
				return;
			}else{
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("articleid", article.getId());
				map.put("labelids", newlist);
				articlelabeldao.batchdelete(map);
				return;
			}
		}
		List<String>  insertlist=new ArrayList<String>();
		List<String>  list=articlelabeldao.findLabelId(article.getId());
		List<String>  deletelist=new ArrayList<String>();
		//System.out.println("article"+article.getId()+"---"+article.getCategory().getId());
		if(list.size()==0 || list==null){
			insertlist=labellist;
		}else{
			for(int i=0;i<labellist.size();i++){
				String id=labellist.get(i);
				int count=0;
				for(int j=0;j<list.size();j++){
					String lid=list.get(j);
					if(id.equals(lid)){
						count++;
						list.remove(j);
						break;
					}			
				}if(count==0){
					insertlist.add(labellist.get(i));
				}
			}
			//System.out.println("list.size="+list.size());
			if(list.size() != 0 && list!=null){
				System.out.println("删除的数据为"+JsonMapper.toJsonString(list));
//				StringBuffer sb=new StringBuffer();
//				for(int i=0;i<list.size();i++){
//					if(i==list.size()-1){
//						sb.append("'"+list.get(i)+"'");
//						break;
//					}
//					sb.append("'"+list.get(i)+"'"+",");
//				}
//				System.out.println("删除的数据为"+sb.toString());
//				ArticleLabel articlelaebl=new ArticleLabel();
//				articlelaebl.setArticleid(article.getId());
//				articlelaebl.setLabellist(sb.toString());
				Map<String,Object> map=new HashMap<String,Object>();
				map.put("articleid", article.getId());
				map.put("labelids", list);
				articlelabeldao.batchdelete(map);
			}
		}
		if(insertlist==null||insertlist.size()==0){
			List<String>  la=new ArrayList<String>();
			la=labeldao.batchget(labellist);
			StringBuffer sb=new StringBuffer();
			//System.out.println("标签的标题为"+la.size());
			for(int i=0;i<la.size();i++){
				System.out.println("标签的标题为"+la.get(i));
				sb.append(la.get(i)+",");
			}
			if(sb.length()==0){
				return;
			}
			articlelabeldao.updateInsertArticle(sb.toString(),article.getId());
			return;
		}
		List<ArticleLabel> al=new ArrayList<ArticleLabel>();	
		for(int i=0;i<insertlist.size();i++){
			ArticleLabel ar=new ArticleLabel();
			ar.preInsert();
			ar.setLabelid(insertlist.get(i));
			ar.setArticleid(article.getId());
			ar.getCategory().setId(article.getCategory().getId());
			al.add(ar);
		}
		if(al.size()==0){
			//System.out.println("al为空");
		}
		for(int i=0;i<al.size();i++){
			//System.out.println("知识插入的标签为:"+al.get(i).getLabelid()+"--"+al.get(i).getId());
			
		}
		//System.out.println("插入开始。。。。。。");
		articlelabeldao.batchInsert(al);
		//System.out.println("插入结束。。。。。。");
		List<String>  la=new ArrayList<String>();
		la=labeldao.batchget(labellist);
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<la.size();i++){
			//System.out.println("标签的标题为"+la.get(i));
			sb.append(la.get(i)+",");
		}
		if(sb.length()==0){
			return;
		}
		articlelabeldao.updateInsertArticle(sb.toString(),article.getId());
	}
	/*
	 * 
	 * 取得知识关联的标签，通过知识id取得
	 */
	public List<String>  getLabel(String articleid){
		List<String>  labellist=new ArrayList<String>();
		labellist=articlelabeldao.getArticleLabel(articleid);
		return labellist;
	}
	//增加关联文章的标签,不显示已有的标签
	public List<Label> addLabelToArticle(String articleid){
		List<Label> newlist=new ArrayList<Label>();
		List<Label>	 al=new ArrayList<Label>();
		List<Label>	 label=new ArrayList<Label>();
		al=articlelabeldao.findLabelByArticle(articleid);//文章关联的标签
		label=labeldao.getAllLabel(new Label());//全部标签
//		for(int i=0;i<label.size();i++){
//			//System.out.println("标签为"+label.get(i).getId()+"--"+label.get(i).getLabelvalue());
//		}
		for(int i=0;i<label.size();i++){
			String id=label.get(i).getId();
			int count=0;
			//System.out.println("标签为：id="+id+"--"+label.get(i).getLabelvalue());
			for(int j=0;j<al.size();j++){
				String lid=al.get(j).getId();
				//System.out.println("标签为：lid="+lid+al.get(j).getLabelvalue());
				if(id.equals(lid)){
					count++;
				}
			}
			//System.out.println("count="+count);
			if(count==0){
				newlist.add(label.get(i));
			}
		}
		return newlist;
	}
	
	
	
}
