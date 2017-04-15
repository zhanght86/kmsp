/**
 * 
 */
package com.yonyou.kms.modules.sys.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.common.collect.Maps;
import com.yonyou.kms.common.config.Global;
import com.yonyou.kms.common.mail.MailSenderInfo;
import com.yonyou.kms.common.mail.SimpleMailSender;
import com.yonyou.kms.common.security.shiro.session.SessionDAO;
import com.yonyou.kms.common.servlet.ValidateCodeServlet;
import com.yonyou.kms.common.utils.CacheUtils;
import com.yonyou.kms.common.utils.CookieUtils;
import com.yonyou.kms.common.utils.IdGen;
import com.yonyou.kms.common.web.BaseController;
import com.yonyou.kms.modules.cms.service.ArticleService;
import com.yonyou.kms.modules.cms.service.CommentService;
import com.yonyou.kms.modules.sys.dao.UserDao;
import com.yonyou.kms.modules.sys.entity.User;
import com.yonyou.kms.modules.sys.entity.UserSchema;
import com.yonyou.kms.modules.sys.security.FormAuthenticationFilter;
import com.yonyou.kms.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.yonyou.kms.modules.sys.service.SystemService;
import com.yonyou.kms.modules.sys.utils.SchemaUtils;
import com.yonyou.kms.modules.sys.utils.UserUtils;

/**
 * 登录Controller
 * @author 
 */
@Controller
public class LoginController extends BaseController{
	
	@Autowired
	private SessionDAO sessionDAO;
	@Autowired
	private ArticleService articleService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private UserDao userDao;
	
	/**
	 * 管理登录
	 */
	@RequestMapping(value = "${adminPath}/login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response, Model model) {
		Principal principal = UserUtils.getPrincipal();
		
		
		//articleService.search(category, keywords, labels);
		
		
//		// 默认页签模式
//		String tabmode = CookieUtils.getCookie(request, "tabmode");
//		if (tabmode == null){
//			CookieUtils.setCookie(response, "tabmode", "1");
//		}
		
		if (logger.isDebugEnabled()){
			logger.debug("login, active session size: {}", sessionDAO.getActiveSessions(false).size());
		}
		
		//-----------
//		 //如果已登录，再次访问主页，则退出原账号。
//		if (Global.TRUE.equals(Global.getConfig("notAllowRefreshIndex"))){
//			CookieUtils.setCookie(response, "LOGINED", "false");
//		}
		
		 //如果已经登录，则跳转到管理首页
		if(principal != null && !principal.isMobileLogin()){
			return "redirect:" + adminPath;
		}
		//---------------
		
//		//add by luqibao
//		// 当请求是GET的时候，退出当前的账号，需要重新登录
//		if(principal != null && !principal.isMobileLogin()){
//			UserUtils.getSubject().logout();
//		}
//		//end
//		//UserUtils.getSubject().logout();
		UserUtils.removeCache("schema");
		UserUtils.removeCache("schema-private");
		return "modules/sys/sysLogin";
	}
	/**
	 * 登录失败，真正登录的POST请求由Filter完成
	 */
	@RequestMapping(value = "${adminPath}/login", method = RequestMethod.POST)
	public String loginFail(HttpServletRequest request, HttpServletResponse response, Model model) {
		//登录失败以后，将副本中的变量删除 在没有登录的时候 schema为默认的
		UserUtils.removeCache("schema");
		UserUtils.removeCache("schema-private");
		
		Principal principal = UserUtils.getPrincipal();
		// 如果已经登录，则跳转到管理首页
		if(principal != null){
			return "redirect:" + adminPath;
		}

		String username = WebUtils.getCleanParam(request, org.apache.shiro.web.filter.authc.FormAuthenticationFilter.DEFAULT_USERNAME_PARAM);
		boolean rememberMe = WebUtils.isTrue(request, org.apache.shiro.web.filter.authc.FormAuthenticationFilter.DEFAULT_REMEMBER_ME_PARAM);
		boolean mobile = WebUtils.isTrue(request, FormAuthenticationFilter.DEFAULT_MOBILE_PARAM);
		String exception = (String)request.getAttribute(org.apache.shiro.web.filter.authc.FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
		String message = (String)request.getAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM);
		
		if (org.apache.commons.lang3.StringUtils.isBlank(message) || org.apache.commons.lang3.StringUtils.equals(message, "null")){
			message = "用户或密码错误, 请重试.";
		}

		model.addAttribute(org.apache.shiro.web.filter.authc.FormAuthenticationFilter.DEFAULT_USERNAME_PARAM, username);
		model.addAttribute(org.apache.shiro.web.filter.authc.FormAuthenticationFilter.DEFAULT_REMEMBER_ME_PARAM, rememberMe);
		model.addAttribute(FormAuthenticationFilter.DEFAULT_MOBILE_PARAM, mobile);
		model.addAttribute(org.apache.shiro.web.filter.authc.FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME, exception);
		model.addAttribute(FormAuthenticationFilter.DEFAULT_MESSAGE_PARAM, message);
		
		if (logger.isDebugEnabled()){
			logger.debug("login fail, active session size: {}, message: {}, exception: {}", 
					sessionDAO.getActiveSessions(false).size(), message, exception);
		}
		
		// 非授权异常，登录失败，验证码加1。
		if (!UnauthorizedException.class.getName().equals(exception)){
			model.addAttribute("isValidateCodeLogin", isValidateCodeLogin(username, true, false));
		}
		
		// 验证失败清空验证码
		request.getSession().setAttribute(ValidateCodeServlet.VALIDATE_CODE, IdGen.uuid());
		
		// 如果是手机登录，则返回JSON字符串
		if (mobile){
	        return renderString(response, model);
		}
		
		return "modules/sys/sysLogin";
	}

	/**
	 * 登录成功，进入管理首页
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "${adminPath}")
	public String index(HttpServletRequest request, HttpServletResponse response) {
		Principal principal = UserUtils.getPrincipal();
		List<String> str=commentService.commentList(null);
		//System.out.println(JsonMapper.toJsonString(str));
		// 登录成功后，验证码计算器清零
		isValidateCodeLogin(principal.getLoginName(), false, true);
		
		if (logger.isDebugEnabled()){
			
			logger.debug("show index, active session size: {}", sessionDAO.getActiveSessions(false).size());
		}
		
		// 如果已登录，再次访问主页，则退出原账号。
		if (Global.TRUE.equals(Global.getConfig("notAllowRefreshIndex"))){
			
			String logined = CookieUtils.getCookie(request, "LOGINED");
			if (org.apache.commons.lang3.StringUtils.isBlank(logined) || "false".equals(logined)){
				
				CookieUtils.setCookie(response, "LOGINED", "true");
			}else if (org.apache.commons.lang3.StringUtils.equals(logined, "true")){
				UserUtils.getSubject().logout();
				
				return "redirect:" + adminPath + "/login";
			}
		}
		
		// 如果是手机登录，则返回JSON字符串
		if (principal.isMobileLogin()){
			if (request.getParameter("login") != null){
				return renderString(response, principal);
			}
			if (request.getParameter("index") != null){
				return "modules/sys/sysIndex";
			}
			return "redirect:" + adminPath + "/login";
		}
		
//		// 登录成功后，获取上次登录的当前站点ID
//		UserUtils.putCache("siteId", StringUtils.toLong(CookieUtils.getCookie(request, "siteId")));

//		System.out.println("==========================a");
//		try {
//			byte[] bytes = com.yonyou.kms.common.utils.FileUtils.readFileToByteArray(
//					com.yonyou.kms.common.utils.FileUtils.getFile("c:\\sxt.dmp"));
//			UserUtils.getSession().setAttribute("kkk", bytes);
//			UserUtils.getSession().setAttribute("kkk2", bytes);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
////		for (int i=0; i<1000000; i++){
////			//UserUtils.getSession().setAttribute("a", "a");
////			request.getSession().setAttribute("aaa", "aa");
////		}
		
		return "modules/sys/sysIndex";
	}
	
	@RequiresPermissions("user")
	@RequestMapping(value = "${adminPath}"+"/a")
	public String index_1(HttpServletRequest request, HttpServletResponse response) {
		//System.out.println("---10-----");
		Principal principal = UserUtils.getPrincipal();
		// 登录成功后，验证码计算器清零
		isValidateCodeLogin(principal.getLoginName(), false, true);
		return "modules/sys/sysIndex";
		
	}
	/**
	 *获取主题方案
	 */
	@RequestMapping(value = "/theme/{theme}")
	public String getThemeInCookie(@PathVariable String theme, HttpServletRequest request, HttpServletResponse response){
		if (org.apache.commons.lang3.StringUtils.isNotBlank(theme)){
			CookieUtils.setCookie(response, "theme", theme);
		}else{
			theme = CookieUtils.getCookie(request, "theme");
		}
		return "redirect:"+request.getParameter("url");
	}
	
	/**
	 * 是否是验证码登录
	 * @param useruame 用户名
	 * @param isFail 计数加1
	 * @param clean 计数清零
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static boolean isValidateCodeLogin(String useruame, boolean isFail, boolean clean){
		Map<String, Integer> loginFailMap = (Map<String, Integer>)CacheUtils.get("loginFailMap");
		if (loginFailMap==null){
			loginFailMap = Maps.newHashMap();
			CacheUtils.put("loginFailMap", loginFailMap);
		}
		Integer loginFailNum = loginFailMap.get(useruame);
		if (loginFailNum==null){
			loginFailNum = 0;
		}
		if (isFail){
			loginFailNum++;
			loginFailMap.put(useruame, loginFailNum);
		}
		if (clean){
			loginFailMap.remove(useruame);
		}
		return loginFailNum >= 3;
	}
	//add by luqibao
	@RequestMapping("${adminPath}/forward")
	public String forward(){
		//System.out.println("--");
		return "modules/sys/sysIndex";
	}
	//end
	
	//add by yinshh3
	@RequestMapping("${adminPath}/forgotpwd")
	public String forgotpwd(){
		//System.out.println("--");
		return "modules/sys/sysForgotPwd";
	}
	//end
	
	//add by yinshh3
	@RequestMapping(value="${adminPath}/getNewPwd",method = RequestMethod.POST)
	public String getNewPwd(String username,String email,Model model){
		//登录名唯一
		//暂时把loginname当做id用.
		UserSchema schema = SchemaUtils.findUserSchemaByLoginName(username);
		if(schema==null){
			model.addAttribute("message", "请输入正确的用户名");
			model.addAttribute("hidden_name",username);
			model.addAttribute("hidden_email",email);
			return "modules/sys/sysForgotPwd";
		}
		UserUtils.putCache("schema", schema.getTenantSchemaName());
		UserUtils.putCache("schema-private", schema.getTenantSchemaName());
		
		User user=UserUtils.getByLoginName(username);
		String useremail=user.getEmail();
		if(useremail.equals(email)){
		MailSenderInfo mailInfo = new MailSenderInfo();
		  mailInfo.setMailServerHost("smtp.163.com");
		  mailInfo.setMailServerPort("25");
		  mailInfo.setValidate(true);
		  // 邮箱用户名
		  mailInfo.setUserName("kms_pub@163.com");
		  // 邮箱密码cobfqswvbqpjduwd
		  mailInfo.setPassword("cobfqswvbqpjduwd");
		  // 发件人邮箱
		  mailInfo.setFromAddress("kms_pub@163.com");
		  // 收件人邮箱
		  mailInfo.setToAddress(useremail);
		  // 邮件标题
		  mailInfo.setSubject("新的密码");
		  // 邮件内容
		  StringBuffer buffer = new StringBuffer();
		  String password="";
		  password=SimpleMailSender.MakeID();
		  buffer.append("您好,您的新密码是:"+password);
		  mailInfo.setContent(buffer.toString());
		  String plainpassword=SystemService.entryptPassword(password);
		  //,更新密码,明文转密文传入数据库,并且发送邮件
		  try{
		  user.setPassword(plainpassword);
		  userDao.updatePasswordById(user);
		  SimpleMailSender.sendHtmlMail(mailInfo);
		  }catch(Exception e){
			  e.printStackTrace();
		  }
		  return "modules/sys/sysLogin";
		
		}
		else{
			//返回message到界面,说请输入匹配的邮箱名
			model.addAttribute("message", "请输入匹配的邮箱名");
			model.addAttribute("hidden_name",username);
			model.addAttribute("hidden_email",email);
			return "modules/sys/sysForgotPwd";
		}
	}
	//end
	
	
}
