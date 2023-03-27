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
<!-- navYyzj.css 用来显示蓝色下划线的 -->
<link rel="stylesheet" href="<%=basePath%>css/underline/navYyzj.css" />
<!-- kyzr_Yyzj.jsp的css，定义了白色区域的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_yyzj.css" />
<title>预约专家</title>
</head>
<body>
	<jsp:include page="../../tools/nav.jsp" />
	<script type="text/javascript">
		var myName = "${myName}";
		var myUser = "${myUser}";
		var status = "${myUser.status}";
		var myMoney;
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
			//拿目前登录用户的钱数
			$.post("${pageContext.request.contextPath}/user/money",function (data){
				myMoney = data;
			})
			//拿专家列表
			getList();
		}
		//非常重要的数据：page总页数，pageNum当前页数，num当前搜索到的帖子个数，pageList当前帖子的列表
		var page;
		var pageNum = 1;
		var num;
		var pageList;
		//拿咨询师列表
		function getList(){
			$.ajax({
				url:"${pageContext.request.contextPath}/expert/getList",
				success:function(data){
					var html = "";
					//每次打开页面只显示最新的五个
					var sum = 0;
					pageNum = 1;
					num = data.length;
					page = Math.ceil(data.length/5) ;
					//alert(page);
					pageList = data;
					if(data.length<=5)
						sum = 0;
					else
						sum = data.length - 5;
					for(var i=data.length-1;i>=sum;i--){
						html += "<div class=\"kyzr_expert\">"+
									"<img class=\"kyzr_expertImg\" src=\"" + data[i].img + "\"/>"+
									"<div class=\"kyzr_expertName\">"+data[i].name+"</div>"+
									"<div class=\"kyzr_expertDescribe\">"+data[i].introduction+"</div>"+
									"<div class=\"kyzr_expertValue\">"+
										"<i class=\"kyzr_expertMoney\">"+data[i].value+"</i>元起"+
									"</div>"+
									"<div class=\"kyzr_expertTag\">"+
										"<div class=\"kyzr_expertTagOne\">"+data[i].tagOne+"</div>"+
										"<div class=\"kyzr_expertTagOne\">"+data[i].tagTwo+"</div>"+
										"<div class=\"kyzr_expertTagOne\">"+data[i].tagThree+"</div>"+
									"</div>"+
									"<div class=\"kyzr_expertBtn\">"+
										"<button type=\"button\" expert_id=\""+data[i].user_id+"\" onclick=\"appoint(this)\" class=\"btn btn-info\">点击预约</button>"+
									"</div>"+
								"</div>";
					}
					$(".kyzr_Content").html(html);
				}
			});
		}
		//模糊搜索
		function searchBtn(){
			var content = $("#searchExpert").val();
			$.ajax({
				url:"${pageContext.request.contextPath}/expert/searchList",
				type: "POST",
				data:{'content':content},
				contentType:"application/x-www-form-urlencoded; charset=UTF-8",
				success:function(data){
					var html = "";
					//每次打开页面只显示最新的五个
					var sum = 0;
					pageNum = 1;
					num = data.length;
					page = Math.ceil(data.length/5) ;
					//alert(page);
					pageList = data;
					if(data.length<=5)
						sum = 0;
					else
						sum = data.length - 5;
					for(var i=data.length-1;i>=sum;i--){
						html += "<div class=\"kyzr_expert\">"+
									"<img class=\"kyzr_expertImg\" src=\"" + data[i].img + "\"/>"+
									"<div class=\"kyzr_expertName\">"+data[i].name+"</div>"+
									"<div class=\"kyzr_expertDescribe\">"+data[i].introduction+"</div>"+
									"<div class=\"kyzr_expertValue\">"+
										"<i class=\"kyzr_expertMoney\">"+data[i].value+"</i>元起"+
									"</div>"+
									"<div class=\"kyzr_expertTag\">"+
										"<div class=\"kyzr_expertTagOne\">"+data[i].tagOne+"</div>"+
										"<div class=\"kyzr_expertTagOne\">"+data[i].tagTwo+"</div>"+
										"<div class=\"kyzr_expertTagOne\">"+data[i].tagThree+"</div>"+
									"</div>"+
									"<div class=\"kyzr_expertBtn\">"+
										"<button type=\"button\" expert_id=\""+data[i].user_id+"\" onclick=\"appoint(this)\" class=\"btn btn-info\">点击预约</button>"+
									"</div>"+
								"</div>";
					}
					$(".kyzr_Content").html(html);
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
			startPage = num - (pageNum-1)*5;
			startPage--;
			endPage = startPage - 4;
			if(endPage<0)
				endPage = 0;
			for(var i=startPage;i>=endPage;i--){
				html += "<div class=\"kyzr_expert\">"+
							"<img class=\"kyzr_expertImg\" src=\"" + pageList[i].img + "\"/>"+
							"<div class=\"kyzr_expertName\">"+pageList[i].name+"</div>"+
							"<div class=\"kyzr_expertDescribe\">"+pageList[i].introduction+"</div>"+
							"<div class=\"kyzr_expertValue\">"+
								"<i class=\"kyzr_expertMoney\">"+pageList[i].value+"</i>元起"+
							"</div>"+
							"<div class=\"kyzr_expertTag\">"+
								"<div class=\"kyzr_expertTagOne\">"+pageList[i].tagOne+"</div>"+
								"<div class=\"kyzr_expertTagOne\">"+pageList[i].tagTwo+"</div>"+
								"<div class=\"kyzr_expertTagOne\">"+pageList[i].tagThree+"</div>"+
							"</div>"+
							"<div class=\"kyzr_expertBtn\">"+
								"<button type=\"button\" expert_id=\""+pageList[i].user_id+"\" onclick=\"appoint(this)\" class=\"btn btn-info\">点击预约</button>"+
							"</div>"+
						"</div>";
			}
			$(".kyzr_Content").html(html);
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
			startPage = num - (pageNum-1)*5;
			startPage--;
			endPage = startPage - 4;
			if(endPage<0)
				endPage = 0;
			for(var i=startPage;i>=endPage;i--){
				html += "<div class=\"kyzr_expert\">"+
							"<img class=\"kyzr_expertImg\" src=\"" + pageList[i].img + "\"/>"+
							"<div class=\"kyzr_expertName\">"+pageList[i].name+"</div>"+
							"<div class=\"kyzr_expertDescribe\">"+pageList[i].introduction+"</div>"+
							"<div class=\"kyzr_expertValue\">"+
								"<i class=\"kyzr_expertMoney\">"+pageList[i].value+"</i>元起"+
							"</div>"+
							"<div class=\"kyzr_expertTag\">"+
								"<div class=\"kyzr_expertTagOne\">"+pageList[i].tagOne+"</div>"+
								"<div class=\"kyzr_expertTagOne\">"+pageList[i].tagTwo+"</div>"+
								"<div class=\"kyzr_expertTagOne\">"+pageList[i].tagThree+"</div>"+
							"</div>"+
							"<div class=\"kyzr_expertBtn\">"+
								"<button type=\"button\" expert_id=\""+pageList[i].user_id+"\" onclick=\"appoint(this)\" class=\"btn btn-info\">点击预约</button>"+
							"</div>"+
						"</div>";
			}
			$(".kyzr_Content").html(html);
		}
		
		
		//点击预约按钮执行的函数
		function appoint(obj){
			var id = $(obj).attr("expert_id");
			var price;
			//拿当前心理咨询师的钱数
			$.ajax({
				url:"${pageContext.request.contextPath}/expert/price",
				data:{'id':id},
				success:function(data){
					price = data;
					//先判断用户是否登录
					if(myName==""){
						confirm("请登陆后再进行预约！");
					}
					else{
						//判断用户目前钱包内的余额够不够支付本次的咨询费用
						if(myMoney<price){
							confirm("余额不足，请移至“钱包”内充值！");
						}
						else{
							//用户输入预约时的要求
							var myInfo = prompt('请输入您的咨询要求(若取消则认为无特殊要求)');
							if(confirm("您确定要预约吗？")){
								//alert(myInfo);
								//判断一下用户身份，咨询师和管理员不能预约，只能在user表中status为0的用户可以预约
								if(status == 0){
									//查询一下本用户order表内是否有未完成的预约（status为0或1的order数据）
									//如果有未完成的，抛出异常提示用户先进行完本项预约，如果没有就新增一条数据然后提示用户在个人中心内查看进度
									$.ajax({
										url:"${pageContext.request.contextPath}/chat/getOrdersByID",
										data:{'id':id,'myInfo':myInfo},
										type: "POST",
										contentType:"application/x-www-form-urlencoded; charset=UTF-8",
										success:function(){
											alert("预约成功!请前往\"个人中心\"页面的\"订单\"内观察预约情况")
										},
										error:function(){
											alert("目前您仍然存在未完成的订单!");
										}
									});
								}
								else{
									alert("您的权限太高,只有用户可以预约哦~");
								}
							}
						}
					}
				}
			});
			
		}
	</script>
	<div class="kyzr_yyzjContainer">
		<!-- 白色背景 1200px高度 -->
		<div class="kyzr_yyzjContent">
			<!-- 搜索框 -->
			<div class="kyzr_searchExpert">
				<div class="kyzr_yyzjSearch input-group col-md-3" style="margin-top:0px;position:relative">
					<input type="text" id="searchExpert" class="form-control" placeholder="请输入想要搜索的专家名" style="height:53px;width:1265px;top:0px;" >
					<span class="input-group-btn">
						<button type="button" onclick="searchBtn()" class="btn btn-info btn-search">搜索</button>
					</span>
				</div>
			</div>
			<!-- 循环读取整个表内的数据 -->
			<div class="kyzr_Content">
			</div>
			<!-- 翻页 -->
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