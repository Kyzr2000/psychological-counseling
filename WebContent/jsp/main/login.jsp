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
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
  <link rel="stylesheet" href="<%=basePath%>css/kyzr_login.css" />
  <title>登录</title>
</head>
	<body>
	<script type="text/javascript">
		function loginPurse(){
			//这个地方添加一个加载钱包是因为：如果在用户主页内加载钱包状态（设置session的话），第一次加载不出来，需要刷新页面
			//使用ajax拿用户钱包，先设置一次myPurseStatus的session值
			$.post("${pageContext.request.contextPath}/user/money",function (data){
			})
		}
	</script>
	
	  <div class="frosted-glass">
	   	<a href="<%=basePath%>/index.jsp"><h1 class="title">心理咨询系统</h1></a>
	  </div>
	  
	  <div class="kyzr_centerLeft">
	  	<img id="kyzr_picture" src="http://nickyzj.run:12450/lychee/uploads/big/0bf71313b9a71ed136c7bbbf9e4d9af0.jpg" />
	  	
	  </div>
	  
	  <div class="kyzr_centerRight">
	  	<form action="<%=basePath%>user/login" method="post">
	  		<div style="color:red;text-align:center;">${loginInfo}</div>
	  		<label for="account">账号</label>
	  		<input type="text" name="account" class="form-control" placeholder="account" /><br/>
	  		<label for="password">密码</label>
	  		<input type="password" name="password" class="form-control" placeholder="password" /><br/>
	  		<nav class="kyzr_forgetRegister">
	  			<a style="color:white;" href="register.jsp">注册</a>&nbsp;
	  			<a style="color:white;" href="">忘记密码?</a>
	  		</nav>
	  		<button type="submit" onclick="loginPurse()" class="btn btn-default kyzr_loginButton">登录</button>
	  		
	  	</form>
	  </div>
	  
	  <div class="kyzr_bottom">
	  	<a class="kyzr_bottomWord">@2021 By <a class="kyzr_blog" target="_blank" href="http://kyzr2000.gitee.io/myblog/">King_FLYz</a></a>
	  </div>
	  
	</body>
</html>