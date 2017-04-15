package com.yonyou.kms.modules.sys.security;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.springframework.stereotype.Service;

import com.yonyou.kms.common.utils.CacheUtils;
import com.yonyou.kms.modules.sys.entity.User;
import com.yonyou.kms.modules.sys.utils.UserUtils;

/**
 * 
 * 
 * @author Hotusm
 *
 *
 */
@Service
public class LogoutFilter extends org.apache.shiro.web.filter.authc.LogoutFilter{

	/**
	 * 退出账号的时候 将用户缓存清除
	 */
	@Override
	protected boolean preHandle(ServletRequest request, ServletResponse response)
			throws Exception {
		super.preHandle(request, response);
		UserUtils.removeCache("schema");
		UserUtils.removeCache("schema-private");
		CacheUtils.remove(UserUtils.USER_CACHE, UserUtils.USER_CACHE_ID_+UserUtils.getUser().getId());
		return false;
	}

}
