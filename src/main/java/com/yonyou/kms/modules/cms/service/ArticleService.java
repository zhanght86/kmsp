/**
 * 
 */
package com.yonyou.kms.modules.cms.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.yonyou.kms.common.config.Global;
import com.yonyou.kms.common.mapper.JsonMapper;
import com.yonyou.kms.common.persistence.BaseEntity;
import com.yonyou.kms.common.persistence.Page;
import com.yonyou.kms.common.service.CrudService;
import com.yonyou.kms.common.utils.CacheUtils;
import com.yonyou.kms.common.utils.StringUtils;
import com.yonyou.kms.modules.cms.dao.ArticleAttFileDao;
import com.yonyou.kms.modules.cms.dao.ArticleDao;
import com.yonyou.kms.modules.cms.dao.ArticleDataDao;
import com.yonyou.kms.modules.cms.dao.ArticleLabelDao;
import com.yonyou.kms.modules.cms.dao.CategoryDao;
import com.yonyou.kms.modules.cms.dao.RecommendDao;
import com.yonyou.kms.modules.cms.dao.StoreDao;
import com.yonyou.kms.modules.cms.entity.Article;
import com.yonyou.kms.modules.cms.entity.ArticleAttFile;
import com.yonyou.kms.modules.cms.entity.ArticleData;
import com.yonyou.kms.modules.cms.entity.Category;
import com.yonyou.kms.modules.cms.entity.Store;
import com.yonyou.kms.modules.cms.utils.CmsUtils;
import com.yonyou.kms.modules.oa.service.OaNotifyService;
import com.yonyou.kms.modules.sys.dao.UserDao;
import com.yonyou.kms.modules.sys.entity.User;
import com.yonyou.kms.modules.sys.utils.FileStorageUtils;
import com.yonyou.kms.modules.sys.utils.UserUtils;

/**
 * 文章Service
 * @author hotsum
 * @version 2013-05-15
 */
@Service
@Transactional(readOnly = true)
public class ArticleService extends CrudService<ArticleDao, Article> {

	@Autowired
	private ArticleDataDao articleDataDao;
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private ArticleDao articleDao;
	@Autowired
	private StoreDao storeDao;
	@Autowired
	private OaNotifyService oaNotifyService;
	@Autowired
	private ArticleAttFileService articleAttFileService;
	@Autowired
	private ArticleLabelService articleLabelService;
	@Autowired
	private ArticleLabelDao articleLabelDao;
	@Autowired
	private RecommendDao recommendDao;
	@Autowired
	private ArticleAttFileDao articleAttFileDao;
	@Autowired
	private CategoryService categoryService;
	//huangmj 2015.11.12
	@Autowired
	private UserDao userDao;
	
	//审核变发布，huangmj6 2015.10.22
	public void update(Article article){
		dao.update(article);
	}
	
	public User getArticleUser(User user){
		return userDao.get(user);
	}
	
	@Transactional(readOnly = false)
	public Page<Article> findPage(Page<Article> page, Article article, boolean isDataScopeFilter) {
		// 更新过期的权重，间隔为“6”个小时
		Date updateExpiredWeightDate =  (Date)CacheUtils.get("updateExpiredWeightDateByArticle");
		if (updateExpiredWeightDate == null || (updateExpiredWeightDate != null 
				&& updateExpiredWeightDate.getTime() < new Date().getTime())){
			dao.updateExpiredWeight(article);
			CacheUtils.put("updateExpiredWeightDateByArticle", DateUtils.addHours(new Date(), 6));
		}
//		DetachedCriteria dc = dao.createDetachedCriteria();
//		dc.createAlias("category", "category");
//		dc.createAlias("category.site", "category.site");
		if (article.getCategory()!=null && org.apache.commons.lang3.StringUtils.isNotBlank(article.getCategory().getId()) && !Category.isRoot(article.getCategory().getId())){
			Category category = categoryDao.get(article.getCategory().getId());
			if (category==null){
				category = new Category();
			}
			category.setParentIds(category.getId());
			category.setSite(category.getSite());
			article.setCategory(category);
		}
		else{
			
			article.setCategory(new Category());
		}
//		if (StringUtils.isBlank(page.getOrderBy())){
//			page.setOrderBy("a.weight,a.update_date desc");
//		}
//		return dao.find(page, dc);
	//	article.getSqlMap().put("dsf", dataScopeFilter(article.getCurrentUser(), "o", "u"));
		//设置分页数 15 huangmj 2015 11 29
		page.setPageSize(12);
		return super.findPage(page, article);
		
	}

	@Override
	@Transactional(readOnly = false)
	public String save(Article article) {
		if (article.getArticleData().getContent()!=null){
			article.getArticleData().setContent(StringEscapeUtils.unescapeHtml4(
					article.getArticleData().getContent()));
		}
		// 改为待审核状态
		//article.setDelFlag(BaseEntity.DEL_FLAG_AUDIT);
//		if (!UserUtils.getSubject().isPermitted("cms:article:audit")){
//			
//		}
		// 如果栏目不需要审核，则将该内容设为发布状态
//		if (article.getCategory()!=null&&org.apache.commons.lang3.StringUtils.isNotBlank(article.getCategory().getId())){
//			Category category = categoryDao.get(article.getCategory().getId());
//			if (!Global.YES.equals(category.getIsAudit())){
//				article.setDelFlag(BaseEntity.DEL_FLAG_NORMAL);
//			}
//		}
		article.setUpdateBy(UserUtils.getUser());
		article.setUpdateDate(new Date());
        if (org.apache.commons.lang3.StringUtils.isNotBlank(article.getViewConfig())){
            article.setViewConfig(StringEscapeUtils.unescapeHtml4(article.getViewConfig()));
        }
        
        ArticleData articleData = new ArticleData();;
		if (org.apache.commons.lang3.StringUtils.isBlank(article.getId())){
			article.preInsert();
			articleData = article.getArticleData();
			articleData.setId(article.getId());
			dao.insert(article);
			articleDataDao.insert(articleData);
		}else{
			article.preUpdate();
			articleData = article.getArticleData();
			articleData.setId(article.getId());
			dao.update(article);
			articleDataDao.update(article.getArticleData());
		}
		return "";
	}
	
	//新增文章状态下调用 huangmj 2015.10.21
	@Transactional(readOnly = false)
	public void save_insert(Article article,String temp_article_id) {
		if (article.getArticleData().getContent()!=null){
			article.getArticleData().setContent(StringEscapeUtils.unescapeHtml4(
					article.getArticleData().getContent()));
		}
		// 如果没有审核权限，则将当前内容改为待审核状态
	//	article.setDelFlag(BaseEntity.DEL_FLAG_AUDIT);
//		if (!UserUtils.getSubject().isPermitted("cms:article:audit")){
//			
//		}
		// 如果栏目不需要审核，则将该内容设为发布状态
//		if (article.getCategory()!=null&&org.apache.commons.lang3.StringUtils.isNotBlank(article.getCategory().getId())){
//			Category category = categoryDao.get(article.getCategory().getId());
//			if (!Global.YES.equals(category.getIsAudit())){
//				article.setDelFlag(BaseEntity.DEL_FLAG_NORMAL);
//			}
//		}
		
		article.setUpdateBy(UserUtils.getUser());
		article.setUpdateDate(new Date());
        if (org.apache.commons.lang3.StringUtils.isNotBlank(article.getViewConfig())){
            article.setViewConfig(StringEscapeUtils.unescapeHtml4(article.getViewConfig()));
        }
        
        	ArticleData articleData = new ArticleData();
        	//设置新增文章ID
    	    article.setId(temp_article_id);
			article.preInsert_insert();
			articleData = article.getArticleData();
			articleData.setId(article.getId());
			dao.insert(article);
			articleDataDao.insert(articleData);
		
	}
	
	@Transactional(readOnly = false)
	public void delete(Article article, Boolean isRe) {
//		dao.updateDelFlag(id, isRe!=null&&isRe?Article.DEL_FLAG_NORMAL:Article.DEL_FLAG_DELETE);
		// 使用下面方法，以便更新索引。
		//Article article = dao.get(id);
		//article.setDelFlag(isRe!=null&&isRe?Article.DEL_FLAG_NORMAL:Article.DEL_FLAG_DELETE);
		//dao.insert(article);
		super.delete(article);
	}
	
	/**
	 * 通过编号获取内容标题
	 * @return new Object[]{栏目Id,文章Id,文章标题}
	 */
	public List<Object[]> findByIds(String ids) {
		if(ids == null){
			return new ArrayList<Object[]>();
		}
		List<Object[]> list = Lists.newArrayList();
		String[] idss = org.apache.commons.lang3.StringUtils.split(ids,",");
		Article e = null;
		for(int i=0;(idss.length-i)>0;i++){
			e = dao.get(idss[i]);
			list.add(new Object[]{e.getCategory().getId(),e.getId(),StringUtils.abbr(e.getTitle(),50)});
		}
		return list;
	}
	
	//add hefeng
	/**
	 * 还原消息标志
	 */
	@Transactional(readOnly = false)
	public void revertMsgFlag(String articleId){
		dao.revertMsgFlag(articleId,"00");
	}
	@Transactional(readOnly = false)
	public void MergeArticle(String originalcategoryId,String categoryId,String articleId){
		dao.MergeArticle(originalcategoryId, categoryId, articleId);
	}
	/**
	 * 预处理调用不同更新消息
	 * //标志简介：无更新（00），内容更新（10），附件更新（01），内容和附件更新（11）
	 */
	public void PretreatmentUpdateUserMsg(String articleId) {
		String flag="";
		if(articleId==null){
			articleId="";
		}
		Article article=new Article();
		article=this.get(articleId);
		if(article==null){
			
		}else{
			flag=article.getRemarks();
		}
		if(flag==null){
			flag="00";
		}
		if("10".equals(flag)){
			this.updateUserMessage(article);
		}else if("01".equals(flag)){
			this.updateUserMessage(article, 0);//第二个参数暂时不用
		}else if("11".equals(flag)){
			this.updateUserMessage(article);
			this.updateUserMessage(article, 0);
		}else{
			
		}
	}
		
		@Transactional(readOnly=false)
		public void deleteUserArticle(Article article, Boolean isRe) {
			if(article==null){
				article=new Article();
			}
			dao.deleteUserArticle(article);
		}
		/**
		 * 获取当前用户所有文章的编号
		 * @return String{编号集合 "1,2,3..."}
		 * @author hefeng
		 */
		public String getArticleIdByUserId(){
			
			String currentId=UserUtils.getUser().getId();
			String ArticleListId = dao.findArticleId(currentId);
			return ArticleListId;
		}
		
		/**
		 * 更新文章内容后发送消息给收藏、推荐这篇知识的所有用户
		 * @return 
		 * @author hefeng
		 */
		public void updateUserMessage(Article article) {
		if (article == null) {
			article = new Article();
		}
//		SimpleDateFormat df =  new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy",Locale.US);
//		Date d1 = null;
//		Date d2 = null;
		StringBuffer stringbufferstore=new StringBuffer();
		for (int i = 0; i < storeDao.getStore(article.getId()).size(); i++) {
//			try {
//				d1 = df.parse(articleDao.get(article.getId()).getUpdateDate()
//						.toString());
//				d2 = df.parse(storeDao.getStore(article.getId()).get(i)
//						.getUpdateDate().toString());
//			} catch (ParseException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			if (d1.getTime() > d2.getTime()) {
			String thisstoreuserid=articleDao.get(article.getId()).getCreateBy().getId();
			if(storeDao.getStore(article.getId()).get(i).getCreateBy().getId().equals(thisstoreuserid)){
				
			}else{
				stringbufferstore.append(storeDao.getStore(article.getId()).get(i).getCreateBy()+",");
			}
				
//			}
		}
		Article articlestore=new Article();
		articlestore.setTitle(article.getTitle());
		articlestore.setCreateBy(UserUtils.getUser());
		articlestore.setUpdateBy(UserUtils.get(article.getUpdateBy().getId()));
		articlestore.setId(article.getId());
		oaNotifyService.save(oaNotifyService.PretreatmentMsgBeforeSave(articlestore, "1", "1", stringbufferstore.toString()));
		
		StringBuffer stringbufferrecommend=new StringBuffer();
		for(int j=0;j<recommendDao.getRecommendList(article.getId()).size();j++){
			String thisrecommenduserid=articleDao.get(article.getId()).getCreateBy().getId();
			if(recommendDao.getRecommendList(article.getId()).get(j).getCreateBy().getId().equals(thisrecommenduserid)){
				
			}else{
				stringbufferrecommend.append(recommendDao.getRecommendList(article.getId()).get(j).getCreateBy()+",");
			}
		}
		Article articlerecommend=new Article();
		articlerecommend.setTitle(article.getTitle());
		articlerecommend.setCreateBy(UserUtils.getUser());
		articlerecommend.setUpdateBy(UserUtils.get(article.getUpdateBy().getId()));
		articlerecommend.setId(article.getId());
		oaNotifyService.save(oaNotifyService.PretreatmentMsgBeforeSave(articlerecommend, "2", "1", stringbufferrecommend.toString()));
	}	
		/**
		 * 更新文章附件后发送消息给收藏、推荐这篇知识的所有用户(待定)
		 * @return 
		 * @author hefeng
		 */
		public void updateUserMessage(Article article,int sumdiff) {
		if (article == null) {
			article = new Article();
		}
		StringBuffer stringbufferstore=new StringBuffer();
		for (int i = 0; i < storeDao.getStore(article.getId()).size(); i++) {
			String thisstoreuserid=articleDao.get(article.getId()).getCreateBy().getId();
			if(storeDao.getStore(article.getId()).get(i).getCreateBy().getId().equals(thisstoreuserid)){
				
			}else{
			stringbufferstore.append(storeDao.getStore(article.getId()).get(i).getCreateBy()+",");
			}
		}
		Article articlestore=new Article();
		articlestore.setTitle(article.getTitle());
		articlestore.setCreateBy(UserUtils.getUser());
		articlestore.setUpdateBy(UserUtils.get(article.getUpdateBy().getId()));
		articlestore.setId(article.getId());
		oaNotifyService.save(oaNotifyService.PretreatmentMsgBeforeSave(articlestore, "1", "2", stringbufferstore.toString()));
		
		StringBuffer stringbufferrecommend=new StringBuffer();
		for(int j=0;j<recommendDao.getRecommendList(article.getId()).size();j++){
			String thisrecommenduserid=articleDao.get(article.getId()).getCreateBy().getId();
			if(recommendDao.getRecommendList(article.getId()).get(j).getCreateBy().getId().equals(thisrecommenduserid)){
				
			}else{
			stringbufferrecommend.append(recommendDao.getRecommendList(article.getId()).get(j).getCreateBy()+",");
			}
		}
		Article articlerecommend=new Article();
		articlerecommend.setTitle(article.getTitle());
		articlerecommend.setCreateBy(UserUtils.getUser());
		articlerecommend.setUpdateBy(UserUtils.get(article.getUpdateBy().getId()));
		articlerecommend.setId(article.getId());
		oaNotifyService.save(oaNotifyService.PretreatmentMsgBeforeSave(articlerecommend, "2", "2", stringbufferrecommend.toString()));
	}
	// add yinshh3
		/**
		 * @param 用户对象
		 * return 某个用户所有知识状态的集合()
		 */
		public List<String> getAllDelFlagByUserId(User user){
			
			List<Article> articlelist=articleDao.getArticleID(user);
			List<String> delFlagList=Lists.newArrayList();
			String delFlag=null;
			for(Article article:articlelist){
				delFlag=article.getDelFlag();
				delFlagList.add(delFlag);
			}
			return delFlagList;
		}
		//end
		
		@Transactional(readOnly = false)
		public Page<Article> findArticleListPage(Page<Article> page, Article article, boolean isDataScopeFilter) {
			article.setCreateBy(UserUtils.getUser());
			article.setPage(page);
			page.setList(dao.findListPage(article));
			return page;
		}
	//end
		
	/**
	 * 点击数加一
	 */
	@Transactional(readOnly = false)
	public void updateHitsAddOne(String id) {
		dao.updateHitsAddOne(id);
	}
	
	/**
	 * 更新索引
	 */
	public void createIndex(){
		//dao.createIndex();
	}
	
	/**
	 * 全文检索
	 */
	//FIXME 暂不提供检索功能
	public Page<Article> search(Page<Article> page, String q, String categoryId, String beginDate, String endDate){
		
		// 设置查询条件
//		BooleanQuery query = dao.getFullTextQuery(q, "title","keywords","description","articleData.content");
//		
//		// 设置过滤条件
//		List<BooleanClause> bcList = Lists.newArrayList();
//
//		bcList.add(new BooleanClause(new TermQuery(new Term(Article.FIELD_DEL_FLAG, Article.DEL_FLAG_NORMAL)), Occur.MUST));
//		if (StringUtils.isNotBlank(categoryId)){
//			bcList.add(new BooleanClause(new TermQuery(new Term("category.ids", categoryId)), Occur.MUST));
//		}
//		
//		if (StringUtils.isNotBlank(beginDate) && StringUtils.isNotBlank(endDate)) {   
//			bcList.add(new BooleanClause(new TermRangeQuery("updateDate", beginDate.replaceAll("-", ""),
//					endDate.replaceAll("-", ""), true, true), Occur.MUST));
//		}   
		
		//BooleanQuery queryFilter = dao.getFullTextQuery((BooleanClause[])bcList.toArray(new BooleanClause[bcList.size()]));

//		System.out.println(queryFilter);
		
		// 设置排序（默认相识度排序）
		//FIXME 暂时不提供lucene检索
		//Sort sort = null;//new Sort(new SortField("updateDate", SortField.DOC, true));
		// 全文检索
		//dao.search(page, query, queryFilter, sort);
		// 关键字高亮
		//dao.keywordsHighlight(query, page.getList(), 30, "title");
		//dao.keywordsHighlight(query, page.getList(), 130, "description","articleData.content");
		
		return page;
	}
	/**
	 * 
	 * 
	 * @param categoryId 分类ids
	 * @param q keywords
	 * @param labelId 标签ids
	 * @return 
	 */
	//add by luqibao
	@SuppressWarnings("unchecked")
	public List<Article> search(String categoryId, String q, String labelId){
		
		List<Article> articles=Lists.newArrayList();//存放文章
		List<Map<String,Object>> maps=Lists.newArrayList();//阿里云返回字段的map集合
		List<Article> articleTemp=null;
		List<Article> labelArticles=Lists.newArrayList();//存放标签的文章
		List<Article> categoryArticles=Lists.newArrayList();//存放知识分类的文章
		List<Article> keywordsArticles=Lists.newArrayList();//关键字的文章
		/*
		 * 对传进来的参数进行加工  返回id的集合
		 */
		List<String> categoryIds=CmsUtils.transform(categoryId, ",");//分类id
		List<String> labelIds=CmsUtils.transform(labelId, ",");//标签id
		List<String> qs=CmsUtils.transform(q, " ");//keywords 集合
		List<String> articleIds=Lists.newArrayList(); //文章id集合
		
		//start   从阿里云取出数据
		//取出阿里云返回的map集合
		if(qs.size()>0&&qs!=null){
			for(String keyword:qs){
				//System.out.println("keyword::|"+keyword+"|");
				List<Map<String,Object>> temp=FileStorageUtils.search(keyword);
				//System.out.println(JsonMapper.toJsonString(temp));
				if(temp==null&&temp.size()<=0){
					continue;
				}
				for(Map map:temp){
					maps.add(map);
				}
			}
		}
		//获取本地数据库附件表中的id和一些附件相关的信息
		ArticleAttFile articleAttFile=null;
		for(Map map:maps){
			//System.out.println("identifier:"+map.get("identifier"));
			articleAttFile=new ArticleAttFile();
			articleAttFile.setAttfilekey((String)map.get("identifier"));
			ArticleAttFile temp=articleAttFileService.findRecordByAttFileKey(articleAttFile);
			if(temp!=null){
				articleIds.add(temp.getActicleid());
			}
		}

		//System.out.println("==000==");
		if(articleIds!=null&&articleIds.size()>0){
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("ids",articleIds);
			map.put("userid",UserUtils.getUser().getId());
			articleTemp=articleDao.findListByIds(map);
			//System.out.println("查询完成。。。。。。");
			if(articleTemp!=null||articleTemp.size()>0){
				keywordsArticles.addAll(articleTemp);
				//articles.addAll(articleTemp);
			}
		}

		System.out.println("==111===");
		//end   从阿里云取出数据
		
		//start 根据分类id的集合取出文章的集合
		if(categoryIds!=null&&categoryIds.size()>0){
			for(String category:categoryIds){
				articleTemp=articleDao.findArticlesByCategoryId(category,UserUtils.getUser().getId());
				if(articleTemp!=null||articleTemp.size()>0){
					//articles.addAll(articleTemp);
					categoryArticles.addAll(articleTemp);
				}
			}
		}
		//System.out.println("==222===");
		//end 根据标签id的集合取出文章的集合
		if(labelIds.size()>0&&labelIds!=null){
			for(String label:labelIds){
				//System.out.println("id:"+label);
				articleTemp=articleLabelDao.findArticlesByLabelId(label,UserUtils.getUser().getId());
				//System.out.println("标签id："+articleTemp.size());
				if(articleTemp!=null||articleTemp.size()>0){
					//articles.addAll(articleTemp);
					labelArticles.addAll(articleTemp);
				}
			}
		}

		//System.out.println("==333===");
		if(qs.size()>0){
			//当搜索框中是标题的时候
			articleTemp=articleDao.findListByTitle(containsSql(qs),UserUtils.getUser().getId());
		
		if(articleTemp!=null||articleTemp.size()>0){
			keywordsArticles.addAll(articleTemp);
		}
		//System.out.println("==444===");
		//当搜索框中是标签的时候
		articleTemp=articleDao.findListByLabelValue(containsSql(qs),UserUtils.getUser().getId());
		//System.out.println("标签："+articleTemp.size());
		if(articleTemp!=null||articleTemp.size()>0){
			keywordsArticles.addAll(articleTemp);
		}
		//System.out.println("==555===");
		//当搜索框中是内容的时候
		articleTemp=articleDao.findListByContent(containsSql(qs),UserUtils.getUser().getId());
		if(articleTemp!=null||articleTemp.size()>0){
			keywordsArticles.addAll(articleTemp);
		}
		}
		
		//System.out.println("==666===");
		//start 将数据作为AND的关系
		articles.addAll(keywordsArticles);
		articles.addAll(labelArticles);
		articles.addAll(categoryArticles);
//		for(Article a:articles){
//			System.out.println(a.getTitle());
//		}
		if(keywordsArticles!=null&&!StringUtils.isEmpty(q)){
			articles.retainAll(keywordsArticles);
		}
		if(labelArticles!=null&&!StringUtils.isEmpty(labelId)){
			articles.retainAll(labelArticles);
		}
		if(categoryArticles!=null&&!StringUtils.isEmpty(categoryId)){
			articles.retainAll(categoryArticles);
		}
		//end
		//System.out.println("777");
		User user=UserUtils.getUser();
		//去除重复的文章
		//System.out.println("888");
		List<Article> temp=Lists.newArrayList();
		Store store=null;
		Category category=null;
		for(Article article:articles){
			if(!temp.contains(article)){
				String articleId=article.getId();
				//start 将收藏信息放进去
				store=new Store();
				store.setCreateBy(user);
				store.setTitleId(articleId);
				store=storeDao.get(store);
				article.setStore(store);	
				String categoryid=CmsUtils.getArticlecid(articleId);
				String path=CmsUtils.getCategoryStringByIds(categoryid);
				String categoryName=CmsUtils.getArticleCategoryName(articleId);
				String fPath=path+categoryName;
				category=article.getCategory();
				category.setName(categoryName);
				article.setCategory(category);
				article.setPath(fPath);
				//end 
				temp.add(article);
			}
		}
		//add by yangshw6
		//System.out.println("搜索:"+JsonMapper.toJsonString(temp.size()));
		List<Article>	newtemp=CmsUtils.filterArticle(temp);
		//System.out.println("搜索:"+JsonMapper.toJsonString(newtemp.size()));
//		for(Article artic:newtemp){
//			System.out.println("搜索结果为:"+JsonMapper.toJsonString(artic));
//		}
		//end by yangshw6
		return newtemp;
		
	}
	//拼接sql 这部分sql是contains（）后面的条件
//	private String baseSql(List<String> list){
//		
//		StringBuffer sb=new StringBuffer();
//		if(list.size()<=0||list==null){
//			return null;
//		}
//		sb.append("'");
//		for(int i=0;i<=list.size()-2;i++){
//			sb.append(list.get(i)+",");
//		}
//		sb.append(list.get(list.size()-1)+"'");
//		return sb.toString();
//	}
	private String containsSql(List<String> list){
		
		StringBuffer sb=new StringBuffer();
		if(list==null&&list.size()<=0){
			return null;
		}
		for(int i=0;i<=list.size()-2;i++){
			sb.append(list.get(i)+",");
		}
		sb.append(list.get(list.size()-1));
		return sb.toString();
	}
	/**
	 * 
	 * @return 最新的200条知识.
	 */
	public List<Article> getNewestArticle(){
		List<Article> articleList=Lists.newArrayList();
		Map<String,Object> map=new HashMap<String,Object>();
		List<String> categoryids=categoryService.findCategoryIdByUser(null);
		if(categoryids==null || categoryids.size()==0){
			return articleList;
		}
		map.put("userid",UserUtils.getUser().getId());
		map.put("categoryids",categoryids);
		articleList=articleDao.getNewestArticle(map);
		for(Article article:articleList){
			String articleId=article.getId();
			String categoryid=CmsUtils.getArticlecid(articleId);
			String path=CmsUtils.getCategoryStringByIds(categoryid);
			String categoryName=CmsUtils.getArticleCategoryName(articleId);
			String fPath=path+categoryName;
			article.setPath(fPath);
		}
		return articleList;
	}

	public void MergeCategory(String originalcategoryId, String categoryId) {
		dao.MergeCategory(originalcategoryId, categoryId);
	}
	/*
	 * 获取热门知识的前200条数据
	 * 
	 */
	public List<Article> getHotestArticle(){
		List<Article> articlelist=new ArrayList<Article>();
		Map<String,Object> map=new HashMap<String,Object>();
		List<String> categoryids=categoryService.findCategoryIdByUser(null);
		if(categoryids==null || categoryids.size()==0){
			return articlelist;
		}
		map.put("userid",UserUtils.getUser().getId());
		map.put("categoryids",categoryids);
		articlelist=articleDao.getHotestArticle(map);
		for(Article article:articlelist){
			String articleId=article.getId();
			String categoryid=CmsUtils.getArticlecid(articleId);
			String path=CmsUtils.getCategoryStringByIds(categoryid);
			String categoryName=CmsUtils.getArticleCategoryName(articleId);
			String fPath=path+categoryName;
			article.setPath(fPath);
		}
		return articlelist;
	}
}
