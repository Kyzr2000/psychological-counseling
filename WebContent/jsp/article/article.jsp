<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta charset="UTF-8">
<!-- bootstrap框架 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- kyzr.css 全局css文件，目前只定义了首页的颜色 -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr.css" />
<!-- homePageContent.css是jsp/user/homePageContent.jsp的css，定义了首页三大块白色区域的css -->
<link rel="stylesheet" href="<%=basePath%>css/homePageContent.css" />
<!-- kyzr_bottom.css是底部bottom.jsp的css文件 -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_bottom.css" />
<!-- kyzr_nav.css是头部黑色长导航栏tools/nav.jsp的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_nav.css" />
<script src="<%=basePath%>js/jquery-3.6.0.js"></script>
<!-- 文章内的css -->
<link rel="stylesheet" href="<%=basePath%>css/articlePageContent.css" />
<!-- nav.css 用来显示蓝色下划线的 -->
<link rel="stylesheet" href="<%=basePath%>css/underline/navSy.css" />
<title>${myPassage.title}</title>
</head>
<body>
	<jsp:include page="../../tools/nav.jsp" />
	<!-- 整体区域 ，高度1800px -->
	<div class="kyzr_articlePageContent">
		<!-- 大白色区域 ，高度1500px -->
		<div class="kyzr_articleContent">
			
			<!-- 顶部图片 -->
			<div class="kyzr_articleContent_img">
				<img class="kyzr_articleImg" src=${myPassage.img} />
			</div>
			
			<!-- 文章标题和时间 -->
			<div class="kyzr_articleContent_TitleAndTime">
				<!-- 标题 -->
				<div class="kyzr_articleTitle">${myPassage.title}</div>
				<!-- 时间 -->
				<div class="kyzr_articleTime">发布时间：${myPassage.createAt}</div>
			</div>
			
			<!-- 文章内容 -->
			<div class="kyzr_articleContent_Main">
				<div class="kyzr_articleMain">
					${myPassage.article}				
				</div>
			</div>
			
		</div>
	
	</div>
	<jsp:include page="../../tools/bottom.jsp" />
</body>
</html>