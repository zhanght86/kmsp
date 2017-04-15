<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	<meta name="decorator" content="blank"/>
	<style type="text/css">
      html,body,table{background-color:#f5f5f5;width:100%;text-align:center;}.form-signin-heading{font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:36px;margin-bottom:20px;color:#0663a2;}
      .form-signin{position:relative;text-align:left;width:300px;padding:25px 29px 29px;margin:0 auto 20px;background-color:#fff;border:1px solid #e5e5e5;
        	-webkit-border-radius:5px;-moz-border-radius:5px;border-radius:5px;-webkit-box-shadow:0 1px 2px rgba(0,0,0,.05);-moz-box-shadow:0 1px 2px rgba(0,0,0,.05);box-shadow:0 1px 2px rgba(0,0,0,.05);}
      .form-signin .checkbox{margin-bottom:10px;color:#0663a2;} .form-signin .input-label{font-size:16px;line-height:23px;color:#999;}
      .form-signin .input-block-level{font-size:16px;height:auto;margin-bottom:15px;padding:7px;*width:283px;*padding-bottom:0;_padding:7px 7px 9px 7px;}
      .form-signin .btn.btn-large{font-size:16px;} .form-signin #themeSwitch{position:absolute;right:15px;bottom:10px;}
      .form-signin div.validateCode {padding-bottom:15px;} .mid{vertical-align:middle;}
      .header{height:80px;padding-top:20px;} .alert{position:relative;width:300px;margin:0 auto;*padding-bottom:0px;}
      label.error{background:none;width:270px;font-weight:normal;color:inherit;margin:0;}
      .mf{margin-left:110px;font-size:20px;}
    </style>


<!--  -->

	<script type="text/javascript">
	$(function(){
	
		var name=$("#hidden_name").val();
		var email=$("#hidden_email").val();
		if(name!=""){
		$("#username").val(name);
		}
		if(email!=""){
		$("#email").val(email);
		}
	});
	</script>

</head>
<body>
	<div class="header">
		<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
			<label id="loginError" class="error">${message}</label>
		</div>
	</div>
	<form id="loginForm" class="form-signin" action="${ctx}/getNewPwd" method="post">
		<label class="input-label" for="username">用户名 </label>
		<input type="hidden" id="hidden_name" value="${hidden_name}"/>
		<input type="text" id="username" name="username" class="input-block-level required" autocomplete='off'>
		<label class="input-label" for="email">邮箱 </label>
		<input type="hidden" id="hidden_email" value="${hidden_email}"/>
		<input type="text" id="email" name="email" class="input-block-level required" autocomplete='off' placeholder="email">
		<input type="submit" class="btn btn-primary" value="发送新密码到邮箱"></br></br>
	</form>
</body>
</html>