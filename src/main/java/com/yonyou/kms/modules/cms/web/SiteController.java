/**
 * 
 */
package com.yonyou.kms.modules.cms.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yonyou.kms.common.config.Global;
import com.yonyou.kms.common.persistence.Page;
import com.yonyou.kms.common.utils.CacheUtils;
import com.yonyou.kms.common.utils.CookieUtils;
import com.yonyou.kms.common.web.BaseController;
import com.yonyou.kms.modules.cms.entity.Site;
import com.yonyou.kms.modules.cms.service.SiteService;
import com.yonyou.kms.modules.sys.utils.SchemaUtils;
import com.yonyou.kms.modules.sys.utils.UserUtils;
import com.yonyou.kms.common.mapper.JsonMapper;

/**
 * 站点Controller
 * @author hotsum
 * @version 2013-3-23
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/site")
public class SiteController extends BaseController {

	@Autowired
	private SiteService siteService;
	private static final String CMS_CACHE = "cmsCache";
	
	@ModelAttribute
	public Site get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return siteService.get(id);
		}else{
			return new Site();
		}
	}
	
	//@RequiresPermissions("cms:site:view")
	@RequestMapping(value = {"list", ""})
	public String list(Site site, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Site> page = siteService.findPage(new Page<Site>(request, response), site); 
        model.addAttribute("page", page);
		return "modules/cms/siteList";
	}

	//@RequiresPermissions("cms:site:view")
	@RequestMapping(value = "form")
	public String form(Site site, Model model) {
		model.addAttribute("site", site);
		return "modules/cms/siteForm2";
	}
	
	//@RequiresPermissions("cms:site:view")
	@ResponseBody
	@RequestMapping(value = "redefault",method=RequestMethod.POST)
	public String reDefault() {
		Site site=siteService.get("1");
		Site sitedefault=new Site();
		sitedefault=siteService.get("2");
		site.setCustomIndexView(sitedefault.getCustomIndexView());
		site.setCopyright(sitedefault.getCopyright());
		//
		siteService.save(site);
		String schemaName=SchemaUtils.findUserSchemaByLoginName(UserUtils.getUser().getLoginName()).getTenantSchemaName();
		if(schemaName==null){
			schemaName="guestuser";
		}
		CacheUtils.remove(CMS_CACHE, schemaName+"siteList");
		return JsonMapper.toJsonString(site);
	}

	//@RequiresPermissions("cms:site:edit")
	@RequestMapping(value = "save")
	public String save(Site site, Model model, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/cms/site/?repage";
		}
		if (!beanValidator(model, site)){
			return form(site, model);
		}
		siteService.save(site);
		String schemaName=SchemaUtils.findUserSchemaByLoginName(UserUtils.getUser().getLoginName()).getTenantSchemaName();
		if(schemaName==null){
			schemaName="guestuser";
		}
		CacheUtils.remove(CMS_CACHE, schemaName+"siteList");
		addMessage(redirectAttributes, "保存修改成功");
		//model.addAttribute("site", site);
		//addMessage(redirectAttributes, "保存站点'" + site.getName() + "'成功");
		return "redirect:" + adminPath + "/cms/site/form?id="+site.getId();
		//return form(site, model);
	}
	
	@RequiresPermissions("cms:site:edit")
	@RequestMapping(value = "delete")
	public String delete(Site site, @RequestParam(required=false) Boolean isRe, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/cms/site/?repage";
		}
		if (Site.isDefault(site.getId())){
			addMessage(redirectAttributes, "删除站点失败, 不允许删除默认站点");
		}else{
			siteService.delete(site, isRe);
			addMessage(redirectAttributes, (isRe!=null&&isRe?"恢复":"")+"删除站点成功");
		}
		return "redirect:" + adminPath + "/cms/site/?repage";
	}
	
	/**
	 * 选择站点
	 * @param id
	 * @return
	 */
	@RequiresPermissions("cms:site:select")
	@RequestMapping(value = "select")
	public String select(String id, boolean flag, HttpServletResponse response){
		if (id!=null){
			UserUtils.putCache("siteId", id);
			// 保存到Cookie中，下次登录后自动切换到该站点
			CookieUtils.setCookie(response, "siteId", id);
		}
		if (flag){
			return "redirect:" + adminPath;
		}
		return "modules/cms/siteSelect";
	}
}
