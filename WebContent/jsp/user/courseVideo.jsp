<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${myCourse.title}</title>
<script src="<%=basePath%>js/jquery-3.6.0.js"></script>
<!-- bootstrap框架 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- kyzr.css 全局css文件，目前只定义了首页的颜色 -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr.css" />
<!-- kyzr_bottom.css是底部bottom.jsp的css文件 -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_bottom.css" />
<!-- kyzr_nav.css是头部黑色长导航栏tools/nav.jsp的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_nav.css" />
<!-- navKc.css 用来显示蓝色下划线的 -->
<link rel="stylesheet" href="<%=basePath%>css/underline/navKc.css" />
<!-- kyzr_kc.jsp的css，定义了白色区域的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_kc.css" />
</head>
<body>

	<jsp:include page="../../tools/nav.jsp" />
	<div class="kyzr_videoContainer">
		<!-- 白色背景 1200px高度 -->
		<div class="kyzr_videoContent">
			<div class="kyzr_video">			
				<iframe src="${myCourse.courseURL}" width="1000px" height="600px" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"> </iframe>
			</div>
		</div>
	</div>
	<jsp:include page="../../tools/bottom.jsp" />
</body>
</html>