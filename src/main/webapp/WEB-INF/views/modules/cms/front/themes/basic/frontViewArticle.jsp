<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<!--allowshare==1允许分享状态，userIsLogin==1用户登录状态  huangmj 2015.10.22-->

<c:choose>
	<c:when test="${article.articleData.allowshare==1 || userIsLogin==1 }">

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1.0, user-scalable=no">
	<%--<%@ include file="/WEB-INF/views/include/head.jsp" %>--%>
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.validate.js"></script>
	<script src="${ctxStatic}/jquery-jbox/2.3/i18n/jquery.jBox-zh-CN.min.js" type="text/javascript"></script>
	<title>${article.title} - ${category.name}</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="${article.description} ${category.description}" />
	<meta name="keywords" content="${article.keywords} ${category.keywords}" />
	
<!--Start CSS huang Start 2015 11 11 -->
	<style type="text/css">
		#span22{width:12%;}
		.span10{width:988px;}
		.pre_location{ width:100%;  line-height:54px; border-bottom:2px solid #1489c9;}
		.pre_title h2{ height:40px; background:#1489c9; color:#fff; line-height:40px; padding-left: 12px; width:988px; font-size:24px;  font-weight:normal;}
		
		#attfiletitle{
		  	color: #000;
		  	font-size: 18px;
		  	height: 30px;
		  	float: left;
		}
	
		.fileline{
			margin-bottom: 5px;	
			list-style:none
		}
		
		.file_download{
			position: absolute;
			left: 84%;
		}
		.file_play{position: absolute;left: 65%;}
		.file_playy{position: absolute;left: 65%;}
		.picshow{display:inline; }
		
/* CSS Document */
ul,li,ol{list-style:none; }
.pre_location{ width:100%; line-height:32px; border-bottom:2px solid #1489c9;}
.pre_location .pre_loc{ width:1000px;  margin:0 auto; font-size:14px; color:#ccc;}
.pre_location .pre_loc a:link,.pre_location .pre_loc a:visited{ color:#666;}
.pre_location .pre_loc a:hover{ color:#1489c9;}

.pre_center{ width:1000px; height:auto; overflow:hidden; margin:42px auto;}
.pre_center .pre_title{ height:auto; width:100%; overflow:hidden; float:left;}
.pre_center .pre_title h2{ height:40px; background:#1489c9; color:#fff; line-height:40px; padding-left: 12px; width:988px; font-size:24px;  font-weight:normal;}
/*.pre_center .pre_title p{ font-size:14px; line-height:24px; padding:25px 10px 25px 10px; text-align:justify; color:#000; border-bottom:2px dotted #ccc; margin-bottom: 15px;}*/
.pre_center .pre_vedio{border-bottom:2px solid #ccc; float:left; width:100%; overflow:hidden; height:auto; padding-bottom:20px;}
.pre_center .pre_vedio ul{ float:left; width:100%; font-size:14px;  height:auto; overflow:hidden; }
.pre_center .pre_vedio ul p{ color:#000; font-size:18px; height:30px; float:left;}

.pre_center .pre_vedio ul li{ height:25px; width:100%; }
.pre_center .pre_vedio ul li span{ float:left;}
.pre_center .pre_vedio ul li a{ float:left; padding-right:14px; color:#1489c9;}
.pre_center .pre_vedio .vedio{ width:100%;  height:590px; background:#000; float:left; display:none;}
.pre_center .pr_detail{ float:left; width:100%; height:auto; overflow:hidden;}
.pre_center .pr_detail dl{ height:auto; overflow:hidden; width:988px; background:#e5e5e5; line-height:27px; float:left; margin-top:2px;  margin-bottom: 1px; font-size:12px; color:#666; padding-left: 12px;  }
.pre_center .pr_detail dl dt{ float:left; height:27px; }
.pre_center .pr_detail dl dd{ float:left;margin-right: 36px; height:27px;}
.pre_save{ /*height:37px;*/ float:left; padding-top: 13px; width:100%; border-bottom:2px solid #ccc;}
.pre_save .save{ width:198px; height:37px;float:left; padding-left: 10px;}

.pre_save .save span{ width:37px; height:24px; float:left; color:#fff; margin-right: 12px; line-height:24px;  text-align:left; padding-left: 34px; cursor:pointer;}
.pre_save .save span.tj{ background:url(<%=request.getContextPath()%>/resources/img/tuijian.png) no-repeat;}
.pre_save .save span.untj{ background:url(<%=request.getContextPath()%>/resources/img/untuijian.png) no-repeat left center;color:#333;}
.pre_save .save span.untj:hover{background:url(<%=request.getContextPath()%>/resources/img/tuijian.png) no-repeat left center;color:#fff; border:none;}
.pre_save .save span.sc{ background:url(<%=request.getContextPath()%>/resources/img/save.png) no-repeat;}
.pre_save .save span.unsc{ background:url(<%=request.getContextPath()%>/resources/img/unsave.png) no-repeat left center;color:#333;}	
.pre_save .save span.unsc:hover{background:url(<%=request.getContextPath()%>/resources/img/save.png) no-repeat left center;color:#fff; border:none;}	
.pre_save .save span.unlove{ background:url(<%=request.getContextPath()%>/resources/img/save2.png) no-repeat; width:71px; text-align:center; padding-left: 0;}
.pre_save .share{ font-size:14px;  color:#000; line-height:25px;<%-- width:255px;--%> float:left;}
.pre_save .share span{ float:left; padding-left: 10px;}
.pre_save .share div{ float:left;}
<%--.pre_save .share div.bdsharebuttonbox a{margin-top: 0px; background:url(<%=request.getContextPath()%>/resources/img/share.png) no-repeat 0 0;}--%>
.share .bdsharebuttonbox {margin:-5px 10px 0;}
.pre_save .share div.bdsharebuttonbox a.sh2{ background-position:-25px 0;}
.pre_save .share div.bdsharebuttonbox a.sh3{ background-position:-50px 0;}
.pre_save .share div.bdsharebuttonbox a.sh4{ background-position:-75px 0;}
.pre_save .share div.bdsharebuttonbox a.sh5{ background-position:-100px 0;}
.pre_save .share div.bdsharebuttonbox a.sh6{ background-position:-125px 0;}
.pre_list{ float:left; margin-top: 27px;}
.pre_list h3{ height:27px; line-height:27px; border-left:5px solid #1489c9;  font-size:18px; color:#000; background:#dcedf7; width:984px; font-weight:normal; padding-left: 11px;}
.pre_list ul{ width:1000px;}
.pre_list ul li{   padding-bottom: 5px;width:970px;/*height:42px; line-height:42px; padding-left: 30px;background:url(<%=request.getContextPath()%>/resources/img/images/dot.png) no-repeat 12px center;*/ font-size:14px; border-bottom:2px dotted #ccc;  }

.pre_center .fenye{ margin:18px 0 0 0px; float:left; width:1000px; overflow:hidden;}
.pre_center .fenye a{ display:inline-block; margin-right:8px ;padding:0px 10px; border:1px solid #ccc; height:24px; line-height:24px; cursor:pointer; float:left;}
.pre_center .fenye a:link,.pre_center .fenye a:visited{ color:#666;}
.pre_center .fenye a:hover{ color:#fff; background:#0e9cd8; border:1px solid #0e9cd8;}
.pre_list{ width:100%; height:auto; overflow:hidden; float:left;}
.liuyan{padding:22px 10px;}
.liuyan textarea{ padding:10px; outline:none; width:800px;}
.liuyan span{ width:82px; float:left; height:30px; font-size:14px; color:#000;}
.liuyan .submit{  border: 2px solid #FFF; width:180px; height:60px; color:#fff; line-height:60px; text-align:center; background:#f19715; font-size:26px; cursor:pointer; display:block; margin-top:4px;margin-bottom: -42px;margin-left:9%; font-family:arial,'Hiragino Sans GB','Microsoft YaHei','微软雅黑','宋体',sans-serif;}
#validateCode{position: relative;}
@media (max-width:1000px) {
.pre_center{ width:100%;}
.pre_save .save{ width:100%;}
.liuyan span{ width:100%;}
.liuyan textarea{ width:92%;}
.pre_center .pr_detail dl{ padding-left: 2%; width:98%;}
.pre_center .pr_detail dl dd{ margin-right: 14px;}
.pre_center .pr_detail dl .fb{ width:100%;}
.pre_location .pre_loc{ width:100%;}
.pre_center .pre_vedio{ padding-left: 2%;}
.pre_location{ padding-left: 2%; width:98%;}
.pre_center .fenye{ width:98%; padding-left: 2%;}
}
/* 页面布局 End */

		footer{ 
		background-color: #1489c9;
		text-align:center;
		border-top:1px solid #000;
		padding:10px 0 10px 0;
		margin-top: 10px;
	    width:100%;
	    font-size: 14px;
	    
		} 
		.color-F00{ color:#FFFFFF;}  
		.span11{
		width:98%;
		}
	
</style>
<!--End  CSS huang2015 11 11 -->
		
	<script type="text/javascript">
		$(document).ready(function() {
			$("#officeshow").hide();
			$("#player2").hide();
			if ("${category.allowComment}"=="1" && "${article.articleData.allowComment}"=="1"){
				$("#comment").show();
				page(1);
			}
		});
		function page(n,s){
			$.get("${ctx}/comment",{theme: '${site.theme}', 'category.id': '${category.id}','articleCreater':'${article.user.name}',
				contentId: '${article.id}', title: '${article.title}', pageNo: n, pageSize: s, date: new Date().getTime()
			},function(data){
				$("#comment").html(data);
			});
		}
		
		<%-- add by zhengyu--%>
			
$(function(){
		$('.pre_save .save .recommend span').click(function(){
						var favoriteflag=$(this).attr("favoriteflag");//当前点击项
						$('.pre_save .save .recommend span').attr("disabled",true); 
						if(favoriteflag==0){
						$.ajax({
                			type:'GET',
                			url:'${ctx}/recommend',
                			data:{
                				 theme: '${site.theme}',
                				 'category.id': '${category.id}',
                				 'titleId':'${article.id}'
                				},
                			success:function(){
			 						$.jBox.tip('推荐成功');
			 						$('.pre_save .save .recommend span').attr("disabled",false); 
                					$('.pre_save .save .recommend span').removeClass("untj");
									$('.pre_save .save .recommend span').addClass("tj");	
									$('.pre_save .save .recommend span').attr("favoriteflag","1");
									<%-- add by yangshw6--%>
									var n=parseInt($('.pr_detail dd').eq(2).text());		
									$('.pr_detail dd').eq(2).text(n+1);
									<%-- end by zhengyu--%>
                			},error:function() {
                                    $.jBox.tip('推荐失败');
                                }
                		});
                		}else{
                		$.ajax({
                			type:'GET',
                			url:'${ctx}/cancelRecommend',
                			data:{
                				 theme: '${site.theme}',
                				 'delFlag':'1',
                				 'titleId':'${article.id}'
                				},
                			success:function(){
                					$.jBox.tip('取消推荐');
                					$('.pre_save .save .recommend span').attr("disabled",false); 
                					$('.pre_save .save .recommend span').removeClass("tj");
									$('.pre_save .save .recommend span').addClass("untj");
									$('.pre_save .save .recommend span').attr("favoriteflag","0");	
									<%-- add by yangshw6--%>
									var n=parseInt($('.pr_detail dd').eq(2).text());
									if(n>0){
										$('.pr_detail dd').eq(2).text(n-1);
									}		
									
									<%-- end by zhengyu--%>	
                			},error:function() {
                                    $.jBox.tip('取消推荐失败');
                                }
                			});
                		
                		
                		}
                		})
			
			
			$('.pre_save .save .collect  span').click(function(){
						var favoriteflag=$(this).attr("favoriteflag");//当前点击项
						$('.pre_save .save .collect span').attr("disabled",true);
						if(favoriteflag==0){
						$.ajax({
                			type:'GET',
                			url:'${ctx}/storesave',
                			data:{
                				 theme: '${site.theme}',
                				 'category.id': '${category.id}',
                				 'upLoadUserId': '${article.user.name}',
                				 'titleId':'${article.id}'
                				},
                			success:function(){
			 						$.jBox.tip('收藏成功');
			 						$('.pre_save .save .collect span').attr("disabled",false);
                					$('.pre_save .save .collect span').removeClass("unsc");
									$('.pre_save .save .collect span').addClass("sc");	
									$('.pre_save .save .collect span').attr("favoriteflag","1");
                					<%-- add by yangshw6--%>
									var n=parseInt($('.pr_detail dd').eq(3).text());		
									$('.pr_detail dd').eq(3).text(n+1);
									<%-- end by zhengyu--%>
                			},error:function() {
                                    $.jBox.tip('收藏失败');
                                }
                		});
                		}else{
                		$.ajax({
                			type:'GET',
                			url:'${ctx}/storedelete',
                			data:{
                				 theme: '${site.theme}',
                				 'delFlag':'1',
                				 'titleId':'${article.id}'
                				},
                			success:function(){
                					$.jBox.tip('取消收藏');
                					$('.pre_save .save .collect span').attr("disabled",false);
                					$('.pre_save .save .collect span').removeClass("sc");
									$('.pre_save .save .collect span').addClass("unsc");
									$('.pre_save .save .collect span').attr("favoriteflag","0");	
									<%-- add by yangshw6--%>
									var n=parseInt($('.pr_detail dd').eq(3).text());
									if(n>0){
										$('.pr_detail dd').eq(3).text(n-1);
									}
									<%-- end by zhengyu--%>
                			},error: function() {
                                    $.jBox.tip('取消收藏失败');
                                }
                			});
                		
                		
                		}
                		})
                		
			
		$('.share .bdsharebuttonbox a').click(function(){

		$.ajax({
                			type:'GET',
                			url:'${ctx}/share',
                			data:{
                				 theme: '${site.theme}',
                				 'ownlib':'${article.category.id}',
                				 'allowShare':'${article.articleData.allowComment}',
                				 'titleId':'${article.id}',
                				 'category.id': '${category.id}'
                				},
                			success:function(){
                				
                			}
                		});	
			})
		})

<%-- end--%>
		
	</script>
	<script type="text/javascript"> 
	$(document).ready(function(){ 
	    //平台、设备和操作系统   
	    var system ={  
	        win : false,  
	        mac : false,  
	        xll : false  
	    };  
	    //检测平台   
	    var p = navigator.platform;  
	    system.win = p.indexOf("Win") == 0;  
	    system.mac = p.indexOf("Mac") == 0;  
	    system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);  
	    //跳转语句   
	    if(system.win||system.mac||system.xll){//转向后台登陆页面  
	      
	    }else{
	    	$("#go_head").hide(); 
	        $(".file_playy").hide(); 
	    } 
    });     
</script>  
	
<!-- 12 8 -->
<style type="text/css">
/*联系框*/
.wrap-box{height:2500px;}
/* fixed-bar */
.fixed-bar .icon,.fixed-bar .consult-list .tel-icon{background:url("<%=request.getContextPath()%>/resources/img/JS_02.png") no-repeat;}
.fixed-bar .icon{display:block;position:absolute;top:50%;left:50%;width:23px;height:12px;overflow:hidden;margin:-18px 0 0 -12px;background-position:right -220px;text-indent:-999em;}
.fixed-bar{position:fixed;right:20px;bottom:50px;z-index:50;_position:absolute;_bottom:auto;_top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0))-30);}
.fixed-bar .gotop{position:relative;z-index:1;display:block;width:68px;height:36px;overflow:hidden;margin:-1px 0 0;padding:32px 0 0;border:1px solid #e6e6e6;border-top:1px dashed #eaeaea;background-color:#fff;color:#666;font:normal 14px/36px "Microsoft YaHei","\5FAE\8F6F\96C5\9ED1";text-align:center;}
.fixed-bar .share{height:68px;overflow:hidden;margin:-1px 0 0;border:1px solid #e6e6e6;}
.fixed-bar .gotop:hover{z-index:10;border-color:#e6870a;background-color:#e6870a;color:#fff;text-decoration:none;}
.fixed-bar .gotop:hover .icon{background-position:right -251px;}
/*.fixed-bar .consult-box{border:1px solid #e6e6e6;}*/
.fixed-bar .consult-box .consult-header{position:relative;height:18px;margin:-1px 0px 0;background:#e6870a;}
.fixed-bar .consult-box .consult-title{color:#fff;font:normal 16px/36px "Microsoft YaHei","\5FAE\8F6F\96C5\9ED1";text-align:center;}
.fixed-bar .consult-box .icon{display:none;top:0;left:-28px;width:28px;height:36px;overflow:hidden;margin:0;background-position:-80px -530px;cursor:pointer;}
.fixed-bar .consult-box .icon:hover{background-position:-110px -530px;}
.fixed-bar .consult-list{margin:0 2px -1px;padding:9px 0;border-bottom:1px dashed #eaeaea;}
.fixed-bar .consult-list li{padding:6px 0 6px 23px;color:#666;font:normal 12px/24px "Microsoft YaHei","\5FAE\8F6F\96C5\9ED1";}
.fixed-bar .consult-list span,.fixed-bar .consult-list a{float:left;line-height:24px;}
.fixed-bar .consult-list span{padding-right:10px;}
.fixed-bar .consult-list img{vertical-align:top;}
.fixed-bar .wide-bar{background:#fff;}
.fixed-bar .wide-bar .share .bds_more{width:148px;_width:146px;background-position:-252px -568px;}
.fixed-bar .wide-bar .share .bds_more:hover{background-position:-354px -568px;}
.fixed-bar .wide-bar .gotop{width:132px;}
.fixed-bar .consult-list .tel-icon{margin-left:-15px;padding:0 0 0 20px;background-position:-591px -264px;}
</style>
<script type="text/javascript">    
$(document).scroll(function(){ 
	//alert('scroll');
	var  scrollTop =  $(document).scrollTop(),bodyHeight = $(window).height(); 
	//alert('scrollTop > bodyHeight'+'scrollTop:'+scrollTop+'bodyHeight:'+bodyHeight);
	if(scrollTop>500){ 
		$('#greenline').css('display','block');
		$('.fixed-bar .gotop').css('display','block');
	}else{
		$('.fixed-bar .gotop').css('display','none');
		$('#greenline').css('display','none');
	} 
})
</script>
<link rel="stylesheet"  href="<%=request.getContextPath()%>/resources/js/zoom.css" media="all" />
	  <style type="text/css">
		.gallery{
			list-style-type:none;
				}
		/* .gallery li ,.gallery li img{float:left;} float:left;padding:0 10px 10px 0;.container{width:505px;margin:0 auto;}*/
		.gallery li{
			.gallery li:nth-child(6n){padding-right:0;}
			 float:right;
		}
		.list{
			height:550px;
			/*overflow:hidden;*/
		}
	 </style>
</head>
<body>
	<!--12 8  -->
	<div class="fixed-bar" id="go_head">
		<div class="wide-bar">
			<div class="consult-box">
				<div class="consult-header clearfix" id="greenline" style="display:none;width:100px;">
				</div>
			</div>
			<a href="javascript:scrollTo(0,0)" class="gotop" title="回到顶部" style="display:none;width:98px;"><i class="icon">返回顶部</i><span>返回顶部</span></a>
		</div>
	</div>
	<!-- 12 8 -->
	<!-- <div class="row">-->
		<!--  
		<div class="span2" id="span22">
	  		<div style="with:100px;height:200px;"></div>
	    </div>
	    -->
	   	<div class="pre_location">
		   <div class="pre_loc" >
			 <ul class="breadcrumb">
			    <cms:frontCurrentPosition category="${category}"/>
			 </ul>
		   </div>
	   	</div>
	  	<!-- CSS start 图片预览 huangmj 2015 11  11-->
	  
	  	<!-- CSS End 图片预览 huangmj 2015 11<div style=""></div>  11-->
	  	<div class="pre_center">
	        <div class="pre_title">
				<h2>${article.title}</h2>
				<c:if test="${flaglabel==1}">
					<div class="shared" style="margin-top:16px;margin-bottom:20px;padding-left: 13px;position: relative;">
					<img src="<%=request.getContextPath()%>/resources/img/label.png">
					    <div class="bdsharebuttonbox"style="border-bottom:solid 2px #cccccc;  padding-bottom: 4px;position: relative; top: -26px;left: 23px;">
					        <span style="font-size: 14px;color:#000;">标签：</span>
								<c:forEach items="${label}" var="list">
									<span style="font-size:14px;color:#999">[${list}]&nbsp;</span>
								</c:forEach>
								<!--  
								<span style="font-size:14px;color:#999">[植物技术]&nbsp;</span>
								<span style="font-size:14px;color:#999">[测试13]&nbsp;</span>
								<span style="font-size:14px;color:#999">[抗旱]&nbsp;</span>
								<span style="font-size:14px;color:#999">[作物杂交]&nbsp;</span>
								<span style="font-size:14px;color:#999">[合并12]&nbsp;</span>
								<span style="font-size:14px;color:#999">[合并45]&nbsp;</span>
								<span style="font-size:14px;color:#999">[IT技术]&nbsp;</span>
								<span style="font-size:14px;color:#999">[植物技术]&nbsp;</span>
								<span style="font-size:14px;color:#999">[测试13]&nbsp;</span>
								<span style="font-size:14px;color:#999">[抗旱]&nbsp;</span>
								<span style="font-size:14px;color:#999">[作物杂交]&nbsp;</span>
								<span style="font-size:14px;color:#999">[合并12]&nbsp;</span>
								<span style="font-size:14px;color:#999">[合并45]&nbsp;</span>
								<span style="font-size:14px;color:#999">[IT技术]&nbsp;</span>
								-->
							</div>
						</div>	
				</c:if>	
			</div>
			<script type="text/javascript" src="<%=request.getContextPath()%>/resources/ueditor1_4_3-utf8-jsp/ueditor.parse.js"></script>
			<div id="content11">
					${article.articleData.content}
			</div>
		<!--  
			<h3 style="color:#555555;font-size:20px;text-align:center;border-bottom:1px solid #ddd;padding-bottom:15px;margin:25px 0;"></h3>
		-->
		
			<script type="text/javascript">
						$(document).ready(function() {
							var c = $("#content11").val();
							
							var strJSON = "{name:c}";//得到的JSON
							var obj = eval( "(" + strJSON + ")" );//转换后的JSON对象
							uParse('#content11',obj.name);
						});
			</script>
			<!-- 附件列表 huangmj 2015.10.22 start -->
			
			<div class="pre_vedio">
				<div class="ppp" style="border-top:2px dotted #ccc;padding-top:25px;margin:25px 0;"> 
					<ul>
					<p id="attfiletitle">附件：</p>
					<ul class="gallery" style="width:1px;height:1px;" >
 						<li><a href="http://hftest1.oss-cn-beijing.aliyuncs.com/a28f05e547dc29d66149e9ade01fdf06.1449193699822.Desert.jpg"></a></li>
 					</ul>
					<div style="width:10px;height:40px;" ></div>
					<c:if test="${article.attfilenumber==0}">
						<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本知识文章无附件</p>
					</c:if>
						<c:forEach items="${listArticleAttFile}" var="listAttFile">	
							<div class="file_line">
					     		<span class="file_title" title="${listAttFile.attfilename}" >
					     			${fns:abbr(listAttFile.attfilename,30)}
					     			<span style=" font-size: 10px;">
					     				(<fmt:formatNumber type="number" value="${listAttFile.attfilesize/1024/1024}" maxFractionDigits="2"/>MB)
					     			</span>
					     		</span>
								<c:choose>
									<c:when test="${listAttFile.attfiletype=='MP4'||listAttFile.attfiletype=='mp4'
											||listAttFile.attfiletype=='FLV'||listAttFile.attfiletype=='flv'
											||listAttFile.attfiletype=='AVI'||listAttFile.attfiletype=='avi'
											}">
										<c:if test="${listAttFile.attfiletype=='MP4'||listAttFile.attfiletype=='mp4'
												 ||listAttFile.attfiletype=='AVI'||listAttFile.attfiletype=='avi'
												 }">	
											<a class="file_play" href="${ctx_f}/viewf?id=${listAttFile.id}" target="_blank" name="ff_22"  title="在线播放" style="color:#1489c9;" temp4="#" mpp4="${listAttFile.attfiletype}">在线播放</a>
										</c:if>
										<c:if test="${listAttFile.attfiletype=='FLV'||listAttFile.attfiletype=='flv'}">	
											<a class="file_play" href="${ctx_f}/viewf?id=${listAttFile.id}" target="_blank" name="ff_22"  title="在线播放" style="color:#1489c9;" temp4="#" mpp4="${listAttFile.attfiletype}">在线播放</a>
										</c:if>
										<c:if test="${article.articleData.isallowdownload==1}">
											<shiro:hasPermission name="sys:article:upload">
												<a class="file_download" title="点击下载" style="color:#1489c9;" href="${ctx1}a/cms/article/downloadattfile?id=${listAttFile.id}">下载&nbsp;&nbsp;&nbsp;</a>
											</shiro:hasPermission>
										</c:if>
									</c:when>
									<c:when test="${listAttFile.attfiletype=='JPEG'||listAttFile.attfiletype=='jpeg'
												||listAttFile.attfiletype=='JPG'||listAttFile.attfiletype=='jpg'
												||listAttFile.attfiletype=='PNG'||listAttFile.attfiletype=='png'
												||listAttFile.attfiletype=='GIF'||listAttFile.attfiletype=='gif'
												}">
												<span class="gallery">
													<li class="picshow">
														<a class="file_play" style="color:#1489c9;" href="${oss_base_path}${listAttFile.attfilekey}">查看图片</a>
													</li>	
													<c:if test="${article.articleData.isallowdownload==1}">	
														<shiro:hasPermission name="sys:article:upload">
														<a class="file_download" title="下载" style="color:#1489c9;" href="${ctx1}a/cms/article/downloadattfile?id=${listAttFile.id}">下载&nbsp;&nbsp;&nbsp;</a>
														</shiro:hasPermission>
													</c:if>	
												</span>
									</c:when>
									<c:when test="${listAttFile.attfiletype=='TXT'||listAttFile.attfiletype=='txt'
												||listAttFile.attfiletype=='PPTX'||listAttFile.attfiletype=='pptx'
												||listAttFile.attfiletype=='PPT'||listAttFile.attfiletype=='ppt'
												||listAttFile.attfiletype=='DOCX'||listAttFile.attfiletype=='docx'
												||listAttFile.attfiletype=='DOC'||listAttFile.attfiletype=='doc'
												||listAttFile.attfiletype=='PDF'||listAttFile.attfiletype=='pdf'
												||listAttFile.attfiletype=='XLS'||listAttFile.attfiletype=='xls'
												}">
										<!--  ${ctx_a}/cms/article/viewfile?id=${listAttFile.id}
										<a class="file_play" href="#" title="在线预览" style="color:#1489c9;" off44="http://localhost:8088/KMS_bak/userfiles/1/images/cms/article/2015/09/长文档6.doc.pdf" officetype="${listAttFile.attfiletype}">在线预览</a>
										-->
										<a class="file_playy" href="${ctx_f}/viewf?id=${listAttFile.id}" target="_blank"  name="ff_22" title="在线预览" style="color:#1489c9;" off44="#" officetype="${listAttFile.attfiletype}">在线预览</a>
										<c:if test="${listAttFile.attfiletype=='PDF'||listAttFile.attfiletype=='pdf'}">
											<a class="file_playy" href="${ctx_f}/viewf?id=${listAttFile.id}" target="_blank" name="ff_22" title="在线预览" style="color:#1489c9;" off44="#" officetype="${listAttFile.attfiletype}">在线预览</a>
										</c:if>
										<c:if test="${article.articleData.isallowdownload==1}">
											<shiro:hasPermission name="sys:article:upload">
											<a class="file_download" title="点击下载" style="color:#1489c9;" href="${ctx1}a/cms/article/downloadattfile?id=${listAttFile.id}">下载&nbsp;&nbsp;&nbsp;</a>
											</shiro:hasPermission>
										</c:if>
									</c:when>
									<c:otherwise>
									<c:if test="${article.articleData.isallowdownload==1}">
										<shiro:hasPermission name="sys:article:upload">
										<a class="file_download" title="点击下载" style="color:#1489c9;" href="${ctx1}a/cms/article/downloadattfile?id=${listAttFile.id}">下载&nbsp;&nbsp;&nbsp;</a>
										</shiro:hasPermission>
									</c:if>
									</c:otherwise>
								</c:choose>
							</div>
						</c:forEach>
					</ul>
				</div>	
			</div>
			<script src="<%=request.getContextPath()%>/resources/js/zoom.min.js"></script>
			<!-- Begin VideoJS -->
				<!-- Chang URLs to wherever Video.js files will be hosted -->
				<!-- Default URLs assume the examples folder is included alongside video.js -->
				<link href="<%=request.getContextPath()%>/resources/js/video-js.css" rel="stylesheet" type="text/css">
				<!-- Include ES5 shim, sham and html5 shiv for ie8 support  -->
				<!-- Exclude this if you don't need ie8 support -->
				<script src="<%=request.getContextPath()%>/resources/js/videojs-ie8.min.js"></script>
				<!-- video.js must be in the <head> for older IEs to work. -->
				<script src="<%=request.getContextPath()%>/resources/js/video.js"></script>
				<!-- 皮肤 -->
				<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/js/video-js.css" type="text/css" media="screen" title="Video JS">
			<!-- End加载 VideoJS js -->
			
			<script type="text/javascript">
		       		$(".file_line").mouseover(function(){
						$(this).css("background","rgb(238, 238, 238)");
					}).mouseout(function(){
						$(this).css("background","none");
					});
			</script> 		
			
		  	<!-- author：zhengyu添加推荐按钮，收藏按钮，推荐数，收藏数-->
			<!-- author：zhengyu添加推荐按钮，收藏按钮，推荐数，收藏数-->
					<div class="pr_detail">
						<div class="line"></div>
						<dl>
				    		<dt>发布者：</dt><dd title="${articelUser.company.name}/${articelUser.office.name}">
				    		${article.user.name}</dd>
				    		<dt>点击数：</dt><dd>${article.hits}</dd>
				    		<dt>推荐数：</dt><dd>${articleCount.countreco}</dd>
				    		<dt>收藏数：</dt><dd>${articleCount.countcollect}</dd>
				    		<dt>发布时间：</dt><dd><fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></dd>
							<dt>更新时间：</dt><dd><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></dd>
						</dl>
				        <div class="pre_save">
				        	<div class="save">
				        	<!--
				        		<span class="tj" favoriteflag='1'>推荐</span>
        						<span class="sc" favoriteflag='1'>收藏</span>
				        	-->
				        	<div class="recommend">
					        			<c:if test="${recommend.delFlag=='1'}" ><span class="untj" favoriteflag='0' value='推荐'>推荐</span></c:if>
					        			<c:if test="${recommend.delFlag=='2'}" ><span class="tj" favoriteflag='1' value='推荐'>推荐</span></c:if>
					        </div>
					        <div class="collect">			
					        			<c:if test="${store.delFlag=='1'}" ><span class="unsc" favoriteflag='0' value='收藏'>收藏</span></c:if>
					        			<c:if test="${store.delFlag=='2' }" ><span class="sc" favoriteflag='1' value='收藏'>收藏</span></c:if>
				        	</div>	 	
									<%--<c:if test="${store.delFlag=='2'}"><span class="sc" favoriteflag='0'>取消收藏</span></c:if>--%>
				        	</div>
				        	<c:if test="${article.articleData.allowshare==1}">
				            	<div class="share">
				            		<span>分享到：</span>
				            		<div class="bdsharebuttonbox">
												<a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
												<a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
												<a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a>
												<a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a>
												<a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
												<a href="#" class="bds_sqq" data-cmd="sqq" title="分享到QQ好友"></a>
												<a href="#" class="bds_bdhome" data-cmd="bdhome" title="分享到百度新首页"></a>
												<a href="#" class="bds_ibaidu" data-cmd="ibaidu" title="分享到百度中心"></a>
												<a href="#" class="bds_bdysc" data-cmd="bdysc" title="分享到百度云收藏"></a>
												<a href="#" class="bds_kaixin001" data-cmd="kaixin001" title="分享到开心网"></a>
												<a href="#" class="bds_douban" data-cmd="douban" title="分享到豆瓣网"></a>
												<a href="#" class="bds_youdao" data-cmd="youdao" title="分享到有道云笔记"></a>
										</div>
									<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"24"},"share":{},"image":{"viewList":["qzone","tsina","tqq","renren","weixin","sqq","bdhome","ibaidu","bdysc","kaixin001","douban","youdao"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin","sqq","bdhome","ibaidu","bdysc","kaixin001","douban","youdao"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
								</div>
							</c:if>
				 	</div>	
  	     		</div>
  	     		<div id="comment" >
						
				</div>
		 </div>
		 
		<footer class="color-F00"> 
				CopyRight© 2014-2015知识库管理 Powered By yonyou V1.0.0
		</footer>
   		
	<script>
		window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"1","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"24"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
	</script>
</body>
</html>
</c:when>
<c:otherwise>
<%@page import="com.yonyou.kms.common.web.Servlets"%>
<%@page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<title>404 - 页面不存在</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<h1>本知识不支持分享!</h1>

	<div class="container-fluid">
		<div class="page-header"><h1>页面不存在.</h1></div>
		<div>
		<!--  
		<a href="javascript:" onclick="history.go(-1);" class="btn">返回知识库主页</a>
		-->
		<a href="${ctx_f}" onclick="history.go(-1);" class="btn">返回知识库主页</a>
		</div>
		<script>try{$.jBox.closeTip();}catch(e){}</script>
	</div>
</body>
</html>
</c:otherwise>
</c:choose>