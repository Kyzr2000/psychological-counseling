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
<link rel="stylesheet" href="<%=basePath%>css/underline/navGyjd.css" />
<!-- kyzr_gyjd.jsp的css，定义了白色区域的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_gyjd.css" />
<title>公益解答</title>
</head>
<body>
	<jsp:include page="../../tools/nav.jsp" />
	<script type="text/javascript">
		//非常重要的数据：page总页数，pageNum当前页数，num当前搜索到的帖子个数，pageList当前帖子的列表
		var page;
		var pageNum = 1;
		var num;
		var pageList;
		//answer
		function answer(){
			$.post("${pageContext.request.contextPath}/answer/list",function (data){
				var html = "";
				//每次打开页面只显示前十个帖子
				var sum = 0;
				pageNum = 1;
				num = data.length;
				page = Math.ceil(data.length/10) ;
				//alert(page);
				pageList = data;
				if(data.length<=10)
					sum = 0;
				else
					sum = data.length - 10;
				for(var i=data.length-1;i>=sum;i--){
					html += "<tr>"+
								"<td>"+ 
										"<a href=\"../jsp/user/answerPageContent.jsp\" answer-id=\"" + data[i].id +
										"\" onclick=\"getAnswer(this)\" style=\"color:black;\">" 
										+ data[i].title + "</a>" +
								"</td>"+
								"<td style=\"text-align:center;\">"+ data[i].user.name +"</td>"+
								"<td style=\"text-align:right;\">"+ data[i].createAt +"</td>"+
							"</tr>";
				}
				$("#answerList").html(html);
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
			//注入下方内容列表
			answer();
		}
		//点击公益解答下面每一个帖子时候所执行的函数
		function getAnswer(obj){
			var id = $(obj).attr("answer-id");
			$.ajax({
				url:"${pageContext.request.contextPath}/answer/getAnswer/"+id,
				data:{'id':id},
				success:function(data){
					
				}
			})
		}
		//点击“发布问题”按钮
		function uploadQuestion(){
			$("#kyzr_newAnswer").css("display","block");
		}
		//点×关掉弹窗
		function chaBtn(){
			$("#kyzr_newAnswer").css("display","none");
		}
		//把新添加的问题上传到数据库
		function submitUploadAnswer(){
			if(myName != ""){
				$.ajax({
					url:"${pageContext.request.contextPath}/answer/uploadAnswer",
					type: "POST",
					data:$("#submitAnswerForm").serialize(),
					contentType:"application/x-www-form-urlencoded; charset=UTF-8",
					success:function(data){
						alert("发布成功！");
						answer();
					},
					error:function(){
						alert("输入的标题和内容不能为空！");
					}
				})
			}
			else{
				alert("请登录后在进行发布问题！");
			}
		}
		//模糊搜索
		function searchBtn(){
			var content = $("#searchAnswer").val();
			$.ajax({
				url:"${pageContext.request.contextPath}/answer/searchList",
				type: "POST",
				data:{'content':content},
				contentType:"application/x-www-form-urlencoded; charset=UTF-8",
				success:function(data){
					var html = "";
					//每次打开页面只显示前十个帖子
					var sum = 0;
					pageNum = 1;
					num = data.length;
					page = Math.ceil(data.length/10);
					pageList = data;
					if(data.length<=10)
						sum = 0;
					else
						sum = data.length - 10;
					for(var i=data.length-1;i>=sum;i--){
						html += "<tr>"+
									"<td>"+ 
											"<a href=\"../jsp/user/answerPageContent.jsp\" answer-id=\"" + data[i].id +
											"\" onclick=\"getAnswer(this)\" style=\"color:black;\">" 
											+ data[i].title + "</a>" +
									"</td>"+
									"<td style=\"text-align:center;\">"+ data[i].user.name +"</td>"+
									"<td style=\"text-align:right;\">"+ data[i].createAt +"</td>"+
								"</tr>";
					}
					$("#answerList").html(html);
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
			startPage = num - (pageNum-1)*10;
			startPage--;
			endPage = startPage - 9;
			if(endPage<0)
				endPage = 0;
			for(var i=startPage;i>=endPage;i--){
				html += "<tr>"+
							"<td>"+ 
									"<a href=\"../jsp/user/answerPageContent.jsp\" answer-id=\"" + pageList[i].id +
									"\" onclick=\"getAnswer(this)\" style=\"color:black;\">" 
									+ pageList[i].title + "</a>" +
							"</td>"+
							"<td style=\"text-align:center;\">"+ pageList[i].user.name +"</td>"+
							"<td style=\"text-align:right;\">"+ pageList[i].createAt +"</td>"+
						"</tr>";
			}
			$("#answerList").html(html);
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
			startPage = num - (pageNum-1)*10;
			startPage--;
			endPage = startPage - 9;
			if(endPage<0)
				endPage = 0;
			for(var i=startPage;i>=endPage;i--){
				html += "<tr>"+
							"<td>"+ 
									"<a href=\"../jsp/user/answerPageContent.jsp\" answer-id=\"" + pageList[i].id +
									"\" onclick=\"getAnswer(this)\" style=\"color:black;\">" 
									+ pageList[i].title + "</a>" +
							"</td>"+
							"<td style=\"text-align:center;\">"+ pageList[i].user.name +"</td>"+
							"<td style=\"text-align:right;\">"+ pageList[i].createAt +"</td>"+
						"</tr>";
			}
			$("#answerList").html(html);
		}
	</script>
	<div class="kyzr_gyjdContainer">
		<!-- 白色背景 1200px高度 -->
		<div class="kyzr_gyjdContent">
			<!-- 左侧图片 -->
			<img class="kyzr_gyjdPicture" src="http://nickyzj.run:12450/lychee/uploads/big/199d9038fdd7661a32d7c6ea14802892.jpg" />
			<!-- 左侧图片的右侧内容 -->
			<div class="kyzr_gyjdGood">
				<!-- 搜索解答内容 -->
				<div class="kyzr_gyjdSearch input-group col-md-3" style="margin-top:0px;position:relative">
					<input type="text" id="searchAnswer" class="form-control" placeholder="请输入想要搜索的解答内容" style="height:34px;top:0px;" >
					<span class="input-group-btn">
						<button type="button" onclick="searchBtn()" class="btn btn-info btn-search">搜索</button>
					</span>
				</div>
				<!-- 精华 可以有三个 每个的高度都是100px -->
				<div class="kyzr_gyjdJH">
					<div class="kyzr_gyjdTitle"><a class="gyjdtitle" href="javascript:void(0)"><i>【置顶】</i>欢迎大家来这里留下问题，会有人解答哦~</a></div>
					<div class="kyzr_gyjdCreator">发表者：King_FLYz</div>
					<div class="kyzr_gyjdTime">创建时间：2021/12/25</div>
				</div>
				<div class="kyzr_gyjdJH">
					<div class="kyzr_gyjdTitle"><a class="gyjdtitle" href="javascript:void(0)"><i>【置顶】</i>心理咨询系统祝大家新年快乐！</a></div>
					<div class="kyzr_gyjdCreator">发表者：King_FLYz</div>
					<div class="kyzr_gyjdTime">创建时间：2022/02/01</div>
				</div>
				<div class="kyzr_gyjdJH">
					<div class="kyzr_gyjdTitle"><a class="gyjdtitle" href="javascript:void(0)"><i>【置顶】</i>如有问题可联系QQ342133194</a></div>
					<div class="kyzr_gyjdCreator">发表者：King_FLYz</div>
					<div class="kyzr_gyjdTime">创建时间：2022/03/29</div>
				</div>
			</div>
			<!-- 发布按钮 -->
			<button id="kyzr_uploadBtn" onclick="uploadQuestion()" type="button" class="btn btn-success">
				<span class="glyphicon glyphicon-plus"></span> 发布问题
			</button>
			<!-- 下方常规内容 -->
			<div class="kyzr_gyjdList">
				<table style="position:relative;border-radius:25px;" class="table table-hover">
					<tr>
						<td>主题</td>
						<td style="text-align:center;">发表者</td>
						<td style="text-align:right;">发布时间</td>
					</tr>
					<tbody id="answerList">
						
					</tbody>
				</table>
				<div class= "kyzr_changePage">
					<ul class="pager">
						<!-- 为a标签的href设置href="javascript:void(0)"，使得点击a标签不刷新页面 -->
						<li class=""><a href="javascript:void(0)" onclick="upPage()" style="color:black;">上一页</a></li>
						<li class=""><a href="javascript:void(0)" onclick="downPage()" style="color:black;">下一页</a></li>
					</ul>
				</div>
			</div>
			<!-- 发布新帖子，隐藏内容，display:none  -->
			<div id="kyzr_newAnswer">
				<!-- 白色区域，居中显示 -->
				<div class="kyzr_newAnswerContent">
					<button type="button" onclick="chaBtn()" class="kyzr_cha">×</button>
					<!-- 表单 -->
					<div class="uploadAnswer_form">
						<form class="form-horizontal" action="" id="submitAnswerForm">
						    <div class="form-group">
							    <label for="title" class="col-sm-2 control-label">标题</label>
							    <div class="col-sm-10">
							      <input class="form-control" name="title" id="title" type="text">
							    </div>
						    </div>
						    <div class="form-group">
							    <label for="article" class="col-sm-2 control-label">详细内容</label>
							    <div class="col-sm-10">
							      <textarea class="form-control" id="article" name="article" rows="4" style="resize:none;"></textarea>
							    </div>
						    </div>
							<div class="form-group">
							    <div class="col-sm-offset-2 col-sm-10">
							      <button type="button" id="uploadAnswerBtn" onclick="submitUploadAnswer()" class="btn btn-default">发布</button>
							    </div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../../tools/bottom.jsp" />
</body>
</html>