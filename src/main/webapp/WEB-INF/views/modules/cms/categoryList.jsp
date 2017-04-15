<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>知识库管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 3});
		});
    	function updateSort() {
			loading('正在提交，请稍等...');
	    	$("#listForm").attr("action", "${ctx}/cms/category/updateSort");
	    	$("#listForm").submit();
    	}
    	
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/category/">知识分类列表</a></li>
		<shiro:hasPermission name="cms:category:edit"><li><a href="${ctx}/cms/category/form">知识库添加</a></li></shiro:hasPermission>
	</ul>
	<sys:message2 content="${message1}"/>
	<sys:message2 content="${message}"/>
	<form id="listForm" method="post">
		<table id="treeTable" class="table table-striped table-bordered table-condensed">
			<tr><th>知识分类名称</th><th>归属机构</th><%--<th>知识库模型</th><th style="text-align:center;">排序</th><th title="是否在导航中显示该知识库">导航菜单</th><th title="是否在分类页中显示该栏目的知识列表">知识库列表</th><th>展现方式</th>--%><th>操作</th></tr>
			<c:forEach items="${list}" var="tpl">
				<tr id="${tpl.id}" pId="${tpl.parent.id ne '1'?tpl.parent.id:'0'}">
					<!-- <td><a href="${ctx}/cms/category/form?id=${tpl.id}">${tpl.name}</a></td> -->
					<td>${tpl.name}</td>
					<td>${tpl.office.name}</td>
					<%--<td>${fns:getDictLabel(tpl.module, 'cms_module', '公共模型')}</td>
					<td style="text-align:center;">
						<shiro:hasPermission name="cms:category:edit">
							<input type="hidden" name="ids" value="${tpl.id}"/>
							<input name="sorts" type="text" value="${tpl.sort}" style="width:50px;margin:0;padding:0;text-align:center;">
						</shiro:hasPermission><shiro:lacksPermission name="cms:category:edit">
							${tpl.sort}
						</shiro:lacksPermission>
					</td>
					<td>${fns:getDictLabel(tpl.inMenu, 'show_hide', '隐藏')}</td>
					<td>${fns:getDictLabel(tpl.inList, 'show_hide', '隐藏')}</td>
					<td>${fns:getDictLabel(tpl.showModes, 'cms_show_modes', '默认展现方式')}</td>--%>
					<td>
						<%-- <a href="${pageContext.request.contextPath}${fns:getFrontPath()}/list-${tpl.id}${fns:getUrlSuffix()}" target="_blank">访问</a>&nbsp;&nbsp;&nbsp;--%>
						<shiro:hasPermission name="cms:category:edit">
						
						<c:if test="${tpl.isAdmin=='1'}">
							<a href="${ctx}/cms/category/form?id=${tpl.id}">修改</a>&nbsp;&nbsp;&nbsp;
							<a href="${ctx}/cms/category/delete?id=${tpl.id}" onclick="return confirmx('要删除该知识库及所有子知识项吗？', this.href)">删除</a>&nbsp;&nbsp;&nbsp;
								<shiro:hasPermission name="sys:category:merge">
							<c:if test="${tpl.module=='article'}">
							<sys:categorytreeselect id="category_${tpl.id}" name="category.id" value="${tpl.id}" labelName="category.name" labelValue="${tpl.name}"
								title="合并到另一个知识分类" url="/cms/category/treeData" module="article" selectScopeModule="true" notAllowSelectRoot="false" notAllowSelectParent="true" cssClass="input-small"/>
							</c:if>
							</shiro:hasPermission>
							
						</c:if>
							<c:if test="${tpl.module!='article'}">
								&nbsp;<a href="${ctx}/cms/category/form?parent.id=${tpl.id}">添加下级</a>&nbsp;&nbsp;&nbsp;
							</c:if>
						</shiro:hasPermission>
					</td>
				</tr>
			</c:forEach>
		</table>
		<!--<shiro:hasPermission name="cms:category:edit"><div class="form-actions pagination-left">
			<input id="btnSubmit" class="btn btn-primary" type="button" value="保存排序" onclick="updateSort();"/>
		</div></shiro:hasPermission>-->
	</form>
</body>
</html>