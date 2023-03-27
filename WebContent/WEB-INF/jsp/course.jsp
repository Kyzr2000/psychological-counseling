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
<script src="<%=basePath%>js/jquery-3.6.0.js"></script>
<!-- kyzr_kc.jsp的css，定义了白色区域的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_kc.css" />
<title>课程</title>
</head>
<body>
	<jsp:include page="../../tools/nav.jsp" />
	<script type="text/javascript">
		function getCourse(obj){
			var id = $(obj).attr("course-id");
			$.ajax({
				url:"${pageContext.request.contextPath}/user/getCourse/"+id,
				data:{'id':id},
				success:function(){
				}
			})
		}
		var myName = "${myName}";
		var myUser = "${myUser}";
		//设置一个变量courseList，用来存放当前获得的课程列表
		var courseList;
		var page;
		var pageNum = 1;
		var num;
		window.onload=function(){
			if(myName!="" && myUser!=""){
				//上方
				$("#navLogin").css("display","none");
				$("#navRegister").css("display","none");
				$("#navLogout").css("display","block");
				$("#myname").css("display","block");
			}
			//拿存在session里面的courseList
			$.ajax({
				url:"${pageContext.request.contextPath}/user/courseList",
				success:function(data){
					var html = "";
					courseList = data;//每次打开页面只显示前9个页面
					var sum = 0;
					pageNum = 1;
					num = data.length;
					page = Math.ceil(data.length/9) ;
					//alert(page);
					if(data.length<=9)
						sum = 0;
					else
						sum = data.length - 9;
					for(var i=data.length-1;i>=sum;i--){
						html += "<ul class=\"kyzr_kcUL\">"+
									"<a course-id=\""+courseList[i].id+"\" onclick=\"getCourse(this)\" href=\"../jsp/user/courseVideo.jsp\" >"+
										"<img class=\"kyzr_kcIMG\" src=\""+courseList[i].img+"\" />"+
									"</a>"+
									"<div class=\"kyzr_kcti\">"+
										"<div class=\"kyzr_kctitle\">"+
											"<a class=\"kyzr_kcword\" course-id=\""+courseList[i].id+"\" onclick=\"getCourse(this)\" href=\"../jsp/user/courseVideo.jsp\">"+
												courseList[i].title +
											"</a>"+
										"</div>"+
										"<div class=\"kyzr_kcTime\">"+ courseList[i].createAt +"</div>"+
									"</div>"+
								"</ul>" ;
					}
					$("#kyzr_allKc").html(html);
				}
			})
			
		}
		//点击下一页
		function downPage(){
			var html = "";
			//判断下一页到第几页
			if(pageNum == page)
				pageNum = 1;
			else
				pageNum++;
			//点击下一页后注入下一页的帖子
			//alert(pageNum);
			var startPage,endPage;
			startPage = num - (pageNum-1)*9;
			startPage--;
			endPage = startPage - 8;
			if(endPage<0)
				endPage = 0;
			for(var i=startPage;i>=endPage;i--){
				html += "<ul class=\"kyzr_kcUL\">"+
							"<a course-id=\""+courseList[i].id+"\" onclick=\"getCourse(this)\" href=\"../jsp/user/courseVideo.jsp\" >"+
								"<img class=\"kyzr_kcIMG\" src=\""+courseList[i].img+"\" />"+
							"</a>"+
							"<div class=\"kyzr_kcti\">"+
								"<div class=\"kyzr_kctitle\">"+
									"<a class=\"kyzr_kcword\" course-id=\""+courseList[i].id+"\" onclick=\"getCourse(this)\" href=\"../jsp/user/courseVideo.jsp\">"+
										courseList[i].title +
									"</a>"+
								"</div>"+
								"<div class=\"kyzr_kcTime\">"+ courseList[i].createAt +"</div>"+
							"</div>"+
						"</ul>" ;
			}
			$("#kyzr_allKc").html(html);
		}
		//点击上一页
		function upPage(){
			var html = "";
			//判断下一页到第几页
			if(pageNum == 1)
				pageNum = page;
			else
				pageNum--;
			//点击下一页后注入下一页的帖子
			//alert(pageNum);
			var startPage,endPage;
			startPage = num - (pageNum-1)*9;
			startPage--;
			endPage = startPage - 8;
			if(endPage<0)
				endPage = 0;
			for(var i=startPage;i>=endPage;i--){
				html += "<ul class=\"kyzr_kcUL\">"+
							"<a course-id=\""+courseList[i].id+"\" onclick=\"getCourse(this)\" href=\"../jsp/user/courseVideo.jsp\" >"+
								"<img class=\"kyzr_kcIMG\" src=\""+courseList[i].img+"\" />"+
							"</a>"+
							"<div class=\"kyzr_kcti\">"+
								"<div class=\"kyzr_kctitle\">"+
									"<a class=\"kyzr_kcword\" course-id=\""+courseList[i].id+"\" onclick=\"getCourse(this)\" href=\"../jsp/user/courseVideo.jsp\">"+
										courseList[i].title +
									"</a>"+
								"</div>"+
								"<div class=\"kyzr_kcTime\">"+ courseList[i].createAt +"</div>"+
							"</div>"+
						"</ul>" ;
			}
			$("#kyzr_allKc").html(html);
		}
		//模糊搜索
		function searchBtn(){
			var title = $("#courseTitle").val();
			//alert(content);
			$.ajax({
				url:"${pageContext.request.contextPath}/manage/searchCourseList",
				type: "POST",
				data:{'title':title},
				contentType:"application/x-www-form-urlencoded; charset=UTF-8",
				success:function(data){
					var html = "";
					courseList = data;//每次打开页面只显示前9个页面
					var sum = 0;
					pageNum = 1;
					num = data.length;
					page = Math.ceil(data.length/9) ;
					//alert(page);
					if(data.length<=9)
						sum = 0;
					else
						sum = data.length - 9;
					for(var i=data.length-1;i>=sum;i--){
						html += "<ul class=\"kyzr_kcUL\">"+
									"<a course-id=\""+courseList[i].id+"\" onclick=\"getCourse(this)\" href=\"../jsp/user/courseVideo.jsp\" >"+
										"<img class=\"kyzr_kcIMG\" src=\""+courseList[i].img+"\" />"+
									"</a>"+
									"<div class=\"kyzr_kcti\">"+
										"<div class=\"kyzr_kctitle\">"+
											"<a class=\"kyzr_kcword\" course-id=\""+courseList[i].id+"\" onclick=\"getCourse(this)\" href=\"../jsp/user/courseVideo.jsp\">"+
												courseList[i].title +
											"</a>"+
										"</div>"+
										"<div class=\"kyzr_kcTime\">"+ courseList[i].createAt +"</div>"+
									"</div>"+
								"</ul>" ;
					}
					$("#kyzr_allKc").html(html);
				}
			});
		}
	</script>
	<div class="kyzr_kcContainer">
		<!-- 白色背景 1200px高度 -->
		<div class="kyzr_kcContent">
			<!-- 搜索课程区域 -->
			<div class="kyzr_searchCourse">
				<div class="kyzr_search input-group col-md-3" style="margin-top:0px;position:relative;width: 94%;">
		       		<input type="text" class="form-control" id="courseTitle" placeholder="请输入课程名进行搜索课程" style="height:50px;top:0px;" >
		            <span class="input-group-btn">
		               <button type="button" onclick="searchBtn()" class="btn btn-info btn-search" style="height:50px;">查找</button>
		            </span>
				</div>
			</div>
			<!-- 课程区域 -->
			<div id="kyzr_allKc">
				<!-- 循环读取整个课程表内的数据 -->
				<!-- 课程列表 -->
				
			</div>
			<div class= "kyzr_changePage">
				<ul class="pager">
					<!-- 为a标签的href设置href="javascript:void(0)"，使得点击a标签不刷新页面 -->
					<li class=""><a href="javascript:void(0)" onclick="upPage()" style="color:black;">上一页</a></li>
					<li class=""><a href="javascript:void(0)" onclick="downPage()" style="color:black;">下一页</a></li>
				</ul>
			</div>
		</div>
	</div>
	<jsp:include page="../../tools/bottom.jsp" />
</body>
</html>