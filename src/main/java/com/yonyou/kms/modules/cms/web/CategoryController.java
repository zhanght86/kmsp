/**
 * 
 */
package com.yonyou.kms.modules.cms.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yonyou.kms.common.config.Global;
import com.yonyou.kms.common.persistence.Page;
import com.yonyou.kms.common.service.BaseService;
import com.yonyou.kms.common.web.BaseController;
import com.yonyou.kms.modules.cms.dao.ArticleDao;
import com.yonyou.kms.modules.cms.dao.CategoryDao;
import com.yonyou.kms.modules.cms.entity.Article;
import com.yonyou.kms.modules.cms.entity.Category;
import com.yonyou.kms.modules.cms.entity.Site;
import com.yonyou.kms.modules.cms.service.ArticleService;
import com.yonyou.kms.modules.cms.service.CategoryService;
import com.yonyou.kms.modules.cms.service.FileTplService;
import com.yonyou.kms.modules.cms.service.SiteService;
import com.yonyou.kms.modules.cms.utils.CmsUtils;
import com.yonyou.kms.modules.cms.utils.TplUtils;
import com.yonyou.kms.modules.sys.entity.Role;
import com.yonyou.kms.modules.sys.entity.User;
import com.yonyou.kms.modules.sys.service.SystemService;
import com.yonyou.kms.modules.sys.utils.UserUtils;

/**
 * 栏目Controller
 * @author hotsum
 * @version 2013-4-21
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/category")
public class CategoryController extends BaseController {

	@Autowired
	private CategoryService categoryService;
    @Autowired
   	private FileTplService fileTplService;
    @Autowired
   	private SiteService siteService;
    @Autowired
	private ArticleService articleService;
    @Autowired
	private SystemService systemService;
    @Autowired
    private ArticleDao articleDao;
    @Autowired
    private CategoryDao categoryDao;
    
	
	@ModelAttribute("category")
	public Category get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return categoryService.get(id);
		}else{
			return new Category();
		}
	}

	@RequiresPermissions("cms:category:view")
	@RequestMapping(value = {"list", ""})
	public String list(Model model,HttpServletRequest request, HttpServletResponse response) {
		List<Category> list = Lists.newArrayList();
		//add by luqibao
		
		List<Category> sourcelist = categoryService.findByUser(true, null,BaseService.CATEGORY_PLACE_SYS);
		Category.sortList(list, sourcelist, "1");
		//System.out.println(JsonMapper.toJsonString(list));
		
        model.addAttribute("list", list);
        for(Category category:list){
        	//System.out.println(category.getOffice().getName());
        }
        if(UserUtils.getCache("flag")!=null){
        	model.addAttribute("message1", "知识分类下不能创建下级");
        	UserUtils.putCache("flag", null);
        }
		return "modules/cms/categoryList";
	}
	//add by luqibao
	//改变状态
	@ResponseBody
	@RequestMapping(value="toExamine")
	public String  toExamine(Article article, Model model,RedirectAttributes redirectAttributes){
		//System.out.println("toExamine:"+article.getDelFlag());
		String categoryId=categoryService.changeDelFlag(article);
		//System.out.println("categoryId:"+categoryId);
		String flag = article.getDelFlag();
		
		//add hefeng 当知识发布审核上架后，更新消息
		if(flag.equals("0")){
			articleService.PretreatmentUpdateUserMsg(article.getId());
			articleService.revertMsgFlag(article.getId());
		}
		//end hefeng
		
		//addMessage(redirectAttributes, "操作成功");
		//return "redirect:" + adminPath + "/cms/article/?category.id="+categoryId;
		//return "redirect:" + adminPath + "/cms/article/?article.delFlag=";
		return categoryId;
	}
	//end
	
	@RequiresPermissions("cms:category:view")
	@RequestMapping(value = "form")
	public String form(Category category,Model model,RedirectAttributes redirectAttributes) {
		User user=UserUtils.getUser();
		//System.out.println("ID:"+category.getId());
		//add by luqibao判断是新增还是修改  新增的时候 默认显示自己所在部门
		String id=category.getId();
		if(id==null){
			model.addAttribute("isNew", true);
			model.addAttribute("user", user);
		}
		//start
		
		if (category.getParent()==null||category.getParent().getId()==null){
			category.setParent(new Category("1"));
		}
		//add by luqibao  2015-12-30 显示分类下面的管理人员
		List<User> categorymanagers=new ArrayList<User>();
		categorymanagers=categoryService.getUserByCategory(category);
		//界面可以显示本人或者不显示本人
		//categorymanagers.remove(user);
		//add by luqibao 如果是新增的时候 将自己显示出来 2015-12-30
		if(category.getId()==null){
			categorymanagers.add(user);
		}
		//end
		//add by luqibao 2015-12-31显示分类下面已经选择的角色
		List<Role> roles=Lists.newArrayList();
		if(category!=null||!category.equals("")){
			roles=categoryService.getRoleByCategory(category);
			if(roles!=null|roles.size()>0){
				model.addAttribute("roles", roles);
			}
		}
		
		// end
		if(categorymanagers!=null&&categorymanagers.size()!=0){
			model.addAttribute("categorymanagers",categorymanagers);
		}
		Category parent = categoryService.get(category.getParent().getId());
		category.setParent(parent);
		if (category.getOffice()==null||category.getOffice().getId()==null){
			category.setOffice(parent.getOffice());
		}
        model.addAttribute("listViewList",getTplContent(Category.DEFAULT_TEMPLATE));
        model.addAttribute("category_DEFAULT_TEMPLATE",Category.DEFAULT_TEMPLATE);
        model.addAttribute("contentViewList",getTplContent(Article.DEFAULT_TEMPLATE));
        model.addAttribute("article_DEFAULT_TEMPLATE",Article.DEFAULT_TEMPLATE);
		model.addAttribute("office", category.getOffice());
		model.addAttribute("category", category);
		
		//add by luqibao 查询层级
		//System.out.println(category.getParentId());
		String ids[] =categoryService.findparentIdsById(category.getParentId()).split(",");
		if(ids.length>=4){
			//addMessage(redirectAttributes, "该知识分类下不能添加分类");
			UserUtils.putCache("flag", "1");
			return "redirect:"+adminPath+"/cms/category";
		}
		//System.out.println(ids.length);
		model.addAttribute("hierNum", ids.length);
		//end
		//add by luqibao 2015-12-30

		//end
		
		return "modules/cms/categoryForm";
	}
	
	@RequestMapping(value = "addCategoryManage")
	public String addCategoryManage(String managers,HttpServletRequest request, HttpServletResponse response,Model model,RedirectAttributes redirectAttributes){
		List<String> malist=new ArrayList<String>();
		if(managers!=null){
			String[] string=managers.split("\\.");
			malist.addAll(Arrays.asList(string));
		}
		List<User> manager=new ArrayList<User>();
		User user=new User();
		user.setIsNewRecord(true);
		user.setLoginFlag("1");
		user.setIsChecked("0");
		manager=systemService.findUserByOffice(new Page<User>(request, response), user);
		for(int i=0;i<manager.size();i++){
			String id=manager.get(i).getId();
			for(int j=0;j<malist.size();j++){
				String mid=malist.get(j).trim();
				if(id.equals(mid)){
					manager.get(i).setIsChecked("1");
				}
			}
			
		}
		//界面上不显示出来  默认就有管理权限
		//manager.remove(UserUtils.getUser());
		model.addAttribute("managers",manager);
		return "modules/cms/addCategoryManage";
	}
	
	@RequestMapping(value = "addRole")
	public String addCategoryRole(String roles,HttpServletRequest request, HttpServletResponse response,Model model,RedirectAttributes redirectAttributes){
		List<String> malist=new ArrayList<String>();
		if(roles!=null){
			String[] string=roles.split("\\.");
			malist.addAll(Arrays.asList(string));
		}
		
		List<Role> manager=new ArrayList<Role>();
		manager=categoryService.findAllRole();
		for(int i=0;i<manager.size();i++){
			String id=manager.get(i).getId();
			for(int j=0;j<malist.size();j++){
				String mid=malist.get(j).trim();
				if(id.equals(mid)){
					manager.get(i).setIsChecked("1");
				}
			}
			
		}
		//界面上不显示出来  默认就有管理权限
		//manager.remove(UserUtils.getUser());
		model.addAttribute("roles",manager);
		return "modules/cms/addRole";
	}
	
	
	@RequiresPermissions("cms:category:edit")
	@RequestMapping(value = "save")
	public String save(Category category,@RequestParam(value = "managers", required = false)String managers,@RequestParam(value = "selectroles", required = false)String roles,Model model, RedirectAttributes redirectAttributes) {
		//-----
		//System.out.println("managers:"+managers);
	
//		for(String str:userIds){
//			System.out.println(str);
//		}
//		if(category.getModule().equals("article")){
//			if(managers==null || managers.equals("")){
//				addMessage(redirectAttributes, "必须选择一个分类管理员!");
//				return "redirect:" + adminPath + "/cms/category/form?parent.id="+category.getParent().getId();
//			}
//		}
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/cms/category/";
		}
		if (!beanValidator(model, category)){
			return form(category, model,redirectAttributes);
		}
		String id=categoryService.save(category);
		//增加完成以后
		//增加管理此分类的人员 start
		//1.将传输给来的id全部变为user
		List<String> userIds=CmsUtils.transform(managers, ",");
		List<User> newUsers=Lists.newArrayList();
		User user=null;
		category.setId(id);
		for(String idd:userIds){
			user=new User();
			user.setId(idd);
			newUsers.add(user);
		}
		//将原来的管理员取出 删除
		List<User> oldUsers=categoryService.getUserByCategory(category);
		for(User u:oldUsers){
			categoryService.deleteUserCategory(u,category);
		}
		//将现有的这些插入到数据库中
		categoryService.insertUserCategory(newUsers, category);
		
		//end
		//add by luqibao 保存角色到数据中  2015-12-31
		List<String> roleIds=CmsUtils.transform(roles, ",");
		List<Role> newRoles=Lists.newArrayList();
		Role role=null;
		category.setId(id);
		for(String idd:roleIds){
			role=new Role();
			role.setId(idd);
			newRoles.add(role);
		}
		//删除以前的
		List<Role> oldRoles=categoryService.getRoleByCategory(category);
		for(Role r:oldRoles){
			categoryService.deleteRoleCategory(r,category);
		}
		//插入新的
		if(newRoles.size()>0){
			categoryService.insertRoleCategory(newRoles, category);
		}
		//System.out.println("roles"+roles);
		//end
		addMessage(redirectAttributes, "保存栏目'" + category.getName() + "'成功");
		return "redirect:" + adminPath + "/cms/category/";
	}
	
	@RequiresPermissions("cms:category:edit")
	@RequestMapping(value = "delete")
	public String delete(Category category, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/cms/category/";
		}
		List<Article> articles=articleDao.findAllByCategoryId(category);
		List<Category> ids=categoryService.getChildsByCategoryId(category.getId());
		//System.out.println(size);
		if (Category.isRoot(category.getId())){
			addMessage(redirectAttributes, "删除分类失败, 不允许删除知识库或编号为空");
		}else if(ids.size()!=0)
		{
			addMessage(redirectAttributes, "删除分类失败, 有下级分类");
		}else if(articles.size()>0){
			addMessage(redirectAttributes, "删除分类失败, 分类下有文章");
		}
		else{
			categoryService.delete(category);
			addMessage(redirectAttributes, "删除分类成功");
		}
		return "redirect:" + adminPath + "/cms/category/";
	}

	/**
	 * 批量修改栏目排序
	 */
	@RequiresPermissions("cms:category:edit")
	@RequestMapping(value = "updateSort")
	public String updateSort(String[] ids, Integer[] sorts, RedirectAttributes redirectAttributes) {
    	int len = ids.length;
    	Category[] entitys = new Category[len];
    	for (int i = 0; i < len; i++) {
    		entitys[i] = categoryService.get(ids[i]);
    		entitys[i].setSort(sorts[i]);
    		categoryService.save(entitys[i]);
    	}
    	addMessage(redirectAttributes, "保存栏目排序成功!");
		return "redirect:" + adminPath + "/cms/category/";
	}
	
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(String module, @RequestParam(required=false) String extId, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Category> list = categoryService.findByUser(true, module,BaseService.CATEGORY_PLACE_USER);
		for (int i=0; i<list.size(); i++){
			Category e = list.get(i);
			if (extId == null || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParent()!=null?e.getParent().getId():0);
				map.put("name", e.getName());
				map.put("module", e.getModule());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
	
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "treeData1")
	public List<Map<String, Object>> treeData1(String module, @RequestParam(required=false) String extId, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<Category> list = categoryService.findByUser(true, module,BaseService.CATEGORY_PLACE_SYS);
		for (int i=0; i<list.size(); i++){
			Category e = list.get(i);
			if (extId == null || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParent()!=null?e.getParent().getId():0);
				map.put("name", e.getName());
				map.put("module", e.getModule());
				mapList.add(map);
			}
		}
		return mapList;
	}

    private List<String> getTplContent(String prefix) {
   		List<String> tplList = fileTplService.getNameListByPrefix(siteService.get(Site.getCurrentSiteId()).getSolutionPath());
   		tplList = TplUtils.tplTrim(tplList, prefix, "");
   		return tplList;
   	}
    //add hefeng
    /**
	 * 合并
	 */
	@RequestMapping(value = "merge",method=RequestMethod.POST)
	public String merge(@RequestParam("originalcategoryId") String originalcategoryId,@RequestParam("categoryId") String categoryId,Model model,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes) {
		if(originalcategoryId.equals(categoryId)){
			
		}else{
			CmsUtils.MergeCategory(originalcategoryId, categoryId);
			model.addAttribute("message", "合并成功");
		}
		
		return "redirect:"+adminPath+"/cms/category/";
	}
    //end hefeng
}
