<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<html>
<head>
	<title>知识管理</title>
	<%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp" %>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.validate.js"></script>
	
	<!-- Baidu tongji analytics --><script>var _hmt=_hmt||[];(function(){var hm=document.createElement("script");hm.src="//hm.baidu.com/hm.js?8695d378a6e7e43400b08b7a6dc28a69";var s=document.getElementsByTagName("script")[0];s.parentNode.insertBefore(hm,s);})();</script>
	<sitemesh:head/>
	<meta name="decorator" content="default"/>
	
	<script type="text/javascript">
		$(document).ready(function() {
		
		  $("a").css("font-size", "14px");
		  
            if($("#link").val()){
                $('#linkBody').show();
                $('#url').attr("checked", true);
            }
            
			$("#title").focus();
			var ue = UE.getEditor('ueditor');
			$("#inputForm").validate({
				submitHandler: function(form){
				
                    if ($("#categoryId").val()==""){
                        //$("#categoryName").focus();
                        $.jBox.tip('请选择归属知识库','warning');
                    }else if($("#title").val()==""){
                    	$.jBox.tip('请填写标题','warning');
                    	
                    }
                    else if ($("#content_of_article").val()==""){//else if (CKEDITOR.instances.content.getData()=="" && $("#link").val().trim()==""){
                        $.jBox.tip('请填写正文','warning');
                    }else{
                        //loading('正在提交，请稍等...');
                        
                        form.submit();
                    }
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element){
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
	<style>
		.blueTag{
			color:blue;
		}
	
	</style>
</head>
<body>
<c:if test="${frontIndex!=null}">
	<div class="navbar navbar-fixed-top" style="position:static;margin-bottom:10px;">
      <div class="navbar-inner">
        <div class="container">
          <c:choose>
   			<c:when test="${not empty site.logo}">
   				<img alt="${site.title}" src="${site.logo}" class="container" onclick="location='${ctx}/index-${site.id}${fns:getUrlSuffix()}'">
   			</c:when>
   			<c:otherwise><a class="brand" href="${ctx}/index-${site.id}${fns:getUrlSuffix()}">${site.title}</a></c:otherwise>
   		  </c:choose>
          <div class="nav-collapse">
            <ul id="main_nav" class="nav nav-pills">
			    <li>
			    <a href="${pageContext.request.contextPath}/f/">知识库</a></li>
			    <li>
			    <li>
			    <a href="${pageContext.request.contextPath}/f/">首&nbsp;&nbsp;页</a></li>
			    <li>
			    <li>
			    <a class="active" href="#">知识发布</a></li>
			    <li>
			    <li>
			    <a href="${pageContext.request.contextPath}/f/list-24.html">个人中心</a></li>
			    <li>
			    <a href="${pageContext.request.contextPath}${fns:getAdminPath()}/a" >后台管理</a>
			    </li>
			    
            </ul>
            <form class="navbar-form pull-right" action="${ctx}/search" method="get">
              	<input type="text" name="q" maxlength="20" style="width:65px;" placeholder="全站搜索..." value="${q}">
            </form>
            
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
    <style>
	    #container_1{
	    	width:100%;
	    }
    </style>
</c:if>

	<!-- 123 -->
	<sys:message2 content="${message}"/>
	
	<!-- 123 -->
	<form:form id="inputForm" modelAttribute="article" action="${ctx_a}/cms/article/save" method="post" class="form-horizontal">
		
		<form:hidden path="id" id="current_article_id"/>
		
		<input id="attfile_temp_guid"  name="attfile_temp_guid" value=""  type="hidden"/>
		<input id="cookie_guid"  name="cookie_guid" value=""  type="hidden"/>
		<input id="current_article_id"  name="current_article_id" value="${article.id}"  type="hidden"/>
		<input id="current_category_id"  name="" value="${article.category.id}"  type="hidden"/>
		<input id="save_key"  name="save_key" value="save"  style="display:none"/>
		<c:if test="${person!=null}">
			<input id="person_save_key"  name="person_save_key" value="person_save"  style="display:none"/>
		</c:if>
		<c:if test="${front!=null}">
			<input id="front_save_key"  name="front_save_key" value="front_save"  style="display:none"/>
		</c:if>
		<div class="control-group">
			<label class="control-label">知识分类:</label>
			<div class="controls">
			 
                <sys:treeselect id="category" name="category.id" value="${article.category.id}" labelName="category.name" labelValue="${article.category.name}"
					title="知识分类(只能选择末级)" url="/cms/category/treeData" module="article" selectScopeModule="true" notAllowSelectRoot="false" notAllowSelectParent="true" />&nbsp;
				
					<%-- 隐藏外部链接 cssClass="required"--%>
               <%--  <span>
                    <input id="url" type="checkbox" onclick="if(this.checked){$('#linkBody').show()}else{$('#linkBody').hide()}$('#link').val()"><label for="url">外部链接</label>
                </span>--%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标题:</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="50" class="input-xlarge" style="width:94%"/>
			</div>
			 <!-- <div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-xxlarge measure-input required"/>
				<%-- &nbsp;<label>颜色:</label>
				<form:select path="color" class="input-mini">
					<form:option value="" label="默认"/>
					<form:options items="${fns:getDictList('color')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>--%>
			</div> -->
		</div>
        <div id="linkBody" class="control-group" style="display:none">
          <!--  <label class="control-label">外部链接:</label> --> 
            <div class="controls">
                <form:input path="link" htmlEscape="false" maxlength="200" class="input-xlarge"/>
                <span class="help-inline">绝对或相对地址。</span>
            </div>
        </div>
        
		<div class="control-group">
			<label class="control-label">标签:</label>
			<div class="controls" id="selectTagDiv">
				<!--  
					<form:input path="keywords" htmlEscape="false" maxlength="200" class="input-xlarge"/>
					<span class="help-inline">多个关键字，用空格分隔。</span>
				btn btn-primary-->
				 <a href="#" id="selecetTag1" style="text-decoration:none;">
					<div id="selecetTag1" class="uploadify-button " style="height: 23px; line-height: 23px; width: 72px;">
						<span class="uploadify-button-text" id="selTag">选择标签</span>		
					</div>
					 &nbsp;
					<div id="selecetTag2" class="uploadify-button " style="height: 23px; line-height: 23px; width: 72px;display:none;">
						<span class="uploadify-button-text" id="adTag">增加标签</span>
					</div>
			 	</a>	
				<div class="selectedTags">
					<c:forEach items="${listlabel}" var="listlabel">
						
						<c:if test="${listlabel.ischecked==1}">	
							<input class="selectedTag" name='selectTag' type="checkbox" value="${listlabel.id}" checked >
								<c:if test="${listlabel.delFlag==0}">
								${listlabel.labelvalue}
								</c:if>
								<c:if test="${listlabel.delFlag==1}">
								<span class="blueTag" title="待审核">${listlabel.labelvalue}</span>
								</c:if>
						</c:if>
					</c:forEach>	
				</div>
			</div>
		</div>
		<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
		<script src="${ctxStatic}/jquery-jbox/2.3/i18n/jquery.jBox-zh-CN.min.js" type="text/javascript"></script>
		<script src="${ctxStatic}/jquery/jquery.XYTipsWindow.min.2.8.js" type="text/javascript"></script>
		<script type="text/javascript">
		 
			
				$("#selTag").click(function(){
					var selectedTagString = "";
					$(".selectedTag").each(function(){
						if($(this).attr("checked")){
      						selectedTagString = selectedTagString+$(this).attr("value")+".";
      					}
    				});
    				
					//
			 		$.jBox.open(
            			"iframe:${ctx_a}/sys/user/addmyTag_article?articleid=${article.id}&selectedTagString="+selectedTagString,
				 		"标签列表",300,420, 
				 		{id:'Tag',	  
					 		//ajaxData:{
					 		showScrolling:true,
					 		top:'20px',
		            		buttons: { '增加':2,'确定':true ,'关闭':false},
		            		submit:function(v,h,f){
				            	if(v==true){
				            	$(".selectedTags").empty();
						            //var checked=f.find("input[name='selectTag']:checked").val();
						            //var checked=h.find("#jbox-iframe")[0].contentWindow;
						            //var window=h.find("#jbox-iframe")[0].contentWindow;
						            //var alllabel=window.alllabel.value;
						            var doc = h.find("#jbox-iframe")[0].contentWindow.document;
						            obj = $(doc).find("input[name=selectTag_1]");
						            check_val = [];
									for(k in obj){
										if(k==8){
											$(".selectedTags").append("<br />");
										}
								    	if(obj[k].checked){
											var v1 = obj[k];
											var v=$(v1);
											if($(v).attr('delFlag')==0){
											$(".selectedTags").append("<input name='selectTag' class='selectedTag' type='checkbox' value="+obj[k].value +" checked='checked' />"+$(v).attr("labelvalue1"));
											}else{
											$(".selectedTags").append("<input name='selectTag' class='selectedTag' type='checkbox' value="+obj[k].value +" checked='checked' /><span class='blueTag' title='待审核'>"+$(v).attr("labelvalue1")+"</span>");
											}
										}
									}
					           	}else if(v==2){
					           			$.jBox.close("Tag");
					           			var id=$('#adTag').attr("id");
					           			$('#adTag').trigger("click");				           		
					           		/*
					           		var doc = h.find("#jbox-iframe")[0].contentWindow.document;
						            obj = $(doc).find("input[name=selectTag_1]");
						            check_val = [];
									for(k in obj){
								    	if(obj[k].checked){
											var v1 = obj[k];
											var v=$(v1);
											$(".selectedTags").append("<input name='selectTag' class='selectedTag' type='checkbox' value="+obj[k].value +" checked='checked' onclick='return false;'/>"+$(v).attr("labelvalue1"));
										}
									}
									*/
					           	}
		            		} 	
	            		} 
        			);
        			$('.jbox-content').css('overflow-y','hidden');
				});
				
				$("#adTag").click(function(){
						$.jBox.open("iframe:${ctx_a}/cms/addTag?tagflag=3", 
          		 				"增加标签",  
            					300,  
            					420,  
            					{ id:'addTag',top:'20px',buttons: {'确定':true ,'返回': false},
            					submit:function(v,h,f){
            								if(v==true){
            									var dv;
            									//var checked=f.find("input[name='selectTag']:checked").val();
            									//var checked=h.find("#jbox-iframe")[0].contentWindow;
            									var window=h.find("#jbox-iframe")[0].contentWindow.document;
            									//var labelvalue=window.labelvalue.value;
            									var labelvalue=$(window).find('#labelvalue').val();
            									//var labelcontent=window.labelcontent.value;
            									var labelcontent=$(window).find('#labelcontent').val();
            									$.ajax({  
													type 	: 	"POST",   
		        									url 	: 	'${ctx_a}/cms/saveUnexamineLabel',
		        									data 	:	{
		        												labelvalue: labelvalue,
		        												labelcontent: labelcontent,
		        												labelflag:"0"
		        												},
													success : 	function(data){
																dv=data;						
																	if(data=='1'){
																		$.jBox.tip("信息错误，请重新填写");
																		$('#adTag').trigger("click");								
																	}else if(data=='2'){
																		$.jBox.tip("标签名已被现有的标签所使用,请重新填写");
																		$('#adTag').trigger("click");
																	}else if(data=='0'){
																		$.jBox.close("addTag");
																		$('#selTag').trigger("click");
																	}else{
																		$.jBox.tip("标签限制在4个字符");
																		$('#adTag').trigger("click");
																	}
		              		  									},
		         									error 	: 	function(){     
		            												$.jBox.error("Error Transufal", "Error");	
		          												} 
												});
            								}else{
            									$.jBox.close("addTag");
            									$('#selTag').trigger("click");
            								}
            								return false;
            					}  
        				});
				});
            				
            	/*
            				$.ajax({
								type 	: 	"POST",   
		        				url 	: 	'${ctx}/sys/user/savemyTag',
		        				data 	:	{
		        								addtag: alllabel
		        							},
								success : 	function(){
		            							location.reload();
		              		  				},
		         				error 	: 	function(){     
		            							$.jBox.error("Error Transufal", "Error");	
		          							} 
							});
				*/
         
		</script>
		
		<%-- <div class="control-group">
			<label class="control-label">权重:</label>
			<div class="controls">
				<form:input path="weight" htmlEscape="false" maxlength="200" class="input-mini required digits"/>&nbsp;
				<span>
					<input id="weightTop" type="checkbox" onclick="$('#weight').val(this.checked?'999':'0')"><label for="weightTop">置顶</label>
				</span>
				&nbsp;过期时间：
				<input id="weightDate" name="weightDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate"
					value="<fmt:formatDate value="${article.weightDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
				<span class="help-inline">数值越大排序越靠前，过期时间可为空，过期后取消置顶。</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">摘要:</label>
			<div class="controls">
				<form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">缩略图:</label>
			<div class="controls">
                <input type="hidden" id="image" name="image" value="${article.imageSrc}" />
				<sys:ckfinder input="image" type="thumb" uploadPath="/cms/article" selectMultiple="false"/>
			</div>
		</div>
		正文:
		rows="4" maxlength="500"--%>
		<!--  
		<div class="control-group">
			<label class="control-label">正文:</label>
			<div class="controls">
				<form:textarea id="content" htmlEscape="true" path="articleData.content"  class="input-xxlarge"/>
				<sys:ckeditor replace="content" uploadPath="/cms/article" />
			</div>
		</div>
		 --> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/ueditor1_4_3-utf8-jsp/ueditor.config.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/ueditor1_4_3-utf8-jsp/ueditor.all.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/ueditor1_4_3-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
		
		<div class="control-group">
			<label class="control-label">正文:</label>
			<input id="content_of_article" htmlEscape="true" name="articleData.content"  class="input-xxlarge" type="hidden"/>
			<div class="controls">
				<script id="ueditor" type="text/plain" style="width:98%;height:400px;">
				${article.articleData.content}
				</script>
				<script type="text/javascript">
				 	var ue = UE.getEditor('ueditor');
				 	
				 	//这段要放在文本编辑器的实例化之后
					function temporary_save(){
						if (!UE.getEditor('ueditor').hasContents()){
							$.jBox.tip('请填写正文','warning');
							return false;
						}else{
							$("#content_of_article").val(UE.getEditor('ueditor').getContent());
							//alert(UE.getEditor('ueditor').getContent());
							$('#save_key').attr("disabled", true);//save_key==null 暂存
						return true;
						}
					}
					
					function just_save(){
						if (!UE.getEditor('ueditor').hasContents()){
							$.jBox.tip('请填写正文','warning');
							return false;
						}else{
							$("#content_of_article").val(UE.getEditor('ueditor').getContent());
							$('#save_key').attr("disabled", false);//save_key!=null 保存
							$.jBox.tip('正在保存知识','success');
							return true;
						}
					}
				</script>
				<span>
				<span style="font-size:10px;color:#333">
					支持上传、在线预览文件的格式：
					<span style="font-size:10px;color:#666">
						常见图片格式; mp4、flv、webm、ogv视频;
					</span>
					&nbsp;&nbsp;&nbsp;&nbsp;支持文件大小：
					<span style="font-size:10px;color:#666">
						10MB以内。
					</span>
				</span>
				</span>
			
			</div>
		</div>
		
		<%--<div class="control-group">
			<label class="control-label">来源:</label>
			<div class="controls">
				<form:input path="articleData.copyfrom" htmlEscape="false" maxlength="200" class="input-xlarge"/>
			</div>
		</div>
		 <div class="control-group">
			<label class="control-label">相关知识:</label>
			<div class="controls">
				<form:hidden id="articleDataRelation" path="articleData.relation" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<ol id="articleSelectList"></ol>
				<a id="relationButton" href="javascript:" class="btn">添加相关</a>
				<script type="text/javascript">
					var articleSelect = [];
					function articleSelectAddOrDel(id,title){
						var isExtents = false, index = 0;
						for (var i=0; i<articleSelect.length; i++){
							if (articleSelect[i][0]==id){
								isExtents = true;
								index = i;
							}
						}
						if(isExtents){
							articleSelect.splice(index,1);
						}else{
							articleSelect.push([id,title]);
						}
						articleSelectRefresh();
					}
					function articleSelectRefresh(){
						$("#articleDataRelation").val("");
						$("#articleSelectList").children().remove();
						for (var i=0; i<articleSelect.length; i++){
							$("#articleSelectList").append("<li>"+articleSelect[i][1]+"&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"articleSelectAddOrDel('"+articleSelect[i][0]+"','"+articleSelect[i][1]+"');\">×</a></li>");
							$("#articleDataRelation").val($("#articleDataRelation").val()+articleSelect[i][0]+",");
						}
					}
					$.getJSON("${ctx}/cms/article/findByIds",{ids:$("#articleDataRelation").val()},function(data){
						for (var i=0; i<data.length; i++){
							articleSelect.push([data[i][1],data[i][2]]);
						}
						articleSelectRefresh();
					});
					$("#relationButton").click(function(){
						top.$.jBox.open("iframe:${ctx}/cms/article/selectList?pageSize=8", "添加相关",$(top.document).width()-220,$(top.document).height()-180,{
							buttons:{"确定":true}, loaded:function(h){
								$(".jbox-content", top.document).css("overflow-y","hidden");
							}
						});
					});
				</script>
			</div>
		</div>--%>
		<style type="text/css">
		.pp .del{
			position: absolute;
			left: 720px;
			}
		.pp .dow{
			position: absolute;
			left: 650px;
			}
			
		</style>
<!-- 附件 start huangmj 2015.10.21 onmouseover="dl_mouseover(this)" onmouseout="dl_mouseout(this)"-->
<c:if test="${listlabelsize!=0}">
		<div class="control-group" id="att_file">	
	 		<label class="control-label">已上传附件:</label>
	 		<div class="controls">
	     		<c:forEach items="${listArticleAttFile}" var="listAttFile">
	     			<p  class="pp" >
	     				<span title="${listAttFile.attfilename}">
	     					${fns:abbr(listAttFile.attfilename,50)}
	     				</span>
	     				<a class="del" filename="${listAttFile.attfilename}" idd=${listAttFile.id}  acticleid=${listAttFile.acticleid} >删除</a>
	     				
	     				<a class="dow"title="点击下载" href="${ctx_a}/cms/article/downloadattfile?id=${listAttFile.id}">下载</a>
	     			  
	     			</p>
				</c:forEach>
			</div>
	 	</div>
</c:if>
	 	
	 	<script type="text/javascript">
	 	
	 	$(".pp").mouseover(function(){
			$(this).css("background","rgb(238, 238, 238)");
		}).mouseout(function(){
			$(this).css("background","none");
		});

            $(".pp > .del").on("click", function (){
	            var idd = $(this).attr("idd");
	            //var ctx = ""+$(this).attr("ctx");
	            var acticleid = $(this).attr("acticleid");
	            //alert(idd+ctx);
	            var currenTr = $(this).parent('.pp');
	            var filename = $(this).attr("filename");
	            //var r = confirm("你确定删除"+filename+"?");
  				//if (r==true){
  				$.jBox.confirm('你确定删除'+filename+'?','系统提示',function(v,h,f){
	  				if(v=='ok'){
			           	$.ajax({ 
			          			     type : "POST",   
			          			     url : '${ctx_a}/cms/article/deleteattfile',
			          			     data : {
			            				   id : idd,
			            			acticleid : acticleid
			          			},
			          			 dataType : "text",
			          			 success : function(data){
			          			  	//alert(data);
			            		  	currenTr.remove();
			            			 
			          			},
			          			 error : function(jqXHR){     
			            				alert("发生错误：" + jqXHR.status); 
			            				//$(this).closest(".pp").remove();
			            				
			          			}    
			        	});
			        }
		        });	
		      });
         	
        </script>
		<!-- 附件表 end huangmj 2015.10.21-->
		
		<!-- 附件支持上传到 start huangmj 2015.10.21-->
	 	<div class="control-group" id="att_file">	
	 		<label class="control-label">添加附件:</label>
	 		<div class="controls">
     			<div id="fileQueue"></div>
     			<div id="fileInfo"></div>
				<input type="file" name="uploadify" id="uploadify" />
				<span>
					<span style="font-size:10px;color:#333">
						支持在线预览文件的格式：
					<span style="font-size:10px;color:#666">
						常见图片格式; mp4、avi、flv视频;word、ppt、txt(utf-8)、pdf文档。
					</span>
					&nbsp;&nbsp;&nbsp;&nbsp; 支持文件大小：
					<span style="font-size:10px;color:#666">
						10MB以内。
					</span>
				</span>
				
				</span>
			</div>
	 	</div>
	 	
<!--附件支持js start huangmj 2015.10.21-->
		<div class="control-group" id="isAllowDownload">	
	 		<label class="control-label">附件允许下载:</label>
	 		<div class="controls">
	 			<span>
					<input id="articleData.isallowdownload1" name="articleData.isallowdownload" type="radio" value="1"
						<c:if test="${article.articleData.isallowdownload==1}">
							checked="checked"
						</c:if>
					/>
					<label for="articleData.isallowdownload1">是</label>
				</span>
				<span>
					<input id="articleData.isallowdownload2" name="articleData.isallowdownload" type="radio" value="0"
						<c:if test="${article.articleData.isallowdownload==0}">
							checked="checked"
						</c:if>
					 />
					<label for="articleData.isallowdownload2">否</label>
				</span>
			</div>
	 	</div>

	
	
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/uploadify.css"></link>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.uploadify.js"></script>
	 	<script type="text/javascript">
	 	function setCookie(c_name,value,expiredays){
			var exdate=new Date()
			exdate.setDate(exdate.getDate()+expiredays)
			document.cookie=c_name+ "=" +escape(value)+
			((expiredays==null) ? "" : ";expires="+exdate.toGMTString())
		}
		function getCookie(name)
		{
			//alert(name);
			var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
			if(arr=document.cookie.match(reg))
			return unescape(arr[2]);
			else
			return null;
		}
		function newGuid(){
   			var guid = "";
    		for (var i = 1; i <= 32; i++){
      			var n = Math.floor(Math.random()*16.0).toString(16);
      			guid +=   n;
      			if((i==8)||(i==12)||(i==16)||(i==20))
        		guid += "";
    		}
    	return guid;    
		}
		
		function cutstr(str,len){
  			var str_length = 0;
   			var str_len = 0;
      		str_cut = new String();
      		str_len = str.length;
      		for(var i = 0;i<str_len;i++){
       	 		a = str.charAt(i);
        		str_length++;
       			if(escape(a).length > 4){
         			//中文字符的长度经编码之后大于4
         			str_length++;
         		}
         		str_cut = str_cut.concat(a);
         		if(str_length>=len){
         			str_cut = str_cut.concat("...");
         			return str_cut;
        		}
    		}
    		//如果给定字符串小于指定长度，则返回源字符串；
    		if(str_length<len){
     			return  str;
    		}
		}
		
		
			var category_id="123";
		
	 	$(document).ready(function(){ 
	 		
	 		$(".filenaem").val(
	 			cutstr($(".filenaem").text(),10)
	 			);
 			
 			//附件标记->对应知识保存状态
 			var attfile_temp_guid = newGuid()
 			$("#attfile_temp_guid").val(attfile_temp_guid);
 			
 			var cookie_guid = newGuid();
 			
 			$("#cookie_guid").val(cookie_guid);
 			//var category_id =$("#current_category_id").val();
 			
 			var current_article_id = $("#current_article_id").val();
 			
 			//category_id= $("#categoryId").val();
 			//alert("category_id1:"+category_idd);
 /*
      		setCookie('cookie_guid',cookie_guid,365);
      		var category_id1 = $("#current_category_id").val();
      		setCookie('category_id',category_id1,365);
      		var category_id2 = $("#categoryId").val();
      		setCookie('category_id',category_id2,365);
      		var current_article_id = $("#current_article_id").val();
      		setCookie('current_article_id',current_article_id,365);
*/     		
/*
    		function deleteTR(index,filename) {
				$("tr[id='"+index+"']").remove();
	    		$.post(
	    			'${ctx}deleteFile.do?id='+index+'&&name='+encodeURI(encodeURI(filename))+''
	    			);
			}
			
*/

			var uploadify_onSelectError = function(file, errorCode, errorMsg) {  
       		 	var msgText = "上传失败\n";  
        		switch (errorCode) {  
	       		 /*
	            case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:  
	                //this.queueData.errorMsg = "每次最多上传 " + this.settings.queueSizeLimit + "个文件";  
	                msgText += "每次最多上传 " + this.settings.queueSizeLimit + "个文件";  
	                break;
	             */ 
	            case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:  
	                msgText += "文件大小超过限制( " + this.settings.fileSizeLimit + " )";  
	                break; 
	            /*     
	            case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:  
	                msgText += "文件大小为0";  
	                break;  
	            
	            case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:  
	                msgText += "文件格式不正确，仅限 " + this.settings.fileTypeExts;  
	                break;  
	            */
	            default:  
	                msgText += "错误代码：" + errorCode + "\n" + errorMsg;  
        		}  
        		alert(msgText);  
    		};  

           	$("#uploadify").uploadify({
	        'swf' 				: 	'${ctx1}resources/js/uploadify.swf',
	        'cancelImg' 		: 	'${ctx1}resources/img/uploadify-cancel.png',
	        'uploader' 			: 	'${ctx1}a/cms/article/uploadFile',
	        'onSelect'			: 	 function(file){
           								 category_id = $("#categoryId").val();
        							},
	        'queueID' 			: 	'fileQueue',//文件在页面的显示队列的id
	        'queueSizeLimit' 	: 	8,//可上传文件的个数
	        'auto' 				: 	true,
	        'method'			:	'post',
	        'width'  			: 	'72',
	        'height' 		    : 	'23',
	        'progressData'		:	'percentage',//显示进度条
	        /*'removeTimeout'	:	0.5, 如果设置了任务完成后自动从队列中移除，则可以规定从完成到被移除的时间间隔。*/
	        'removeCompleted'	:	false,
	        'multi' 			: 	true,
	        'successTimeout'	:	50,
	        'fileSizeLimit'		: 	'10MB',//限制上传文件大小
	        'buttonText' 		: 	'选择文件',
	        'buttonClass' 		: 	'',
	        /*'overrideEvents'  : 	[ 'onDialogClose', 'onUploadSuccess', 'onUploadError', 'onSelectError' ], */ 
		    /*'onSelect'        : 	uploadify_onSelect, */ 
		    'overrideEvents' 	: 	['onUploadSuccess','onUploadStart', 'onSelectError'],
		    "formData"			: 	{"cookie_guid":cookie_guid,"category_idd":$("#categoryId").val(),"current_article_id":current_article_id,"attfile_temp_guid":attfile_temp_guid},
            // 'onUploadStart' 	: 	function(file) {$("#uploadify").uploadify("settings", "formData", {'userName':'huangmj');}, 
		    'onCancel'		 	:	function(file){alert('文件：'+file.name+'取消！')},
		  	'onSelectError'     :   uploadify_onSelectError,  
	        'onUploadSuccess' 	: 	function(file, data, response) { //成功提醒 
						        	//alert(data);
						        	/*
						        	var jsonResult = eval('('+data+')');
						        	var trid=jsonResult.id;
						        	var filename = jsonResult.file_name;
									$("#fileInfo").append("<tr id="+trid+"><td>"+file.name+"</td>  <td>"+jsonResult.uploadTime+
											"</td> <td><a class='red' href=\"javascript:deleteTR('" + trid + "','"+ filename 
											+ "');\">删除</a></td><input type='hidden' name='id' value='"
											+jsonResult.id+"'></tr>")
						       	 	*/
	       	 	
	       	  }
	       	});
    	});  
     </script> 
		<!-- 附件支持js end huangmj 2015.10.21-->
<!-- 附件支持上传到 	end huangmj 2015.10.21   -->
<!-- 知识是否支持分享 	start huangmj 2015.10.21-->
		<div class="control-group">
			<label class="control-label">允许对外分享:</label>
			<div class="controls">
				<span>
					<input id="articleData.allowshare1" name="articleData.allowshare" type="radio" value="1"
						<c:if test="${article.articleData.allowshare=='1'}">
							checked="checked"
						</c:if>
					/>
					<label for="articleData.allowshare1">是</label>
				</span>
				<span>
					<input id="articleData.allowshare2" name="articleData.allowshare" type="radio" value="0"
					<c:if test="${article.articleData.allowshare=='0'}">
						checked="checked"
					</c:if>
					 />
					<label for="articleData.allowshare2">否</label>
				</span>
			</div>
		</div>
<!-- 知识是否支持分享 end huangmj 2015.10.21-->
		
		<div class="control-group">
			<label class="control-label">是否允许评论:</label>
			<div class="controls">
				<span>
					<input id="articleData.allowComment1" name="articleData.allowComment" type="radio" value="1"
						<c:if test="${article.articleData.allowComment=='1'}">
							checked="checked"
						</c:if>
					/>
					<label for="articleData.allowComment1">是</label>
				</span>
				<span>
					<input id="articleData.allowComment2" name="articleData.allowComment" type="radio" value="0"
					<c:if test="${article.articleData.allowComment=='0'}">
						checked="checked"
					</c:if>
					 />
					<label for="articleData.allowComment2">否</label>
				</span>
			</div>
		</div>
		
		
		<%-- <div class="control-group">
			<label class="control-label">推荐位:</label>
			<div class="controls">
				<form:checkboxes path="posidList" items="${fns:getDictList('cms_posid')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</div>
		</div>--%>
		<!-- huangmj 隐藏发布时间 -->
		<div class="control-group"  style="display:none" >
			<label class="control-label">发布时间:</label>
			<div class="controls">
				<input id="createDate" name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<shiro:hasPermission name="cms:article:audit">
		<%--begin zhengyu --%>
			<div class="control-group" style="display:none">
				<label class="control-label">发布状态:</label>
			
				<div class="controls">
				  <span>
				      <input id="delFlag1" name="delFlag" class="required" type="radio" value="2" checked="checked"/>
				  </span> 
				</div>
			</div>
			<%--end --%>
		</shiro:hasPermission>
		<shiro:hasPermission name="cms:category:edit">
             <%--<div class="control-group">
                <label class="control-label">自定义内容视图:</label>
                <div class="controls">
                      <form:select path="customContentView" class="input-medium">
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
            </div>--%>
		</shiro:hasPermission>
		<%-- <c:if test="${not empty article.id}">
			<div class="control-group">
				<label class="control-label">查看评论:</label>
				<div class="controls">
					<input id="btnComment" class="btn" type="button" value="查看评论" onclick="viewComment('${ctx_a}/cms/comment/?module=article&contentId=${article.id}&status=0')"/>
					<script type="text/javascript">
						function viewComment(href){
							$.jBox.open('iframe:'+href,'查看评论',$(top.document).width()-220,$(top.document).height()-180,{
								buttons:{"关闭":true},
								loaded:function(h){
									$(".jbox-content", top.document).css("overflow-y","hidden");
									$(".nav,.form-actions,[class=btn]", h.find("iframe").contents()).hide();
									$("body", h.find("iframe").contents()).css("margin","10px");
								}
							});
							return false;
						}
					</script>
				</div>
			</div>
		</c:if>--%>
		<div class="form-actions">
			<!-- style="position: absolute;left:-77px; top:15px;" -->
				<shiro:hasPermission name="cms:article:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="暂存" onClick="return temporary_save();"/>&nbsp;</shiro:hasPermission>
				
			
				<shiro:hasPermission name="cms:article:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" onClick="return just_save();"/>&nbsp;</shiro:hasPermission>
				<!-- huangmj 2015.10.26 区分前后台显隐 -->
				<c:if test="${indexx!='0'}">
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</c:if> 
				
		</div>
	</form:form>
</body>
</html>