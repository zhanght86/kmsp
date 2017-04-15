<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
	<%
				String path = request.getContextPath();
				//String basePath_f = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/f";
				//String basePath_a = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/a";
			%>
			<c:set var="ctx" value="<%=path%>"/>
			
<html>
<head>
	<meta charset="utf-8">
	<title>${articleAttFile.attfilename}</title>
</head>
<body>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery1.8.2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/pdfobject.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/flowplayer-3.2.6.min.js"></script>
<script type="text/javascript"> 
		flowplayer("player", "http://www.helloweba.com/demo/flowplayer/flowplayer-3.2.7.swf"); 
</script>
<c:if test="${articleAttFile.attfiletype=='TXT'||articleAttFile.attfiletype=='txt'
			  	||articleAttFile.attfiletype=='PPTX'||articleAttFile.attfiletype=='pptx'
			  	||articleAttFile.attfiletype=='PPT'||articleAttFile.attfiletype=='ppt'
				||articleAttFile.attfiletype=='DOCX'||articleAttFile.attfiletype=='docx'
				||articleAttFile.attfiletype=='DOC'||articleAttFile.attfiletype=='doc'
				||articleAttFile.attfiletype=='XLS'||articleAttFile.attfiletype=='xls'
				}">
				<a id="key" playoff="${articleAttFile.attfiletype}" ></a>
</c:if>

<c:if test="${articleAttFile.attfiletype=='PDF'||articleAttFile.attfiletype=='pdf'}">
	<a id="key" playoff="${articleAttFile.attfiletype}"></a>
</c:if>
<c:if test="${articleAttFile.attfiletype=='MP4'||articleAttFile.attfiletype=='mp4'
			  ||articleAttFile.attfiletype=='AVI'||articleAttFile.attfiletype=='avi'
			  }">
			  <a id="key" playvide="${articleAttFile.attfiletype}"></a>
			  </c:if>
<c:if test="${articleAttFile.attfiletype=='FLV'||articleAttFile.attfiletype=='flv'}">	
			  <a id="key" playvide="${articleAttFile.attfiletype}"  ></a>
			</c:if>			  

<script type="text/javascript">
      	window.onload = function (){
      		var off = $("#key").attr("playoff");
      		var vide = $("#key").attr("playvide");
      		var fileurl;
      		if(off!=null){
      			 //alert(off);
      			 //$("#key").attr("href")cms/article/downloadattfile
      			 fileurl = "${articleAttFile.attfilekey}";
       	 		var myPDF = new PDFObject({ url:fileurl}).embed();
       	 	}
       	 	if(vide!=null){
       	 		//alert(vide);
       	 		//$("#key").attr("href")
       	 		//fileurl = "${ctx}/viewff?id=${articleAttFile.id}";
       	 		fileurl = "${articleAttFile.attfilekey}";
       	 		flowplayer( 
			    			"player2",  
			    			"http://www.helloweba.com/demo/flowplayer/flowplayer-3.2.7.swf",{ 
				      			clip: { 
				        			url: fileurl, 
				        			autoPlay: false,  
				        			autoBuffering: true  
				      			} 
			    			} 
						); 
       	 	}
       	 	
      };
</script>
<a id="player2" style="width:998px; height:640px"></a>
</body>
</html>