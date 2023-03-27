<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>心理测评报告</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>用户主页</title>
<script src="<%=basePath%>js/jquery-3.6.0.js"></script>
<script tyle="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
<!-- bootstrap框架 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- kyzr.css 全局css文件，目前只定义了首页的颜色 -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr.css" />
<!-- 本页面的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_report.css" />
</head>
<body>
	<script type="text/javascript">
		//全局变量：用户的名字
		var myName = "${myName}";
		var myUser = "${myUser}";
		//全局变量：拿到当前要生成报告的title_id
		var title_id = "${myChecksID}";
		//启动页面时判断是否登录
		 window.onload=function(){
			//alert(myName);
			if(myName!="" && myUser!=""){
				//上方
				$("#navLogin").css("display","none");
				$("#navRegister").css("display","none");
				$("#navLogout").css("display","block");
				$("#myname").css("display","block");
			}
			//标题判断
			title();
			//得分注入
			score();
			//用户名称注入
			userName();
			//建议
			suggest();
		}
		//标题判断
		function title(){
			if(title_id == 1)
				$("#kyzr_title").html("焦虑程度测试");
			if(title_id == 2)
				$("#kyzr_title").html("亲密关系恐惧测试");
			if(title_id == 3)
				$("#kyzr_title").html("测测你是杠精吗");
			if(title_id == 4)
				$("#kyzr_title").html("测测你的油腻程度");				
		}
		//获取得分
		function score(){
			$.ajax({
				url:"${pageContext.request.contextPath}/psyTest/getScore",
				type: "POST",
				data:{'title_id':title_id},
				success:function(data){
					if(data == 0){
						$("#kyzr_score").html("题目未测评  ");
					}
					else{
						$("#kyzr_score").html("得分:"+data);
					}
				}
			})
		}
		//用户名字
		function userName(){
			$("#kyzr_useName").html(myName+",您好");
		}
		//建议
		function suggest(){
			$.ajax({
				url:"${pageContext.request.contextPath}/psyTest/getSuggest",
				type: "POST",
				data:{'title_id':title_id},
				success:function(data){
					$("#kyzr_suggest").html(data);
				}
			})
		}
		
		// 截图转换格式 防止url过长
		function dataURLToBlob(dataurl) {
			let arr = dataurl.split(',');
			let mime = arr[0].match(/:(.*?);/)[1];
			let bstr = atob(arr[1]);
			let n = bstr.length;
			let u8arr = new Uint8Array(n);
			while (n--) {
				u8arr[n] = bstr.charCodeAt(n);
			}
			return new Blob([u8arr], {
				type: mime
			});
		}
		
		// 用画布把div盒子转换为截图
		function saveImage() {
			$("#kyzr_content").css("background-color","thistle");
		//	$("#kyzr_content").css("box-shadow","   ");
			let _this = this;
			html2canvas($('#kyzr_content')[0],{dpi:window.devicePixelRatio}).then(function(canvas) {
				var img = document.getElementById('img');
				var imgSrc = canvas.toDataURL('image/png',1.0);
				img.src = imgSrc;
				_this.imgURL = img.src;
				console.log(img.src);
				img.src=URL.createObjectURL(_this.dataURLToBlob(img.src));
				$('#export_btn').attr('href',img.src);
				//_this.$nextTick(()=>{
				$('#export_btn')[0].click();
				//})
				$("#kyzr_content").css("background-color","rgba(255,255,255,0.5)");
				//$("#kyzr_content").css("box-shadow"," 0 0.3px 0.7px rgba(0, 0, 0, 0.126), 0 0.9px 1.7px rgba(0, 0, 0, 0.179), 0 1.8px 3.5px rgba(0, 0, 0, 0.224), 0 3.7px 7.3px rgba(0, 0, 0, 0.277), 0 10px 20px rgba(0, 0, 0, 0.4)");
			})
			.catch(err => {
	
			})
			
		}
	</script>
	<nav class="kyzr_header">
		<div class="navbar navbar-default" style="background-color:#333333 !important;">
			<div class="navbar-header">
				<a href="<%=basePath%>index.jsp" class="navbar-brand">心理咨询系统</a>
			</div>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="<%=basePath%>user/main">${myName}</a></li>
				<li><a id="navLogout" href="<%=basePath%>user/logout" style="display:none;">退出</a></li>
				<li><a id="navLogin" href="<%=basePath%>jsp/main/login.jsp">登录</a></li>
				<li><a id="navRegister" href="<%=basePath%>jsp/main/register.jsp">注册</a></li>
				<li><a href="">联系我们</a></li>
			</ul>
		</div>
	</nav>
	
	<!-- 中部内容区域 -->
	<div class="kyzr_container">
		<!-- 大白色区域 -->
		<div id="kyzr_content">
		
			<div class="title">
				<img class="orangeToYellow" src="http://nickyzj.run:12450/lychee/uploads/big/3894fe1b2fe782fa04dd1b4d6236620c.jpg" />
				<div id="kyzr_title"></div>
			</div>
			<div class="info1">(心理测评意见仅供参考)</div>
			<div class="score">  
				<div class="scoreContent">
					<div id="kyzr_score"></div>
				</div>
			</div>
			<div id="kyzr_useName"></div>
			<div class="suggest">
				<img class="orange" src="http://nickyzj.run:12450/lychee/uploads/big/6c2d8f930c4dbf4e7774cfa70484fbf8.png" />
				<div class="info2">建议</div>
				<div id="kyzr_suggest">未检测到您提交了本道题目，请前往“首页”的“心理测评”页面，做完测评题再来生成报告~</div>
			</div>
			<!-- <div class="kyzr_madeby">Made by King_FLYz</div> -->
		</div>
	</div>
	
	<!-- 下载报告按钮 -->
	<div class="downloadReport">
		<button class="btn btn-info" type="button" onclick="saveImage()">下载测评报告</button>
		<a download="个人测评报告" id="export_btn" style="visibility:hidden;">aaa</a>
	</div>
	<div id="canvas_area" style="position:absolute;top:9999px;">
		<img src="" id="img" />
	</div>
	
	<div class="kyzr_bottom">
		<div class="kyzr_bottomWord">
	  		@2021 By <a class="kyzr_blog" target="_blank" href="http://kyzr2000.gitee.io/myblog/">King_FLYz</a>
	  	</div>
	</div>
</body>
</html>