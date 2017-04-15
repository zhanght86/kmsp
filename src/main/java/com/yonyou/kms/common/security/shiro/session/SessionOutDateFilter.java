package com.yonyou.kms.common.security.shiro.session;

import java.io.PrintWriter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.web.servlet.AdviceFilter;

import com.yonyou.kms.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.yonyou.kms.modules.sys.utils.UserUtils;

/**
 * 
 * 自定义filter
 * @author Hotusm
 *
 */
public class SessionOutDateFilter extends AdviceFilter{
	
	private String redirectUrl="http://113.108.201.78:8090/portal";//session 失效之后需要跳转的页面
	private String loginUrl="/kms/a/login";//排除这个链接 其他的链接都会进行拦截
	private String frontUrl="cms/f";
	
	protected boolean preHandle(ServletRequest request, ServletResponse response){
		Principal principal = UserUtils.getPrincipal();
		HttpServletRequest req=(HttpServletRequest) request;
		String uri=req.getRequestURI();
		if(uri.endsWith(frontUrl)|loginUrl.equals(uri)|(principal!=null&&!principal.isMobileLogin())){
			return true;
		}
		try {
			issueRedirect(request,response,redirectUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	  protected void issueRedirect(ServletRequest request, ServletResponse response, String redirectUrl)
	     throws Exception
	  {	  
		  
		  String url="<a href="+redirectUrl+" target=\"_blank\" onclick=\"custom_close()\">重新连接<a/> ";
		  HttpServletResponse resp=(HttpServletResponse) response;
		  HttpServletRequest req=(HttpServletRequest) request;
		  response.setContentType("text/html;charset=UTF-8");
		  PrintWriter out=resp.getWriter();
		  out.print("<script language='javascript'>");
		  out.print("function custom_close(){" +
		  			"self.opener=null;" +
		  			"self.close();}");
		  out.print("</script>");
		  out.print("验证信息过期，请点击"+url);
		 
		  
	  }


	  public String getRedirectUrl() {
		return redirectUrl;
	}


	public void setRedirectUrl(String redirectUrl) {
		this.redirectUrl = redirectUrl;
	}


	public String getLoginUrl() {
		return loginUrl;
	}


	public void setLoginUrl(String loginUrl) {
		this.loginUrl = loginUrl;
	}
	
	
}
