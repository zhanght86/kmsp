/**
 * 
 */
package com.yonyou.kms.modules.cms.web.front;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.yonyou.kms.common.config.Global;
import com.yonyou.kms.common.mapper.JsonMapper;
import com.yonyou.kms.common.persistence.BaseEntity;
import com.yonyou.kms.common.persistence.Page;
import com.yonyou.kms.common.persistence.Split;
import com.yonyou.kms.common.servlet.ValidateCodeServlet;
import com.yonyou.kms.common.web.BaseController;
import com.yonyou.kms.modules.cms.dao.ArticleDao;
import com.yonyou.kms.modules.cms.dao.PersonContributionDao;
import com.yonyou.kms.modules.cms.entity.Article;
import com.yonyou.kms.modules.cms.entity.ArticleAttFile;
import com.yonyou.kms.modules.cms.entity.ArticleCount;
import com.yonyou.kms.modules.cms.entity.ArticleData;
import com.yonyou.kms.modules.cms.entity.Category;
import com.yonyou.kms.modules.cms.entity.Comment;
import com.yonyou.kms.modules.cms.entity.DepartContribution;
import com.yonyou.kms.modules.cms.entity.Label;
import com.yonyou.kms.modules.cms.entity.Link;
import com.yonyou.kms.modules.cms.entity.PersonContribution;
import com.yonyou.kms.modules.cms.entity.Recommend;
import com.yonyou.kms.modules.cms.entity.Share;
import com.yonyou.kms.modules.cms.entity.Site;
import com.yonyou.kms.modules.cms.entity.Store;
import com.yonyou.kms.modules.cms.entity.Switch;
import com.yonyou.kms.modules.cms.service.ArticleAttFileService;
import com.yonyou.kms.modules.cms.service.ArticleCountService;
import com.yonyou.kms.modules.cms.service.ArticleDataService;
import com.yonyou.kms.modules.cms.service.ArticleLabelService;
import com.yonyou.kms.modules.cms.service.ArticleService;
import com.yonyou.kms.modules.cms.service.CategoryService;
import com.yonyou.kms.modules.cms.service.CategoryTreeService;
import com.yonyou.kms.modules.cms.service.CommentService;
import com.yonyou.kms.modules.cms.service.DepartContributionService;
import com.yonyou.kms.modules.cms.service.FrontDataService;
import com.yonyou.kms.modules.cms.service.LabelService;
import com.yonyou.kms.modules.cms.service.LinkService;
import com.yonyou.kms.modules.cms.service.PersonContributionService;
import com.yonyou.kms.modules.cms.service.RecommendService;
import com.yonyou.kms.modules.cms.service.ShareService;
import com.yonyou.kms.modules.cms.service.SiteService;
import com.yonyou.kms.modules.cms.service.StoreService;
import com.yonyou.kms.modules.cms.service.SwitchService;
import com.yonyou.kms.modules.cms.utils.CmsUtils;
import com.yonyou.kms.modules.oa.service.OaNotifyService;
import com.yonyou.kms.modules.sys.dao.UserDao;
import com.yonyou.kms.modules.sys.entity.User;
import com.yonyou.kms.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.yonyou.kms.modules.sys.service.SystemService;
import com.yonyou.kms.modules.sys.utils.FileStorageUtils;
import com.yonyou.kms.modules.sys.utils.UserUtils;

/**
 * 网站Controller
 * @author hotsum
 * @version 2013-5-29
 */
@Controller
@RequestMapping(value = "${frontPath}")
public class FrontController extends BaseController{
	
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ArticleCountService articlecountService;
	@Autowired
	private ArticleLabelService	articlelabelService;
	@Autowired
	private ArticleDataService articleDataService;
	@Autowired
	private LinkService linkService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private SiteService siteService;
	//begin zhengyu
	@Autowired
	private StoreService storeService;
	@Autowired
	private ArticleCountService articleCountService;
	@Autowired
	private RecommendService recommendService;
	@Autowired
	private ShareService shareService;
	//end
	//添加by yinshh3 10月16日 10:00
	@Autowired
	private FrontDataService frontDataService;
	@Autowired
	private PersonContributionService personContributionService;
	@Autowired
	private DepartContributionService departContributionService;
	@Autowired
	private LabelService labelService;
	@Autowired
	private SwitchService switchService;
	

	//huang 2015.10.22 start
	@Autowired
	private ArticleAttFileService articleAttFileService;
	@Autowired
	private SystemService systemService;
	//huang 2015.10.22 end

	@Autowired
	private CategoryTreeService categoryTreeService;
	@Autowired
	private OaNotifyService oaNotifyService;
	
	//add by luqibao
	private ArticleDao articleDao;
	private PersonContributionDao personContriDao;
	private UserDao userDao;
	//end

	/**
	 * 网站首页
	 */
	@RequestMapping
	public String index(Model model) {
		//add by luqibao 是否登录/修改/f引起的bug
		if(null==UserUtils.getCache(IS_LOGIN)){
			return "redirect:"+adminPath;
		}
//		List<PersonContribution> userToActi = personContriDao.getUserToActi("kms27");
//		for(PersonContribution p:userToActi){
//			System.out.println(p.getUsername());
//		}
		UserUtils.removeCache(IS_LOGIN);
		//end
		User currentUser=UserUtils.getUser();
		model.addAttribute("user1",currentUser);
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		model.addAttribute("isIndex", true);
		//Start by yinshh3
		//获取用户名
		//System.out.println("---------<<<<<<=========用户登录名==========>>>>>>>>>>----------------"+frontDataService.getUserLoginName(UserUtils.getUser())+"================================");
		model.addAttribute("name",frontDataService.getUserName(UserUtils.getUser()));		
		//获取用户角色列表
		//System.out.println("---------<<<<<<=========用户角色名==========>>>>>>>>>>----------------"+frontDataService.getUserRoleName(UserUtils.getUser())+"=================================");
		model.addAttribute("role",frontDataService.getUserRoleName(UserUtils.getUser()));
		//End by yinshh3
		//取得个人贡献.
		//personContributionService.saveData();
		List<PersonContribution> list =personContributionService.getPersonContributionData();
		model.addAttribute("personcontributionlist", list);
		/*
		 * 取得部门贡献
		 * 将数据从数据库取出.(定时任务)departContributionService.saveData();
		 */
		//departContributionService.saveData();
		List<DepartContribution> departlist=departContributionService.getContributionData();
		model.addAttribute("departcontributionlist", departlist);
		//开始修改-----yinshh3
		/*
		 * 热门知识 功能的实现
		 * 关于返回为category取得id的接口还没有写,用实际的数据测试.
		 */
		List<String> categoryidlist=categoryService.findCategoryIdByUser(null);
		//System.out.println("================="+JsonMapper.toJsonString(categoryidlist));

		if(categoryidlist.size()>0||categoryidlist!=null){

		if(categoryidlist.size()<=0){
			return "modules/cms/front/themes/"+site.getTheme()+"/frontIndex";
		}

		//articleCountService.saveData();
		//取出已经排序好的前5条数据
		List<ArticleCount> artilcecountlist=articleCountService.getArticleCountData(categoryidlist);
		model.addAttribute("articlecountlist", artilcecountlist);
		//取出最新分享的数据
		//articleCountService.saveData();
		List<ArticleCount> articlesharelist=articleCountService.getArticleCountShareData(categoryidlist);
		model.addAttribute("articlesharelist", articlesharelist);
		//取出最新知识
		List<ArticleCount> articlenewlist=articleCountService.getNewArticleCountData(categoryidlist);
		model.addAttribute("articlenewlist", articlenewlist);
		//取出热门标签
		List<Label> labellist=new ArrayList<Label>();
		labellist=labelService.getHotLabelData();
		model.addAttribute("labellist", labellist);
		}
		//结束修改 ------yinshh3 
		
		//将轮播列表的数据传入首页
		List<Switch> frontswitch=Lists.newArrayList();
		frontswitch=switchService.getAllBydelFlag();
		model.addAttribute("frontswitch", frontswitch);
//		String path=currentUser.getPhoto();
//		URL urlStr;
//		int state=-1;
//		HttpURLConnection connection=null;
//		try {
//			urlStr = new URL(path);
//			connection = (HttpURLConnection) urlStr.openConnection();
//			state=connection.getResponseCode();
//		} catch (Exception e) {
//			
//		}finally{
//			if(connection!=null){
//				connection.disconnect();
//			}
//		}
//		
//		if(state!=200){
//			path=null;
//		}
//		currentUser.setPhoto(path);
		//end
		return "modules/cms/front/themes/"+site.getTheme()+"/frontIndex";
	}
	
	
	/**
	 * 
	 * 知识发布
	 * 
	 */
	@RequestMapping("/realize")
	public String realize(Model model,String flag) {
		Article article=new Article();
		model.addAttribute(article);
	//	model.addAttribute("realize", "1");
		//System.out.println("<<<<<<<<<<================>>>>>>>");
		if(flag!=null){
			return "modules/cms/articleForm";
		}
		model.addAttribute("frontIndex", "1");
		return "modules/cms/articleForm";
		//return "modules/cms/front/themes/basic/layouts/default";
	}
	/**
	 * 网站首页
	 */
	@RequestMapping(value = "index-{siteId}${urlSuffix}")
	public String index(@PathVariable String siteId, Model model) {
		if (siteId.equals("1")){
			return "redirect:"+Global.getFrontPath();
		}
		Site site = CmsUtils.getSite(siteId);
		// 子站有独立页面，则显示独立页面
		if (org.apache.commons.lang3.StringUtils.isNotBlank(site.getCustomIndexView())){
			model.addAttribute("site", site);
			model.addAttribute("isIndex", true);
			return "modules/cms/front/themes/"+site.getTheme()+"/frontIndex"+site.getCustomIndexView();
		}
		// 否则显示子站第一个栏目
		List<Category> mainNavList = CmsUtils.getMainNavList(siteId);
		if (mainNavList.size() > 0){
			String firstCategoryId = CmsUtils.getMainNavList(siteId).get(0).getId();
			return "redirect:"+Global.getFrontPath()+"/list-"+firstCategoryId+Global.getUrlSuffix();
		}else{
			model.addAttribute("site", site);
			return "modules/cms/front/themes/"+site.getTheme()+"/frontListCategory";
		}
	}
	
	/**
	 * 内容列表
	 */
	@RequestMapping(value = "list-{categoryId}${urlSuffix}")
	public String list(@PathVariable String categoryId, @RequestParam(required=false, defaultValue="1") Integer pageNo,
			@RequestParam(required=false, defaultValue="15") Integer pageSize, Model model) {
		
		if(categoryId.equals("vip")){
			   User user =UserUtils.getUser();
			   Category category =new Category();
			 // category.setName("知识库列表");
			  List<Category> temp=Lists.newArrayList();
			  List<Category> categoryList=categoryService.findAllCategory(null);
			  
			 // System.out.println("categoryList_before:"+categoryList.size()+":");
			  List<Category> temp_role_categoryList = categoryService.findCategoryRole();
			  //System.out.println("temp_role_categoryList:"+temp_role_categoryList.size()+":");
			  categoryList.removeAll(temp_role_categoryList);
			  //System.out.println("categoryList_after:"+categoryList.size()+":");
			  
			  List<String> list=categoryService.findCategoryIsAllowShare();
			  List<Category> lc=categoryService.findByIds(list);
			  if(categoryList.size()<=0){
				  model.addAttribute("category", category);
				  model.addAttribute("categoryList", categoryList);
				  
			  }else{
				  
					  for(Category c:categoryList){
							  if(!temp.contains(c)&&c.getParentIds().split(",").length<=2){
								  temp.add(c);
						  }
					  }
					  categoryList.clear();
					  categoryList=temp;
					  Site site = CmsUtils.getSite(Site.defaultSiteId());
					  model.addAttribute("site", site);
					  model.addAttribute("category", category);
					  model.addAttribute("categoryList", categoryList);
					  model.addAttribute("vip", "知识库列表");
			          CmsUtils.addViewConfigAttribute(model, category);
					  return "modules/cms/front/themes/basic/frontListCategory";
			  }
		}
		
		User user=UserUtils.getUser();
		//判断分类为空返回404页面
		Category category = categoryService.get(categoryId);
		if (category==null){
			Site site = CmsUtils.getSite(Site.defaultSiteId());
			model.addAttribute("site", site);
			return "error/404";
		}
	
		Site site = siteService.get(category.getSite().getId());
		model.addAttribute("site", site);
		
		// 2：简介类栏目，栏目第一条内容
		if("2".equals(category.getShowModes()) && "article".equals(category.getModule())){
			//System.out.println("<<<<<<<<<<================>>>>>>>2&& article");
			
			// 如果没有子栏目，并父节点为跟节点的，栏目列表为当前栏目。
			List<Category> categoryList = Lists.newArrayList();
			if (category.getParent().getId().equals("1")){
				categoryList.add(category);
			}else{
				categoryList = categoryService.findByParentId(category.getParent().getId(), category.getSite().getId());
			}
			model.addAttribute("category", category);
			model.addAttribute("categoryList", categoryList);
			// 获取文章内容
			Page<Article> page = new Page<Article>(1, 1, -1);
			Article article = new Article(category);
			page = articleService.findPage(page, article, false);
			if (page.getList().size()>0){
				article = page.getList().get(0);
				article.setArticleData(articleDataService.get(article.getId()));
				articleService.updateHitsAddOne(article.getId());
			}
			model.addAttribute("article", article);
            CmsUtils.addViewConfigAttribute(model, category);
            CmsUtils.addViewConfigAttribute(model, article.getViewConfig());
			return "modules/cms/front/themes/"+site.getTheme()+"/"+getTpl(article);
		}else{
			//System.out.println("else<<<<<<<<<<================>>>>>>>2&& article");
			List<Category> categoryList = categoryService.findByParentId(category.getId(), category.getSite().getId());
			//System.out.println("categoryList_befor:"+categoryList.size()+":");
			List<Category> temp_role_categoryList = categoryService.findCategoryRole();
			//System.out.println("temp_role_categoryList:"+temp_role_categoryList.size()+":");
			categoryList.removeAll(temp_role_categoryList);
			//System.out.println("categoryList_after:"+categoryList.size()+":");
			/*for(int i=0;i<temp_role_categoryList.size();i++){
				for(int j=0;j<categoryList.size();j++)
					(Category)temp_role_categoryList.get(i).i
			}
			*/
			
			// 展现方式为1 、无子栏目或公共模型，显示栏目内容列表
			if("1".equals(category.getShowModes())||categoryList.size()==0){
				//System.out.println("<<<<<<<<<<================>>>>>>>1&& article");
				// 有子栏目并展现方式为1，则获取第一个子栏目；无子栏目，则获取同级分类列表。
				if(categoryList.size()>0){
					category = categoryList.get(0);
				}else{
					// 如果没有子栏目，并父节点为跟节点的，栏目列表为当前栏目。
					if (category.getParent().getId().equals("1")){
						categoryList.add(category);
					}else{
						categoryList = categoryService.findByParentId(category.getParent().getId(), category.getSite().getId());
					}
				}
				model.addAttribute("category", category);
				model.addAttribute("categoryList", categoryList);
				// 获取内容列表
				if ("article".equals(category.getModule())){
					//System.out.println("<<<<<<<<<<================>>>>>>>3&& article:ID:"+category.getId());
					Page<Article> page = new Page<Article>(pageNo, pageSize);
					//System.out.println(page.getPageNo());
					page = articleService.findPage(page, new Article(category), false);
					//add by luqibao 筛选可以分享文章列表
					if(user.getId()==null){
						List<Article> articles=page.getList();
						List<String> ids=Lists.newArrayList();
						List<Article> temp1=Lists.newArrayList();
						for(Article a:articles){
							ids.add(a.getId());
						}
						List<ArticleData> ads=articleDataService.findAllByIds(ids);
						for(Article a:articles){
							for(ArticleData ad:ads){
								if(a.getId().equals(ad.getId())){
									a.setArticleData(ad);
									temp1.add(a);
								}
							}
						}
						articles.clear();
						articles=temp1;
							List<Article> temp=Lists.newArrayList();
							for(Article article:articles){
								if(article.getArticleData().getAllowshare().equals("1")){
									if(!temp.contains(article)){
										temp.add(article);
									}
								}
							}
							page.setList(temp);
					}
					
					//end
					model.addAttribute("page", page);
					// 如果第一个子栏目为简介类栏目，则获取该栏目第一篇文章
					if ("2".equals(category.getShowModes())){
						Article article = new Article(category);
						if (page.getList().size()>0){
							article = page.getList().get(0);
							article.setArticleData(articleDataService.get(article.getId()));
							articleService.updateHitsAddOne(article.getId());
						}
						model.addAttribute("article", article);
			            CmsUtils.addViewConfigAttribute(model, category);
			            CmsUtils.addViewConfigAttribute(model, article.getViewConfig());
			           // System.out.println("1modules/cms/front/themes/"+site.getTheme()+"/"+getTpl(article));
						return "modules/cms/front/themes/"+site.getTheme()+"/"+getTpl(article);
					}
				}else if ("link".equals(category.getModule())){
					//System.out.println("<<<<<<<<<<================>>>>>>>4&& article");
					Page<Link> page = new Page<Link>(1, -1);
					page = linkService.findPage(page, new Link(category), false);
					model.addAttribute("page", page);
				}
				String view = "/frontList";
				if (org.apache.commons.lang3.StringUtils.isNotBlank(category.getCustomListView())){
					view = "/"+category.getCustomListView();
				}
	            CmsUtils.addViewConfigAttribute(model, category);
                site =siteService.get(category.getSite().getId());
                //System.out.println("else 栏目第一条内容 _2 :"+category.getSite().getTheme()+","+site.getTheme());
                //System.out.println( "2modules/cms/front/themes/"+siteService.get(category.getSite().getId()).getTheme()+view);
				return "modules/cms/front/themes/"+siteService.get(category.getSite().getId()).getTheme()+view;
			}
			// 有子栏目：显示子栏目列表
			else{

				//add by luqibao 将可分享的知识分类筛选出来
				if(user.getId()==null){
					List<String> list=categoryService.findCategoryIsAllowShare();
					List<Category> temp=Lists.newArrayList();
					for(Category c:categoryList){
						if(list.contains(c.getId())){
							if(!temp.contains(c)){
								temp.add(c);
							}
						}
					}
					List<Category> lc=categoryService.findByIds(list);
					if(lc!=null){
						for(Category c:lc){
							String str=c.getParentIds();
							for(Category cc:categoryList){
								if(str.contains(cc.getId())){
									if(!temp.contains(cc)){
										temp.add(cc);
									}
								};
							}
						}
					}
					categoryList.clear();
					categoryList=temp;
				}

				model.addAttribute("category", category);
				model.addAttribute("categoryList", categoryList);
				String view = "/frontListCategory";
				if (org.apache.commons.lang3.StringUtils.isNotBlank(category.getCustomListView())){
					view = "/"+category.getCustomListView();
				}
	            CmsUtils.addViewConfigAttribute(model, category);
	            //System.out.println("URL2:"+"modules/cms/front/themes/"+site.getTheme()+view+"siteID:"+site.getId()+"site:");
				return "modules/cms/front/themes/"+site.getTheme()+view;
			}
		}
	}

	/**
	 * 内容列表（通过url自定义视图）
	 */
	@RequestMapping(value = "listc-{categoryId}-{customView}${urlSuffix}")
	public String listCustom(@PathVariable String categoryId, @PathVariable String customView, @RequestParam(required=false, defaultValue="1") Integer pageNo,
			@RequestParam(required=false, defaultValue="15") Integer pageSize, Model model) {
		Category category = categoryService.get(categoryId);
		if (category==null){
			Site site = CmsUtils.getSite(Site.defaultSiteId());
			model.addAttribute("site", site);
			return "error/404";
		}
		Site site = siteService.get(category.getSite().getId());
		model.addAttribute("site", site);
		List<Category> categoryList = categoryService.findByParentId(category.getId(), category.getSite().getId());
		model.addAttribute("category", category);
		model.addAttribute("categoryList", categoryList);
        CmsUtils.addViewConfigAttribute(model, category);
		return "modules/cms/front/themes/"+site.getTheme()+"/frontListCategory"+customView;
	}

	/**
	 * 显示内容,这个是对cmsutil中的getURLDunamic()方法的拦截.
	 */
	@RequestMapping(value = "view-{categoryId}-{contentId}${urlSuffix}")
	public String view(@PathVariable String categoryId, @PathVariable String contentId, Model model) {
		
		//add by luqibao  别删！！！！！！！！！！！！！！！！！！！！
//		Article articleTemp=articleDao.get(contentId);
//		if(articleTemp!=null){
//			if(!"0".equals(articleTemp)){
//				return "error/403";
//			}
//		}

		//end by yangshw6
		
		//satart 判断文章在非正常状态下（待审核，下架），不允许查看 huangmj 2015 11 10	
		Article article_temp = articleService.get(contentId);	
		Principal principal1 = UserUtils.getPrincipal();
			if(UserUtils.IsOrdinaryUser() || principal1 == null){
				//System.out.println("普通用户,用户未登录，判断文章状态");
				if (article_temp!=null && !BaseEntity.DEL_FLAG_NORMAL.equals(article_temp.getDelFlag())){
					model.addAttribute("article", article_temp);
					return "error/404";
				}
			}
		//end 判断文章在非正常状态下（待审核，下架），不允许查看 huangmj 2015 11 10	
			
		Category category = categoryService.get(categoryId);
		//add by zhengyu
		String user=null;
		Principal principal2 = UserUtils.getPrincipal();
		// 判断登录
		if(principal2 != null){
			user=UserUtils.getUser().getId().trim();//获取访问该文章人的id
			
			//System.out.println("查看文章的人:"+user);
			//User user=UserUtils.getUser();
			Share sh=new Share();
			sh.setCreateBy(UserUtils.getUser());
			sh.setTitleId(contentId);
			Share share=shareService.get(sh);
			if(share==null|| !user.equals(share.getCreateBy().getId().trim())){
				share=new Share();
			}
	
			model.addAttribute("share", share);
			
			Recommend r=new Recommend();
			r.setCreateBy(UserUtils.getUser());
			r.setTitleId(contentId);
			Recommend recommend=recommendService.get(r);
			//Recommend recommend=recommendService.getRecommend(contentId);
			if(recommend==null|| !user.equals(recommend.getCreateBy().getId().trim())){
				recommend=new Recommend();
				recommend.setDelFlag("1");
				recommend.setRecomCount(recommend.getRecomCount());
				recommend.setDelFlag(recommend.getDelFlag().trim());
				model.addAttribute("recommend", recommend);
			}
			//System.out.println(recommend.getCreateBy().getId().trim());
			recommend.setRecomCount(recommend.getRecomCount());
			recommend.setDelFlag(recommend.getDelFlag().trim());
			model.addAttribute("recommend", recommend);
			ArticleCount articleCount=articleCountService.get(contentId);
			if(articleCount !=null){
				articleCount.setCountreco(articleCount.getCountreco());
				articleCount.setCountcollect(articleCount.getCountcollect());
			}else{
				articleCount=new ArticleCount();
				articleCount.setArticleid(contentId);
				articleCount.setCountreco(0);
				articleCount.setCountcollect(0);
			}
			model.addAttribute("articleCount", articleCount);
			Store s=new Store();
			s.setCreateBy(UserUtils.getUser());
			s.setTitleId(contentId);
			Store store=storeService.get(s);
			if(store==null|| !user.equals(store.getCreateBy().getId().trim())){
				//System.out.println("null");
				store=new Store();
				store.setDelFlag("1");
				store.setDelFlag(store.getDelFlag().trim());
				model.addAttribute("store", store);
			}
			store.setDelFlag(store.getDelFlag().trim());
			model.addAttribute("store", store);
			}


		
		Recommend r=new Recommend();
		r.setCreateBy(UserUtils.getUser());
		r.setTitleId(contentId);
		Recommend recommend=recommendService.get(r);
		//Recommend recommend=recommendService.getRecommend(contentId);
		if(recommend==null|| !user.equals(recommend.getCreateBy().getId().trim())){
			recommend=new Recommend();
			recommend.setDelFlag("1");
			recommend.setRecomCount(recommend.getRecomCount());
			recommend.setDelFlag(recommend.getDelFlag().trim());
			model.addAttribute("recommend", recommend);
		}
//System.out.println(recommend.getCreateBy().getId().trim());
		recommend.setRecomCount(recommend.getRecomCount());
		recommend.setDelFlag(recommend.getDelFlag().trim());
		model.addAttribute("recommend", recommend);
		//add by yangshw6
//		ArticleCount articleCount=articleCountService.get(contentId);
//		if(articleCount!=null){
//			articleCount.setCountreco(articleCount.getCountreco());
//			articleCount.setCountcollect(articleCount.getCountcollect());
//		}else{
//			articleCount.setCountreco(0);
//			articleCount.setCountcollect(0);
//		}
//		model.addAttribute("articleCount", articleCount);
		//end
		

		
		Store s=new Store();
		s.setCreateBy(UserUtils.getUser());
		s.setTitleId(contentId);
		Store store=storeService.get(s);
		if(store==null|| !user.equals(store.getCreateBy().getId().trim())){
			//System.out.println("null");
			store=new Store();
			store.setDelFlag("1");
		}
		store.setDelFlag(store.getDelFlag().trim());
		model.addAttribute("store", store);

	//end
		if (category==null){
			Site site = CmsUtils.getSite(Site.defaultSiteId());
			model.addAttribute("site", site);
			return "error/404";
		}
		model.addAttribute("site", category.getSite());
		if ("article".equals(category.getModule())){
			// 如果没有子栏目，并父节点为跟节点的，栏目列表为当前栏目。
			List<Category> categoryList = Lists.newArrayList();
			if (category.getParent().getId().equals("1")){
				categoryList.add(category);
			}else{
				categoryList = categoryService.findByParentId(category.getParent().getId(), category.getSite().getId());
			}
			// 获取文章内容
			Article article = articleService.get(contentId);
			if (article==null){
				return "error/404";
			}
			// 文章阅读次数+1
			articleService.updateHitsAddOne(contentId);
			articleCountService.updateSingleData(5,1,contentId);
			// 获取推荐文章列表
			List<Object[]> relationList = articleService.findByIds(articleDataService.get(article.getId()).getRelation());
			
//查出对应文章的附件记录： huangmj 2015.10.22 start
			ArticleAttFile articleAttFile = new ArticleAttFile();
			articleAttFile.setActicleid(article.getId());
			List<ArticleAttFile> listArticleAttFile = articleAttFileService.findListFile(articleAttFile);
			
			
			
			//设文章附件数码值
			article.setAttfilenumber(articleAttFileService.getArticleAttFileNumber(contentId));
			//System.out.println("文章："+article.getTitle()+"附件数："+article.getAttfilenumber());
			//文章分享状态
			ArticleData  articleDate = new ArticleData();
			articleDate.setId(article.getId());
			articleDate = articleDataService.get(articleDate);
			//System.out.println("分享状态："+articleDate.getAllowshare());
			String userIsLogin=null;
			
			Principal principal = UserUtils.getPrincipal();
			// 如果已经登录，则跳转到管理首页
			if(principal != null){
				userIsLogin="1";
				//System.out.println("用户登录状态："+userIsLogin);
			}else{
				userIsLogin="0";
				//System.out.println("用户登录状态："+userIsLogin);
			}
			//System.out.println("用户articelUserID："+article.getUser().getId());
			//huangmj 2015.11.12
			User articelUser = articleService.getArticleUser(article.getUser());
			
//查出对应文章的附件记录： huangmj 2015.10.22 end
			
			// 将数据传递到视图
			model.addAttribute("category", categoryService.get(article.getCategory().getId()));
			model.addAttribute("categoryList", categoryList);
			article.setArticleData(articleDataService.get(article.getId()));
			model.addAttribute("article", article);
			model.addAttribute("articelUser", articelUser);
			model.addAttribute("listArticleAttFile",listArticleAttFile);
			model.addAttribute("userIsLogin", userIsLogin);
			model.addAttribute("articledata", articleDate);
			model.addAttribute("relationList", relationList); 
			model.addAttribute("oss_base_path", FileStorageUtils.ossEndPoint); 
				//model.addAttribute("store",store);
            CmsUtils.addViewConfigAttribute(model, article.getCategory());
            CmsUtils.addViewConfigAttribute(model, article.getViewConfig());
            Site site = siteService.get(category.getSite().getId());
            model.addAttribute("site", site);
//			return "modules/cms/front/themes/"+category.getSite().getTheme()+"/"+getTpl(article);
            
            //addby yinshh3
            //add by yangshw6
            List<String> labelList=articlelabelService.getLabel(contentId);
           if(labelList!=null && labelList.size()!=0){
           	 //System.out.println("-----------labelList-----"+JsonMapper.toJsonString(labelList)+"-----");
                model.addAttribute("label",labelList);
                model.addAttribute("flaglabel",1);
                return "modules/cms/front/themes/"+site.getTheme()+"/"+getTpl(article);
           }
           model.addAttribute("flaglabel",0);
           //end by yangshw6
           // System.out.println("--------------getTpl(article)----------"+getTpl(article)+"---------------");
            return "modules/cms/front/themes/"+site.getTheme()+"/"+getTpl(article);
		}
		
		return "";
		
	}
	
	/**
	 * 内容评论
	 */
	@RequestMapping(value = "comment", method=RequestMethod.GET)
	public String comment(String theme, Comment comment, HttpServletRequest request, HttpServletResponse response, Model model) {
		//add by luqibao
		//jquery get方式过来的中文变成乱码 
		String title=articleService.get(comment.getContentId()).getTitle();
		comment.setTitle(title);
		//System.out.println(comment.getTitle().toString());
		//end
		Page<Comment> page = new Page<Comment>(request, response);
		Comment c = new Comment();
		c.setCategory(comment.getCategory());
		c.setContentId(comment.getContentId());
		c.setDelFlag(BaseEntity.DEL_FLAG_NORMAL);
		page = commentService.findPage(page, c);
		//UserUtils.getUser();
		model.addAttribute("page", page);
		model.addAttribute("comment", comment);
		model.addAttribute("user",UserUtils.getUser());
		return "modules/cms/front/themes/"+theme+"/frontComment";
	}
	
	/**
	 * 内容评论保存
	 */
	@ResponseBody
	@RequestMapping(value = "comment", method=RequestMethod.POST)
	public String commentSave(Comment comment, String validateCode,@RequestParam(required=false) String replyId, HttpServletRequest request) {
		
		//--------
		if(UserUtils.getUser().getId()!=null){
		if (org.apache.commons.lang3.StringUtils.isNotBlank(replyId)){
			Comment replyComment = commentService.get(replyId);
			if (replyComment != null){
				comment.setContent("<div class=\"reply\">"+replyComment.getName()+":<br/>"
						+replyComment.getContent()+"</div>"+comment.getContent());
			}
			//add by zhengyu
			Article article = articleService.get(comment.getContentId());
			User user=UserUtils.get(article.getCreateBy().getId());
			comment.setArticleCreater(user.getName());
			comment.setArticleCreaterId(user.getId());
			comment.setNameId(UserUtils.getUser().getId());
			//end
			comment.setIp(request.getRemoteAddr());
			comment.setCreateDate(new Date());
			comment.setDelFlag(BaseEntity.DEL_FLAG_NORMAL);
			commentService.save(comment);
			//add hefeng
			articlecountService.updateSingleData(4,1,comment.getContentId());
			oaNotifyService.save(oaNotifyService.PretreatmentMsgBeforeSave(comment));
			//end hefeng
			return "{result:1, message:'提交成功'}";
			
		}else{
			return "{result:1, message:'提交失败。'}";
		}
		}else{
			if (org.apache.commons.lang3.StringUtils.isNotBlank(validateCode)){
			if (ValidateCodeServlet.validate(request, validateCode)){
				if (org.apache.commons.lang3.StringUtils.isNotBlank(replyId)){
					Comment replyComment = commentService.get(replyId);
					if (replyComment != null){
						comment.setContent("<div class=\"reply\">"+replyComment.getName()+":<br/>"
								+replyComment.getContent()+"</div>"+comment.getContent());
					}
				}
				
				//add by zhengyu
				Article article = articleService.get(comment.getContentId());
				User user=UserUtils.get(article.getCreateBy().getId());
				comment.setArticleCreater(user.getName());
				comment.setArticleCreaterId(user.getId());
				comment.setNameId(UserUtils.getUser().getId());
				//end
				comment.setIp(request.getRemoteAddr());
				comment.setCreateDate(new Date());
				comment.setDelFlag(BaseEntity.DEL_FLAG_NORMAL);
				commentService.save(comment);
				articlecountService.updateSingleData(4,1,comment.getContentId());
				//add hefeng
				oaNotifyService.save(oaNotifyService.PretreatmentMsgBeforeSave(comment));
				//end hefeng
				return "{result:1, message:'提交成功'}";
			}else{
				return "{result:2, message:'验证码不正确。'}";
			}
		}else{
			return "{result:2, message:'验证码不能为空。'}";
		}
		}
	}
			
	//add   zhengyu
	/**
	 * 显示收藏的知识 add by zhengyu
	 */
	@RequestMapping(value = "store", method=RequestMethod.GET)
	public String collection(@RequestParam(required=false) String theme, Store store, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Store> page = new Page<Store>(request, response);
		Store s = new Store();
		s.setDelFlag(BaseEntity.DEL_FLAG_NORMAL);// 删除标记删除标记（0：正常；1：删除；2：审核）
		page = storeService.findPage(page, s);
		model.addAttribute("page", page);
		model.addAttribute("store", store);
		//System.out.println("page:"+JsonMapper.toJsonString(page.getList()));
		return "modules/cms/front/";
	}
	/**
	 * 知识分类收藏知识 add by zhengyu
	 */
	@ResponseBody
	@RequestMapping(value = "collect", method=RequestMethod.GET)
	public String collectsave( HttpServletRequest request, HttpServletResponse response,String articleId) {
		Article article =CmsUtils.getArticle(articleId);//获取相关文章
		Store store=new Store(articleId);//titleId
		store.setStoreDate(new Date());//storeDate
		store.setTitle(article.getTitle());//title
		store.setUpLoadUserId(article.getUser().getName());//uploadUserId
		store.setDelFlag("2");//delflag
		store.setCreateBy(UserUtils.getUser());//createBy
		store.setCategory(article.getCategory());//catagory
		store.setIsNewRecord(true);	
		storeService.save(store);
		//System.out.println(store);
		//add by yangshw6
		articlecountService.updateSingleData(2,1,articleId);
		//end by yangshw6
		//add hefeng
		oaNotifyService.save(oaNotifyService.PretreatmentMsgBeforeSave(store));
		//end hefeng
		return null;
	}
	
	
	/**
	 * 取消知识分类收藏知识 add by zhengyu
	 */
	@RequestMapping(value = "collectdelete", method=RequestMethod.GET)
	public String storedelete(String theme,HttpServletRequest request, HttpServletResponse response,String articleId ) {
		
		//System.out.println("取消收藏");
		//store.setStoreCount(store.getStoreCount()-1);
		Store store=new Store();
		store.setCreateBy(UserUtils.getUser());
		store.setTitleId(articleId);
		store.setDelFlag("1");
		storeService.save(store);
		//add by yangshw6
		articlecountService.updateSingleData(2,0,articleId);
		//end by yangshw6
		return null;
	}
	//end
	
	
	/**
	 * 收藏知识 add by zhengyu
	 */
	@ResponseBody
	@RequestMapping(value = "storesave", method=RequestMethod.GET)
	public String collectionsave(String theme,Store store,ArticleCount articleCount, HttpServletRequest request, HttpServletResponse response, Model model) {
		store.setStoreDate(new Date());
		store.setTitle(CmsUtils.getArticletitle(store.getTitleId()));
		store.setDelFlag("2");
		store.setCreateBy(UserUtils.getUser());
		store.setIsNewRecord(true);
		
		try{storeService.save(store);}catch(Exception e){e.printStackTrace();}
		
		//add by yangshw6
		articlecountService.updateSingleData(2,1,store.getTitleId());
		//end by yangshw6
		//add hefeng
		oaNotifyService.save(oaNotifyService.PretreatmentMsgBeforeSave(store));
		//end hefeng
		return null;
	}
	/**
	 * 取消收藏知识 add by zhengyu
	 */
	@RequestMapping(value = "storedelete", method=RequestMethod.GET)
	public String storedelete(String theme,Store store,ArticleCount articleCount,HttpServletRequest request, HttpServletResponse response, Model model) {
		store.setCreateBy(UserUtils.getUser());
		storeService.save(store);
		int countcollect=articlecountService.get(store.getTitleId()).getCountcollect();
		if(countcollect==0){
			return "modules/cms/front/themes/"+theme+"/frontViewArticle";
		}
		articlecountService.updateSingleData(2,0,store.getTitleId());
		//end by yangshw6
		return "modules/cms/front/themes/"+theme+"/frontViewArticle";
	}
	//end
	/**
	 * 推荐知识 add by zhengyu
	 */
	@ResponseBody
	@RequestMapping(value = "recommend", method=RequestMethod.GET)
	public String recommend(String theme,Recommend recommend,ArticleCount articleCount , HttpServletRequest request, HttpServletResponse response, Model model) {
		recommend.setCreateBy(UserUtils.getUser());
		recommend.setTitle(CmsUtils.getArticletitle(recommend.getTitleId()));
		recommend.setRecomDate(new Date());
		recommend.setDelFlag("2");
		recommend.setIsNewRecord(true);
		recommendService.save(recommend);
		//add by yangshw6
		articlecountService.updateSingleData(1,1,recommend.getTitleId());
		//end by yangshw6
		//add hefeng
		oaNotifyService.save(oaNotifyService.PretreatmentMsgBeforeSave(recommend));
		//end hefeng
		return "modules/cms/front/themes/"+theme+"/frontViewArticle";
	}
	/**
	 * 取消推荐知识 add by zhengyu
	 */
	@ResponseBody
	@RequestMapping(value = "cancelRecommend", method=RequestMethod.GET)
	public String cancelRecommend(String theme,Recommend recommend,ArticleCount articleCount, HttpServletRequest request, HttpServletResponse response, Model model) {
		recommend.setCreateBy(UserUtils.getUser());
		recommendService.save(recommend);
		int countreco=articlecountService.get(recommend.getTitleId()).getCountreco();
		if(countreco==0){
			return "modules/cms/front/themes/"+theme+"/frontViewArticle";
		}
		articlecountService.updateSingleData(1,0,recommend.getTitleId());
		return "modules/cms/front/themes/"+theme+"/frontViewArticle";
	}
		/**
	 * 分享知识
	 */
	@ResponseBody
	@RequestMapping(value = "share", method=RequestMethod.GET)
	public String share(String theme,Share share,HttpServletRequest request, HttpServletResponse response, Model model){
		share.setShareDate(new Date());
		share.setCreateBy(UserUtils.getUser());
		share.setTitle(CmsUtils.getArticletitle(share.getTitleId()));
		share.setIsNewRecord(true);	
		shareService.save(share);
		//add by yangshw6
		articlecountService.updateSingleData(3,1,share.getTitleId());
		//end by yangshw6
		//add hefeng
		oaNotifyService.save(oaNotifyService.PretreatmentMsgBeforeSave(share));
		//end hefeng
		return "modules/cms/front/themes/"+theme+"/frontViewArticle";
	}
	
	
	/**
	 * 站点地图
	 */
	@RequestMapping(value = "map-{siteId}${urlSuffix}")
	public String map(@PathVariable String siteId, Model model) {
		Site site = CmsUtils.getSite(siteId!=null?siteId:Site.defaultSiteId());
		model.addAttribute("site", site);
		return "modules/cms/front/themes/"+site.getTheme()+"/frontMap";
	}

    private String getTpl(Article article){
        if(org.apache.commons.lang3.StringUtils.isBlank(article.getCustomContentView())){
            String view = null;
            Category c = article.getCategory();
            boolean goon = true;
            do{
                if(org.apache.commons.lang3.StringUtils.isNotBlank(c.getCustomContentView())){
                    view = c.getCustomContentView();
                    goon = false;
                }else if(c.getParent() == null || c.getParent().isRoot()){
                    goon = false;
                }else{
                    c = c.getParent();
                }
            }while(goon);
            return org.apache.commons.lang3.StringUtils.isBlank(view) ? Article.DEFAULT_TEMPLATE : view;
        }else{
            return article.getCustomContentView();
        }
    }
    //add by luqibao
    @RequestMapping(value="sortList",method=RequestMethod.GET)
    public String sortList(){
    	//System.out.println("");
    	return "/modules/cms/sortList";
    }
    //end
    
    //addby yinshh3
    //首页上库的跳转.cmsClassifyList.jsp界面点击二级知识分类在上传知识上默认选中.
    @RequestMapping(value="categoryid-{categoryid}")
    public String secondid(@PathVariable String categoryid,Model model){
    	//System.out.println("categoryid="+categoryid);
    	//需要一个接口,将secondid传进去,返回的就是一个该用户权限下的二级分类下的文章列表
    	//取出它的flag用于判断是不是二级知识分类
    	int flag=categoryService.getCategoryFlagByID(categoryid);
    	if(flag==2){
    		//如果是二级就存入进去,不是二级就把空给他.
    		model.addAttribute("categorysecondid", categoryid);
    	}
//    	else{
//    		model.addAttribute("categorysecondid", "");
//    	}
    	model.addAttribute("categoryid", categoryid);
       	String secondids=new String();
       	secondids=categoryService.getSecondIdByFlag(categoryid);
     	//System.out.println("secondid为---:"+secondids);
       	List<Article> articleList=Lists.newArrayList();
       	//调用服务
       	articleList= articleService.search(secondids, "", "");
       	Split split=new Split(articleList,1,8);
       	//System.out.println("articleList的长度为:---"+JsonMapper.toJsonString(articleList.size()));
       	//System.out.println("articleList为:---"+JsonMapper.toJsonString(articleList));
       	model.addAttribute("split", split);
    	return "/modules/cms/cmsClassifyList";
    }
    //addby yinshh3
    //对于的cmsClassifyList全局三个变量的获取以及处理
   @ResponseBody
   @RequestMapping(value="getSearchID",method=RequestMethod.POST)
   public Split getLabelID(HttpServletRequest request,HttpServletResponse response,int currentPage ,String labelid,String categoryid,String searchtext)throws UnsupportedEncodingException{
    	//System.out.println("LabelID为---:"+labelid);
    	//System.out.println("CategoryID为---:"+categoryid);
    	//System.out.println("TEXT的文本内容---:"+searchtext);
//特殊字符转码
   	String searchcontent = URLDecoder.decode(searchtext,"UTF-8");
   //	System.out.println("TEXT的文本内容2转码后---:"+searchcontent);
   	String secondids=new String();
   	secondids=categoryService.getSecondIdByFlag(categoryid);
 	//System.out.println("secondid为---:"+secondids);
   	List<Article> articleList=Lists.newArrayList();
   	//调用服务
   	articleList=articleService.search(secondids, searchcontent, labelid);
   	//System.out.println("articleList:"+JsonMapper.toJsonString(articleList));
   	if(articleList.size()!=0){
    	Split split=new Split(articleList,currentPage,8);
    	//System.out.println("CurrentPage"+split.getCurrentPage());
    	//System.out.println("分页信息："+JsonMapper.toJsonString(split.getPageList()));
    	return split;
   	}else{
   		return new Split();
   	}
    }
    //end
   
   //首页搜索的处理
   @RequestMapping(value="getFrontSearchText")
   public String getFrontSerachText(HttpServletRequest request,HttpServletResponse response,@RequestParam String searchtext,Model model) throws UnsupportedEncodingException{
		//System.out.println("searchtext---:"+searchtext);
		  //特殊字符转码
	    	String searchcontent = URLDecoder.decode(searchtext,"UTF-8");
	    	//System.out.println("searchtext转码后---:"+searchcontent);
	    	model.addAttribute("searchcontent", searchcontent);
	    	return "/modules/cms/cmsClassifyList";
    }
    //end
   //首页标签,显示标签下知识的.
   @RequestMapping(value="label-{labelid}")
   public String labeld(@PathVariable String labelid,Model model){
	  // System.out.println("labelid="+labelid);
//	   List<Article> articleList=Lists.newArrayList();
//	   //调用服务
//	   articleList=articleService.search("", "", labelid);
//	   Split split=new Split(articleList,1,3);
//	   //List<Article> pageList=split.getPageList();
//	   System.out.println("articleList的长度为:---"+JsonMapper.toJsonString(articleList.size()));
//	   System.out.println("articleList为:---"+JsonMapper.toJsonString(articleList));
//	   model.addAttribute("split", split);
	   model.addAttribute("labelid",labelid);
	   return "/modules/cms/cmsClassifyList";
   }
   //从首页进来的分页
   @ResponseBody
   @RequestMapping(value="labelfenye",method=RequestMethod.POST)
   public String labelfenye(@PathVariable String labelid,int currentPage,HttpServletRequest request,HttpServletResponse response,Model model){
	//   System.out.println("labelid="+labelid);
	   List<Article> articleList=Lists.newArrayList();
	 //  System.out.println("............."+labelid+"---"+currentPage);
	   //调用服务
	   articleList=articleService.search("", "", labelid);
	   Split split=new Split(articleList,1,8);
	   //List<Article> pageList=split.getPageList();
	//   System.out.println("articleList的长度为:---"+JsonMapper.toJsonString(articleList.size()));
	//   System.out.println("articleList为:---"+JsonMapper.toJsonString(articleList));
	   model.addAttribute("split", split);
	   return "/modules/cms/cmsClassifyList";
   }
   
   //对于首页中 更多>>的处理
   @RequestMapping(value="type-{typeid}")
   public String MoreByType(@PathVariable String typeid,Model model){
	 //  System.out.println("typeid------"+typeid);
	   List<Article> articleList=Lists.newArrayList();
	   //判断是不是 最新知识,是的话把类型和最新知识列表存过去.
	   if(typeid.equals("NewArticle")){
		   articleList=articleService.getNewestArticle();
		   Split split=new Split(articleList,1,8);
		//   System.out.println("lalalal"+JsonMapper.toJsonString(split.getPageList()));
		   model.addAttribute("split", split);
		   model.addAttribute("", typeid);
	   }
	 //判断是不是 热门知识,是的话把类型和热门知识列表存过去.
	   if(typeid.equals("PopularArticle")){
		   articleList=articleService.getHotestArticle();
		   Split split=new Split(articleList,1,8);
		//   System.out.println("lalalal"+JsonMapper.toJsonString(split.getPageList()));
		   model.addAttribute("split", split);
		   model.addAttribute("", typeid);
	   }
	   return "/modules/cms/cmsClassifyList";
   }
   
   //对于更多的分页
   @ResponseBody
   @RequestMapping(value="morefenye",method=RequestMethod.POST)
   public String Morefenye(HttpServletRequest request,HttpServletResponse response,@RequestParam("typeid")String typeid,@RequestParam("currentPage")int currentPage,Model model){
	   List<Article> articleList=Lists.newArrayList();
	   Map<String,Object> map=new HashMap<String,Object>();
	   //判断是不是 最新知识,是的话把类型和最新知识列表存过去.
	   if(typeid.equals("NewArticle")){
		   articleList=articleService.getNewestArticle();
		   Split split=new Split(articleList,currentPage,8);
		   map.put("split",JsonMapper.toJsonString(split));
		   map.put("typeid", typeid);
		   //model.addAttribute("split", split);
		   //model.addAttribute("", typeid);
	   }
	   if(typeid.equals("PopularArticle")){
		   articleList=articleService.getHotestArticle();
		   Split split=new Split(articleList,currentPage,8);
		   map.put("split",JsonMapper.toJsonString(split));
		   map.put("typeid", typeid);
		   //model.addAttribute("split", split);
		   //model.addAttribute("", typeid);
	   }
	   JSONObject json=new JSONObject(map);
	   return json.toString();
   }
   /**
    * 文章预览页面中跳转的首页
    * @return
    */
   @RequestMapping("/vip")
   public String VIPindex(Model model){
	  User user=UserUtils.getUser();
	  Category category=new Category();
	  //category.setName("知识库");
	  List<Category> temp=Lists.newArrayList();
	  List<Category> categoryList=categoryService.findAllCategory(null);
	  List<String> list=categoryService.findCategoryIsAllowShare();
	  List<Category> lc=categoryService.findByIds(list);
	  if(categoryList.size()<=0){
		  model.addAttribute("category", category);
		  model.addAttribute("categoryList", categoryList);
		  
	  }else{
		  
			  for(Category c:categoryList){
					  if(!temp.contains(c)&&c.getParentIds().split(",").length<=2){
						  temp.add(c);
				  }
			  }
			  categoryList.clear();
			  categoryList=temp;
			  model.addAttribute("category", category);
			  model.addAttribute("categoryList",categoryList);
		  
	  }

	  return "modules/cms/front/themes/basic/frontListCategory";
   }
   

   /**
	* 处理pdf文件预览
	* @param response
	* @param request
	* @return 
	* @throws 
	* @author huangmj,2015.10.20
	*/
  
	@RequestMapping(value="viewf")
	public String viewf(ArticleAttFile articleAttFile, Model model,HttpServletResponse response){
		
	   	articleAttFile = articleAttFileService.findFile(articleAttFile);
	   	//System.out.println("f_id:"+articleAttFile.getId()+"filekey"+articleAttFile.getAttfilekey());
	   	String key_url = FileStorageUtils.ossEndPoint+articleAttFile.getAttfilekey();
	   	String fileType = articleAttFile.getAttfiletype();
	   	if(fileType.equals("TXT")||fileType.equals("txt")||fileType.equals("PPTX")||fileType.equals("pptx")||fileType.equals("PPT")||fileType.equals("ppt")
				||fileType.equals("DOCX")||fileType.equals("docx")
				||fileType.equals("DOC")||fileType.equals("doc")
				||fileType.equals("XLS")||fileType.equals("xls")){
	   		key_url = key_url+".pdf";
	   	}
	   	if(fileType.equals("MP4")||fileType.equals("mp4")
		||fileType.equals("AVI")||fileType.equals("avi")){
	   		key_url = key_url+".flv";
	   		
	   	}
	   	//System.out.println("key_url:"+key_url);
	   	articleAttFile.setAttfilekey(key_url);
	   	
	   	model.addAttribute("articleAttFile", articleAttFile);
	   	return "modules/cms/viewfile";
	}
	@RequestMapping(value="viewff")
	public void viewff(ArticleAttFile articleAttFile, Model model,HttpServletResponse response){
		//设置文件MIME类型  
	    //response.setContentType(getServletContext().getMimeType(filename));  
	    //设置Content-Disposition  
		//response.setHeader("Content-Disposition", "attachment;filename="+filename);  
	    //读取目标文件，通过response将目标文件写到客户端  
	    //获取目标文件的绝对路径  
	    //String fullFileName = getServletContext().getRealPath("/download/" + filename);  
		articleAttFile = articleAttFileService.findFile(articleAttFile);
	   	System.out.println("f_id:"+articleAttFile.getId()+"filekey"+articleAttFile.getAttfilekey());
	   	String key_url = articleAttFile.getAttfilekey();//"http://hftest1.oss-cn-beijing.aliyuncs.com/"+
	   	String fileType = articleAttFile.getAttfiletype();
	   	if(fileType.equals("TXT")||fileType.equals("txt")||fileType.equals("PPTX")||fileType.equals("pptx")||fileType.equals("PPT")||fileType.equals("ppt")
				||fileType.equals("DOCX")||fileType.equals("docx")
				||fileType.equals("DOC")||fileType.equals("doc")
				||fileType.equals("XLS")||fileType.equals("xls")){
	   		key_url = key_url+".pdf";
	   	}
	   	if(fileType.equals("MP4")||fileType.equals("mp4")
		||fileType.equals("AVI")||fileType.equals("avi")){
	   		key_url = key_url+".flv";
	   		
	   	}
	   	
	    //System.out.println(fullFileName);  
	    //读取文件  
	    InputStream in = null;
	    OutputStream out = null;
	    response.setContentType("application/force-download");
		String filename = articleAttFile.getAttfilename();
		try {
			response.addHeader("Content-Disposition","attachment; filename=" + URLEncoder.encode(filename, "UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		//response.setContentLength( (int) Integer.parseInt(articleAttFile.getAttfilesize()));
		try {
			System.out.println("key_url:"+key_url);
			//in = new FileInputStream(key_url);
			in = FileStorageUtils.download(key_url);
			out = response.getOutputStream();
		    //写文件  
		    int b;  
			while((b=in.read())!= -1){  
			    out.write(b);  
			}
			in.close();
			out.close();  
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	    
	}
   
}
