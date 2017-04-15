<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<html>
<head>
	<title>标签管理</title>
	<%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp" %>
	<!-- Baidu tongji analytics --><script>var _hmt=_hmt||[];(function(){var hm=document.createElement("script");hm.src="//hm.baidu.com/hm.js?8695d378a6e7e43400b08b7a6dc28a69";var s=document.getElementsByTagName("script")[0];s.parentNode.insertBefore(hm,s);})();</script>
	<sitemesh:head/>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<c:if test="${tagflag !=3}">
	<ul class="nav nav-tabs">
		<li ><a href="${ctx_a}/cms/tagControl">管理标签</a></li>
		<li class="active"><a href="${ctx_a}/cms/addTag"><c:if test="${tagflag==0}">修改</c:if><c:if test="${tagflag==1}">增加</c:if>标签</a></li>
	</ul>
	</c:if>
	<br/>
	<sys:message2 content="${message}"/>
	<form action="${ctx_a}/cms/save" method="post" class="form-horizontal">
		<c:if test="${tagflag !=3}">
		<div class="control-group">
			<label class="control-label">标签名称:</label>
			<input type="text"  id="labelvalue" name="labelvalue" value="${label.labelvalue}" maxlength="4"/>
			<input type="hidden" name="id" value="${label.id}"/>
			<input type="hidden" name="delFlag" value="${label.delFlag}"/>
		</div>
		<div class="control-group">
			<label class="control-label">标签备注:</label>
			<textarea cols="20" rows="5" name="labelcontent" id="labelcontent" maxlength="25">${label.labelcontent}</textarea>
		</div>
		<div class="form-actions">
			<input type="hidden" name="labelflag" id="labelflag" value="1"/>
			<shiro:hasPermission name="cms:article:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		</div>
		</c:if>
		<c:if test="${tagflag ==3}">
		<div class="control-group">
			<label>标签名称:</label>
			<input type="text"  id="labelvalue" name="labelvalue" value="${label.labelvalue}" style="width:150px;" maxlength="4"/>		
			<input type="hidden" name="delFlag" value="${label.delFlag}"/>
			<input type="hidden" name="id" value="${label.id}"/>
		</div>
		<div class="control-group">
			<label>标签备注:</label>
			<textarea cols="20" rows="5" name="labelcontent" id="labelcontent" style="width:150px;" maxlength="25">${label.labelcontent}</textarea>
		</div>
		</c:if>
	<form>
</body>
</html>