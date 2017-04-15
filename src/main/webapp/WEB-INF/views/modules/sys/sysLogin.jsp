<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	<meta name="decorator" content="blank"/>
	<style type="text/css">
      html,body,table{background-color:#f5f5f5;width:100%;text-align:center;}.form-signin-heading{font-family:Helvetica, Georgia, Arial, sans-serif, 雅黑;font-size:36px;margin-bottom:20px;color:#0663a2;}
      .form-signin{background:url(${ctxStatic}/source-index/images/shape-2.png) repeat -20px -20px;position:relative;text-align:left;width:400px;height:412px;padding:0 0;margin:0 auto 20px;background-color:#fff;border:1px solid #e5e5e5;
        	-webkit-border-radius:3px;-moz-border-radius:3px;border-radius:3px;-webkit-box-shadow:0 1px 2px rgba(0,0,0,.05);-moz-box-shadow:0 1px 2px rgba(0,0,0,.05);box-shadow:0 1px 2px rgba(0,0,0,.05);}
       .form-signin .input-label{font-size:16px;    font-weight: bolder;line-height:23px;color:#999;}
      .form-signin .input-block-level{font-size:16px;height:44px;    font-weight: bolder;
    width: 308px;margin: 30px 46px 0;padding:7px 29px;*width:283px;*padding-bottom:0;}
      .form-signin .btn.btn-large{font-size:16px;} .form-signin #themeSwitch{position:absolute;right:15px;bottom:10px;}
      .form-signin div.validateCode {padding-bottom:15px;} .mid{vertical-align:middle;}
      .header{height:80px;padding-top:20px;} .alert{position:relative;width:300px;margin:0 auto;*padding-bottom:0px;}
      label.error{background:none;width:270px;font-weight:normal;color:inherit;margin:0;}
      .mf{margin-left:110px;font-size:20px;}
      .m1{background:#1489c9;color:#fff;padding:10px 18px;width:364px;
    margin: 20px 0 0;}
    .login_user{background:url(${ctxStatic}/source-index/images/login_user.png) no-repeat 10px 13px;}
     .login_pwd{background:url(${ctxStatic}/source-index/images/login_pwd.png)  no-repeat 10px 13px;}
      .m2{padding: 0 46px;width:400px; 
    margin: 24px 0 0;float:left;font-size:14px;display:inline-block;}
    .m3{ 
    margin: 0 36px ;font-size:14px;display:inline-block;font-weight:bold;}
    .m4{ 
    margin: 20px 116px ;}
    
    .btn {
    width:166px;
    height:44px;
    display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    margin-top:22px;
    font-size: 14px;
    font-weight: normal;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
}
.btn-info {
    color: #fff;
    background-color: #1489c9;
  
}
.m5{width:310px;font-size:16px;border-top:1px solid #999;margin:0 46px;padding:20px 0;}
.mr{
float:right;}
    </style>


<!--  -->

	<script type="text/javascript">
	
		$(document).ready(function() {
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
		
	</script>

</head>
<body>
	<div class="header">
		<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
			<label id="loginError" class="error">${message}</label>
		</div>
	</div>
	<!-- h1 class="form-signin-heading">${fns:getConfig('productName')}</h1-->
	<!--form id="loginForm" class="form-signin" action="${ctx}/login" method="post">
		<label class="input-label" for="username">登录名 </label>
		<input style="display:none">
		<input type="text" id="username" name="username" class="input-block-level required" autocomplete='off'>
		<label class="input-label" for="password">密码</label>
		<input style="display:none">
		<input type="password" id="password" name="password" class="input-block-level required" autocomplete='off'>
		<input class="btn btn-large btn-primary" type="submit" value="登 录"/>&nbsp;&nbsp;
		<div id="themeSwitch" class="dropdown">
			<ul class="dropdown-menu">
			  <c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
			</ul>
		</div>
	</form-->
	<form id="loginForm" class="form-signin" action="${ctx}/login" method="post">
	<div class="m1">请登录</div>
	<div class="input-control">
		<input type="text" id="username" name="username" class="input-block-level required login_user" autocomplete='off' placeholder="用户名ID">
		</div>
		<input style="display:none">
		<input type="password" id="password" name="password" class="input-block-level required login_pwd" autocomplete='off' placeholder="密码">
		<input style="display:none">
		<div class="m2">
		<div style="border-right:1px dotted #000;width:150px;display:inline-block;">
		<input type="checkbox" style="width:20px;height:20px;" name="rememberMe"/>记住我的信息&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
		<a  class="m3" href="${ctx}/forgotpwd">忘记密码</a>
		</div>
		<div class="m4">
		<button class="btn btn-info" type="submit">登录</button>
		</div>
		<div class="m5">
		还没有企业知识库?<a class="mr" href="${ctx}/pub/register">在这点击创建</a>
		</div>
		<div id="themeSwitch" class="dropdown">
			<ul class="dropdown-menu">
			  <c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
			</ul>
		</div>
	</form>
	<!--div class="footer">
		Copyright &copy; 2014-${fns:getConfig('copyrightYear')} <a href="${pageContext.request.contextPath}${fns:getFrontPath()}">${fns:getConfig('productName')}</a> - Powered By <a href="#" target="_blank">yonyou</a> ${fns:getConfig('version')} 
	</div -->
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
</body>
</html>