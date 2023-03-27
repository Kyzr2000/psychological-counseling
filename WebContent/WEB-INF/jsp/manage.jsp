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
<title>管理员页面</title>
<!-- bootstrap框架 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- kyzr.css 全局css文件，目前只定义了首页的颜色 -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr.css" />
<!-- 本页面的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_manage.css" />
<script src="<%=basePath%>js/jquery-3.6.0.js"></script>
<script type="text/javascript">
/*
	function a1() {
		//url：待载入的url
		//data：待发送key/value参数，封装了服务器返回的数据
		//success：再入成功时回调函数
		//status：状态
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/test1",
			data:{'name':$("#txtName").val()},
			success:function(data,status){
				alert(data);
				alert(status);
			}
		});
	}
	$(function a2(){
		$("#btn").click(function(){
			$.post("${pageContext.request.contextPath}/manage/test2",function (data){
				console.log(data);
				var html = "";
				for(var i=0;i<data.length;i++){
					html += "<tr>" +
					"<td>"+data[i].name+"</td>"+
					"<td>"+data[i].sex+"</td>"+
					"</tr>"
					
				}
				$("#content").html(html);
			})
		})
	})
	*/
	//全局变量：用户的名字
	var myName = "${myName}";
	//读取所有首页文章的信息
	//有关于文章的变量
	var PassagePage; //文章的总页数
	var PassagePageNum = 1; //文章的当前页数
	var PassageNum; //总文章或者查找到的文章的数量
	var PassagePageList; //存放所有文章或查找到的文章的集合
	function passage(){
		$.post("${pageContext.request.contextPath}/manage/passageList",function (data){
			var html = "";
			var sum;
			PassagePageList = data;
			PassagePageNum = 1;
			PassageNum = data.length;
			PassagePage = Math.ceil(data.length/10);
			if(data.length>10)
				sum = 10;
			else
				sum = data.length;
			for(var i=0;i<sum;i++){
				//修改状态名
				if(data[i].status == 1)
					data[i].status = "置顶文章";
				if(data[i].status == 0)
					data[i].status = "普通文章";
				//获取列表并添加到页面内
				html += "<tr>" +
				"<td>"+data[i].id+"</td>"+
				"<td>"+data[i].title+"</td>"+
				"<td>"+"<a target=\"_blank\" style=\"color:black;\" href="+data[i].img+">"+"封面链接"+"</a>"+"</td>"+
				"<td>"+data[i].createAt+"</td>"+
				"<td>"+data[i].status+"</td>"+
				"<td>"+
					"<a href=\"../jsp/article/article.jsp\" target=\"_blank\" get-id=\""+ data[i].id +"\" onclick=\"getPassage(this)\" style=\"margin-right:10px;\" class=\"btn btn-info\">查看</a>"+
					"<button change-id=\""+ data[i].id +"\" onclick=\"changePassage(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">编辑</button>"+
					"<button delete-id=\""+ data[i].id +"\" onclick=\"deletePassage(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">删除</button>"+
				"</td>"+
				"</tr>";
			}	
			$("#kyzr_passageList").html(html);	
		})
	}
	//文章翻页，下一页
	function nextPassagePage(){
		var html = "";
		//判断下一页到第几页
		if(PassagePageNum == PassagePage)
			PassagePageNum = 1;
		else
			PassagePageNum++;
		//点击下一页后注入下一页的帖子
		var startPage,endPage;
		startPage = (PassagePageNum-1)*10;
		endPage = startPage + 10;
		if(endPage>PassageNum)
			endPage = PassageNum;
		for(var i=startPage;i<endPage;i++){
			//修改状态名
			if(PassagePageList[i].status == 1)
				PassagePageList[i].status = "置顶文章";
			if(PassagePageList[i].status == 0)
				PassagePageList[i].status = "普通文章";
			//获取列表并添加到页面内
			html += "<tr>" +
			"<td>"+PassagePageList[i].id+"</td>"+
			"<td>"+PassagePageList[i].title+"</td>"+
			"<td>"+"<a target=\"_blank\" style=\"color:black;\" href="+PassagePageList[i].img+">"+"封面链接"+"</a>"+"</td>"+
			"<td>"+PassagePageList[i].createAt+"</td>"+
			"<td>"+PassagePageList[i].status+"</td>"+
			"<td>"+
				"<a href=\"../jsp/article/article.jsp\" target=\"_blank\" get-id=\""+ PassagePageList[i].id +"\" onclick=\"getPassage(this)\" style=\"margin-right:10px;\" class=\"btn btn-info\">查看</a>"+
				"<button change-id=\""+ PassagePageList[i].id +"\" onclick=\"changePassage(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">编辑</button>"+
				"<button delete-id=\""+ PassagePageList[i].id +"\" onclick=\"deletePassage(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">删除</button>"+
			"</td>"+
			"</tr>";
		}
		$("#kyzr_passageList").html(html);
	}
	//文章的搜索功能
	function searchPassage(){
		var title = $("#searchPassage").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/searchPassageList",
			type: "POST",
			data:{'title':title},
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			success:function(data){
				var html = "";
				var sum;
				PassagePageList = data;
				PassagePageNum = 1;
				PassageNum = data.length;
				PassagePage = Math.ceil(data.length/10);
				if(data.length>10)
					sum = 10;
				else
					sum = data.length;
				for(var i=0;i<sum;i++){
					//修改状态名
					if(data[i].status == 1)
						data[i].status = "置顶文章";
					if(data[i].status == 0)
						data[i].status = "普通文章";
					//获取列表并添加到页面内
					html += "<tr>" +
					"<td>"+data[i].id+"</td>"+
					"<td>"+data[i].title+"</td>"+
					"<td>"+"<a target=\"_blank\" style=\"color:black;\" href="+data[i].img+">"+"封面链接"+"</a>"+"</td>"+
					"<td>"+data[i].createAt+"</td>"+
					"<td>"+data[i].status+"</td>"+
					"<td>"+
						"<a href=\"../jsp/article/article.jsp\" target=\"_blank\" get-id=\""+ data[i].id +"\" onclick=\"getPassage(this)\" style=\"margin-right:10px;\" class=\"btn btn-info\">查看</a>"+
						"<button change-id=\""+ data[i].id +"\" onclick=\"changePassage(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">编辑</button>"+
						"<button delete-id=\""+ data[i].id +"\" onclick=\"deletePassage(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">删除</button>"+
					"</td>"+
					"</tr>";
				}	
				$("#kyzr_passageList").html(html);	
			}
		})
	}
	//文章翻页，上一页
	function previousPassagePage(){
		var html = "";
		//判断上一页到第几页
		if(PassagePageNum == 1)
			PassagePageNum = PassagePage;
		else
			PassagePageNum--;
		//点击下一页后注入下一页的帖子
		var startPage,endPage;
		startPage = (PassagePageNum-1)*10;
		endPage = startPage + 10;
		if(endPage>PassageNum)
			endPage = PassageNum;
		for(var i=startPage;i<endPage;i++){
			//修改状态名
			if(PassagePageList[i].status == 1)
				PassagePageList[i].status = "置顶文章";
			if(PassagePageList[i].status == 0)
				PassagePageList[i].status = "普通文章";
			//获取列表并添加到页面内
			html += "<tr>" +
			"<td>"+PassagePageList[i].id+"</td>"+
			"<td>"+PassagePageList[i].title+"</td>"+
			"<td>"+"<a target=\"_blank\" style=\"color:black;\" href="+PassagePageList[i].img+">"+"封面链接"+"</a>"+"</td>"+
			"<td>"+PassagePageList[i].createAt+"</td>"+
			"<td>"+PassagePageList[i].status+"</td>"+
			"<td>"+
				"<a href=\"../jsp/article/article.jsp\" target=\"_blank\" get-id=\""+ PassagePageList[i].id +"\" onclick=\"getPassage(this)\" style=\"margin-right:10px;\" class=\"btn btn-info\">查看</a>"+
				"<button change-id=\""+ PassagePageList[i].id +"\" onclick=\"changePassage(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">编辑</button>"+
				"<button delete-id=\""+ PassagePageList[i].id +"\" onclick=\"deletePassage(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">删除</button>"+
			"</td>"+
			"</tr>";
		}
		$("#kyzr_passageList").html(html);
	}
	//有关于钱包管理翻页的变量
	var PursePage; 
	var PursePageNum = 1; 
	var PurseNum; 
	var PursePageList;
	//读取所有用户的钱包信息
	function purse(){
		$.post("${pageContext.request.contextPath}/manage/purse",function (data){
			var html = "";
			var sum;
			PursePageNum = 1;
			PurseNum = data.length;
			PursePage = Math.ceil(data.length/10);
			if(data.length>10)
				sum = 10;
			else
				sum = data.length;
			for(var i=0;i<data.length;i++){
				if(data[i].status == 0)
					data[i].status = "";
				if(data[i].status == 1)
					data[i].status = "请求充值";
				if(data[i].status == 2)
					data[i].status = "请求提现";
				if(data[i].status == 3)
					data[i].status = "同意请求";
				if(data[i].status == 4)
					data[i].status = "拒绝请求";
			}
			PursePageList = data;
			for(var i=0;i<sum;i++){
				//获取列表并添加到页面内
				html += "<tr>" +
				"<td>"+data[i].id+"</td>"+
				"<td>"+data[i].user.name+"</td>"+
				"<td>"+data[i].user.email+"</td>"+
				"<td>"+data[i].money+"</td>"+
				"<td>"+data[i].inMoney+"</td>"+
				"<td>"+data[i].outMoney+"</td>"+
				"<td>"+data[i].status+"</td>"+
				"<td>"+
					"<button pass-id=\""+ data[i].id +"\" onclick=\"pass(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">通过</button>"+
					"<button refuse-id=\""+ data[i].id +"\" onclick=\"refuse(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">拒绝</button>"+
				"</td>"+
				"</tr>";
			}
			$("#kyzr_purseList").html(html);
		})
	}
	//下一页
	function nextPursePage(){
		var html = "";
		//判断下一页到第几页
		if(PursePageNum == PursePage)
			PursePageNum = 1;
		else
			PursePageNum++;
		//点击下一页后注入下一页的帖子
		var startPage,endPage;
		startPage = (PursePageNum-1)*10;
		endPage = startPage + 10;
		if(endPage>PurseNum)
			endPage = PurseNum;
		for(var i=startPage;i<endPage;i++){
			//获取列表并添加到页面内
			html += "<tr>" +
			"<td>"+PursePageList[i].id+"</td>"+
			"<td>"+PursePageList[i].user.name+"</td>"+
			"<td>"+PursePageList[i].user.email+"</td>"+
			"<td>"+PursePageList[i].money+"</td>"+
			"<td>"+PursePageList[i].inMoney+"</td>"+
			"<td>"+PursePageList[i].outMoney+"</td>"+
			"<td>"+PursePageList[i].status+"</td>"+
			"<td>"+
				"<button pass-id=\""+ PursePageList[i].id +"\" onclick=\"pass(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">通过</button>"+
				"<button refuse-id=\""+ PursePageList[i].id +"\" onclick=\"refuse(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">拒绝</button>"+
			"</td>"+
			"</tr>";
		}
		$("#kyzr_purseList").html(html);
	}
	//上一页
	function previousPursePage(){
		var html = "";
		//判断上一页到第几页
		if(PursePageNum == 1)
			PursePageNum = PursePage;
		else
			PursePageNum--;
		//点击下一页后注入下一页的帖子
		var startPage,endPage;
		startPage = (PursePageNum-1)*10;
		endPage = startPage + 10;
		if(endPage>PurseNum)
			endPage = PurseNum;
		for(var i=startPage;i<endPage;i++){
			//获取列表并添加到页面内
			html += "<tr>" +
			"<td>"+PursePageList[i].id+"</td>"+
			"<td>"+PursePageList[i].user.name+"</td>"+
			"<td>"+PursePageList[i].user.email+"</td>"+
			"<td>"+PursePageList[i].money+"</td>"+
			"<td>"+PursePageList[i].inMoney+"</td>"+
			"<td>"+PursePageList[i].outMoney+"</td>"+
			"<td>"+PursePageList[i].status+"</td>"+
			"<td>"+
				"<button pass-id=\""+ PursePageList[i].id +"\" onclick=\"pass(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">通过</button>"+
				"<button refuse-id=\""+ PursePageList[i].id +"\" onclick=\"refuse(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">拒绝</button>"+
			"</td>"+
			"</tr>";
		}
		$("#kyzr_purseList").html(html);
	}
	//模糊搜索，钱包的查询功能
	function searchPurse(){
		var title = $("#searchPurse").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/searchPurseList",
			type: "POST",
			data:{'title':title},
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			success:function(data){
				var html = "";
				var sum;
				PursePageNum = 1;
				PurseNum = data.length;
				PursePage = Math.ceil(data.length/10);
				if(data.length>10)
					sum = 10;
				else
					sum = data.length;
				for(var i=0;i<data.length;i++){
					if(data[i].status == 0)
						data[i].status = "";
					if(data[i].status == 1)
						data[i].status = "请求充值";
					if(data[i].status == 2)
						data[i].status = "请求提现";
					if(data[i].status == 3)
						data[i].status = "同意请求";
					if(data[i].status == 4)
						data[i].status = "拒绝请求";
				}
				PursePageList = data;
				for(var i=0;i<sum;i++){
					//获取列表并添加到页面内
					html += "<tr>" +
					"<td>"+data[i].id+"</td>"+
					"<td>"+data[i].user.name+"</td>"+
					"<td>"+data[i].user.email+"</td>"+
					"<td>"+data[i].money+"</td>"+
					"<td>"+data[i].inMoney+"</td>"+
					"<td>"+data[i].outMoney+"</td>"+
					"<td>"+data[i].status+"</td>"+
					"<td>"+
						"<button pass-id=\""+ data[i].id +"\" onclick=\"pass(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">通过</button>"+
						"<button refuse-id=\""+ data[i].id +"\" onclick=\"refuse(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">拒绝</button>"+
					"</td>"+
					"</tr>";
				}
				$("#kyzr_purseList").html(html);
			}
		});
	}
	//有关于心理咨询师翻页的变量
	var ExpertPage; 
	var ExpertPageNum = 1; 
	var ExpertNum; 
	var ExpertPageList; 
	//读取所有用户申请成为心理咨询师的请求
	function expert(){
		$.post("${pageContext.request.contextPath}/manage/registExpert",function (data){
			var html = "";
			var sum;
			ExpertPageNum = 1;
			ExpertNum = data.length;
			ExpertPage = Math.ceil(data.length/10);
			if(data.length>10)
				sum = 10;
			else
				sum = data.length;
			for(var i=0;i<data.length;i++){
				//修改状态审批名称
				if(data[i].status == 0)
					data[i].status = "未审批";
				if(data[i].status == 1)
					data[i].status = "审批通过";
				if(data[i].status == 2)
					data[i].status = "审批未通过";
			}
			ExpertPageList = data;
			for(var i=0;i<sum;i++){
				//获取列表并添加到页面内
				html += "<tr>" +
				"<td>"+data[i].id+"</td>"+
				"<td>"+data[i].name+"</td>"+
				"<td>"+data[i].introduction+"</td>"+
				"<td>"+"<a target=\"_blank\" style=\"color:black;\" href="+data[i].img+">"+"图片链接"+"</a>"+"</td>"+
				"<td>"+data[i].value+"</td>"+
				"<td>"+data[i].tagOne+"</td>"+
				"<td>"+data[i].tagTwo+"</td>"+
				"<td>"+data[i].tagThree+"</td>"+
				"<td>"+data[i].status+"</td>"+
				"<td>"+
					"<button pass-id=\""+ data[i].id +"\" onclick=\"passRegist(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">通过</button>"+
					"<button refuse-id=\""+ data[i].id +"\" onclick=\"refuseRegist(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">拒绝</button>"+
				"</td>"+
				"</tr>";
			}
			$("#kyzr_registExpertList").html(html);
		})
	}
	//下一页
	function nextExpertPage(){
		var html = "";
		//判断下一页到第几页
		if(ExpertPageNum == ExpertPage)
			ExpertPageNum = 1;
		else
			ExpertPageNum++;
		//点击下一页后注入下一页的帖子
		var startPage,endPage;
		startPage = (ExpertPageNum-1)*10;
		endPage = startPage + 10;
		if(endPage>ExpertNum)
			endPage = ExpertNum;
		for(var i=startPage;i<endPage;i++){		
			//获取列表并添加到页面内
			html += "<tr>" +
			"<td>"+ExpertPageList[i].id+"</td>"+
			"<td>"+ExpertPageList[i].name+"</td>"+
			"<td>"+ExpertPageList[i].introduction+"</td>"+
			"<td>"+"<a target=\"_blank\" style=\"color:black;\" href="+ExpertPageList[i].img+">"+"图片链接"+"</a>"+"</td>"+
			"<td>"+ExpertPageList[i].value+"</td>"+
			"<td>"+ExpertPageList[i].tagOne+"</td>"+
			"<td>"+ExpertPageList[i].tagTwo+"</td>"+
			"<td>"+ExpertPageList[i].tagThree+"</td>"+
			"<td>"+ExpertPageList[i].status+"</td>"+
			"<td>"+
				"<button pass-id=\""+ ExpertPageList[i].id +"\" onclick=\"passRegist(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">通过</button>"+
				"<button refuse-id=\""+ ExpertPageList[i].id +"\" onclick=\"refuseRegist(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">拒绝</button>"+
			"</td>"+
			"</tr>";
		}
		$("#kyzr_registExpertList").html(html);
	}
	//上一页
	function previousExpertPage(){
		var html = "";
		//判断上一页到第几页
		if(ExpertPageNum == 1)
			ExpertPageNum = ExpertPage;
		else
			ExpertPageNum--;
		//点击下一页后注入下一页的帖子
		var startPage,endPage;
		startPage = (ExpertPageNum-1)*10;
		endPage = startPage + 10;
		if(endPage>ExpertNum)
			endPage = ExpertNum;
		for(var i=startPage;i<endPage;i++){
			//获取列表并添加到页面内
			html += "<tr>" +
			"<td>"+ExpertPageList[i].id+"</td>"+
			"<td>"+ExpertPageList[i].name+"</td>"+
			"<td>"+ExpertPageList[i].introduction+"</td>"+
			"<td>"+"<a target=\"_blank\" style=\"color:black;\" href="+ExpertPageList[i].img+">"+"图片链接"+"</a>"+"</td>"+
			"<td>"+ExpertPageList[i].value+"</td>"+
			"<td>"+ExpertPageList[i].tagOne+"</td>"+
			"<td>"+ExpertPageList[i].tagTwo+"</td>"+
			"<td>"+ExpertPageList[i].tagThree+"</td>"+
			"<td>"+ExpertPageList[i].status+"</td>"+
			"<td>"+
				"<button pass-id=\""+ ExpertPageList[i].id +"\" onclick=\"passRegist(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">通过</button>"+
				"<button refuse-id=\""+ ExpertPageList[i].id +"\" onclick=\"refuseRegist(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">拒绝</button>"+
			"</td>"+
			"</tr>";
		}
		$("#kyzr_registExpertList").html(html);
	}
	//模糊搜索心理咨询师审批
	function searchExpert(){
		var title = $("#searchExpert").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/searchExpertList",
			type: "POST",
			data:{'title':title},
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			success:function(data){
				var html = "";
				var sum;
				ExpertPageNum = 1;
				ExpertNum = data.length;
				ExpertPage = Math.ceil(data.length/10);
				if(data.length>10)
					sum = 10;
				else
					sum = data.length;
				for(var i=0;i<data.length;i++){
					//修改状态审批名称
					if(data[i].status == 0)
						data[i].status = "未审批";
					if(data[i].status == 1)
						data[i].status = "审批通过";
					if(data[i].status == 2)
						data[i].status = "审批未通过";
				}
				ExpertPageList = data;
				for(var i=0;i<sum;i++){
					//获取列表并添加到页面内
					html += "<tr>" +
					"<td>"+data[i].id+"</td>"+
					"<td>"+data[i].name+"</td>"+
					"<td>"+data[i].introduction+"</td>"+
					"<td>"+"<a target=\"_blank\" style=\"color:black;\" href="+data[i].img+">"+"图片链接"+"</a>"+"</td>"+
					"<td>"+data[i].value+"</td>"+
					"<td>"+data[i].tagOne+"</td>"+
					"<td>"+data[i].tagTwo+"</td>"+
					"<td>"+data[i].tagThree+"</td>"+
					"<td>"+data[i].status+"</td>"+
					"<td>"+
						"<button pass-id=\""+ data[i].id +"\" onclick=\"passRegist(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">通过</button>"+
						"<button refuse-id=\""+ data[i].id +"\" onclick=\"refuseRegist(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">拒绝</button>"+
					"</td>"+
					"</tr>";
				}
				$("#kyzr_registExpertList").html(html);
			}
		});
	}
	//有关于用户管理翻页的变量
	var UserPage; 
	var UserPageNum = 1; 
	var UserNum; 
	var UserPageList; 
	//读取“用户信息管理”内的所有用户信息
	function user(){
		$.post("${pageContext.request.contextPath}/manage/user",function (data){
			var html = "";
			var sum;
			UserPageNum = 1;
			UserNum = data.length;
			UserPage = Math.ceil(data.length/10);
			if(data.length>10)
				sum = 10;
			else
				sum = data.length;
			for(var i=0;i<data.length;i++){
				//修改状态名称
				if(data[i].status == 0)
					data[i].status = "普通用户";
				if(data[i].status == 1)
					data[i].status = "心理咨询师";
				if(data[i].status == 2)
					data[i].status = "管理员";
			}
			UserPageList = data;
			for(var i=0;i<sum;i++){
				//获取列表并添加到页面内
				html += "<tr>" +
				"<td>"+data[i].id+"</td>"+
				"<td>"+data[i].account+"</td>"+
				"<td>"+data[i].name+"</td>"+
				"<td>"+data[i].sex+"</td>"+
				"<td>"+data[i].email+"</td>"+
				"<td>"+data[i].phone+"</td>"+
				"<td>"+data[i].createAt+"</td>"+
				"<td>"+data[i].status+"</td>"+
				"<td>"+
					"<button change-id=\""+ data[i].id +"\" onclick=\"editUser(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">编辑</button>"+
					"<button delete-id=\""+ data[i].id +"\" onclick=\"deleteUser(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">删除</button>"+
				"</td>"+
				"</tr>";
			}
			$("#kyzr_userList").html(html);
		})
	}
	//下一页
	function nextUserPage(){
		var html = "";
		//判断下一页到第几页
		if(UserPageNum == UserPage)
			UserPageNum = 1;
		else
			UserPageNum++;
		//点击下一页后注入下一页的帖子
		var startPage,endPage;
		startPage = (UserPageNum-1)*10;
		endPage = startPage + 10;
		if(endPage>UserNum)
			endPage = UserNum;
		for(var i=startPage;i<endPage;i++){	
			//获取列表并添加到页面内
			html += "<tr>" +
			"<td>"+UserPageList[i].id+"</td>"+
			"<td>"+UserPageList[i].account+"</td>"+
			"<td>"+UserPageList[i].name+"</td>"+
			"<td>"+UserPageList[i].sex+"</td>"+
			"<td>"+UserPageList[i].email+"</td>"+
			"<td>"+UserPageList[i].phone+"</td>"+
			"<td>"+UserPageList[i].createAt+"</td>"+
			"<td>"+UserPageList[i].status+"</td>"+
			"<td>"+
				"<button change-id=\""+ UserPageList[i].id +"\" onclick=\"editUser(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">编辑</button>"+
				"<button delete-id=\""+ UserPageList[i].id +"\" onclick=\"deleteUser(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">删除</button>"+
			"</td>"+
			"</tr>";
		}
		$("#kyzr_userList").html(html);
	}
	//上一页
	function previousUserPage(){
		var html = "";
		//判断上一页到第几页
		if(UserPageNum == 1)
			UserPageNum = UserPage;
		else
			UserPageNum--;
		//点击下一页后注入下一页的帖子
		var startPage,endPage;
		startPage = (UserPageNum-1)*10;
		endPage = startPage + 10;
		if(endPage>UserNum)
			endPage = UserNum;
		for(var i=startPage;i<endPage;i++){
			//获取列表并添加到页面内
			html += "<tr>" +
			"<td>"+UserPageList[i].id+"</td>"+
			"<td>"+UserPageList[i].account+"</td>"+
			"<td>"+UserPageList[i].name+"</td>"+
			"<td>"+UserPageList[i].sex+"</td>"+
			"<td>"+UserPageList[i].email+"</td>"+
			"<td>"+UserPageList[i].phone+"</td>"+
			"<td>"+UserPageList[i].createAt+"</td>"+
			"<td>"+UserPageList[i].status+"</td>"+
			"<td>"+
				"<button change-id=\""+ UserPageList[i].id +"\" onclick=\"editUser(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">编辑</button>"+
				"<button delete-id=\""+ UserPageList[i].id +"\" onclick=\"deleteUser(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">删除</button>"+
			"</td>"+
			"</tr>";
		}
		$("#kyzr_userList").html(html);
	}
	//用户信息管理的搜索功能
	function searchUser(){
		var title = $("#searchUser").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/searchUserList",
			type: "POST",
			data:{'title':title},
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			success:function(data){
				var html = "";
				var sum;
				UserPageNum = 1;
				UserNum = data.length;
				UserPage = Math.ceil(data.length/10);
				if(data.length>10)
					sum = 10;
				else
					sum = data.length;
				for(var i=0;i<data.length;i++){
					//修改状态名称
					if(data[i].status == 0)
						data[i].status = "普通用户";
					if(data[i].status == 1)
						data[i].status = "心理咨询师";
					if(data[i].status == 2)
						data[i].status = "管理员";
				}
				UserPageList = data;
				for(var i=0;i<sum;i++){
					//获取列表并添加到页面内
					html += "<tr>" +
					"<td>"+data[i].id+"</td>"+
					"<td>"+data[i].account+"</td>"+
					"<td>"+data[i].name+"</td>"+
					"<td>"+data[i].sex+"</td>"+
					"<td>"+data[i].email+"</td>"+
					"<td>"+data[i].phone+"</td>"+
					"<td>"+data[i].createAt+"</td>"+
					"<td>"+data[i].status+"</td>"+
					"<td>"+
						"<button change-id=\""+ data[i].id +"\" onclick=\"editUser(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">编辑</button>"+
						"<button delete-id=\""+ data[i].id +"\" onclick=\"deleteUser(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">删除</button>"+
					"</td>"+
					"</tr>";
				}
				$("#kyzr_userList").html(html);
			}
		});
	}
	//读取所有课程的信息
	//有关于课程的变量
	var CoursePage; //课程的总页数
	var CoursePageNum = 1; //课程的当前页数
	var CourseNum; //总课程或者查找到的课程的数量
	var CoursePageList; //存放所有课程或查找到的课程的集合
	//课程管理，显示所有课程的列表
	function course(){
		$.post("${pageContext.request.contextPath}/manage/courseList",function (data){
			var html = "";
			var sum;
			CoursePageNum = 1;
			CourseNum = data.length;
			CoursePage = Math.ceil(data.length/10);
			if(data.length>10)
				sum = 10;
			else
				sum = data.length;
			//调整价格
			for(var i=0;i<data.length;i++){
				//价格方面的调整
				if(data[i].price == 0)
					data[i].price = "免费";
				else
					data[i].price = "￥" + data[i].price;
			}
			CoursePageList = data;
			for(var i=0;i<sum;i++){
				//获取列表并添加到页面内
				html += "<tr>" +
				"<td>"+data[i].id+"</td>"+
				"<td>"+data[i].title+"</td>"+
				"<td>"+"<a target=\"_blank\" style=\"color:black;\" href="+data[i].img+">"+"封面链接"+"</a>"+"</td>"+
				"<td>"+data[i].createAt+"</td>"+
				"<td>"+data[i].price+"</td>"+
				"<td>"+
					"<a href=\"../jsp/user/courseVideo.jsp\" target=\"_blank\" get-id=\""+ data[i].id +"\" onclick=\"getCourse(this)\" style=\"margin-right:10px;\" class=\"btn btn-info\">查看</a>"+
					"<button change-id=\""+ data[i].id +"\" onclick=\"changeCourse(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">编辑</button>"+
					"<button delete-id=\""+ data[i].id +"\" onclick=\"deleteCourse(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">删除</button>"+
				"</td>"+
				"</tr>";
			}
			$("#kyzr_courseList").html(html);
		})
	}
	//下一页课程
	//文章翻页，下一页
	function nextCoursePage(){
		var html = "";
		//判断下一页到第几页
		if(CoursePageNum == CoursePage)
			CoursePageNum = 1;
		else
			CoursePageNum++;
		//点击下一页后注入下一页的帖子
		var startPage,endPage;
		startPage = (CoursePageNum-1)*10;
		endPage = startPage + 10;
		if(endPage>CourseNum)
			endPage = CourseNum;
		for(var i=startPage;i<endPage;i++){		
			//获取列表并添加到页面内
			html += "<tr>" +
			"<td>"+CoursePageList[i].id+"</td>"+
			"<td>"+CoursePageList[i].title+"</td>"+
			"<td>"+"<a target=\"_blank\" style=\"color:black;\" href="+CoursePageList[i].img+">"+"封面链接"+"</a>"+"</td>"+
			"<td>"+CoursePageList[i].createAt+"</td>"+
			"<td>"+CoursePageList[i].price+"</td>"+
			"<td>"+
				"<a href=\"../jsp/user/courseVideo.jsp\" target=\"_blank\" get-id=\""+ CoursePageList[i].id +"\" onclick=\"getCourse(this)\" style=\"margin-right:10px;\" class=\"btn btn-info\">查看</a>"+
				"<button change-id=\""+ CoursePageList[i].id +"\" onclick=\"changeCourse(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">编辑</button>"+
				"<button delete-id=\""+ CoursePageList[i].id +"\" onclick=\"deleteCourse(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">删除</button>"+
			"</td>"+
			"</tr>";
		}
		$("#kyzr_courseList").html(html);
	}
	//课程翻页，上一页
	function previousCoursePage(){
		var html = "";
		//判断上一页到第几页
		if(CoursePageNum == 1)
			CoursePageNum = CoursePage;
		else
			CoursePageNum--;
		//点击下一页后注入下一页的帖子
		var startPage,endPage;
		startPage = (CoursePageNum-1)*10;
		endPage = startPage + 10;
		if(endPage>CourseNum)
			endPage = CourseNum;
		for(var i=startPage;i<endPage;i++){
			//获取列表并添加到页面内
			html += "<tr>" +
			"<td>"+CoursePageList[i].id+"</td>"+
			"<td>"+CoursePageList[i].title+"</td>"+
			"<td>"+"<a target=\"_blank\" style=\"color:black;\" href="+CoursePageList[i].img+">"+"封面链接"+"</a>"+"</td>"+
			"<td>"+CoursePageList[i].createAt+"</td>"+
			"<td>"+CoursePageList[i].price+"</td>"+
			"<td>"+
				"<a href=\"../jsp/user/courseVideo.jsp\" target=\"_blank\" get-id=\""+ CoursePageList[i].id +"\" onclick=\"getCourse(this)\" style=\"margin-right:10px;\" class=\"btn btn-info\">查看</a>"+
				"<button change-id=\""+ CoursePageList[i].id +"\" onclick=\"changeCourse(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">编辑</button>"+
				"<button delete-id=\""+ CoursePageList[i].id +"\" onclick=\"deleteCourse(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">删除</button>"+
			"</td>"+
			"</tr>";
		}
		$("#kyzr_courseList").html(html);
	}
	//课程列表的模糊查询
	function searchCourse(){
		var title = $("#searchCourse").val();
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/searchCourseList",
			type: "POST",
			data:{'title':title},
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			success:function(data){
				var html = "";
				var sum;
				CoursePageNum = 1;
				CourseNum = data.length;
				CoursePage = Math.ceil(data.length/10);
				if(data.length>10)
					sum = 10;
				else
					sum = data.length;
				//调整价格
				for(var i=0;i<data.length;i++){
					//价格方面的调整
					if(data[i].price == 0)
						data[i].price = "免费";
					else
						data[i].price = "￥" + data[i].price;
				}
				CoursePageList = data;
				for(var i=0;i<sum;i++){
					//获取列表并添加到页面内
					html += "<tr>" +
					"<td>"+data[i].id+"</td>"+
					"<td>"+data[i].title+"</td>"+
					"<td>"+"<a target=\"_blank\" style=\"color:black;\" href="+data[i].img+">"+"封面链接"+"</a>"+"</td>"+
					"<td>"+data[i].createAt+"</td>"+
					"<td>"+data[i].price+"</td>"+
					"<td>"+
						"<a href=\"../jsp/user/courseVideo.jsp\" target=\"_blank\" get-id=\""+ data[i].id +"\" onclick=\"getCourse(this)\" style=\"margin-right:10px;\" class=\"btn btn-info\">查看</a>"+
						"<button change-id=\""+ data[i].id +"\" onclick=\"changeCourse(this)\" style=\"margin-right:10px;\" class=\"btn btn-success\">编辑</button>"+
						"<button delete-id=\""+ data[i].id +"\" onclick=\"deleteCourse(this)\" style=\"margin-right:10px;\" class=\"btn btn-danger\">删除</button>"+
					"</td>"+
					"</tr>";
				}
				$("#kyzr_courseList").html(html);
			}
		});
	}
	//启动页面时判断是否登录
	 window.onload=function(){
		//alert(myName);
		if(myName!=""){
			//上方
			$("#navLogin").css("display","none");
			$("#navRegister").css("display","none");
			$("#navLogout").css("display","block");
		}
		//读取所有用户信息
		user();
		//读取所有用户的钱包信息
		purse();
		//读取所有课程信息
		course();
		//读取所有首页文章的信息
		passage();
		//读取所有用户申请成为心理咨询师的请求
		expert();
		//读取时间
		getNowDate();
		//统计分析获取数据
		tj();
	 }
	//点击用户信息管理后
	function yhxxgl(){
		document.getElementById("kyzr_yhxxgl").setAttribute("class","btn btn-default kyzr_btn kyzr_active");
		document.getElementById("kyzr_qbgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_kcgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_sywzgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_xlzxssp").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_tjfx").setAttribute("class","btn btn-default kyzr_btn kyzr_lastbtn");
		//如果没登录，点按钮也不显示内容
		if(myName!=""){
			$("#yhxxgl").css("display","block");
			$("#qbgl").css("display","none");
			$("#kcgl").css("display","none");
			$("#sywzgl").css("display","none");
			$("#xlzxssp").css("display","none");
			$("#tjfx").css("display","none");
		}
	}
	//点击钱包管理后
	function qbgl(){
		document.getElementById("kyzr_yhxxgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_qbgl").setAttribute("class","btn btn-default kyzr_btn kyzr_active");
		document.getElementById("kyzr_kcgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_sywzgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_xlzxssp").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_tjfx").setAttribute("class","btn btn-default kyzr_btn kyzr_lastbtn");
		//如果没登录，点按钮也不显示内容
		if(myName!=""){
			$("#yhxxgl").css("display","none");
			$("#qbgl").css("display","block");
			$("#kcgl").css("display","none");
			$("#sywzgl").css("display","none");
			$("#xlzxssp").css("display","none");
			$("#tjfx").css("display","none");
		}
	}
	//点击课程管理
	function kcgl(){
		document.getElementById("kyzr_yhxxgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_qbgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_kcgl").setAttribute("class","btn btn-default kyzr_btn kyzr_active");
		document.getElementById("kyzr_sywzgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_xlzxssp").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_tjfx").setAttribute("class","btn btn-default kyzr_btn kyzr_lastbtn");
		//如果没登录，点按钮也不显示内容
		if(myName!=""){
			$("#yhxxgl").css("display","none");
			$("#qbgl").css("display","none");
			$("#kcgl").css("display","block");
			$("#sywzgl").css("display","none");
			$("#xlzxssp").css("display","none");
			$("#tjfx").css("display","none");
		}
	}
	//首页文章管理
	function sywzgl(){
		document.getElementById("kyzr_yhxxgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_qbgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_kcgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_sywzgl").setAttribute("class","btn btn-default kyzr_btn kyzr_active");
		document.getElementById("kyzr_xlzxssp").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_tjfx").setAttribute("class","btn btn-default kyzr_btn kyzr_lastbtn");
		//如果没登录，点按钮也不显示内容
		if(myName!=""){
			$("#yhxxgl").css("display","none");
			$("#qbgl").css("display","none");
			$("#kcgl").css("display","none");
			$("#sywzgl").css("display","block");
			$("#xlzxssp").css("display","none");
			$("#tjfx").css("display","none");
		}
	}
	//心理咨询师审批
	function xlzxssp(){
		document.getElementById("kyzr_yhxxgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_qbgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_kcgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_sywzgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_xlzxssp").setAttribute("class","btn btn-default kyzr_btn kyzr_active");
		document.getElementById("kyzr_tjfx").setAttribute("class","btn btn-default kyzr_btn kyzr_lastbtn");
		//如果没登录，点按钮也不显示内容
		if(myName!=""){
			$("#yhxxgl").css("display","none");
			$("#qbgl").css("display","none");
			$("#kcgl").css("display","none");
			$("#sywzgl").css("display","none");
			$("#xlzxssp").css("display","block");
			$("#tjfx").css("display","none");
		}
	}
	//统计分析
	function tjfx(){
		document.getElementById("kyzr_yhxxgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_qbgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_kcgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_sywzgl").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_xlzxssp").setAttribute("class","btn btn-default kyzr_btn");
		document.getElementById("kyzr_tjfx").setAttribute("class","btn btn-default kyzr_btn kyzr_active kyzr_lastbtn");
		//如果没登录，点按钮也不显示内容
		if(myName!=""){
			$("#yhxxgl").css("display","none");
			$("#qbgl").css("display","none");
			$("#kcgl").css("display","none");
			$("#sywzgl").css("display","none");
			$("#xlzxssp").css("display","none");
			$("#tjfx").css("display","block");
		}
	}
	//钱包按钮绑定的函数
	function pass(obj){
		var passId = $(obj).attr("pass-id");
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/pass/"+passId,
			data:{'passId':passId},
			success:function(){
				alert("成功通过用户的请求！");
				purse();
			},
			error:function(){
				alert("通过失败，用户不存在该请求！");
			}
		});
	}
	//钱包按钮绑定的函数
	function refuse(obj){
		var refuseId = $(obj).attr("refuse-id");
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/refuse/"+refuseId,
			data:{'refuseId':refuseId},
			success:function(){
				alert("成功拒绝用户的请求！");
				purse();
			},
			error:function(){
				alert("拒绝用户的请求失败，用户不存在该请求！");
			}
		});
	}
	//心理咨询师审批 之 通过按钮
	function passRegist(obj){
		//获取操作行
		var passId = $(obj).attr("pass-id");
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/passRegist/"+passId,
			data:{'passId':passId},
			success:function(){
				alert("成功通过用户的请求！");
				expert();
			},
			error:function(){
				alert("通过失败，该请求已经审批过了！");
			}
		});
	}
	//心理咨询师审批 之 拒绝按钮
	function refuseRegist(obj){
		//获取操作行
		var refuseId = $(obj).attr("refuse-id");
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/refuseRegist/"+refuseId,
			data:{'refuseId':refuseId},
			success:function(){
				alert("成功拒绝用户的请求！");
				expert();
			},
			error:function(){
				alert("审批失败，该请求已经审批过了！");
			}
		});
	}
	//首页文章管理中的 查看按钮
	function getPassage(obj){
		var id = $(obj).attr("get-id");
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/getPassage/"+id,
			data:{'id':id},
			success:function(){
				
			}
		});
	}
	//首页文章管理中的 编辑按钮
	function changePassage(obj){
		//拿对应一条数据passage的id
		var id = $(obj).attr("change-id");
		//反馈给用户该条passage的数据
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/changePassage/"+id,
			data:{'id':id},
			success:function(data){
				//在弹窗表单内先注入数据
				$("#passageId").prop("value",data.id);
				$("#passageTitle").prop("value",data.title);
				$("#passageImg").prop("value",data.img);
				$("#passageStatus").prop("value",data.status);
				//判断文章状态，给文章赋值
				$("#passageSelect").prop("value",data.status);
				$("#passageCreateAt").prop("value",data.createAt);
				$("#passageContent").prop("value",data.article);
				//给弹窗内的“修改按钮”注入一个属性，以确保修改的是当前数据的值
				$("#changePassageBtn").attr("change-id",data.id);
			}
		})
		//显示弹窗
		$(".kyzr_darkPassage").css("display","block");
	}
	//点开首页文章管理中的编辑按钮后  点×关闭
	function closeEditPassage(){
		$(".kyzr_darkPassage").css("display","none");
	}
	//点开首页文章管理中的编辑后 输入完整数据后 点击最下方的“提交修改按钮”
	function submitChangePassage(obj){
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/submitChangePassage",
			type: "POST",
			data:$("#changePassageForm").serialize(),
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			success:function(data){
				alert("当前文章修改成功！");
				passage();
				$(".kyzr_darkPassage").css("display","none");
			}
		})
	}
	//点击首页文章管理中的删除按钮后执行的函数deletePassage()
	function deletePassage(obj){
		var id = $(obj).attr("delete-id");
		if(confirm("确定要删除吗?")==true){
			$.ajax({
				url:"${pageContext.request.contextPath}/manage/deletePassage/"+id,
				data:{'id':id},
				success:function(data){
					alert("删除成功！");
					passage();
				}
			})
		}
	}
	//查看指定id的course
	function getCourse(obj){
		var id = $(obj).attr("get-id");
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/getCourse/"+id,
			data:{'id':id},
			success:function(){
				
			}
		})
	}
	//点击“课程管理内的”按钮“编辑”
	function changeCourse(obj){
		var id = $(obj).attr("change-id");
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/changeCourse/"+id,
			data:{'id':id},
			success:function(data){
				//在弹窗表单内先注入数据
				$("#courseId").prop("value",data.id);
				$("#courseTitle").prop("value",data.title);
				$("#coursePrice").prop("value",data.price);
				$("#courseImg").prop("value",data.img);
				$("#courseCreateAt").prop("value",data.createAt);
				$("#courseURL").prop("value",data.courseURL);
				//显示弹窗
				$(".kyzr_darkCourse").css("display","block");
			}
		})
	}
	//点击课程管理“编辑”按钮后，点×关闭弹窗
	function closeEditCourse(){
		$(".kyzr_darkCourse").css("display","none");
	}
	//编辑课程完成后，点击“提交修改”按钮
	function submitChangeCourse(obj){
		var id = $(obj).attr("change-id");
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/submitChangeCourse",
			type: "POST",
			data:$("#changeCourseForm").serialize(),
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			success:function(data){
				alert("当前文章修改成功！");
				course();
				$(".kyzr_darkCourse").css("display","none");
			}
		})
	}
	//点击课程管理内的“删除”按钮
	function deleteCourse(obj){
		var id = $(obj).attr("delete-id");
		if(confirm("确定要删除吗?")==true){
			$.ajax({
				url:"${pageContext.request.contextPath}/manage/deleteCourse/"+id,
				data:{'id':id},
				success:function(data){
					alert("删除成功！");
					course();
				}
			})
		}
	}
	//添加文章
	function addPassage(){
		$(".kyzr_darkAddPassage").css("display","block");
	}
	//关闭添加文章弹出页面
	function closeAddPassage(){
		$(".kyzr_darkAddPassage").css("display","none");
	}
	//点击添加文章内部的“确认添加”按钮
	function submitAddPassage(){
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/submitAddPassage",
			type: "POST",
			data:$("#addPassageForm").serialize(),
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			success:function(data){
				alert("当前文章添加成功！");
				passage();
				$(".kyzr_darkAddPassage").css("display","none");
			},
			error:function(){
				alert("添加失败!");
			}
		})
	}
	//添加课程
	function addCourse(){
		$(".kyzr_darkAddCourse").css("display","block");
	}
	//关闭添加课程的弹窗
	function closeAddCourse(){
		$(".kyzr_darkAddCourse").css("display","none");
	}
	//点击提交添加，确认添加课程
	function submitaddCourse(){
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/submitAddCourse",
			type: "POST",
			data:$("#addCourseForm").serialize(),
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			success:function(data){
				alert("当前课程添加成功！");
				course();
				$(".kyzr_darkAddCourse").css("display","none");
			},
			error:function(){
				alert("添加失败!");
			}
		})
	}
	//删除用户
	function deleteUser(obj){
		var id = $(obj).attr("delete-id");
		if(confirm("确定要删除吗?")==true){
			$.ajax({
				url:"${pageContext.request.contextPath}/manage/deleteUser",
				type: "POST",
				data:{'id':id},
				contentType:"application/x-www-form-urlencoded; charset=UTF-8",
				success:function(data){
					alert("删除成功！");
					user();
					purse();
				},
				error:function(){
					alert("删除失败!");
				}
			})
		}
	}
	//编辑用户
	function editUser(obj){
		var id = $(obj).attr("change-id");
		//将弹窗的display设置为block，然后用prop注入数据
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/getUser",
			type: "POST",
			data:{'id':id},
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			success:function(data){
				//需要更改的有两项：性别、身份
				//身份
				if(data.status == 0)
					data.status = "普通用户";
				if(data.status == 1)
					data.status = "心理咨询师";
				if(data.status == 2)
					data.status = "管理员";
				//性别
				if(data.sex == "男")
					data.sex = 1;
				if(data.sex == "女")
					data.sex = 0;
				$(".kyzr_darkUser").css("display","block");
				$("#userId").prop("value",data.id);
				$("#userAccount").prop("value",data.account);
				$("#userName").prop("value",data.name);
				$("#userSex").prop("value",data.sex);
				$("#userEmail").prop("value",data.email);
				$("#userPhone").prop("value",data.phone);
				$("#userCreateAt").prop("value",data.createAt);
				$("#userStatus").prop("value",data.status);
			}
		})
	}
	//关闭编辑弹窗
	function closeEditUser(){
		$(".kyzr_darkUser").css("display","none");
	}
	//点击编辑弹窗内部的提交修改按钮
	function submitChangeUser(){
		$.ajax({
			url:"${pageContext.request.contextPath}/manage/submitEditUser",
			type: "POST",
			data:$("#changeUserForm").serialize(),
			contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			success:function(data){
				alert("修改成功！");
				user();
				closeEditUser();
			}
		});
	}
	//获取当前时间
	function getNowDate() {
		var date = new Date();
		var year = date.getFullYear() // 年
		var month = date.getMonth() + 1; // 月
		var day  = date.getDate(); // 日
		var hour = date.getHours(); // 时
		var minutes = date.getMinutes(); // 分
		var seconds = date.getSeconds() //秒
		var weekArr = ['星期日','星期一', '星期二', '星期三', '星期四', '星期五', '星期六' ];
		var week = weekArr[date.getDay()];
		// 给一位数数据前面加 “0”
		if (month >= 1 && month <= 9) {
		 month = "0" + month;
		}
		if (day >= 0 && day <= 9) {
		 day = "0" + day;
		}
		if (hour >= 0 && hour <= 9) {
		 hour = "0" + hour;
		}
		if (minutes >= 0 && minutes <= 9) {
		 minutes = "0" + minutes;
		}
		if (seconds >= 0 && seconds <= 9) {
		 seconds = "0" + seconds;
		}
		document.getElementById("timeInfo").innerHTML = year + "年" + month + "月" + day + "日" + " " + week;
	}
	//统计分析的所有函数整理
	function tj(){
		userNum();
		sexPercent();
		expertNum();
		adminNum();
		answerNum();
		commentNum();
		passageNum();
		courseNum();
		scoreNum1();
		scoreNum2();
		scoreNum3();
		scoreNum4();
	}
	//用户数量
	function userNum(){
		$.post("${pageContext.request.contextPath}/manage/userNum",function (data){
			var html = data+"人";
			$("#userNum").html(html);
		})
	}
	//男女比例
	function sexPercent(){
		$.ajax({
			url:"${pageContext.request.contextPath}/user/getNumberBySex",
			success:function(data){
				var boy = parseInt(data[0]);
				var girl = parseInt(data[1]);
				$("#sexPercent").html(boy+":"+girl);
			}
		});
	}
	//心理咨询师数量
	function expertNum(){
		$.post("${pageContext.request.contextPath}/user/expertNum",function (data){
			var html = data+"人";
			$("#expertNum").html(html);
		})
	}
	//管理员数量
	function adminNum(){
		$.post("${pageContext.request.contextPath}/user/adminNum",function (data){
			var html = data+"人";
			$("#adminNum").html(html);
		})
	}
	//帖子数量
	function answerNum(){
		$.post("${pageContext.request.contextPath}/answer/answerNum",function (data){
			var html = data+"个";
			$("#answerNum").html(html);
		})
	}
	//评论数量
	function commentNum(){
		$.post("${pageContext.request.contextPath}/answer/commentNum",function (data){
			var html = data+"个";
			$("#commentNum").html(html);
		})
	}
	//首页文章数量
	function passageNum(){
		$.post("${pageContext.request.contextPath}/index/passageNum",function (data){
			var html = data+"个";
			$("#passageNum").html(html);
		})
	}
	//课程数量
	function courseNum(){
		$.post("${pageContext.request.contextPath}/user/courseNum",function (data){
			var html = data+"个";
			$("#courseNum").html(html);
		})
	}
	//每个测评题目做过的次数
	function scoreNum1(){
		$.ajax({
			url:"${pageContext.request.contextPath}/psyTest/scoreNum",
			data:{'title_id':1},
			success:function(data){
				var html = data+"次";
				$("#scoreNum1").html(html);
			}
		});
	}
	function scoreNum2(){
		$.ajax({
			url:"${pageContext.request.contextPath}/psyTest/scoreNum",
			data:{'title_id':2},
			success:function(data){
				var html = data+"次";
				$("#scoreNum2").html(html);
			}
		});
	}
	function scoreNum3(){
		$.ajax({
			url:"${pageContext.request.contextPath}/psyTest/scoreNum",
			data:{'title_id':3},
			success:function(data){
				var html = data+"次";
				$("#scoreNum3").html(html);
			}
		});
	}
	function scoreNum4(){
		$.ajax({
			url:"${pageContext.request.contextPath}/psyTest/scoreNum",
			data:{'title_id':4},
			success:function(data){
				var html = data+"次";
				$("#scoreNum4").html(html);
			}
		});
	}
</script>
</head>
<body>


<!-- 用户名：
<input type="text" id="txtName" onblur="a1()" />
<hr />
<input type="button" value="获取数据" id="btn" />
<table width="80%">
	<tr>
		<td>名字</td>
		<td>性别</td>
	</tr>
	<tbody id="content">
		
	</tbody>
</table> -->
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
	<div class="kyzr_container">
		<!-- 白色区域 -->
		<div class="kyzr_content">
			<!-- 内部左侧 -->
			<div class="kyzr_left">
				<div class="kyzr_photo">
					<img id="kyzr_myPhoto" src="http://nickyzj.run:12450/lychee/uploads/big/b7305635955c05903ad39ff85c804059.jpg"/>
				</div>
				<div class="kyzr_name">King_FLYz</div>
				<div class="kyzr_gnlist">
					<button onclick="yhxxgl()" id="kyzr_yhxxgl" class="btn btn-default kyzr_btn kyzr_active">用户信息管理</button>
					<button onclick="qbgl()" id="kyzr_qbgl" class="btn btn-default kyzr_btn">钱包管理</button>
					<button onclick="kcgl()" id="kyzr_kcgl" class="btn btn-default kyzr_btn">课程管理</button>
					<button onclick="sywzgl()" id="kyzr_sywzgl" class="btn btn-default kyzr_btn">首页文章管理</button>
					<button onclick="xlzxssp()" id="kyzr_xlzxssp" class="btn btn-default kyzr_btn">心理咨询师审批</button>
					<button onclick="tjfx()" id="kyzr_tjfx" class="btn btn-default kyzr_lastbtn">统计分析</button>
				</div>
			</div>
			<!-- 内部右侧 -->
			<div class="kyzr_right">
				<!-- 右侧的大白色区域 -->
				<div class="kyzr_alllist">
					<!-- 用户信息管理 -->
					<div id="yhxxgl">
						<!-- 用户信息管理顶部内容：搜索 -->
						<div class="kyzr_topUser">
							<!-- 通过人名搜索请求-->
							<div class="kyzr_userSearch input-group col-md-3" style="z-index:0;margin-top:0px;position:relative">
								<input type="text" id="searchUser" class="form-control" placeholder="请输入想要搜索的姓名" style="height:34px;top:0px;" >
								<span class="input-group-btn">
									<button type="button" onclick="searchUser()" class="btn btn-info btn-search">搜索</button>
								</span>
							</div>
						</div>
						<table style="position:relative;width:95%;" class="table table-striped">
							<tr>
								<td>ID</td>
								<td>账号</td>
								<td>姓名</td>
								<td>性别</td>
								<td>邮箱</td>
								<td>联系方式</td>
								<td>创建时间</td>
								<td>身份</td>
								<td>操作</td>
							</tr>
							<tbody id="kyzr_userList">
								
							</tbody>
						</table>
						<div class= "kyzr_changeUserPage">
							<ul class="pager">
								<!-- 为a标签的href设置href="javascript:void(0)"，使得点击a标签不刷新页面 -->
								<li class=""><a href="javascript:void(0)" onclick="previousUserPage()" style="color:black;">上一页</a></li>
								<li class=""><a href="javascript:void(0)" onclick="nextUserPage()" style="color:black;">下一页</a></li>
							</ul>
						</div>
						<!-- 点击用户信息管理内部的编辑按钮后弹出的页面 -->
						<div class="kyzr_darkUser">
							<!-- 白色弹窗 -->
							<div class="kyzr_whiteUser">
								<!-- × -->
								<div class="kyzr_chaUser">
									<button onclick="closeEditUser()" class="kyzr_chaUserBtn">×</button>
								</div>
								<!-- “编辑”表单 -->
								<div class="changeUser_form">
									<form class="form-horizontal" action="" id="changeUserForm">
										<div class="form-group" style="display:none;">
										    <label for="userId" class="col-sm-2 control-label">ID</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="id" id="userId" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="userAccount" class="col-sm-2 control-label">账号</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="account" id="userAccount" type="text" disabled>
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="userName" class="col-sm-2 control-label">姓名</label>
										    <div class="col-sm-10">
										      <input class="form-control" onblur="" name="name" id="userName" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="userSex" class="col-sm-2 control-label">性别</label>
										    <div class="col-sm-10">
										      <select class="form-control" name="sex" id="userSex" style="font-size:13px;">
										      	<option value="1">男</option>
										      	<option value="0">女</option>
										      </select>
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="userEmail" class="col-sm-2 control-label">邮箱</label>
										    <div class="col-sm-10">
										      <input class="form-control" onblur="" name="email" id="userEmail" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="userPhone" class="col-sm-2 control-label">联系方式</label>
										    <div class="col-sm-10">
										      <input class="form-control" onblur="" name="phone" id="userPhone" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="userCreateAt" class="col-sm-2 control-label">创建时间</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="createAt" id="userCreateAt" type="text" disabled>
										    </div>
									    </div>
									   <div class="form-group">
										    <label for="userStatus" class="col-sm-2 control-label">身份</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="status" id="userStatus" type="text" disabled>
										    </div>
									    </div>
										<div class="form-group">
										    <div class="col-sm-offset-2 col-sm-10">
										      <button type="button" id="changePassageBtn" onclick="submitChangeUser()" class="btn btn-default">提交修改</button>
										    </div>
										</div>
									</form>
								</div>

							</div>
						</div>
					</div>
					<!-- 钱包管理 -->
					<div id="qbgl" style="display:none;">
						<!-- 钱包管理顶部内容：搜索 -->
						<div class="kyzr_topPurse">
							<!-- 通过人名搜索请求-->
							<div class="kyzr_purseSearch input-group col-md-3" style="z-index:0;margin-top:0px;position:relative">
								<input type="text" id="searchPurse" class="form-control" placeholder="请输入想要搜索的姓名" style="height:34px;top:0px;" >
								<span class="input-group-btn">
									<button type="button" onclick="searchPurse()" class="btn btn-info btn-search">搜索</button>
								</span>
							</div>
						</div>
						<table style="position:relative;width:95%;" class="table table-striped">
							<tr>
								<td>ID</td>
								<td>姓名</td>
								<td>邮箱</td>
								<td>钱包余额</td>
								<td>充值金额</td>
								<td>提现金额</td>
								<td>执行状态</td>
								<td>操作</td>
							</tr>
							<tbody id="kyzr_purseList">
								
							</tbody>
						</table>
						<div class= "kyzr_changePursePage">
							<ul class="pager">
								<!-- 为a标签的href设置href="javascript:void(0)"，使得点击a标签不刷新页面 -->
								<li class=""><a href="javascript:void(0)" onclick="previousPursePage()" style="color:black;">上一页</a></li>
								<li class=""><a href="javascript:void(0)" onclick="nextPursePage()" style="color:black;">下一页</a></li>
							</ul>
						</div>
					</div>
					<!-- 课程管理  -->
					<div id="kcgl" style="display:none;">
						<!-- 课程顶部内容：搜索 -->
						<div class="kyzr_topCourse">
							<button type="button" onclick="addCourse()" class="btn btn-success" style="float:left;">
								<span class="glyphicon glyphicon-plus"></span>添加课程
							</button>
							<!-- 通过课程名搜索请求-->
							<div class="kyzr_courseSearch input-group col-md-3" style="z-index:0;margin-top:0px;position:relative">
								<input type="text" id="searchCourse" class="form-control" placeholder="请输入想要搜索的课程名" style="height:34px;top:0px;" >
								<span class="input-group-btn">
									<button type="button" onclick="searchCourse()" class="btn btn-info btn-search">搜索</button>
								</span>
							</div>
						</div>
						<table style="position:relative;width:95%;" class="table table-striped">
							<tr>
								<td>ID</td>
								<td>标题</td>
								<td>封面</td>
								<td>创建时间</td>
								<td>价格</td>
								<td>操作</td>
							</tr>
							<tbody id="kyzr_courseList">
								
							</tbody>
						</table>
						<div class= "kyzr_changeCoursePage">
							<ul class="pager">
								<!-- 为a标签的href设置href="javascript:void(0)"，使得点击a标签不刷新页面 -->
								<li class=""><a href="javascript:void(0)" onclick="previousCoursePage()" style="color:black;">上一页</a></li>
								<li class=""><a href="javascript:void(0)" onclick="nextCoursePage()" style="color:black;">下一页</a></li>
							</ul>
						</div>
						<!-- 点击课程管理内部的编辑按钮后弹出的页面 -->
						<div class="kyzr_darkCourse">
							<!-- 白色弹窗 -->
							<div class="kyzr_whiteCourse">
								<!-- × -->
								<div class="kyzr_chaCourse">
									<button onclick="closeEditCourse()" class="kyzr_chaBtn">×</button>
								</div>
								<!-- 表单 -->
								<div class="changeCourse_form">
									<form class="form-horizontal" action="" id="changeCourseForm">
										<div class="form-group" style="display:none;">
										    <label for="courseId" class="col-sm-2 control-label">ID</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="id" id="courseId" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="courseTitle" class="col-sm-2 control-label">标题</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="title" id="courseTitle" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="courseTitle" class="col-sm-2 control-label">价格</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="price" id="coursePrice" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="courseImg" class="col-sm-2 control-label">封面链接</label>
										    <div class="col-sm-10">
										      <input class="form-control" onblur="" name="img" id="courseImg" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="passageCreateAt" class="col-sm-2 control-label">创建时间</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="createAt" id="courseCreateAt" type="text" disabled>
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="courseURL" class="col-sm-2 control-label">视频链接</label>
										    <div class="col-sm-10">
										      <textarea class="form-control" id="courseURL" name="courseURL" rows="2" style="resize:none;"></textarea>
										    </div>
									    </div>
										<div class="form-group">
										    <div class="col-sm-offset-2 col-sm-10">
										      <button type="button" id="changeCourseBtn" onclick="submitChangeCourse(this)" class="btn btn-default">提交修改</button>
										    </div>
										</div>
									</form>
								</div>
							</div>
						</div>
						<!-- 添加课程 -->
						<div class="kyzr_darkAddCourse">
							<!-- 白色弹窗 -->
							<div class="kyzr_whiteAddCourse">
								<!-- × -->
								<div class="kyzr_chaAddCourse">
									<button onclick="closeAddCourse()" class="kyzr_chaAddBtn">×</button>
								</div>
								<!-- 表单 -->
								<div class="addCourse_form">
									<form class="form-horizontal" action="" id="addCourseForm">
									    <div class="form-group">
										    <label for="courseTitle" class="col-sm-2 control-label">标题</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="title" id="courseTitle" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="courseTitle" class="col-sm-2 control-label">价格</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="price" id="coursePrice" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="courseImg" class="col-sm-2 control-label">封面链接</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="img" id="courseImg" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="courseURL" class="col-sm-2 control-label">视频链接</label>
										    <div class="col-sm-10">
										      <textarea class="form-control" id="courseURL" name="courseURL" rows="2" style="resize:none;"></textarea>
										    </div>
									    </div>
										<div class="form-group">
										    <div class="col-sm-offset-2 col-sm-10">
										      <button type="button" id="addCourseBtn" onclick="submitaddCourse()" class="btn btn-default">提交添加</button>
										    </div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- 首页文章管理 -->
					<div id="sywzgl" style="display:none;">
						<!-- 文章管理顶部内容：添加、搜索 -->
						<div class="kyzr_topPassage">
							<button type="button" onclick="addPassage()" class="btn btn-success" style="float:left;">
								<span class="glyphicon glyphicon-plus"></span>添加文章
							</button>
							<!-- 搜索文章-->
							<div class="kyzr_passageSearch input-group col-md-3" style="z-index:0;margin-top:0px;position:relative">
								<input type="text" id="searchPassage" class="form-control" placeholder="请输入想要搜索的文章" style="height:34px;top:0px;" >
								<span class="input-group-btn">
									<button type="button" onclick="searchPassage()" class="btn btn-info btn-search">搜索</button>
								</span>
							</div>
						</div>
						<table style="position:relative;width:95%;" class="table table-striped">
							<tr>
								<td>ID</td>
								<td>标题</td>
								<td>封面图片</td>
								<td>创建时间</td>
								<td>文章状态</td>
								<td>操作</td>
							</tr>
							<tbody id="kyzr_passageList">
								
							</tbody>
						</table>
						<div class= "kyzr_changePassagePage">
							<ul class="pager">
								<!-- 为a标签的href设置href="javascript:void(0)"，使得点击a标签不刷新页面 -->
								<li class=""><a href="javascript:void(0)" onclick="previousPassagePage()" style="color:black;">上一页</a></li>
								<li class=""><a href="javascript:void(0)" onclick="nextPassagePage()" style="color:black;">下一页</a></li>
							</ul>
						</div>
						<!-- 点击首页文章管理内部的编辑按钮后弹出的页面 -->
						<div class="kyzr_darkPassage">
							<!-- 白色弹窗 -->
							<div class="kyzr_whitePassage">
								<!-- × -->
								<div class="kyzr_chaPassage">
									<button onclick="closeEditPassage()" class="kyzr_chaBtn">×</button>
								</div>
								<!-- “编辑”表单 -->
								<div class="changePassage_form">
									<form class="form-horizontal" action="" id="changePassageForm">
										<div class="form-group" style="display:none;">
										    <label for="passageId" class="col-sm-2 control-label">ID</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="id" id="passageId" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="passageTitle" class="col-sm-2 control-label">标题</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="title" id="passageTitle" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="passageImg" class="col-sm-2 control-label">封面</label>
										    <div class="col-sm-10">
										      <input class="form-control" onblur="" name="img" id="passageImg" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="passageStatus" class="col-sm-2 control-label">状态</label>
										    <div class="col-sm-10">
										      <select class="form-control" name="status" id="passageSelect" style="font-size:13px;">
										      	<option value="1">置顶模式</option>
										      	<option value="0">普通模式</option>
										      </select>
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="passageCreateAt" class="col-sm-2 control-label">创建时间</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="createAt" id="passageCreateAt" type="text" disabled>
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="passageContent" class="col-sm-2 control-label">文章内容</label>
										    <div class="col-sm-10">
										      <textarea class="form-control" id="passageContent" name="article" rows="5" id="introduction" style="resize:none;"></textarea>
										    </div>
									    </div>
										<div class="form-group">
										    <div class="col-sm-offset-2 col-sm-10">
										      <button type="button" id="changePassageBtn" onclick="submitChangePassage(this)" class="btn btn-default">提交修改</button>
										    </div>
										</div>
									</form>
								</div>

							</div>
						</div>
						<!-- 点击首页文章管理内部的添加按钮后弹出的页面 -->
						<div class="kyzr_darkAddPassage">
							<!-- 白色弹窗 -->
							<div class="kyzr_whiteAddPassage">
								<!-- × -->
								<div class="kyzr_chaAddPassage">
									<button onclick="closeAddPassage()" class="kyzr_chaAddBtn">×</button>
								</div>
								<!-- “添加”表单 -->
								<div class="addPassage_form">
									<form class="form-horizontal" action="" id="addPassageForm">
									    <div class="form-group">
										    <label for="passageTitle" class="col-sm-2 control-label">标题</label>
										    <div class="col-sm-10">
										      <input class="form-control" name="title" id="passageTitle" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="passageImg" class="col-sm-2 control-label">封面URL</label>
										    <div class="col-sm-10">
										      <input class="form-control" onblur="" name="img" id="passageImg" type="text">
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="passageStatus" class="col-sm-2 control-label">状态</label>
										    <div class="col-sm-10">
										      <select class="form-control" name="status" id="passageSelect" style="font-size:13px;">
										      	<option value="1">置顶模式</option>
										      	<option value="0">普通模式</option>
										      </select>
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="passageContent" class="col-sm-2 control-label">文章内容</label>
										    <div class="col-sm-10">
										      <textarea class="form-control" id="passageContent" name="article" rows="5" id="introduction" style="resize:none;"></textarea>
										    </div>
									    </div>
										<div class="form-group">
										    <div class="col-sm-offset-2 col-sm-10">
										      <button type="button" id="addPassageBtn" onclick="submitAddPassage()" class="btn btn-default">确认添加</button>
										    </div>
										</div>
									</form>
								</div>

							</div>
						</div>
					</div>
					<!-- 心理咨询师审批 -->
					<div id="xlzxssp" style="display:none;">
						<!-- 心理咨询师审批顶部内容：搜索 -->
						<div class="kyzr_topExpert">
							<!-- 通过人名搜索请求-->
							<div class="kyzr_expertSearch input-group col-md-3" style="z-index:0;margin-top:0px;position:relative">
								<input type="text" id="searchExpert" class="form-control" placeholder="请输入想要搜索的姓名" style="height:34px;top:0px;" >
								<span class="input-group-btn">
									<button type="button" onclick="searchExpert()" class="btn btn-info btn-search">搜索</button>
								</span>
							</div>
						</div>
						<table style="position:relative;width:95%;" class="table table-striped">
							<tr>
								<td>ID</td>
								<td>姓名</td>
								<td>简介</td>
								<td>照片</td>
								<td>价格</td>
								<td>标签一</td>
								<td>标签二</td>
								<td>标签三</td>
								<td>状态</td>
								<td>操作</td>
							</tr>
							<tbody id="kyzr_registExpertList">
								
							</tbody>
						</table>
						<div class= "kyzr_changeExpertPage">
							<ul class="pager">
								<!-- 为a标签的href设置href="javascript:void(0)"，使得点击a标签不刷新页面 -->
								<li class=""><a href="javascript:void(0)" onclick="previousExpertPage()" style="color:black;">上一页</a></li>
								<li class=""><a href="javascript:void(0)" onclick="nextExpertPage()" style="color:black;">下一页</a></li>
							</ul>
						</div>
					</div>
					<!-- 统计分析  -->
					<div id="tjfx" style="display:none;">
						<!-- 注入一个当前的时间 -->
						<div class="kyzr_currentTime">
							截止<span id="timeInfo"></span>
						</div>
						<!-- 分块显示内容 -->
						<div class="kyzr_tjfxContainer">
							<!-- 分块显示每部分内容 -->
							<div class="kyzr_tjfxContent">
								<!-- 上部分 -->
								<div class="kyzr_tjfxTitle">用户数量</div>
								<!-- 下部分 -->
								<div id="userNum"></div>
							</div>
							<div class="kyzr_tjfxContent">
								<!-- 上部分 -->
								<div class="kyzr_tjfxTitle">男女比例</div>
								<!-- 下部分 -->
								<div id="sexPercent"></div>
							</div>
							<div class="kyzr_tjfxContent">
								<!-- 上部分 -->
								<div class="kyzr_tjfxTitle">心理咨询师数量</div>
								<!-- 下部分 -->
								<div id="expertNum"></div>
							</div>
							<div class="kyzr_tjfxContent">
								<!-- 上部分 -->
								<div class="kyzr_tjfxTitle">管理员数量</div>
								<!-- 下部分 -->
								<div id="adminNum"></div>
							</div>
							<!-- 分块显示每部分内容 -->
							<div class="kyzr_tjfxContent">
								<!-- 上部分 -->
								<div class="kyzr_tjfxTitle">问题数量</div>
								<!-- 下部分 -->
								<div id="answerNum"></div>
							</div>
							<div class="kyzr_tjfxContent">
								<!-- 上部分 -->
								<div class="kyzr_tjfxTitle">评论数量</div>
								<!-- 下部分 -->
								<div id="commentNum"></div>
							</div>
							<div class="kyzr_tjfxContent">
								<!-- 上部分 -->
								<div class="kyzr_tjfxTitle">首页文章数量</div>
								<!-- 下部分 -->
								<div id="passageNum"></div>
							</div>
							<div class="kyzr_tjfxContent">
								<!-- 上部分 -->
								<div class="kyzr_tjfxTitle">课程数量</div>
								<!-- 下部分 -->
								<div id="courseNum"></div>
							</div>
							<!-- 分块显示每部分内容 -->
							<div class="kyzr_tjfxContent">
								<!-- 上部分 -->
								<div class="kyzr_tjfxTitle">测评(1)提交次数</div>
								<!-- 下部分 -->
								<div id="scoreNum1"></div>
							</div>
							<div class="kyzr_tjfxContent">
								<!-- 上部分 -->
								<div class="kyzr_tjfxTitle">测评(2)提交次数</div>
								<!-- 下部分 -->
								<div id="scoreNum2"></div>
							</div>
							<div class="kyzr_tjfxContent">
								<!-- 上部分 -->
								<div class="kyzr_tjfxTitle">测评(3)提交次数</div>
								<!-- 下部分 -->
								<div id="scoreNum3"></div>
							</div>
							<div class="kyzr_tjfxContent">
								<!-- 上部分 -->
								<div class="kyzr_tjfxTitle">测评(4)提交次数</div>
								<!-- 下部分 -->
								<div id="scoreNum4"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="kyzr_bottom">
		<div class="kyzr_bottomWord">
	  		@2021 By <a class="kyzr_blog" target="_blank" href="http://kyzr2000.gitee.io/myblog/">King_FLYz</a>
	  	</div>
	</div>
</body>
</html>