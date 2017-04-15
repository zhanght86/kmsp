
package com.yonyou.kms.modules.cms.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aliyun.oss.model.PutObjectResult;
import com.google.common.collect.Lists;
import com.yonyou.kms.common.mapper.JsonMapper;
import com.yonyou.kms.common.persistence.Page;
import com.yonyou.kms.common.service.BaseService;
import com.yonyou.kms.common.utils.IdGen;
import com.yonyou.kms.common.utils.StringUtils;
import com.yonyou.kms.common.web.BaseController;
import com.yonyou.kms.modules.cms.entity.Article;
import com.yonyou.kms.modules.cms.entity.ArticleAttFile;
import com.yonyou.kms.modules.cms.entity.ArticleData;
import com.yonyou.kms.modules.cms.entity.Category;
import com.yonyou.kms.modules.cms.entity.Label;
import com.yonyou.kms.modules.cms.entity.Site;
import com.yonyou.kms.modules.cms.entity.Switch;
import com.yonyou.kms.modules.cms.service.ArticleAttFileService;
import com.yonyou.kms.modules.cms.service.ArticleDataService;
import com.yonyou.kms.modules.cms.service.ArticleLabelService;
import com.yonyou.kms.modules.cms.service.ArticleService;
import com.yonyou.kms.modules.cms.service.CategoryService;
import com.yonyou.kms.modules.cms.service.FileTplService;
import com.yonyou.kms.modules.cms.service.LabelService;
import com.yonyou.kms.modules.cms.service.SiteService;
import com.yonyou.kms.modules.cms.service.SwitchService;
import com.yonyou.kms.modules.cms.utils.CmsUtils;
import com.yonyou.kms.modules.cms.utils.ConvertVideo;
import com.yonyou.kms.modules.cms.utils.FileDelete;
import com.yonyou.kms.modules.cms.utils.Office2PdfUtil;
import com.yonyou.kms.modules.cms.utils.TplUtils;
import com.yonyou.kms.modules.sys.entity.User;
import com.yonyou.kms.modules.sys.entity.UserSchema;
import com.yonyou.kms.modules.sys.utils.FileStorageUtils;
import com.yonyou.kms.modules.sys.utils.SchemaUtils;
import com.yonyou.kms.modules.sys.utils.UserUtils;

/**
 * 文章Controller
 * @author hotsum
 * @version 2013-3-23
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/article")
public class ArticleController extends BaseController {

	@Autowired
	private ArticleService articleService;
	@Autowired
	private ArticleDataService articleDataService;
	@Autowired
	private CategoryService categoryService;
    @Autowired
   	private FileTplService fileTplService;
    @Autowired
   	private SiteService siteService;
    @Autowired
    private ArticleAttFileService articleAttFileService;
    @Autowired
    private LabelService labelService;
    @Autowired 
    private ArticleLabelService articleLabelService;
    @Autowired
    private SwitchService switchService;
   
	
	@ModelAttribute
	public Article get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return articleService.get(id);
		}else{
			return new Article();
		}
	}
	
	@RequiresPermissions("cms:article:view")
	@RequestMapping(value = {"list", ""})
	public String list(Article article, HttpServletRequest request, HttpServletResponse response, Model model) {
		
        Page<Article> page = articleService.findPage(new Page<Article>(request, response), article, true); 
        
        //add by luqibao 将不符合情况的文章筛选出来
    
        List<Article> list=Lists.newArrayList();
        list=page.getList();
        List<Category> categorys = categoryService.findByUser(true, null,BaseService.CATEGORY_PLACE_SYS);
        List<String> ids=Lists.newArrayList();
        for(Category a:categorys){
        	ids.add(a.getId());
        }
        List<Article> temp=Lists.newArrayList();
        if(list!=null){
        	for(Article a:list){
        		if(ids.contains(a.getCategory().getId())){
        			temp.add(a);
        		}
        	}
        }
        list.clear();
        list=temp;
        page.setList(list);
        //end
        model.addAttribute("page", page);
        // model.addAttribute("from_a_cms_article", from_a_cms_article);
        return "modules/cms/articleList";
	}
	
	//add hefeng
	@RequiresPermissions("cms:article:view")
	@RequestMapping(value = {"articlelist"})
	public String articlelist(Article article, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Article> page = articleService.findPage(new Page<Article>(request, response), article, true); 
        model.addAttribute("page", page);
		return "modules/cms/articleList2";
	}
	
	@RequiresPermissions("cms:article:edit")
	@RequestMapping(value = "deleteUserArticle")
	public String deleteUserArticle(Article article, String categoryId, @RequestParam(required=false) Boolean isRe, RedirectAttributes redirectAttributes) {
		
		ArticleAttFile articleAttFile = new ArticleAttFile();
		articleAttFile.setActicleid(article.getId());
		
		articleService.deleteUserArticle(article, isRe);
		
		//关联已删除文章的一系列附件删除 huangmj6 2015.10.21
		articleAttFileService.deleteList(articleAttFile);
		
		addMessage(redirectAttributes, (isRe!=null&&isRe?"发布":"删除")+"文章成功");
		return "redirect:" + adminPath + "/sys/user/uploaded/?repage&delFlag=2&category.id="+("");
	}
	//end
	
	@RequiresPermissions("cms:article:view")
	@RequestMapping(value = "form")
	public String form(Article article, Model model) {
		//System.out.println("1111");
		// 如果当前传参有子节点，则选择取消传参选择
		if (article.getCategory()!=null && org.apache.commons.lang3.StringUtils.isNotBlank(article.getCategory().getId())){
			//System.out.println("getCategory");
			List<Category> list = categoryService.findByParentId(article.getCategory().getId(), Site.getCurrentSiteId());
			if (list.size() > 0){
				article.setCategory(null);
			}else{
				//System.out.println("categoryService");
				article.setCategory(categoryService.get(article.getCategory().getId()));
				//System.out.println("getCategoryID:"+article.getCategory().getId()+":"+article.getCategory().getName());
			}
		}
		
		//article.setCategory(categoryService.get(article.getCategory().getId()));
		
		article.setArticleData(articleDataService.get(article.getId()));
//		if (article.getCategory()==null && StringUtils.isNotBlank(article.getCategory().getId())){
//			Category category = categoryService.get(article.getCategory().getId());
//		}
		
		//查出对应文章的附件记录 start huangmj 2015.10.21
		ArticleAttFile articleAttFile = new ArticleAttFile();
		articleAttFile.setActicleid(article.getId());
		List<ArticleAttFile> listArticleAttFile = articleAttFileService.findListFile(articleAttFile);
		//System.out.println("listArticleAttFile:"+listArticleAttFile.size());
		
		//Label Service start huangmj 2015.10.21
		Article ar=new Article();
		ar=articleService.get(article);
		Label label = new Label();
		List<Label> listlabel = labelService.findList(label);
		label.setUserid(ar.getUser().getId());
		List<Label>  unexalabel=labelService.getUnexamineLabel(label);
		for(Label la:unexalabel){
			StringBuffer sb=new StringBuffer();
			sb.append(la.getLabelvalue());
			la.setLabelvalue(sb.toString());
			listlabel.add(la);
		}
		//System.out.println("listlabel:"+listlabel.size()+":"+listlabel.toString());
		List<Label> listlabelofArticle = articleLabelService.findLabelByArticle(article.getId());
		
		for(int i = 0;i<listlabelofArticle.size();i++){
			for(int j = 0;j<listlabel.size();j++){
				if(listlabelofArticle.get(i).getId().equals(listlabel.get(j).getId())){
					listlabel.get(j).setIschecked(1);
				}
			}
		}
		
        model.addAttribute("contentViewList",getTplContent());
        model.addAttribute("article_DEFAULT_TEMPLATE",Article.DEFAULT_TEMPLATE);
		model.addAttribute("article", article);
		model.addAttribute("listArticleAttFile",listArticleAttFile);
		model.addAttribute("listlabelsize",listArticleAttFile.size());
		model.addAttribute("listlabel",listlabel);
		model.addAttribute("native", "1");
		model.addAttribute("realize", null);
		CmsUtils.addViewConfigAttribute(model, article.getCategory());
		return "modules/cms/articleForm";
	}
	
	/*
	 * @RequestParam String categoryid,@RequestParam String categoryname
	 * huangmj 2015.10.26,首页发布知识
	 */
	@RequiresPermissions("cms:view")
	@RequestMapping(value = "add_article")
	public String index1(Article article, Model model,RedirectAttributes redirectAttributes) {
		// 如果当前传参有子节点，则选择取消传参选择
		if (article.getCategory()!=null && org.apache.commons.lang3.StringUtils.isNotBlank(article.getCategory().getId())){
			List<Category> list = categoryService.findByParentId(article.getCategory().getId(), Site.getCurrentSiteId());
			if (list.size() > 0){
				article.setCategory(null);
			}else{
				article.setCategory(categoryService.get(article.getCategory().getId()));
			}
		}
		article.setArticleData(articleDataService.get(article.getId()));
		//查出对应文章的附件记录 start huangmj 2015.10.21
		ArticleAttFile articleAttFile = new ArticleAttFile();
		articleAttFile.setActicleid(article.getId());
		List<ArticleAttFile> listArticleAttFile = articleAttFileService.findListFile(articleAttFile);
		//System.out.println("listArticleAttFile:"+listArticleAttFile.size());
		
		//Label Service start huangmj 2015.10.21
		Label label = new Label();
		List<Label> listlabel = labelService.findList(label);
		List<Label>  unexalabel=labelService.getUnexamineLabel(new Label());
		for(Label la:unexalabel){
			StringBuffer sb=new StringBuffer();
			sb.append(la.getLabelvalue());
			la.setLabelvalue(sb.toString());
			listlabel.add(la);
		}
		//System.out.println("listlabel:"+listlabel.size()+":"+listlabel.toString());
		List<Label> listlabelofArticle = articleLabelService.findLabelByArticle(article.getId());
		
		for(int i = 0;i<listlabelofArticle.size();i++){
			for(int j = 0;j<listlabel.size();j++){
				if(listlabelofArticle.get(i).getId().equals(listlabel.get(j).getId())){
					listlabel.get(j).setIschecked(1);
				}
			}
		}

		model.addAttribute("article_DEFAULT_TEMPLATE",Article.DEFAULT_TEMPLATE);
		model.addAttribute("article", article);
		model.addAttribute("listArticleAttFile",listArticleAttFile);
		model.addAttribute("listlabelsize",listArticleAttFile.size());
		model.addAttribute("listlabel",listlabel);
		model.addAttribute("native", "1");
		model.addAttribute("front", "f");
		model.addAttribute("realize", null);
		if(article.getCategory()!=null){
			CmsUtils.addViewConfigAttribute(model, article.getCategory());
		}
		model.addAttribute("indexx", "0");
		//model.addAttribute("categoryid",categoryid);
		//model.addAttribute("categoryname",categoryname);
		return "modules/cms/articleForm";
	} 
	
	/*
	 * @RequestParam String categoryid,@RequestParam String categoryname
	 * huangmj 2015.10.26,首页发布知识
	 */
	@RequiresPermissions("cms:view")
	@RequestMapping(value = "add_person_article")
	public String add_person_article(Article article, Model model,RedirectAttributes redirectAttributes) {
		// 如果当前传参有子节点，则选择取消传参选择
		if (article.getCategory()!=null && org.apache.commons.lang3.StringUtils.isNotBlank(article.getCategory().getId())){
			List<Category> list = categoryService.findByParentId(article.getCategory().getId(), Site.getCurrentSiteId());
			if (list.size() > 0){
				article.setCategory(null);
			}else{
				article.setCategory(categoryService.get(article.getCategory().getId()));
			}
		}
		article.setArticleData(articleDataService.get(article.getId()));
		//查出对应文章的附件记录 start huangmj 2015.10.21
		ArticleAttFile articleAttFile = new ArticleAttFile();
		articleAttFile.setActicleid(article.getId());
		List<ArticleAttFile> listArticleAttFile = articleAttFileService.findListFile(articleAttFile);
		//System.out.println("listArticleAttFile:"+listArticleAttFile.size());
		
		//Label Service start huangmj 2015.10.21
		Label label = new Label();
		List<Label> listlabel = labelService.findList(label);
		List<Label>  unexalabel=labelService.getUnexamineLabel(new Label());
		for(Label la:unexalabel){
			StringBuffer sb=new StringBuffer();
			sb.append(la.getLabelvalue()+"(未审批)");
			la.setLabelvalue(sb.toString());
			listlabel.add(la);
		}
		//System.out.println("listlabel:"+listlabel.size()+":"+listlabel.toString());
		List<Label> listlabelofArticle = articleLabelService.findLabelByArticle(article.getId());
		
		for(int i = 0;i<listlabelofArticle.size();i++){
			for(int j = 0;j<listlabel.size();j++){
				if(listlabelofArticle.get(i).getId().equals(listlabel.get(j).getId())){
					listlabel.get(j).setIschecked(1);
				}
			}
		}

		model.addAttribute("article_DEFAULT_TEMPLATE",Article.DEFAULT_TEMPLATE);
		model.addAttribute("article", article);
		model.addAttribute("listArticleAttFile",listArticleAttFile);
		model.addAttribute("listlabelsize",listArticleAttFile.size());
		model.addAttribute("listlabel",listlabel);
		model.addAttribute("native", "1");
		model.addAttribute("person", "p");
		model.addAttribute("realize", null);
		if(article.getCategory()!=null){
			CmsUtils.addViewConfigAttribute(model, article.getCategory());
		}
		model.addAttribute("indexx", "0");
		//model.addAttribute("categoryid",categoryid);
		//model.addAttribute("categoryname",categoryname);
		return "modules/cms/articleForm";
	} 

	@RequiresPermissions("cms:article:edit")
	@RequestMapping(value = "save")
	public String save(Article article, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request) {
		
		String temp_article_id = request.getParameter("cookie_guid");
		String article_id = request.getParameter("current_article_id");
		String attfile_temp_guid = request.getParameter("attfile_temp_guid");
		String save_key = request.getParameter("save_key");
		String personal_key =request.getParameter("person_save_key");
		String front_save_key =request.getParameter("front_save_key");
		//System.out.println("front_save_key:"+front_save_key);
		//System.out.println("personal_key:"+personal_key);
		//System.out.println("save_key:"+save_key);
		//System.out.println("getContent:"+article.getArticleData().getContent());
		//System.out.println("temp_article_id_t:"+temp_article_id+"article_id_t:"+article_id);
		
		String [] selectTag=request.getParameterValues("selectTag");
		List<String> labellist  = new ArrayList<String>();
		if(selectTag!=null){
			for (int i = 0; i < selectTag.length; i++) {
				String selectTageach=selectTag[i];
				labellist.add(selectTageach);
				System.out.println("标签ID："+selectTageach);
			}
		}
		
		
		
		/*
	     * 读cookie
	     * article_id 	：新增文章时为null，更新文章反之
	     * temp_article_id   ：新增文章时为文章ID，更新文章用不到该数据
	     * huangmj6 2015.10.21
	     *
		String article_id = "";
	    String category_id="";
	    String temp_article_id = "";
	    Cookie[] cookies = request.getCookies();    
	    if(cookies!=null){    
	        for (int i = 0; i < cookies.length; i++){    
	           Cookie c = cookies[i];         
	           if(c.getName().equalsIgnoreCase("cookie_guid")){    
	        	   	temp_article_id = c.getValue(); 
	        	   	//System.out.println("cookie->temp_article_id:"+temp_article_id); 
	            }else if(c.getName().equalsIgnoreCase("current_article_id")){    
	            	article_id = c.getValue();
	            	//System.out.println("cookie->article_id:"+article_id);
	            }        
	        }     
	      }  
		*/
		if (!beanValidator(model, article)){
			return form(article, model);
		}
		
		if(article_id != null && article_id.length()!= 0){
			
			//修改文章状态调用save->update huangmj6 2015.10.21
			//System.out.println("just update");

			
			//add hefeng 知识更改保存之前，与数据库对比区别

			
			//add hefeng
			String flag="00";//标记知识和附件是否更改

			if(articleService.get(article.getId())!=null){
				ArticleData articledata2=articleDataService.get(article.getId());
				String s2=articledata2.getContent();//数据库的数据
				//页面上的数据转码
				if (article.getArticleData().getContent()!=null){
					article.getArticleData().setContent(StringEscapeUtils.unescapeHtml4(
					article.getArticleData().getContent()));
				}
				String s1=article.getArticleData().getContent();//页面上转码后的数据
				if(!s1.equals(s2)){
//					articleService.updateUserMessage(article);
					flag="10";
				}
			}

			//end hefeng

			
			//知识附件更改(新增)保存之前（删除待定）
			int sumdiff=0;//临时文件总数
			List<ArticleAttFile> list=articleAttFileService.finddiffByGuid(attfile_temp_guid);
			for(int i=0;i<list.size();i++){
				if(list.get(i).getIspostarticle().equals("0")){
					sumdiff++;
				}
			}
			if(sumdiff>0){
//				articleService.updateUserMessage(article,sumdiff);
				if(flag.equals("10")){
					flag="11";
				}else{
					flag="01";
				}
			}
			//标志简介：无更新（00），内容更新（10），附件更新（01），内容和附件更新（11）
			article.setRemarks(flag);//把内容或附件是否更改写入数据库
			//end hefeng
			
			//add hefeng 如果更改知识分类，更新其他表的分类id
				String originalcategoryId=articleService.get(article.getId()).getCategory().getId().toString();
				String categoryId=article.getCategory().getId().toString();
				if(originalcategoryId.equals(categoryId)){
					
				}else{
					CmsUtils.MergeArticle(originalcategoryId, categoryId, article.getId());
				}
			//end hefeng
				if(save_key==null){
					article.setDelFlag("4");
				}else{
					article.setDelFlag("2");
				}
			articleService.save(article);
			//发布附附件
			articleAttFileService.postattfile(attfile_temp_guid);
			
			articleLabelService.save(labellist, article);
			
		}else{
			//System.out.println("new add");
			//新增文章状态下调用sava_insert->新增的文章ID为前台页面request带的cookie['temp_article_id'] huangmj6 2015.10.21
			if(save_key==null){
				article.setDelFlag("4");
			}else{
				article.setDelFlag("2");
			}
			articleService.save_insert(article, temp_article_id);
			
			//发布附附件
			articleAttFileService.postattfile(attfile_temp_guid);
			if(save_key==null){
				addMessage(redirectAttributes, "暂存文章'" + StringUtils.abbr(article.getTitle(),50) + "'成功");
				articleLabelService.save(labellist, article);
				return "redirect:" + adminPath + "/cms/article/add_article?id="+article.getId();
			}else{
				addMessage(redirectAttributes, "保存文章'" + StringUtils.abbr(article.getTitle(),50) + "'成功");
				articleLabelService.save(labellist, article);
				return "redirect:" + adminPath + "/?login";
			}
		}
		
		if(personal_key!=null){//个人中心，我的上传，保存调回个人中心，我的上传
			if(save_key==null){
				addMessage(redirectAttributes, "暂存文章'" + StringUtils.abbr(article.getTitle(),50) + "'成功");
				articleLabelService.save(labellist, article);
				return "redirect:" + adminPath + "/cms/article/form?id="+article.getId();
			}else{
				addMessage(redirectAttributes, "保存文章'" + StringUtils.abbr(article.getTitle(),50) + "'成功");
				return "redirect:" + adminPath + "/sys/user/uploaded";
			}
		}else if(front_save_key!=null){//主页过来，保存调回主页
			if(save_key==null){
				addMessage(redirectAttributes, "暂存文章'" + StringUtils.abbr(article.getTitle(),50) + "'成功");
				articleLabelService.save(labellist, article);
				return "redirect:" + adminPath + "/cms/article/form?id="+article.getId();
			}else{
				addMessage(redirectAttributes, "保存文章'" + StringUtils.abbr(article.getTitle(),50) + "'成功");
				return "redirect:" + adminPath + "/?login";
			}		
		}else{//后台管理过来，保存调回文章列表
			if(save_key==null){
				addMessage(redirectAttributes, "暂存文章'" + StringUtils.abbr(article.getTitle(),50) + "'成功");
				articleLabelService.save(labellist, article);
				return "redirect:" + adminPath + "/cms/article/form?id="+article.getId();
			}else{
				addMessage(redirectAttributes, "保存文章'" + StringUtils.abbr(article.getTitle(),50) + "'成功");
				return "redirect:" + adminPath + "/cms";//article/?"+"&delFlag="+2;//category.id="+article.getCategory().getId()+
			}	
		}
		//addMessage(redirectAttributes, "保存文章'" + StringUtils.abbr(article.getTitle(),50) + "'成功");
		//String categoryId = article.getCategory()!=null?article.getCategory().getId():null;
		//return "redirect:" + adminPath + "/cms/article/?repage&category.id="+(categoryId!=null?categoryId:"");
		
	}
	
	@RequiresPermissions("cms:article:edit")
	@RequestMapping(value = "delete")
	public String delete(Article article, String categoryId, @RequestParam(required=false) Boolean isRe, RedirectAttributes redirectAttributes) {
		// 如果没有审核权限，则不允许删除或发布。
		if (!UserUtils.getSubject().isPermitted("cms:article:audit")){
			addMessage(redirectAttributes, "你没有删除或发布权限");
		}
		
		ArticleAttFile articleAttFile = new ArticleAttFile();
		articleAttFile.setActicleid(article.getId());
		
		articleService.delete(article, isRe);
		
		//关联已删除文章的一系列附件删除 huangmj6 2015.10.21
		articleAttFileService.deleteList(articleAttFile);
		
		addMessage(redirectAttributes, (isRe!=null&&isRe?"上架":"删除")+"文章成功");
		return "redirect:" + adminPath + "/cms/article/?repage&category.id="+(categoryId!=null?categoryId:"");
	}

	/**
	* 处理知识审核状态-->发布
	* @param response
	* @param request
	* @return 
	* @throws IOException
	* @author huangmj,2015.10.15
	*/
	@RequiresPermissions("cms:article:edit")
	@RequestMapping(value = "update")
	public String update(Article article, String categoryId, @RequestParam(required=false) Boolean isRe, RedirectAttributes redirectAttributes) {
		// 如果没有审核权限，则不允许删除或发布。
		if (!UserUtils.getSubject().isPermitted("cms:article:audit")){
			addMessage(redirectAttributes, "你没有删除或发布权限");
		}
		articleService.update(article);
		//add hefeng 当知识发布审核上架后，更新消息
		articleService.PretreatmentUpdateUserMsg(article.getId());
		articleService.revertMsgFlag(article.getId());
		//end hefeng
		addMessage(redirectAttributes, (isRe!=null&&isRe?"上架":"删除")+"文章成功");
		return "redirect:" + adminPath + "/cms/article/?repage&category.id="+(categoryId!=null?categoryId:"");
	}
	
	/**
	 * 文章选择列表
	 */
	@RequiresPermissions("cms:article:view")
	@RequestMapping(value = "selectList")
	public String selectList(Article article, HttpServletRequest request, HttpServletResponse response, Model model) {
        list(article, request, response, model);
		return "modules/cms/articleSelectList";
	}
	
	/**
	 * 通过编号获取文章标题
	 */
	@RequiresPermissions("cms:article:view")
	@ResponseBody
	@RequestMapping(value = "findByIds")
	public String findByIds(String ids) {
		List<Object[]> list = articleService.findByIds(ids);
		return JsonMapper.nonDefaultMapper().toJson(list);
	}

    private List<String> getTplContent() {
   		List<String> tplList = fileTplService.getNameListByPrefix(siteService.get(Site.getCurrentSiteId()).getSolutionPath());
   		tplList = TplUtils.tplTrim(tplList, Article.DEFAULT_TEMPLATE, "");
   		return tplList;
   	}
    
//    
//    public void inputstreamtofile(InputStream ins,File file){
//    	OutputStream os = null;
//		try {
//			os = new FileOutputStream(file);
//		} catch (FileNotFoundException e1) {
//			
//			e1.printStackTrace();
//		}
//    	int bytesRead = 0;
//    	byte[] buffer = new byte[8192];
//    	try {
//			while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
//			os.write(buffer, 0, bytesRead);
//			}
//		} catch (IOException e) {
//			
//			e.printStackTrace();
//		}
//    	try {
//			os.close();
//		} catch (IOException e) {
//			
//			e.printStackTrace();
//		}
//    	try {
//			ins.close();
//		} catch (IOException e) {
//			
//			e.printStackTrace();
//		}
//    	}
//    
    
   
    
    
    
    
    
    /**
	* 处理文件上传
	* @param response
	* @param request
	* @return 
	* @throws IOException
	* @author huangmj,2015.10.15
	*/
    @RequiresPermissions("cms:article:view")
	@RequestMapping(value="/uploadFile",method=RequestMethod.POST)  
	@ResponseBody
	public String upload(HttpServletResponse response,HttpServletRequest request) throws IOException{  
    System.out.println("处理文件上传 in /uploadFile");
    String temp_article_id 	 = request.getParameter("cookie_guid");
   // String category_id 		 = request.getParameter("category_idd");
    String article_id 		 = request.getParameter("current_article_id");
    String attfile_temp_guid = request.getParameter("attfile_temp_guid");
    System.out.println("attfile_temp_guid:"+attfile_temp_guid);
    System.out.println("temp_article_id:"+temp_article_id);
    //System.out.println("category_id_t:"+category_id);
    System.out.println("article_id:"+article_id);
    /*
     * 读cookie
     * category_id	:文章归属库
     * article_id 	：新增文章时为null，更新文章反之
     * temp_article_id   ：新增文章时为文章ID，更新文章用不到该数据
     *
    String article_id = "";
    String category_id="";
    String temp_article_id = "";
    Cookie[] cookies = request.getCookies();    
    if(cookies!=null){    
        for (int i = 0; i < cookies.length; i++){    
           Cookie c = cookies[i];         
           if(c.getName().equalsIgnoreCase("cookie_guid")){    
        	   temp_article_id = c.getValue(); 
               System.out.println("cookie->temp_article_id:"+temp_article_id);
           }else if(c.getName().equalsIgnoreCase("category_id")){    
        	   category_id = c.getValue();   
               System.out.println("cookie->category_id:"+category_id);
            }else if(c.getName().equalsIgnoreCase("current_article_id")){    
            	article_id = c.getValue();
            	System.out.println("cookie->article_id:"+article_id);
            }          
        }     
    }
    */
	String responseStr="";
	String fileType="";
	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
	Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();    
	String fileName = null;    
	for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {   

		// 获取需上传文件   
		MultipartFile mf = entity.getValue();  
		//获取原文件名 
		fileName = mf.getOriginalFilename();
		
		fileType= mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf(".")+1);
		File outputFile_pdf = null;
		InputStream inputStreanm_pdf=null;
		File inputFile=null;
		String inputFilePath=null;
		
		//临时文件缓存储在服务器下的D盘temp文件夹下，上传OSS后删除
		inputFile=new File(FileStorageUtils.kms_tempfile_path+fileName);
		inputFilePath= FileStorageUtils.kms_tempfile_path+fileName;
		FileCopyUtils.copy(mf.getBytes(), inputFile);
		//FileCopyUtils.copy(mf.getBytes(), uploadFile); 
		//OSS显示的名字oss_file_key=>库名.知识名.时间.原文件名
		Date dt= new Date();
		Long time= dt.getTime();//这就是距离1970年1月1日0点0分0秒的毫秒数
		String oss_file_key="";
		if(article_id !=null && article_id.length() != 0){
			oss_file_key = article_id+"."+time+"."+fileName;
		}else{
			oss_file_key = temp_article_id+"."+time+"."+fileName;
		}
		
		
// 写入数据库附件信息start
		ArticleAttFile articleAttFile = new ArticleAttFile();
			
		//设置附件关联文章ID
		if(article_id !=null && article_id.length() != 0){
			//修改文章状态，启用原有文章ID
			articleAttFile.setActicleid(article_id);
		}else{
			//新增文章状态，启用前端用cookie带过来js生成的GUID
			articleAttFile.setActicleid(temp_article_id);
		}
			
		//设置OSS存放的文件key值
		 //获取当前用户
		 User user = UserUtils.getUser();
		 //获取当前用户所在企业模式名
		 UserSchema userSchema =SchemaUtils.findUserSchemaByLoginName(user.getLoginName());
		 //拼凑oss文件key值
		 oss_file_key = userSchema.getTenantSchemaName()+"/"+oss_file_key;
		 
		 articleAttFile.setAttfilekey(oss_file_key);
		 System.out.println("oss显示的原件名字=>"+oss_file_key);	
		//设置附件原始名称
		articleAttFile.setAttfilename(fileName);
			
		//设置附件时间戳
		articleAttFile.setAttfiletime(Long.toString(time));
			
		//设置附件大小
		articleAttFile.setAttfilesize(Long.toString(mf.getSize()));
			
		//获取文件后缀名
		articleAttFile.setAttfiletype(mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf(".")+1));
			
		articleAttFile.setAttfile_temp_guid(attfile_temp_guid);
		//articleAttFile.setIspostarticle("1");
			
		//存入数据库Service
		articleAttFileService.save(articleAttFile);
//写入数据库附件信息end
			
			if(FileStorageUtils.contentType(fileType)){
				//FiletoPDF start
				System.out.println("File need to FDP ....");
			    outputFile_pdf = new File(FileStorageUtils.kms_tempfile_path+fileName+".pdf");
			    Office2PdfUtil op = new Office2PdfUtil(inputFile,outputFile_pdf);
			    op.start();
			    boolean flag = true;
			    do{
			        switch (op.getState()) {
				        //可运行线程的线程状态。
				        case RUNNABLE:
				        	System.out.println("thread runing...");
				        	break; 
				        	
				        //已终止线程的线程状态。
				        case TERMINATED:
				        	flag =  false;
				        	System.out.println("thread over...");
				        	break;   
			        }
			        
			        // Be gentle
			        try {
						Thread.sleep(100);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
			    }while (flag);
			    System.out.println("start upload to OSS...");
			   inputStreanm_pdf = new FileInputStream(outputFile_pdf);
			}
		//FiletoPDF end	

		// 上传Object
		if(!FileStorageUtils.filevideo(fileType).equals("0")){
			System.out.println("File need to flv");
			
			//上传视频,mp4,avi,wmv
			String outputFilePath = inputFilePath+".flv";
			ConvertVideo convertVideo =new ConvertVideo(inputFilePath,outputFilePath);
			if (convertVideo.process()) {
		            System.out.println("ok to flv");
		            //源文件上传
		            PutObjectResult result=FileStorageUtils.upload(oss_file_key,inputFile,fileName,fileType, mf.getSize(),mf.getInputStream());
					
		            //flv文件上传
			        String oss_file_flv_key = oss_file_key+".flv";
			        File flvFile = new File(outputFilePath);
			        String flvFileName = "";
			        String flvFileType = "newflv";
			        Long flvSize = flvFile.length();
			        InputStream flvinputStream = new FileInputStream(outputFilePath);
			        PutObjectResult result_flv=FileStorageUtils.upload(oss_file_flv_key,flvFile,outputFilePath,flvFileType,flvSize,flvinputStream);
		            
			        System.out.println("result:"+result.getETag());
			        System.out.println("result_flv:"+result_flv.getETag());
		        }
			
		}else{
			//上传其他
			PutObjectResult result=FileStorageUtils.upload(oss_file_key, inputFile,fileName,fileType, mf.getSize(),mf.getInputStream());
			System.out.println(result.getETag());
		}
		
		//上传newPDF
		if(FileStorageUtils.contentType(fileType)){
			fileType="newpdf";
			String oss_file_pdf_key=oss_file_key+".pdf";
		    //System.out.println("oss显示的pdf件名字=>"+oss_file_pdf_key);
		    PutObjectResult result_pdf =FileStorageUtils.upload(oss_file_pdf_key, outputFile_pdf,fileName,fileType,outputFile_pdf.length(),inputStreanm_pdf);
		    System.out.println("result_pdf:"+result_pdf.getETag());
		}

//获取的文件流上传到阿里云并写入数据库--end
			
		responseStr="上传成功";
	}   
	
	
	FileDelete fileDelete = new FileDelete();
	//删除临时文件
	System.out.println("删除"+FileStorageUtils.kms_tempfile_path+fileName);
	fileDelete.deleteFile(FileStorageUtils.kms_tempfile_path+fileName);
	if(fileType.equals("newpdf")){	
		System.out.println("删除"+FileStorageUtils.kms_tempfile_path+fileName+".pdf");
		fileDelete.deleteFile(FileStorageUtils.kms_tempfile_path+fileName+".pdf");
	}
	
	//删除flv视频
	if(!FileStorageUtils.filevideo(fileType).equals("0")){
		fileDelete.deleteFile(FileStorageUtils.kms_tempfile_path+fileName+".flv");
	}
	System.out.println(responseStr);
	return responseStr;    
   }

    /**
	* 处理文件删除，update DEL_FLAG为1=>已删除；DEL_FLAG为0=>正常
	* @param response
	* @param request
	* @return 
	* @throws 
	* @author huangmj,2015.10.20
	*/
    @RequiresPermissions("cms:article:edit")
    @ResponseBody
	@RequestMapping(value = "deleteattfile")
	public String deleteattfile(ArticleAttFile articleAttFile,HttpServletResponse response) {
    	System.out.println("删除:"+articleAttFile.getId()+"文章ID:"+articleAttFile.getActicleid());
    	// 如果没有审核权限，则不允许删除或发布。
    	String deletResult="";
		if (!UserUtils.getSubject().isPermitted("cms:article:audit")){
			//addMessage(redirectAttributes, "你没有删除或发布权限");
			return "你没有删除或发布权限";
		}else{
			articleAttFileService.deleteAttfile(articleAttFile);
			deletResult = "删除成功";
			return deletResult;
		}
		
		//return "redirect:" + adminPath + "/cms/article/form?id="+articleAttFile.getActicleid();
	}

    @RequiresPermissions("cms:article:view")
    @ResponseBody
	@RequestMapping(value="viewattfile")
    public String viewattfile(ArticleAttFile articleAttFile){
    	System.out.println("viewattfile");
    	articleAttFile = articleAttFileService.findFile(articleAttFile);
    	String attfileUrl= FileStorageUtils.gerObjectUrl(articleAttFile.getAttfilekey()+".pdf");
    	System.out.println("viewattfile:"+attfileUrl);
    	return attfileUrl;
    }

    /**
	* 处理文件下载
	* @param response
	* @param request
	* @return 
	* @throws 
	* @author huangmj,2015.10.20
	*/
    @RequiresPermissions("cms:article:view")
	@RequestMapping(value="downloadattfile")
	public void download(ArticleAttFile articleAttFile, HttpServletResponse response){
    	articleAttFile = articleAttFileService.findFile(articleAttFile);
    	System.out.println("下载id:"+articleAttFile.getId()+"filekey"+articleAttFile.getAttfilekey());
		String filepath = "";
		InputStream inputStream = null;
		OutputStream outputStream = null;
		byte[] b= new byte[1024];
		int len = 0;
		try {
			//获取目标下载文件流
			inputStream = FileStorageUtils.download(articleAttFile.getAttfilekey());
			outputStream = response.getOutputStream();
			response.setContentType("application/force-download");
			String filename = articleAttFile.getAttfilename();
			response.addHeader("Content-Disposition","attachment; filename=" + URLEncoder.encode(filename, "UTF-8"));
			response.setContentLength( (int) Integer.parseInt(articleAttFile.getAttfilesize()));
			
			while((len = inputStream.read(b)) != -1){
				outputStream.write(b, 0, len);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(inputStream != null){
				try {
					inputStream.close();
					inputStream = null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(outputStream != null){
				try {
					outputStream.close();
					outputStream = null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
    
    /**
	* 处理pdf文件预览
	* @param response
	* @param request
	* @return 
	* @throws 
	* @author huangmj,2015.10.20
	*/
    @RequiresPermissions("cms:article:view")
	@RequestMapping(value="viewfile")
	public String viewfile(ArticleAttFile articleAttFile, Model model,HttpServletResponse response){
    	articleAttFile = articleAttFileService.findFile(articleAttFile);
    	System.out.println("id:"+articleAttFile.getId()+"filekey"+articleAttFile.getAttfilekey());
    	model.addAttribute("articleAttFile", articleAttFile);
    	return "modules/cms/viewfile";
	}
    
    
    /**
	* 处理文件上传
	* @param response
	* @param request
	* @return 
	* @throws IOException
	* @author yinshh3,2015.12.7
	*/
    @RequiresPermissions("cms:article:view")
	@RequestMapping(value="/uploadpicture",method=RequestMethod.POST)  
	@ResponseBody
	public String uploadpicture(HttpServletResponse response,HttpServletRequest request) throws IOException{  
    System.out.println("处理文件上传 in /uploadFile");
    String switch_id 	 = request.getParameter("switch_id");
	String responseStr="";
	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
	Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();    
	String fileName = null;    
	for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {   

		// 获取需上传文件   
		MultipartFile mf = entity.getValue();  
		//获取原文件名 
		fileName = mf.getOriginalFilename();
		int lastIndex=fileName.lastIndexOf(".");
		String suffix=fileName.substring(lastIndex+1, fileName.length());
		
		File inputFile=null;
		String path = request.getSession().getServletContext().getRealPath("");
		String pic_url = path+"\\static\\dist\\images\\"+fileName;
		System.out.println("pic_url:"+pic_url);
		inputFile=new File(pic_url);
		FileCopyUtils.copy(mf.getBytes(), inputFile);
		
		String imgUrl="";
		String fileName1=IdGen.uuid()+"."+suffix;
		try {
			imgUrl=FileStorageUtils.putObject(fileName1, pic_url);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		System.out.println(imgUrl);
// 写入数据库附件信息start
		Switch switchOnly=new Switch();
		switchOnly=switchService.get(switch_id);
		switchOnly.setImageUrl(imgUrl);
		System.out.println("写入数据库附件信息!!!!!!!!!!"+JsonMapper.toJsonString(switchOnly));
		switchService.update(switchOnly);
//写入数据库附件信息end	
		responseStr=imgUrl;
	}   
	return responseStr;    
   }
}
