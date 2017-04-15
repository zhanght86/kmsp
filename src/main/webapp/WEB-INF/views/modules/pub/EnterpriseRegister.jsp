<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
  <head>
    <meta name="decorator" content="default"/>
    <title>企业创建</title>
    <script type="text/javascript">
    	$(document).ready(function(){
    		$("#inputForm").validate({
				submitHandler: function(form){
					var count=0;
					var i=0
					reg=/^\w{3,}@\w+(\.\w+)+$/;
					login=/^[A-Za-z0-9]{5,12}$/;
					phone=/^[0-9]+$/;
                    if ($("#ename").val()==""){
                    	count++;
                    }
                    if($("#kname").val()==""){
                    	count++;
                    }
                    if ($("#eadress").val()==""){
                    	count++;
                    }
                    if ($("#etelephone").val()==""){
                    	count++;
                    }
                    if ($("#login").val()==""){
                    	count++;
                    }
                    if ($("#psd").val()==""){
                    	count++;
                    }
                    if ($("#repsd").val()==""){
                    	count++;
                    }
                    if ($("#email").val()==""){
                    	count++;
                    }
                    if($("#email").val()!="" && !reg.test($("#email").val())){ 
                    	$('#msg').text("请填写 正确的邮箱地址!");
                    	i++;
                    }else{
                    	$('#msg').text("");
                    }
                    if($("#telephone").val()!="" && !phone.test($("#telephone").val())){ 
                    	$('#tp').text("请填写正确的电话号码!");
                    	i++;
                    }else{
                    	$('#tp').text("");
                    }
                    if($("#mobilePhone").val()!="" && !phone.test($("#mobilePhone").val())){ 
                    	$('#mtp').text("请填写正确的移动号码!");
                    	i++;
                    }else{
                    	$('#mtp').text("");
                    }
                    if($("#login").val()!="" &&!login.test($("#login").val())){ 
                    	$('#sl').text("管理员账号只能由字母数字组成,在5-12个字符之间!");
                    	i++;
                    }else{
                    	$('#sl').text("");
                    }
                    if($('#psd').val() != $('#repsd').val()){
                    	$('span[name=psd]').text("两次输入的密码不一致");
                    	i++;
                    }else{
                    	$('span[name=psd]').text("");
                    }
                    if(count==0){
                    	if(i==0){
                    		form.submit();	
                    	}else{
                    		$.jBox.tip("根据提示输入正确的信息!");
                    	}
                    }else{
                    	$.jBox.tip("请将带星号的信息填写完整!");
                    }
				}
			});
    	});
    </script>
  </head>
  <body>
	</br></br>
  	<sys:message2 content="${message}"/>
	<form id="inputForm" action="${ctx_a}/pub/save" method="post" class="form-horizontal">
		<div class="control-group">
			<label class="control-label">企业名称:</label>&nbsp;&nbsp;&nbsp;
			<input type="text"  id="name" name="name"/>&nbsp;<span style="color:red">*</span>
		</div>
		<div class="control-group">
			<label class="control-label">固定电话:</label>&nbsp;&nbsp;&nbsp;
			<input type="text"  id="telephone" name="telephone"/>&nbsp;<span style="color:red">*</span><span id="tp" style="color:red"></span>
		</div>
		<div class="control-group">
			<label class="control-label">移动电话:</label>&nbsp;&nbsp;&nbsp;
			<input type="text"  id="mobilePhone" name="mobilePhone"/><span id="mtp" style="color:red"></span>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱:</label>&nbsp;&nbsp;&nbsp;
			<input type="text"  id="email" name="email"/>&nbsp;<span style="color:red">*</span><span id="msg" style="color:red"></span>
		</div>
		<div class="control-group">
			<label class="control-label">地址:</label>&nbsp;&nbsp;&nbsp;
			<input type="text"  id="address" name="address"/>&nbsp;<span style="color:red">*</span>
		</div>
		<div class="control-group">
			<label class="control-label">公司简介:</label>&nbsp;&nbsp;&nbsp;
			<textarea cols="20" rows="5" name="descs" id="introduction" maxlength="25"></textarea>
		</div>
			<legend>管理员账号设置</legend>
			<div class="control-group">
			<label class="control-label">企业管理员账号:</label>&nbsp;&nbsp;&nbsp;
			<input type="text"  id="login" name="login"/>&nbsp;<span style="color:red">*</span></span><span id="sl" style="color:red"></span>
			</div>
			<div class="control-group">
			<label class="control-label">口令:</label>&nbsp;&nbsp;&nbsp;
			<input type="password"  id="psd" name="psd"/>&nbsp;<span style="color:red">*</span><span name="psd" style="color:red"></span>
			</div>
			<div class="control-group">
			<label class="control-label">再次输入口令:</label>&nbsp;&nbsp;&nbsp;
			<input type="password"  id="repsd" name="repsd"/>&nbsp;<span style="color:red">*</span><span name="psd" style="color:red"></span>
			</div>
		<div class="form-actions">
			<Button class="btn btn-info"><a href="${ctx_a}/login" style="color:white;text-decoration:none;">返回登录界面</a></Button>&nbsp;
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
		</div>
	</form>
  </body>
</html>
