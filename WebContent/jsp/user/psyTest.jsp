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
<title>心理测试</title>
<script src="<%=basePath%>js/jquery-3.6.0.js"></script>
<!-- bootstrap框架 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- kyzr.css 全局css文件，目前只定义了首页的颜色 -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr.css" />
<!-- kyzr_bottom.css是底部bottom.jsp的css文件 -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_bottom.css" />
<!-- kyzr_nav.css是头部黑色长导航栏tools/nav.jsp的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_nav.css" />
<!-- navXlcp.css 用来显示蓝色下划线的 -->
<link rel="stylesheet" href="<%=basePath%>css/underline/navXlcp.css" />
<link rel="stylesheet" href="<%=basePath%>css/kyzr_xlcp.css" />
</head>
<body>
	<jsp:include page="../../tools/nav.jsp" />
	<script type="text/javascript">
		//题目个数
		var num;
		window.onload=function(){
			var id = "${myChecksID}";
			var myName = "${myName}";
			var myUser = "${myUser}";
			if(myName!="" && myUser!=""){
				//上方
				$("#navLogin").css("display","none");
				$("#navRegister").css("display","none");
				$("#navLogout").css("display","block");
				$("#myname").css("display","block");
				//判断用户是否登录了，没登录不显示
				getQuestionByTitleID();
				$("#nologin").css("display","none");
			}
				
		}
		function getQuestionByTitleID(){
			var id = "${myChecksID}";
			var dis = "";
			$.ajax({
				url:"${pageContext.request.contextPath}/psyTest/getTestList/"+id,
				data:{'id':id},
				success:function(data){
					var html="";
					for(var i=0;i<data.length;i++){
						if(i==0)
							dis="block";
						else
							dis="none";
						html += 
							"<div id=\"question"+data[i].question_id+"\" style=\"display:"+dis+";\">"+
								"<div class=\"psytestInfo\">共" + data.length + "题，目前为第" + (i+1) + "题</div>" + "<br />" +
								"<div class=\"kyzr_issue\">" + data[i].question_id+"."+data[i].question + "</div>" +
								"<div class=\"radiolist\">"+
									"<div class=\"radio\">"+
										"<label>"+
										"<input type=\"radio\" id=\"psyRadio\" name=\"question"+ data[i].question_id + "\" value=\""+ data[i].valueA +"\"/>" + data[i].optionA +
										"</label>"+
									"</div>"+
									"<div class=\"radio\">"+
										"<label>"+
										"<input type=\"radio\" id=\"psyRadio\" name=\"question"+ data[i].question_id + "\" value=\""+ data[i].valueB +"\"/>" + data[i].optionB +
										"</label>"+
									"</div>"+
									"<div class=\"radio\">"+
										"<label>"+
										"<input type=\"radio\" id=\"psyRadio\" name=\"question"+ data[i].question_id + "\" value=\""+ data[i].valueC +"\"/>" + data[i].optionC +
										"</label>"+
									"</div>"+
								"</div>"+
								"<button class=\"btn btn-info upBtn\" type=\"button\" question-id=\""+ data[i].question_id +"\" onclick=\"preQuestion(this)\">"+
									"<span class=\"glyphicon glyphicon-chevron-left\" style=\"color: white;\">"+"</span>"+"上一题"+
								"</button>"+
								"<button class=\"btn btn-info downBtn\" type=\"button\" question-id=\""+ data[i].question_id +"\" onclick=\"nextQuestion(this)\">"+
									"下一题"+"<span class=\"glyphicon glyphicon-chevron-right\" style=\"color: white;\">"+"</span>"+
								"</button>"+
								"<button class=\"btn submitBtn\" type=\"button\" onclick=\"submitQuestion()\">"+
									"查看测试结果"+
								"</button>"+
								
							"</div>";
					}
					num=data.length;
					$("#questionForm").html(html);
				}
			});
		}
		//点击“上一题”按钮，切换上一道题
		function preQuestion(obj){
			var q = $(obj).attr("question-id");
			if(q == 1){
				alert("没有上一道题了哦");
			}
			else{
				var idNow = "#question"+q;
				q--;
				var idPre = "#question"+q;
				$(idNow).css("display","none");
				$(idPre).css("display","block");
			}
		}
		//点击“下一题”按钮，切换下一个题
		function nextQuestion(obj){
			var q = $(obj).attr("question-id");
			if(q >= num){
				alert("没有下一道题了哦");
			}
			else{
				var idNow = "#question"+q;
				q++;
				var idNext = "#question"+q;
				$(idNow).css("display","none");
				$(idNext).css("display","block");
			}
		}
		//提交测评
		function submitQuestion(){
			var itname,node;
			var j=0;
			var valueQ = new Array();
			//判断所有题是不是都已经填写完了
			for(var i=1;i<=num;i++){
				itname = "question" + i;
				node = document.getElementsByName(itname);
				for(var x=0;x<node.length;x++){
					if(node[x].checked){
						j++;
						valueQ[i-1] = node[x].value;
						break;
					}
				}
			}
			if(j == num){
				//所有题都填写完成之后执行的部分
				var score = Number("0");
				for(var i=0;i<valueQ.length;i++){
					score += Number(valueQ[i]);
				}
				//更新score成绩表格，ajax传值（后台）
				$.ajax({
					url:"${pageContext.request.contextPath}/psyTest/updateScore",
					data:{'score':score},
					success:function(data){
						alert("测试完毕，您的得分为"+score+"分，请返回个人中心查看详情数据。");
					}
				});
			}
			if(j != num)
				alert("请填写完所有问题~");
			
		}
	</script>
	<!-- 整体1500px -->
	<div class="kyzr_psyOneContainer">
		<!-- 白色区域 -->
		<div class="kyzr_psyOneContent">
			<!-- 表单 -->
			<form class="kyzr_centerPsyTest" id="questionForm">
				
			</form>
			<!-- 未登录的提示信息 -->
			<div id="nologin">
				您还未登录，请登陆后使用此功能！
			</div>
		</div>
	</div>
	<jsp:include page="../../tools/bottom.jsp" />
</body>
</html>