<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>站点管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			
			$("#btnredefault").click(function(){
				confirmx("确认要恢复到默认的样式吗？",function(){
					$.ajax({
								type 	: 	"POST",   
		        				url 	: 	'${ctx}/cms/site/redefault',
		        				contentType: "application/json;charset=utf-8",//设置内容的类型
                				dataType: "text",
								success : 	function(data){
											//$.jBox.success("恢复成功", "信息");
											
											location.reload();
		              		  				},
		         				error 	: 	function(){     
		            						$.jBox.error("系统出错", "错误");	
		          							//location.reload();
		          							} 
							});
				});
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/frontswitch">首页轮播</a></li>
		<li class="active"><a href="#">首页修改</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="site" action="${ctx}/cms/site/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group" style="display:none">
			<label class="control-label">站点名称:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group" style="display:none">
			<label class="control-label">站点标题:</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group" style="display:none">
			<label class="control-label">站点Logo:</label>
			<div class="controls">
				<form:hidden path="logo" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="logo" type="images" uploadPath="/cms/site"/>
				<span class="help-inline">建议Logo大小：1000 × 145（像素）</span>
			</div>
		</div>
		<div class="control-group" style="display:none">
			<label class="control-label">描述:</label>
			<div class="controls">
				<form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
			</div>
		</div>
		<div class="control-group" style="display:none">
			<label class="control-label">关键字:</label>
			<div class="controls">
				<form:input path="keywords" htmlEscape="false" maxlength="200"/>
				<span class="help-inline">填写描述及关键字，有助于搜索引擎优化</span>
			</div>
		</div>
		<div class="control-group" style="display:none">
			<label class="control-label">默认主题:</label>
			<div class="controls">
				<form:select path="theme" class="input-medium">
					<form:options items="${fns:getDictList('cms_theme')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		 
		
		<div class="control-group">
			<label class="control-label">首页Head HTML:</label>
			<div class="controls">
			<!--  
				<form:input path="customIndexView" htmlEscape="false" maxlength="200"/>
				-->
				<form:textarea id="customIndexView" htmlEscape="true" path="customIndexView" rows="6" maxlength="2000" class="input-xxlarge"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">首页 Tail HTML:</label>
			<div class="controls">
				<form:textarea id="copyright" htmlEscape="true" path="copyright" rows="6" maxlength="2000" class="input-xxlarge"/>
			</div>
		</div>
		
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
			 
			<input id="btnredefault" class="btn" value="恢复默认" style="width:55px;"/>
		</div>
	</form:form>
</body>
</html>