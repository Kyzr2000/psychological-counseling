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
<link rel="stylesheet" href="<%=basePath%>css/underline/navGyjd.css" />
<!-- kyzr_gyjd.jsp的css，定义了白色区域的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_gyjd.css" />
<title>${myAnswer.title}</title>
</head>
<body>
	<jsp:include page="../../tools/nav.jsp" />
	<script type="text/javascript">
		//点击“发表回复”按钮后的函数
		function comment(){
			var article = $("#commentText").val();
			if(article != ""){
				$.ajax({
					url:"${pageContext.request.contextPath}/answer/comment",
					type: "POST",
					contentType:"application/x-www-form-urlencoded; charset=UTF-8",
					data:{'article':$("#commentText").val()},
					success:function(data){
						alert("评论成功！");
						commentList();
					},
					error:function(){
						alert("请登录后在评论");
					}
						
				})
			}
			else{
				alert("评论内容不能为空");
			}
		}
		//加载当前咨询帖子的所有回复列表
		function commentList(){
			$.post("${pageContext.request.contextPath}/answer/commentList",function (data){
				var html = "";
				var j = data.length;
				for(var i=data.length-1;i>=0;i--){
					html += "<div class=\"wjb_comment\">"+
								"<div class=\"wjb_name\">"+"#"+j+data[i].user.name+"</div>"+
								"<div class=\"wjb_createAt\">"+data[i].createAt+"</div>"+
								"<div class=\"wjb_article\">"+data[i].article+"</div>"+
								"<hr />"+
							"</div>";
					j--;
				}
				$("#kyzr_commentList").html(html);
			})
		}
		var myName = "${myName}";
		var myUser = "${myUser}";
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
			commentList();
		}
	</script>
	<div class="kyzr_gyjdContainer">
		<!-- 白色背景 1200px高度 -->
		<div class="kyzr_gyjdContent">
			<!-- 内容放置区域 -->
			<div class="commentContent">
				<!-- 本条帖子的内容 -->
				<div class="commentTitle">${myAnswer.title}</div>
				<div class="commentCreate">
					<div class="commentCN">${myAnswer.user.name}&nbsp;&nbsp;&nbsp;</div>
					<div class="commentCT">发表于${myAnswer.createAt}</div>
				</div>
				<hr />
				<div class="commentArticle">${myAnswer.article}</div>
				<!-- 本条帖子下方的评论部分 -->
				<div class="kyzr_comment">
					<textarea class="form-control" id="commentText" name="" rows="5" style="resize:none;"></textarea>
					<button onclick="comment()" class="btn btn-info" style="position:relative;float:right;top:30px;">发表回复</button>
				</div>
				<!-- 评论区  -->
				<div id="kyzr_commentList">
					
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="../../tools/bottom.jsp" />
</body>
</html>