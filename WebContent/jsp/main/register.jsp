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
  <link rel="stylesheet" href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.css">
  <link rel="stylesheet" href="<%=basePath%>css/kyzr_register.css" />
  <script src="<%=basePath%>js/jquery-3.6.0.js"></script>
<title>注册</title>
</head>
   <body>
		<script type="text/javascript">
			var accountStatus,passwordStatus,nameStatus,sexStatus,emailStatus,phoneStatus = 0;
			function checkRegister(){
				//ajax验证用户注册信息
				if(accountStatus,passwordStatus,nameStatus,sexStatus,emailStatus,phoneStatus == 1){
					$.ajax({
						url:"${pageContext.request.contextPath}/user/checkRegister",
						type: "POST",
						data:$("#registerForm").serialize(),
						contentType:"application/x-www-form-urlencoded; charset=UTF-8",
						success:function(){
							alert("注册成功,请返回登录页面登录！");
						},
						error:function(){
							alert("注册失败，请检查是否存在已有的账号！");
						}
					});
				}
				else{
					alert("注册失败，请检查用户信息！");
				}
			}
			//account验证
			function checkAccount(){
				var account = document.getElementById("account").value;
				if(account.search(/^\d{5,}$/) != -1){
					accountStatus = 1;
					$("#accountInfo").html("");
				}
				else{
					accountStatus = 0;
					var msg = "请输入5位以上由数字组成的账号~";
					$("#accountInfo").html(msg);
				}
			}
			//password验证
			function checkPassword(){
				var password = document.getElementById("password").value;
				if(password.search(/^[a-zA-Z]\w{5,17}$/) != -1){
					passwordStatus = 1;
					$("#passwordInfo").html("");
				}
				else{
					passwordStatus = 0;
					var msg = "请输入以字母开头，长度在6-18之间，只能包含字符、数字和下划线的密码~";
					$("#passwordInfo").html(msg);
				}
			}
			//name验证
			function checkName(){
				var name = document.getElementById("name").value;
				if(name.search(/^[\u4e00-\u9fa5]{2,4}$/) != -1){
					nameStatus = 1;
					$("#nameInfo").html("");
				}
				else{
					nameStatus = 0;
					var msg = "请输入2-4位汉字组成的姓名~";
					$("#nameInfo").html(msg);
				}
			}
			//sex验证
			function checkSex(){
				//不选是0，选了是1
				sexStatus = 1;
			}
			//email验证
			function checkEmail(){
				var email = document.getElementById("email").value;
				if(email.search(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/) != -1){
					emailStatus = 1;
					$("#emailInfo").html("");
				}
				else{
					emailStatus = 0;
					var msg = "请输入正确的邮箱哦~";
					$("#emailInfo").html(msg);
				}
			}
			//phone验证
			function checkPhone(){
				var phone = document.getElementById("phone").value;
				if(phone.search(/^(\+86)?1\d{10}$/) != -1){
					phoneStatus = 1;
					$("#phoneInfo").html("");
				}
				else{
					phoneStatus = 0;
					var msg = "请输入正确的手机号哦~";
					$("#phoneInfo").html(msg);
				}
			}
		</script>
	  <div class="frosted-glass">
	   	<a href=""><h1 class="title">注册</h1></a>
	  </div>
	  
	  <div class="kyzr_centerRight">
	  	<img id="kyzr_picture" src="http://nickyzj.run:12450/lychee/uploads/big/0bf71313b9a71ed136c7bbbf9e4d9af0.jpg" />
	  	
	  </div>
	  
	  <div class="kyzr_centerLeft">
	  	<form action="" id="registerForm">
	  		<label for="account">账号</label>
	  		<div id="accountInfo" style="color:Red;"></div>
	  		<input type="text" id="account" name="account" class="form-control" placeholder="account" onblur="checkAccount()"/><br/>
	  		<label for="password">密码</label>
	  		<div id="passwordInfo" style="color:Red;"></div>
	  		<input type="password" id="password" name="password" class="form-control" placeholder="password" onblur="checkPassword()" /><br/>
	  		<label for="name">真实姓名</label>
	  		<div id="nameInfo" style="color:Red;"></div>
	  		<input type="text" id="name" name="name" class="form-control" placeholder="name" onblur="checkName()"/><br/>
	  		<label for="sex">性别</label><br/>
	  		<div id="sexInfo" style="color:Red;"></div>
	  		<div id="sexInfo" style="color:Red;"></div>
	  		<input type="radio" id="sex1" name="sex"  value="男" onclick="checkSex()"/><a>男</a>
	  		<input type="radio" id="sex2" name="sex"  value="女" onclick="checkSex()"/><a>女</a>
	  		<br/><br/>
	  		<label for="email">Email</label>
	  		<div id="emailInfo" style="color:Red;"></div>
	  		<input type="email" id="email" name="email" class="form-control" placeholder="email" onblur="checkEmail()"/><br/ >
	  		<label for="phone">联系方式</label>
	  		<div id="phoneInfo" style="color:Red;"></div>
	  		<input type="text" id="phone" name="phone" class="form-control" placeholder="phone" onblur="checkPhone()"/><br/>
	  		<nav>
	  			已有账号，点击<a href="login.jsp">登录</a>
	  		</nav>
	  		<button type="button" class="btn btn-default kyzr_loginButton" onclick="checkRegister()">注册</button>
	  		
	  	</form>
	  </div>
	  
	  <div class="kyzr_bottom">
	  	<a class="kyzr_bottomWord">@2021 By <a class="kyzr_blog" target="_blank" href="http://kyzr2000.gitee.io/myblog/">King_FLYz</a></a>
	  </div>
	  
	  
	</body>
</html>