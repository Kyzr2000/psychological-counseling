<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<title>心理测评</title>
<script src="<%=basePath%>js/jquery-3.6.0.js"></script>
<!-- bootstrap框架 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- kyzr.css 全局css文件，目前只定义了首页的颜色 -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr.css" />
<!-- kyzr_xlcp.jsp的css，定义了白色区域的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_xlcp.css" />
<!-- kyzr_bottom.css是底部bottom.jsp的css文件 -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_bottom.css" />
<!-- kyzr_nav.css是头部黑色长导航栏tools/nav.jsp的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_nav.css" />
<!-- navXlcp.css 用来显示蓝色下划线的 -->
<link rel="stylesheet" href="<%=basePath%>css/underline/navXlcp.css" />
</head>
<body>
	<jsp:include page="../../tools/nav.jsp" />
	<script type="text/javascript">
		function getTest(obj){
			var id = $(obj).attr("title-id");
			$.ajax({
				url:"${pageContext.request.contextPath}/psyTest/getTest/"+id,
				data:{'id':id}
			});
		}
	</script>
	<!-- 整体区域 ，高度1800px -->
	<div class="kyzr_psyPageContent">
		<!-- 大白色区域 ，高度1500px -->
		<div class="kyzr_psyContent">
			<!-- 标题 -->
			<div class="kyzr_psyContentTitle">
				<div class="kyzr_word">请选择心理测评类型</div>
			</div>
			<!-- 四个类型的容器 -->
			<div class="kyzr_psyContainer">
				<div class="kyzr_psyKind">
					<img src="http://nickyzj.run:12450/lychee/uploads/big/72ca96974e3bcd82fef4ba19ffcc96f1.jpeg" class="kyzr_psyIMG" />
					<div class="kyzr_psyKindTitle">
						<a href="<%=basePath%>jsp/user/psyTest.jsp" title-id="1" onclick="getTest(this)">焦虑程度测试</a>
					</div>
				</div>
				<div class="kyzr_psyKind">
					<img src="http://nickyzj.run:12450/lychee/uploads/big/d2b7b41b686df8d27fe97e8b1ec13e58.jpg" class="kyzr_psyIMG" />
					<div class="kyzr_psyKindTitle">
						<a href="<%=basePath%>jsp/user/psyTest.jsp" title-id="2" onclick="getTest(this)">亲密关系恐惧测试</a>
					</div>
				</div>
				<div class="kyzr_psyKind">
					<img src="http://nickyzj.run:12450/lychee/uploads/big/3aca6e4aead1e071f6b38507fc8e1547.jpg" class="kyzr_psyIMG" />
					<div class="kyzr_psyKindTitle">
						<a href="<%=basePath%>jsp/user/psyTest.jsp" title-id="3" onclick="getTest(this)">测测你是杠精吗</a>
					</div>
				</div>
				<div class="kyzr_psyKind">
					<img src="http://nickyzj.run:12450/lychee/uploads/big/75ffb6c64c17463e26d1651e61a9d51f.jpeg" class="kyzr_psyIMG" />
					<div class="kyzr_psyKindTitle">
						<a href="<%=basePath%>jsp/user/psyTest.jsp" title-id="4" onclick="getTest(this)">测测你的油腻程度</a>
					</div>
				</div>
			</div>
		</div>
	
	</div>
	<jsp:include page="../../tools/bottom.jsp" />
</body>
</body>
</html>