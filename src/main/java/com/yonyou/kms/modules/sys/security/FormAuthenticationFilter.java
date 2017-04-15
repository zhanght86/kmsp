/**
 * 
 */
package com.yonyou.kms.modules.sys.security;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.yonyou.kms.common.utils.StringUtils;
import com.yonyou.kms.modules.sys.dao.UserDao;

/**
 * 表单验证（包含验证码）过滤类
 * @author hotsum
 * @version 2014-5-19
 */
@Service
public class FormAuthenticationFilter extends org.apache.shiro.web.filter.authc.FormAuthenticationFilter {

	public static final String DEFAULT_CAPTCHA_PARAM = "validateCode";
	public static final String DEFAULT_MOBILE_PARAM = "mobileLogin";
	public static final String DEFAULT_MESSAGE_PARAM = "message";

	private String captchaParam = DEFAULT_CAPTCHA_PARAM;
	private String mobileLoginParam = DEFAULT_MOBILE_PARAM;
	private String messageParam = DEFAULT_MESSAGE_PARAM;
	
	@Autowired 
	private UserDao userDao;
	@Value("${local_pwd}")
	private String local_pwd;
	

	@Override
	protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) {
		
		String username = getUsername(request);
		String password = getPassword(request);
		if (password==null){
			password = "";
		}
		boolean rememberMe = isRememberMe(request);
		String host = StringUtils.getRemoteAddr((HttpServletRequest)request);
		String captcha = getCaptcha(request);
		boolean mobile = isMobileLogin(request);
		return new UsernamePasswordToken(username, password.toCharArray(), rememberMe, host, captcha, mobile);
		
		//------------
		//mofidify by luqibao
//		String host = StringUtils.getRemoteAddr((HttpServletRequest)request);
//		boolean mobile = isMobileLogin(request);
////		//add by luqibao 修改登录时密码的验证逻辑
//		User user=new User();
//		if(!username.equals("superadmin")){
//			username=username.toUpperCase();
//		}
//		user.setLoginName(username);
//		user=userDao.getByLoginName(user);
//		
//		//boolean flag=true;
//		//不进行密码验证  
////		try {
////			if(username.equalsIgnoreCase("superadmin")){
////				flag = PLStrategy.get(password, user,"local");
////			}else{
////				flag = PLStrategy.get(password, user,"local");
////			}
////			
////		} catch (UnsupportedEncodingException e) {
////			e.printStackTrace();
////		}
////		
////		System.out.println(flag);
////		if(flag){
////			
////		}
//		password=local_pwd;
//		System.out.println(password);
		//end
		//return new UsernamePasswordToken(username, password.toCharArray(), rememberMe, host, mobile);
		//end
	}

	public String getCaptchaParam() {
		return captchaParam;
	}

	protected String getCaptcha(ServletRequest request) {
		return WebUtils.getCleanParam(request, getCaptchaParam());
	}

	public String getMobileLoginParam() {
		return mobileLoginParam;
	}
	
	protected boolean isMobileLogin(ServletRequest request) {
        return WebUtils.isTrue(request, getMobileLoginParam());
    }
	
	public String getMessageParam() {
		return messageParam;
	}
	
	/**
	 * 登录成功之后跳转URL
	 */
	@Override
	public String getSuccessUrl() {
		return super.getSuccessUrl();
	}
	
	@Override
	protected void issueSuccessRedirect(ServletRequest request,
			ServletResponse response) throws Exception {
//		Principal p = UserUtils.getPrincipal();
//		if (p != null && !p.isMobileLogin()){
			 WebUtils.issueRedirect(request, response, getSuccessUrl(), null, true);
//		}else{
//			super.issueSuccessRedirect(request, response);
//		}
	}

	/**
	 * 登录失败调用事件
	 */
	@Override
	protected boolean onLoginFailure(AuthenticationToken token,
			AuthenticationException e, ServletRequest request, ServletResponse response) {
		String className = e.getClass().getName(), message = "";
		if (IncorrectCredentialsException.class.getName().equals(className)
				|| UnknownAccountException.class.getName().equals(className)){
			message = "用户或密码错误, 请重试.";
		}
		else if (e.getMessage() != null && org.apache.commons.lang3.StringUtils.startsWith(e.getMessage(), "msg:")){
			message = org.apache.commons.lang3.StringUtils.replace(e.getMessage(), "msg:", "");
		}
		else{
			message = "系统出现点问题，请稍后再试！";
			e.printStackTrace(); // 输出到控制台
		}
        request.setAttribute(getFailureKeyAttribute(), className);
        request.setAttribute(getMessageParam(), message);
        return true;
	}
	
}