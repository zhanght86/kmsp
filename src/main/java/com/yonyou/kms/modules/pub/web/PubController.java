package com.yonyou.kms.modules.pub.web;

import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.yonyou.kms.common.mail.MailSenderInfo;
import com.yonyou.kms.common.mail.SimpleMailSender;
import com.yonyou.kms.common.utils.CacheUtils;
import com.yonyou.kms.common.web.BaseController;
import com.yonyou.kms.modules.pub.entity.Enterprise;
import com.yonyou.kms.modules.pub.service.EnterpriseService;
import com.yonyou.kms.modules.sys.entity.User;
import com.yonyou.kms.modules.sys.entity.UserSchema;
import com.yonyou.kms.modules.sys.service.SystemService;
import com.yonyou.kms.modules.sys.utils.SchemaUtils;

/*
 * 公有云控制器
 * 
 */
@Controller
@RequestMapping(value = "${adminPath}/pub")
@Transactional(readOnly = false)
public class PubController extends BaseController{
	@Autowired
	private SystemService systemService;
	@Autowired
	private EnterpriseService enterpriseService;
	
	
	/*
	 * 公有云企业注册界面
	 */
	@RequestMapping(value = "register")
	public String register(HttpServletRequest request, HttpServletResponse response, Model model) {

		return "modules/pub/EnterpriseRegister";
	}
	//注册
	@RequestMapping(value = "save")
	public String save(Enterprise ep,HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		String loginame=request.getParameter("login").toUpperCase();
		String psd=request.getParameter("psd");
		int number=enterpriseService.getNumber();
		if(number==0){
			addMessage(redirectAttributes, "创建企业知识库失败!");
			return "redirect:"+adminPath+"/pub/register";
		}
		ep.setCode(String.valueOf(number+1));
		StringBuffer sb=new StringBuffer();
		sb.append("kms").append(ep.getCode());
		//判断登录是否重名
		Map<String,UserSchema> map=SchemaUtils.getAllUserSchema();
		if(map !=null && map.size()>0){
			Set<String> keySet = map.keySet();
			if(keySet.contains(loginame)){
				addMessage(redirectAttributes, "创建企业知识库失败!系统管理员已存在!");
				return "redirect:"+adminPath+"/pub/register";
			}
		}
		//为企业创建一个Schema
		boolean flag=systemService.initSchemaData(sb.toString(), loginame, psd);
		if(!flag){
			addMessage(redirectAttributes, "创建企业知识库失败!企业知识库已存在");
			return "redirect:"+adminPath+"/pub/register";
		}
		//为Schema创建一个租户记录
		String tenantId=enterpriseService.createTenant(sb.toString());
		if(tenantId.equals("")){
			systemService.deleteSchema(sb.toString());
			addMessage(redirectAttributes, "创建企业知识库失败!");
			return "redirect:"+adminPath+"/pub/register";
		}
		//为企业管理员创建公共Schema的关联关系
		if(!enterpriseService.createSuperadmin(loginame, tenantId, sb.toString())){
			systemService.deleteSchema(sb.toString());
			addMessage(redirectAttributes, "创建企业知识库失败!");
			return "redirect:"+adminPath+"/pub/register";
		}
		//enterpriseService.createSuperadmin(loginame, tenantId, sb.toString());
		//在公共Schema下创建企业关系
		
		ep.setTenantId(tenantId);
		User createby=new User();
		createby.setName(loginame);
		createby.setEmail(ep.getEmail());
		ep.setCreateBy(createby);
		if(!enterpriseService.createEnterprise(ep)){
			systemService.deleteSchema(sb.toString());
			addMessage(redirectAttributes, "创建企业知识库失败!");
			return "redirect:"+adminPath+"/pub/register";
		}
		//enterpriseService.createEnterprise(ep);
		CacheUtils.remove(SchemaUtils.CACHE_SCHEMA_MAP);
		addMessage(redirectAttributes, "创建企业知识库成功!");
		
		//add by yinsh3 1.22.2016 9:31 
		String subject="创建成功";
		String content="您好,该企业知识库已经成功创建,谢谢您使用本系统!";
		SchemaUtils.sendEmail(createby, subject, content);
		return "redirect:"+adminPath+"/pub/register";
	}
}
