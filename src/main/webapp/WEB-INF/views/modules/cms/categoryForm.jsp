<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>知识库管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({ 	
				submitHandler: function(form){
					var length=$('input[name=managers]:checked').length;
					var module="${hierNum}";
					if(module==3){
						if(length==0){
						$.jBox.tip("必须选择一个分类管理员!");
						return false;
						}	
					}
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
			
			//add by yangshw6
			//添加知识分类管理员
			$("#addCategoryManage").click(function(){
				var managers=$('input[name=managers]:checked');
				var string="";
				managers.each(function(){
					if($(this).attr("checked")){
						var value=$(this).val()+".";
						string=string+value;
					}
				});
				$.jBox.open(
            			"iframe:${ctx_a}/cms/category/addCategoryManage?managers="+string,
				 		"选择知识库管理员",300,420, 
				 		{
					 		top:'20px',
		            		buttons: {'确定':true ,'关闭':false},
		            		submit:function(v,h,f){
				            	if(v==true){
				            		$("#CategoryManagers").empty();
				            		var doc = h.find("#jbox-iframe")[0].contentWindow.document;
						            obj = $(doc).find("input[name=selectManger]");
				            		for(k in obj){
				            			if(k==8){
											$("#CategoryManagers").append("<br />");
										}
				            			if(obj[k].checked){
											var v1 = obj[k];
											var v=$(v1);
											$("#CategoryManagers").append("<input name='managers' type='checkbox' value="+obj[k].value +" checked='checked' />"+$(v).attr("manager"));
										}
				            		
				            		}
				            	}
		            		} 	
	            		} 
        		);
        		$('.jbox-content').css('overflow-y','hidden');
			});
			
			//添加角色
			$("#addRole").click(function(){
				var roles=$('input[name=selectroles]:checked');
				var string="";
				roles.each(function(){
					if($(this).attr("checked")){
						var value=$(this).val()+".";
						string=string+value;
					}
				});
				$.jBox.open(
            			"iframe:${ctx_a}/cms/category/addRole?roles="+string,//string 是已选人员的id集合,需要默认选中的人员
				 		"选择知识库管理员",300,420, 
				 		{
					 		top:'20px',
		            		buttons: {'确定':true ,'关闭':false},
		            		submit:function(v,h,f){
				            	if(v==true){
				            		$("#roles").empty();
				            		var doc = h.find("#jbox-iframe")[0].contentWindow.document;
						            obj = $(doc).find("input[name=selectrole]");
				            		for(k in obj){
				            			if(k==8){
											$("#roles").append("<br />");
										}
				            			if(obj[k].checked){
											var v1 = obj[k];
											var v=$(v1);
											$("#roles").append("<input name='selectroles' type='checkbox' value="+obj[k].value +" checked='checked' />"+$(v).attr("role"));
										}
				            		
				            		}
				            	}
		            		} 	
	            		} 
        		);
        		$('.jbox-content').css('overflow-y','hidden');
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/category/">知识分类列表</a></li>
		<li class="active"><a href="${ctx}/cms/category/form?id=${category.id}&parent.id=${category.parent.id}">知识库<shiro:hasPermission name="cms:category:edit">${not empty category.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:category:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="category" action="${ctx}/cms/category/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">归属机构:</label>
			<div class="controls">
				<c:choose>
					<c:when test="${isNew==true}">
					<sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}"
					title="机构" url="/sys/office/treeData" cssClass="required"/>
					&nbsp;&nbsp;&nbsp;
					</c:when>
					<c:otherwise>
					<sys:treeselect id="office" name="office.id" value="${category.office.id}" labelName="office.name" labelValue="${category.office.name}"
					title="机构" url="/sys/office/treeData" cssClass="required"/>
					&nbsp;&nbsp;&nbsp;
					</c:otherwise>
				</c:choose>
                
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上级知识分类:</label>
			<div class="controls">
                <sys:treeselect id="category" name="parent.id" value="${category.parent.id}" labelName="parent.name" labelValue="${category.parent.name}"
					title="知识库" url="" extId="${category.id}" cssClass="required" hideBtn="true" disabled="disabled"/>
			</div>
		</div>
		<div class="control-group" style="display:none">
			<label class="control-label">模型:</label>
			<div class="controls">
				<form:select path="module">
				<c:choose>
						<c:when test="${hierNum==3}">
							<form:option value="article" label="知识分类"/>
						</c:when>
						<c:otherwise>
							<form:option value="" label="知识库"/>
						</c:otherwise>
					</c:choose>
				</form:select>
			</div>
		</div>
		
		
		<div class="control-group">
			<label class="control-label">知识库名称:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		
		<c:choose>
			<c:when test="${hierNum==3}">
				<div class="control-group" >
				<label class="control-label">分类管理员:</label>
				<div class="controls">
					<input class="btn btn-primary" id="addCategoryManage" value="添加" type="button"/>
					<div id="CategoryManagers">
						<c:forEach items="${categorymanagers}" var="managers">
							${managers.name}<input name='managers' type="checkbox" value="${managers.id}" checked="checked" />
						</c:forEach>
					</div>
				</div>
				</div>
				<div class="control-group" >
				<label class="control-label">角色:</label>
				<div class="controls">
					<input class="btn btn-primary" id="addRole" value="添加" type="button"/>
					<div id="roles">
						<c:forEach items="${roles}" var="roles">
							${roles.name}<input name='selectroles' type="checkbox" value="${roles.id}" checked="checked" />
						</c:forEach>
					</div>
				</div>
				</div>
			</c:when>
			<c:when test="${hierNum==3}">
			
			
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>
		
		
		
		<%-- <div class="control-group">
			<label class="control-label">缩略图:</label>
			<div class="controls">
				<form:hidden path="image" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="image" type="thumb" uploadPath="/cms/category"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">链接:</label>
			<div class="controls">
				<form:input path="href" htmlEscape="false" maxlength="200"/>
				<span class="help-inline">知识库超链接地址，优先级“高”</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">目标:</label>
			<div class="controls">
				<form:input path="target" htmlEscape="false" maxlength="200"/>
				<span class="help-inline">知识库超链接打开的目标窗口，新窗口打开，请填写：“_blank”</span>
			</div>
		</div>--%>
		<div class="control-group">
			<label class="control-label">描述:</label>
			<div class="controls">
				<form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">关键字:</label>
			<div class="controls">
				<form:input path="keywords" htmlEscape="false" maxlength="200"/>
				<span class="help-inline">填写描述及关键字</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序:</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="required digits"/>
				<span class="help-inline">知识库的排列次序</span>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">在导航中显示:</label>
			<div class="controls">
				<form:radiobuttons path="inMenu" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline">是否在导航中显示该栏目</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">在分类页中显示列表:</label>
			<div class="controls">
				<form:radiobuttons path="inList" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline">是否在分类页中显示该知识库的知识列表</span>
			</div>
		</div>--%>
		<!-- <div class="control-group">
			<label class="control-label" title="默认展现方式：有子知识显示知识库列表，无子知识显示内容列表。">展现方式:</label>
			<div class="controls">
				<form:radiobuttons path="showModes" items="${fns:getDictList('cms_show_modes')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/><%--
				<form:select path="showModes" class="input-medium">
					<form:option value="" label="默认"/>
					<form:options items="${fns:getDictList('cms_show_modes')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select><span class="help-inline"></span> --%>
			</div>
		</div> -->
		<div class="control-group">
			<label class="control-label">是否允许评论:</label>
			<div class="controls">
				<form:radiobuttons path="allowComment" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		<!-- 
		<div class="control-group">
			<label class="control-label">是否需要审核:</label>
			<div class="controls">
				<form:radiobuttons path="isAudit" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>
		 -->
		<%-- 
		<div class="control-group">
			<label class="control-label">自定义列表视图:</label>
			<div class="controls">
                <form:select path="customListView">
                    <form:option value="" label="默认视图"/>
                    <form:options items="${listViewList}" htmlEscape="false"/>
                </form:select>
                <span class="help-inline">自定义列表视图名称必须以"${category_DEFAULT_TEMPLATE}"开始</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义内容视图:</label>
			<div class="controls">
                <form:select path="customContentView">
                    <form:option value="" label="默认视图"/>
                    <form:options items="${contentViewList}" htmlEscape="false"/>
                </form:select>
                <span class="help-inline">自定义内容视图名称必须以"${article_DEFAULT_TEMPLATE}"开始</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自定义视图参数:</label>
			<div class="controls">
                <form:input path="viewConfig" htmlEscape="true"/>
                <span class="help-inline">视图参数例如: {count:2, title_show:"yes"}</span>
			</div>
		</div>
		--%>
		<div class="form-actions">
			<shiro:hasPermission name="cms:category:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<!-- <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> -->
		</div>
	</form:form>
</body>
</html>