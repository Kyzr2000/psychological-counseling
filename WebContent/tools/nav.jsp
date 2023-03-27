<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
</head>
<body>
	<script type="text/javascript">
		 window.onload=function(){
			var myName = "${myName}";
			var myUser = "${myUser}";
			//alert(myName);
			if(myName!="" && myUser!=""){
				$("#navLogin").css("display","none");
				 $("#navRegister").css("display","none");
				 $("#navLogout").css("display","block");
				 $("#myname").css("display","block");
			}
		 }
	</script>
	<nav class="kyzr_header">
		<div class="navbar navbar-default" style="background-color:#333333 !important;">
			<div class="navbar-header">
				<a href="<%=basePath%>index.jsp" class="navbar-brand">心理咨询系统</a>
			</div>
			<ul class="nav navbar-nav navbar-right">
				<li><a id="myname" href="<%=basePath%>user/main" style="display:none;">${myName}</a></li>
				<li><a id="navLogout" href="<%=basePath%>user/logout" style="display:none;">退出</a></li>
				<li><a id="navLogin" href="<%=basePath%>jsp/main/login.jsp">登录</a></li>
				<li><a id="navRegister" href="<%=basePath%>jsp/main/register.jsp">注册</a></li>
				<li><a href="">联系我们</a></li>
			</ul>
		</div>
		
		<nav class="kyzr_headerMid">
			<nav class="kyzr_title">
				<ul>
					<li class="kyzr_navLi kyzr_underlineSy"><a href="<%=basePath%>index.jsp">首页</a></li>
					<li class="kyzr_navLi kyzr_underlineXlcp"><a href="<%=basePath%>psyTest/main">心理测评</a></li>
					<li class="kyzr_navLi kyzr_underlineYyzj"><a href="<%=basePath%>expert/list">预约专家</a></li>
					<li class="kyzr_navLi kyzr_underlineGyjd"><a href="<%=basePath%>answer/main">公益解答</a></li>
					<li class="kyzr_navLi kyzr_underlineZx"><a href="<%=basePath%>chat/main">咨询</a></li>
					<li class="kyzr_navLi kyzr_underlineKc"><a href="<%=basePath%>user/course">课程</a></li>
				</ul>
			</nav>
		</nav>
	</nav>
	<hr class="kyzr_topHr"/>
</body>
</html>