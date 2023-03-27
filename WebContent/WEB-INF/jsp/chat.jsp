<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta charset="UTF-8">
<script src="<%=basePath%>js/jquery-3.6.0.js"></script>
<!-- bootstrap框架 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- kyzr.css 全局css文件，目前只定义了首页的颜色 -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr.css" />
<!-- kyzr_bottom.css是底部bottom.jsp的css文件 -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_bottom.css" />
<!-- kyzr_nav.css是头部黑色长导航栏tools/nav.jsp的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_nav.css" />
<!-- navGyjd.css 用来显示蓝色下划线的 -->
<link rel="stylesheet" href="<%=basePath%>css/underline/navZx.css" />
<!-- kyzr_gyjd.jsp的css，定义了白色区域的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_zx.css" />
<title>咨询</title>
</head>
<body>
	<jsp:include page="../../tools/nav.jsp" />
	<script type="text/javascript">
		var myName = "${myName}";
		var myUser = "${myUser}";
		var myStatus = "${myUser.status}";
		var id = "${myUser.id}";
		//页面一加载就执行的函数
		window.onload=function(){
			//alert(myName);
			if(myName!="" && myUser!=""){
				//上方
				$("#navLogin").css("display","none");
				$("#navRegister").css("display","none");
				$("#navLogout").css("display","block");
				$("#myname").css("display","block");
			}
			chat();
		}
		//1.首先要判断当前登录的是用户还是心理咨询师
		//2.通过用户id/心理咨询师id在orders表内查status的单条数据
		function chat(){
			if(myStatus == 0){
				$.ajax({
					url:"${pageContext.request.contextPath}/chat/getHIDByCID",
					type: "POST",
					data:{'id':id},
					success:function(data){
						/*
						var html = "<iframe id=\"mychat\" src=\"http://localhost:5000?house_id="+
						data+
						"&user_id="+
						myName+
						"\" width=\"80%\" height=\"500px\"></iframe>";
						$(".kyzr_zxContent").html(html);
						*/
						var html =	"<div class=\"house\">"+
										"<div class=\"house_img\">"+
											"<img src=\"http://nickyzj.run:12450/lychee/uploads/big/c8763be7a80d5e8fd2cbfb7f5396e8a6.jpeg\" class=\"houseImg\"/>"+
										"</div>"+
										"<div class=\"house_id\">"+
											"<a house-id=\""+"客服"+id+"\" href=\"javascript:void(0)\" style=\"color:black;\" onclick=\"joinHouse(this)\">"+"客服"+id+"</a>"+
										"</div>"+
									"</div>";
									
						html += "<div class=\"house\">"+
									"<div class=\"house_img\">"+
										"<img src=\"http://nickyzj.run:12450/lychee/uploads/big/c8763be7a80d5e8fd2cbfb7f5396e8a6.jpeg\" class=\"houseImg\"/>"+
									"</div>"+
									"<div class=\"house_id\">"+
										"<a house-id=\""+data+"\" href=\"javascript:void(0)\" style=\"color:black;\" onclick=\"joinHouse(this)\">"+data+"</a>"+
									"</div>"+
								"</div>";
								
						$(".manyHouse").html(html);
					},
					error:function(){
						var html =	"<div class=\"house\">"+
										"<div class=\"house_img\">"+
											"<img src=\"http://nickyzj.run:12450/lychee/uploads/big/c8763be7a80d5e8fd2cbfb7f5396e8a6.jpeg\" class=\"houseImg\"/>"+
										"</div>"+
										"<div class=\"house_id\">"+
											"<a house-id=\""+"客服"+id+"\" href=\"javascript:void(0)\" style=\"color:black;\" onclick=\"joinHouse(this)\">"+"客服"+id+"</a>"+
										"</div>"+
									"</div>";
						$(".manyHouse").html(html);
					}
				});
			}
			else if(myStatus==2){
				$.ajax({
					url:"${pageContext.request.contextPath}/user/number",
					type: "POST",
					success:function(data){
						var html = "";
						for(var i=0;i<data;i++){
							html += "<div class=\"house\">"+
										"<div class=\"house_img\">"+
											"<img src=\"http://nickyzj.run:12450/lychee/uploads/big/c8763be7a80d5e8fd2cbfb7f5396e8a6.jpeg\" class=\"houseImg\"/>"+
										"</div>"+
										"<div class=\"house_id\">"+
											"<a house-id=\""+"客服"+(i+1)+"\" href=\"javascript:void(0)\" style=\"color:black;\" onclick=\"joinHouse(this)\">"+"客服"+(i+1)+"</a>"+
										"</div>"+
									"</div>";
						}
						$(".manyHouse").html(html);
					}
				})
			}
			else{
				$.ajax({
					url:"${pageContext.request.contextPath}/chat/getHIDByEID",
					type: "POST",
					data:{'id':id},
					success:function(data){
						/*
						var html = "<iframe id=\"mychat\" src=\"http://localhost:5000?house_id="+
								data+
								"&user_id="+
								myName+
								"\" width=\"80%\" height=\"500px\"></iframe>";
						$(".kyzr_zxContent").html(html);
						*/
						var html =	"<div class=\"house\">"+
										"<div class=\"house_img\">"+
											"<img src=\"http://nickyzj.run:12450/lychee/uploads/big/c8763be7a80d5e8fd2cbfb7f5396e8a6.jpeg\" class=\"houseImg\"/>"+
										"</div>"+
										"<div class=\"house_id\">"+
											"<a house-id=\""+"客服"+id+"\" href=\"javascript:void(0)\" style=\"color:black;\" onclick=\"joinHouse(this)\">"+"客服"+id+"</a>"+
										"</div>"+
									"</div>";
						for(var i=0;i<data.length;i++){
							html += "<div class=\"house\">"+
										"<div class=\"house_img\">"+
											"<img src=\"http://nickyzj.run:12450/lychee/uploads/big/c8763be7a80d5e8fd2cbfb7f5396e8a6.jpeg\" class=\"houseImg\"/>"+
										"</div>"+
										"<div class=\"house_id\">"+
											"<a house-id=\""+data[i]+"\" href=\"javascript:void(0)\" style=\"color:black;\" onclick=\"joinHouse(this)\">"+data[i]+"</a>"+
										"</div>"+
									"</div>";
						}
						$(".manyHouse").html(html);
					},
					error:function(){
						var html =	"<div class=\"house\">"+
										"<div class=\"house_img\">"+
											"<img src=\"http://nickyzj.run:12450/lychee/uploads/big/c8763be7a80d5e8fd2cbfb7f5396e8a6.jpeg\" class=\"houseImg\"/>"+
										"</div>"+
										"<div class=\"house_id\">"+
											"<a house-id=\""+"客服"+id+"\" href=\"javascript:void(0)\" style=\"color:black;\" onclick=\"joinHouse(this)\">"+"客服"+id+"</a>"+
										"</div>"+
									"</div>";
						$(".manyHouse").html(html);
					}
				});
			}
		}
		function joinHouse(obj){
			var id = $(obj).attr("house-id");
			var html = "<iframe id=\"mychat\" src=\"http://localhost:5000?house_id="+
						id+
						"&user_id="+
						myName+
						"\" width=\"80%\" height=\"500px\"></iframe>";
			$(".kyzr_zxContent").html(html);
		}
	</script>
	<!-- 大白色区域 -->
	<div class="kyzr_zxContainer">
		<div class="kyzr_zxContent">
			<!-- 选择房间区域 -->
			<div class="houseChange">
				<div class="houseChange_info">请选择进入的房间号</div>
				<!-- 往manyHouse里插数据 -->
				<div class="manyHouse">
					
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../../tools/bottom.jsp" />
</body>
</html>