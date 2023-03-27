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
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>用户主页</title>
<script src="<%=basePath%>js/jquery-3.6.0.js"></script>
<!-- bootstrap框架 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- kyzr.css 全局css文件，目前只定义了首页的颜色 -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr.css" />
<!-- 本页面的css -->
<link rel="stylesheet" href="<%=basePath%>css/kyzr_user.css" />
</head>
<body>
	<script type="text/javascript">
		//全局变量：用户的名字
		var myName = "${myName}";
		//全局变量：用户所有信息
		var myUser = "${myUser}";
		//全局变量：用户钱包的状态
		var myPurseStatus = "${myPurseStatus}";
		//全局变量：用户的钱数，点击左侧我的钱包后会存入数据
		var myMoney;
		//启动页面时判断是否登录
		 window.onload=function(){
			//保证启动页面第一时间拿到钱包最新状态
			 myPurseStatus = "${myPurseStatus}";
			//alert(myName);
			if(myName!="" && myUser!=""){
				//上方
				$("#navLogin").css("display","none");
				$("#navRegister").css("display","none");
				$("#navLogout").css("display","block");
				$("#myname").css("display","block");
			}
			if(myName=="" || myUser==""){
				//下方内容
				$("#nologin").css("display","block");
				$("#sy").css("display","none");
				$("#wdqb").css("display","none");
				$("#wddd").css("display","none");
				$("#cpjl").css("display","none");
				$("#zcxlzxs").css("display","none");
				$("#sz").css("display","none");
			}
			//根据用户组对应的数字来输出用户当前的组别 0：普通用户；1：心理咨询师；2管理员
			var status = "${myUser.status}";
			if(status==0){
				$(".myStatus").html("普通用户");
				$(".zcxlzxsInfo").html("若想注册为心理咨询师，请<a onclick=\"registExpert()\" href=\"javascript:void(0)\" style=\"color:red;\">点击此处</a>。");
			}
			if(status==1){
				$(".myStatus").html("心理咨询师");
				$(".zcxlzxsInfo").html("无需注册为心理咨询师。");
			}
			if(status==2){
				$(".myStatus").html("管理员");
				$(".zcxlzxsInfo").html("无需注册为心理咨询师。");
			}
			//如果是管理员的话，左侧显示管理员功能按钮
			if(status==2)
				$("#kyzr_glyjm").css("display","block");
			//使用ajax拿用户钱包内的钱
			$.post("${pageContext.request.contextPath}/user/money",function (data){
				$("#qbRed").html("￥"+data);
				myMoney = data;
			})
			//注入首页的问题列表
			answerList();
			//注入心理测评的得分
			score();
			//心理测评历史记录
			historicalPsytest();
			//注入订单
			orderList();
			//判断当前用户的钱包是什么状态并给用户提示
			var purseInfo1 = "<a style=\"color:red;\" onclick=\"cancel()\">点击此处</a>";
			var purseInfo2 = "<a style=\"color:red;\" onclick=\"accept()\">点击此处</a>";
			if(myPurseStatus == 0)
				$("#kyzr_purseMsg").html("");
			if(myPurseStatus == 1)
				$("#kyzr_purseMsg").html("您的上一次充值正在等待管理员受理，若想取消可"+purseInfo1);
			if(myPurseStatus == 2)
				$("#kyzr_purseMsg").html("您的上一次提现正在等待管理员受理，若想取消可"+purseInfo1);
			if(myPurseStatus == 3)
				$("#kyzr_purseMsg").html("管理员已经通过了您的上一次申请，请"+purseInfo2+"确认");
			if(myPurseStatus == 4)
				$("#kyzr_purseMsg").html("管理员拒绝了您的上一次申请，请"+purseInfo2+"确认");
		 }
		//按钮“首页”
		function sy(){
			document.getElementById("kyzr_sy").setAttribute("class","btn btn-default kyzr_btn kyzr_active");
			document.getElementById("kyzr_wdqb").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_wddd").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_cpjl").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_zcxlzxs").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_sz").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_glyjm").setAttribute("class","btn btn-default kyzr_btn");
			//如果没登录，点按钮也不显示内容
			if(myName!="" && myUser!=""){
				$("#sy").css("display","block");
				$("#wdqb").css("display","none");
				$("#wddd").css("display","none");
				$("#cpjl").css("display","none");
				$("#zcxlzxs").css("display","none");
				$("#sz").css("display","none");
				$("#glyjm").css("display","none");
			}
		}
		//按钮“我的钱包”
		function wdqb(){
			document.getElementById("kyzr_wdqb").setAttribute("class","btn btn-default kyzr_btn kyzr_active");
			document.getElementById("kyzr_sy").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_wddd").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_cpjl").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_zcxlzxs").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_sz").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_glyjm").setAttribute("class","btn btn-default kyzr_btn");
			//如果没登录，点按钮也不显示内容
			if(myName!="" && myUser!=""){
				$("#wdqb").css("display","block");
				$("#sy").css("display","none");
				$("#wddd").css("display","none");
				$("#cpjl").css("display","none");
				$("#zcxlzxs").css("display","none");
				$("#sz").css("display","none");
				$("#glyjm").css("display","none");
			}
		}
		//按钮“我的订单”
		function wddd(){
			document.getElementById("kyzr_wdqb").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_sy").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_wddd").setAttribute("class","btn btn-default kyzr_btn kyzr_active");
			document.getElementById("kyzr_cpjl").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_zcxlzxs").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_sz").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_glyjm").setAttribute("class","btn btn-default kyzr_btn");
			//如果没登录，点按钮也不显示内容
			if(myName!="" && myUser!=""){
				$("#wddd").css("display","block");
				$("#sy").css("display","none");
				$("#wdqb").css("display","none");
				$("#cpjl").css("display","none");
				$("#zcxlzxs").css("display","none");
				$("#sz").css("display","none");
				$("#glyjm").css("display","none");
			}
		}
		//按钮“测评记录”
		function cpjl(){
			document.getElementById("kyzr_wdqb").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_sy").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_wddd").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_cpjl").setAttribute("class","btn btn-default kyzr_btn kyzr_active");
			document.getElementById("kyzr_zcxlzxs").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_sz").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_glyjm").setAttribute("class","btn btn-default kyzr_btn");
			//如果没登录，点按钮也不显示内容
			if(myName!="" && myUser!=""){
				$("#wddd").css("display","none");
				$("#sy").css("display","none");
				$("#wdqb").css("display","none");
				$("#cpjl").css("display","block");
				$("#zcxlzxs").css("display","none");
				$("#sz").css("display","none");
				$("#glyjm").css("display","none");
			}
		}
		//按钮“注册心理咨询师”
		function zcxlzxs(){
			/*
			document.getElementById("kyzr_wdqb").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_sy").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_wddd").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_cpjl").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_zcxlzxs").setAttribute("class","btn btn-default kyzr_btn kyzr_active");
			document.getElementById("kyzr_sz").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_glyjm").setAttribute("class","btn btn-default kyzr_btn");
			*/
			//如果没登录，点按钮也不显示内容
			if(myName!="" && myUser!=""){
				/*
				$("#wddd").css("display","none");
				$("#sy").css("display","none");
				$("#wdqb").css("display","none");
				$("#cpjl").css("display","none");
				$("#zcxlzxs").css("display","block");
				$("#sz").css("display","none");
				$("#glyjm").css("display","none");
				*/
				//如果用户权限等级比较高的话，弹窗提示用户，否则展示注册心理咨询师界面
				//根据用户组对应的数字来输出用户当前的组别 0：普通用户；1：心理咨询师；2管理员
				var status = "${myUser.status}";
				var statusInfo;
				if(status == 1){
					statusInfo = "心理咨询师";
				}
				else if(status ==2){
					statusInfo = "管理员";
				}
				if(status == 0){
					$(".kyzr_registExpert").css("display","block");
				}
				else{
					confirm("您目前是"+statusInfo+"，无需继续注册！");
				}
			}
		}
		//按钮“设置”
		function sz(){
			document.getElementById("kyzr_wdqb").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_sy").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_wddd").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_cpjl").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_zcxlzxs").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_sz").setAttribute("class","btn btn-default kyzr_btn kyzr_active");
			document.getElementById("kyzr_glyjm").setAttribute("class","btn btn-default kyzr_btn");
			//如果没登录，点按钮也不显示内容
			if(myName!="" && myUser!=""){
				$("#wddd").css("display","none");
				$("#sy").css("display","none");
				$("#wdqb").css("display","none");
				$("#cpjl").css("display","none");
				$("#zcxlzxs").css("display","none");
				$("#sz").css("display","block");
				$("#glyjm").css("display","none");
			}
		}
		//点击按钮“管理员界面”
		function glyjm(){
			document.getElementById("kyzr_wdqb").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_sy").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_wddd").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_cpjl").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_zcxlzxs").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_sz").setAttribute("class","btn btn-default kyzr_btn");
			document.getElementById("kyzr_glyjm").setAttribute("class","btn btn-default kyzr_btn kyzr_active");
			//如果没登录，点按钮也不显示内容
			if(myName!="" && myUser!=""){
				$("#wddd").css("display","none");
				$("#sy").css("display","none");
				$("#wdqb").css("display","none");
				$("#cpjl").css("display","none");
				$("#zcxlzxs").css("display","none");
				$("#sz").css("display","none");
				$("#glyjm").css("display","block");
			}
		}
		//钱包内功能 充值
		//实时获取钱包内的钱数
		function myMoney(){
			//使用ajax拿用户钱包内的钱
			$.post("${pageContext.request.contextPath}/user/money",function (data){
				$("#qbRed").html("￥"+data);
				myMoney = data;
			})
		}
		//全局变量，js第一层过滤,该状态最终为1的话可点击充值按钮，为0禁止点击
		var czStatus = 0;
		function czInfo(){
			//判断输入框内的数据是否合法
			//拿充值框内数据
			var czMoney = document.getElementById("cz").value;
			if(czMoney.search(/^\d+$/) != -1 && czMoney != 0){
				$("#kyzr_purseMsg").html("");
				czStatus = 1;
			}
			else{
				$("#kyzr_purseMsg").html("充值金额有误，请检查后重新输入！");
				czStatus = 0;
			}
		}
		//点击充值按钮
		function czBtn(){
			//判断上面输入充值金额的状态
			//数据有误
			if(czStatus == 0)
				alert("您输入的充值数据有误！");
			//数据正确，通过ajax向后台传递想要充值的金额，后台改数据库相应数据，在管理员完成一系列操作前禁止用户再次进行充值和提现
			if(czStatus == 1){
				$.ajax({
					url:"${pageContext.request.contextPath}/user/cz",
					type: "POST",
					data:{'czMoney':$("#cz").val()},
					success:function(){
						alert("充值请求成功，请耐心等待审批！");
						$("#kyzr_purseMsg").html("您的上一次充值正在等待管理员受理，若想取消可" + "<a style=\"color:red;\" onclick=\"cancel()\">点击此处</a>");
					},
					error:function(){
						alert("充值请求失败，请等待管理员审批上次请求！");
					}
				});
			}
				
		}
		//支付宝沙箱充值
		function alipayCZ(){
			var money = $("#cz").val();
			$.ajax({
				url:"${pageContext.request.contextPath}/user/AlipayCZ",
				type: "POST",
				data:{'money':money},
				success:function(){
					
				}
			});
		}
		//钱包内功能 提现
		//全局变量，js第一层过滤,该状态最终为1的话可点击提现按钮，为0禁止点击
		var txStatus = 0;
		function txInfo(){
			//判断输入框内的数据是否合法
			//拿提现框内数据
			var txMoney = document.getElementById("tx").value;
			if(txMoney.search(/^\d+$/) != -1 && txMoney != 0 && txMoney <= myMoney){
				$("#kyzr_purseMsg").html("");
				txStatus = 1;
			}
			else{
				$("#kyzr_purseMsg").html("提现金额有误，请检查后重新输入！");
				txStatus = 0;
			}
		}
		//点击提现按钮
		function txBtn(){
			//判断上面输入提现金额的状态
			//数据有误
			if(txStatus == 0)
				alert("您输入的提现数据有误！");
			//数据正确，通过ajax向后台传递想要提现的金额，后台改数据库相应数据，在管理员完成一系列操作前禁止用户再次进行充值和提现
			if(txStatus == 1){
				$.ajax({
					url:"${pageContext.request.contextPath}/user/tx",
					type: "POST",
					data:{'txMoney':$("#tx").val()},
					success:function(){
						alert("提现请求成功，请耐心等待审批！");
						$("#kyzr_purseMsg").html("您的上一次提现正在等待管理员受理，若想取消可"+"<a style=\"color:red;\" onclick=\"cancel()\">点击此处</a>");
					},
					error:function(){
						alert("提现请求失败，请等待管理员审批上次请求！");
					}
				});
			}
				
		}
		//用户取消钱包的充值和提现
		function cancel(){
			$.get("${pageContext.request.contextPath}/user/cancelPurse",function (){
				alert("取消成功！");
				$("#kyzr_purseMsg").html("");
				myMoney();
			})
		}
		//用户确认钱包的充值和提现
		function accept(){
			$.get("${pageContext.request.contextPath}/user/accpetPurse",function (){
				alert("确认成功！");
				$("#kyzr_purseMsg").html("");
				myMoney();
			})
		}
		//普通用户点击注册心理咨询师，弹窗
		function registExpert(){
			$(".kyzr_registExpert").css("display","block");
		}
		//点× 关闭弹窗
		function closeRegistExpert(){
			$(".kyzr_registExpert").css("display","none");
		}
		//点击按钮 提交注册心理咨询师的信息
		function registExpertBtn(){
			$.ajax({
				url:"${pageContext.request.contextPath}/user/expertRegist",
				type: "POST",
				data:$("#registExpertForm").serialize(),
				contentType:"application/x-www-form-urlencoded; charset=UTF-8",
				success:function(){
					alert("成功提交信息！");
				},
				error:function(){
					alert("提交失败，请等待管理员审批上一条数据！");
				}
			});
		}
		//打开设置内的修改个人信息，弹窗
		function openCM(){
			$(".kyzr_changeMessage").css("display","block");
		}
		//点×，关闭修改个人信息
		function closeCM(){
			$(".kyzr_changeMessage").css("display","none");
		}
		//检查修改个人信息内信息的可行性
		var cmStatus = 1;
		//name验证
		function checkCMName(){
			var name = document.getElementById("CMname").value;
			if(name.search(/^[\u4e00-\u9fa5]{2,4}$/) != -1){
				cmStatus = 1;
			}
			else{
				cmStatus = 0;
			}
		}
		//email验证
		function checkCMEmail(){
			var email = document.getElementById("CMemail").value;
			if(email.search(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/) != -1){
				cmStatus = 1;
			}
			else{
				cmStatus = 0;
			}
		}
		//phone验证
		function checkCMPhone(){
			var phone = document.getElementById("CMphone").value;
			if(phone.search(/^(\+86)?1\d{10}$/) != -1){
				cmStatus = 1;
			}
			else{
				cmStatus = 0;
			}
		}
		//修改个人信息，点击提交修改
		function cmSubmit(){
			if(cmStatus == 1){
				$.ajax({
					url:"${pageContext.request.contextPath}/user/changeMessage",
					type: "POST",
					data:$("#changeMessageForm").serialize(),
					contentType:"application/x-www-form-urlencoded; charset=UTF-8",
					success:function(){
						alert("成功修改信息！");
						$(".kyzr_changeMessage").css("display","none");
					},
					error:function(){
						alert("修改信息失败！");
					}
				});
			}
			else{
				alert("修改信息失败,请检查信息格式是否正确！");
			}
		}
		//打开设置内的修改账号密码，弹窗
		function openCP(){
			$(".kyzr_changePsw").css("display","block");
		}
		//点×，关闭修改账号密码
		function closeCP(){
			$(".kyzr_changePsw").css("display","none");
		}
		//点击提交修改密码时候的函数
		function cpSubmit(){
			var password = document.getElementById("CPpwd").value;
			var password1 = document.getElementById("CPpwd1").value;
			var password2 = document.getElementById("CPpwd2").value;
			if(password != "" && password1 != "" && password2 != "" ){
				if(password1 == password2){
					//判断新密码格式是否正确
					if(password1.search(/^[a-zA-Z]\w{5,17}$/) != -1){
						//两次新密码相同的同时要判断一下旧密码是不是对的，旧密码是对的才行
						$.ajax({
							url:"${pageContext.request.contextPath}/user/changePassword",
							type: "POST",
							data:{"pwd":password,"pwd1":password1,"pwd2":password2},
							contentType:"application/x-www-form-urlencoded; charset=UTF-8",
							success:function(){
								alert("修改密码成功！");
								$(".kyzr_changePsw").css("display","none");
							},
							error:function(){
								alert("原密码输入错误，请重新检查原密码！");
							}
						});
					}
					else{
						alert("新密码的格式不正确，请输入以字母开头，长度在6-18之间，只能包含字符、数字和下划线的密码！")
					}
				}
				if(password1 != password2){
					alert("请输入两次相同的新密码！")
				}
			}
			else{
				alert("请检查输入信息是否正确！");
			}
		}
		//获取用户心理测评的所有成绩
		function score(){
			//第一项测评成绩
			$.ajax({
				url:"${pageContext.request.contextPath}/psyTest/getScore",
				type: "POST",
				data:{'title_id':1},
				success:function(data){
					if(data == 0){
						$("#psyTestScore1").html("未测评  ");
					}
					else{
						$("#psyTestScore1").html("得分："+data);
					}
				}
			})
			//第二项测评成绩
			$.ajax({
				url:"${pageContext.request.contextPath}/psyTest/getScore",
				type: "POST",
				data:{'title_id':2},
				success:function(data){
					if(data == 0){
						$("#psyTestScore2").html("未测评  ");
					}
					else{
						$("#psyTestScore2").html("得分："+data);
					}
				}
			})
			//第三项测评成绩
			$.ajax({
				url:"${pageContext.request.contextPath}/psyTest/getScore",
				type: "POST",
				data:{'title_id':3},
				success:function(data){
					if(data == 0){
						$("#psyTestScore3").html("未测评  ");
					}
					else{
						$("#psyTestScore3").html("得分："+data);
					}
				}
			})
			//第四项测评成绩
			$.ajax({
				url:"${pageContext.request.contextPath}/psyTest/getScore",
				type: "POST",
				data:{'title_id':4},
				success:function(data){
					if(data == 0){
						$("#psyTestScore4").html("未测评  ");
					}
					else{
						$("#psyTestScore4").html("得分："+data);
					}
				}
			})
		}
		//获取单项测评成绩
		function getTestSore(obj){
			var id = $(obj).attr("title_id");
			$.ajax({
				url:"${pageContext.request.contextPath}/psyTest/getTest/"+id,
				type: "POST",
				data:{'id':id},
				success:function(){
					
				}
			})
		}
		var userStatus = "${myUser.status}";
		//点击我的订单时右侧载入的内容
		function orderList(){
			if(userStatus == 0 || userStatus == 1){
				$.ajax({
					url:"${pageContext.request.contextPath}/chat/orderList",
					type: "POST",
					success:function(data){
						var html = "";
						if(userStatus == 0){
							for(var i=0;i<data.length;i++){
								html += "<tr>" +
											"<td>"+(i+1)+"</td>"+
											"<td>"+data[i].house_id+"</td>"+
											"<td>"+data[i].user.name+"</td>"+
											"<td>"+ 
											myName + 
											"</td>"+
											"<td>￥"+data[i].price+"</td>"+
											"<td>"+data[i].createAt+"</td>";
								//弄一组新的数据来存放“执行状态”
								if(data[i].status == 0){
									html += "<td style=\"color:black;\">"+"申请预约"+"</td>";
								}
								else if(data[i].status == 1){
									html += "<td style=\"color:yellow;\">"+"正在咨询"+"</td>";
								}
								else if(data[i].status == 2){
									html += "<td style=\"color:green;\">"+"咨询成功"+"</td>";
								}
								else if(data[i].status == 3){
									html += "<td style=\"color:red;\">"+"咨询失败"+"</td>";
								}
								//提示信息
								html += "<td>"+"<a style=\"color:black;\" href=\"javascript:void(0)\" title=\""+data[i].myInfo+"\">"+"查看提示"+"</a>"+"</td>";
								//最后的操作按钮
								if(data[i].status == 0){
									html += "<td>"+
												"<button cancel-id=\""+ data[i].id +"\" onclick=\"cancelOrder(this)\" class=\"btn btn-danger\">取消</button>"+
											"</td>"+
											"</tr>";
								}
								else if(data[i].status == 1){
									html += "<td>"+
												"<button pass-id=\""+ data[i].id +"\" onclick=\"passOrder(this)\" class=\"btn btn-success\">完成</button>"+
											"</td>"+
											"</tr>";
								}
								else{
									html += "<td>"+
												"&nbsp;"+
											"</td>"+
											"</tr>";
								}
							}
						}
						else{
							for(var i=0;i<data.length;i++){
								html += "<tr>" +
											"<td>"+(i+1)+"</td>"+
											"<td>"+data[i].house_id+"</td>"+
											"<td>"+myName+"</td>"+
											"<td>"+
											"<a user-id=\""+data[i].customer_id+"\" onclick=\"customerMessage(this)\" href=\"javascript:void(0)\" style=\"color:black;\">" + 
											data[i].user.name+
											"</a>" +
											"</td>"+
											"<td>￥"+data[i].price+"</td>"+
											"<td>"+data[i].createAt+"</td>";
								//弄一组新的数据来存放“执行状态”
								if(data[i].status == 0){
									html += "<td style=\"color:black;\">"+"申请预约"+"</td>";
								}
								else if(data[i].status == 1){
									html += "<td style=\"color:yellow;\">"+"正在咨询"+"</td>";
								}
								else if(data[i].status == 2){
									html += "<td style=\"color:green;\">"+"咨询成功"+"</td>";
								}
								else if(data[i].status == 3){
									html += "<td style=\"color:red;\">"+"咨询失败"+"</td>";
								}
								//提示信息
								html += "<td>"+"<a style=\"color:black;\" href=\"javascript:void(0)\" title=\""+data[i].myInfo+"\">"+"查看提示"+"</a>"+"</td>";
								//后面的按钮
								if(data[i].status == 0){
									html += "<td>"+
												"<button accept-id=\""+ data[i].id +"\" onclick=\"acceptOrder(this)\" style=\"margin:0px 5px;\" class=\"btn btn-success\">同意</button>"+
												"<button refuse-id=\""+ data[i].id +"\" onclick=\"refuseOrder(this)\" style=\"margin:0px 5px;\" class=\"btn btn-danger\">拒绝</button>"+
											"</td>"+
											"</tr>";
								}
								else if(data[i].status == 1){
									html += "<td>"+
												"<button pass-id=\""+ data[i].id +"\" onclick=\"passOrder(this)\" style=\"margin:0px 5px;\" class=\"btn btn-success\">完成</button>"+
												"<button cancel-id=\""+ data[i].id +"\" onclick=\"cancelOrder(this)\" style=\"margin:0px 5px;\" class=\"btn btn-danger\">取消</button>"+
											"</td>"+
											"</tr>";
								}
								else{
									html += "<td>"+ 
												"&nbsp;"+
											"</td>"+
											"</tr>";
								}
							}
						}
						$("#kyzr_orderList").html(html);
					}
				})
			}
			else{
				$.ajax({
					url:"${pageContext.request.contextPath}/chat/orderAllList",
					type: "POST",
					success:function(data){
						var html = "";
						for(var i=0;i<data.length;i++){
							html += "<tr>" +
										"<td>"+(i+1)+"</td>"+
										"<td>"+data[i].house_id+"</td>"+
										"<td>"+data[i].expert_id+"</td>"+
										"<td>"+data[i].customer_id+"</td>"+
										"<td>￥"+data[i].price+"</td>"+
										"<td>"+data[i].createAt+"</td>";
							//弄一组新的数据来存放“执行状态”
							if(data[i].status == 0){
								html += "<td style=\"color:black;\">"+"申请预约"+"</td>";
							}
							else if(data[i].status == 1){
								html += "<td style=\"color:yellow;\">"+"正在咨询"+"</td>";
							}
							else if(data[i].status == 2){
								html += "<td style=\"color:green;\">"+"咨询成功"+"</td>";
							}
							else if(data[i].status == 3){
								html += "<td style=\"color:red;\">"+"咨询失败"+"</td>";
							}
							//提示信息
							html += "<td>"+"<a style=\"color:black;\" href=\"javascript:void(0)\" title=\""+data[i].myInfo+"\">"+"查看提示"+"</a>"+"</td>";
							//后面的按钮
							if(data[i].status == 0){
								html += "<td>"+
											"<button accept-id=\""+ data[i].id +"\" onclick=\"acceptOrder(this)\" style=\"margin:0px 5px;\" class=\"btn btn-success\">同意</button>"+
											"<button refuse-id=\""+ data[i].id +"\" onclick=\"refuseOrder(this)\" style=\"margin:0px 5px;\" class=\"btn btn-danger\">拒绝</button>"+
										"</td>"+
										"</tr>";
							}
							else if(data[i].status == 1){
								html += "<td>"+
											"<button pass-id=\""+ data[i].id +"\" onclick=\"passOrder(this)\" style=\"margin:0px 5px;\" class=\"btn btn-success\">完成</button>"+
											"<button cancel-id=\""+ data[i].id +"\" onclick=\"cancelOrder(this)\" style=\"margin:0px 5px;\" class=\"btn btn-danger\">取消</button>"+
										"</td>"+
										"</tr>";
							}
							else{
								html += "<td>"+ 
											"<button change-id=\""+ data[i].id +"\" onclick=\"changeOrder(this)\" style=\"margin:0px 5px;\" class=\"btn btn-info\">修改提示信息</button>"+
										"</td>"+
										"</tr>";
							}
						}
						$("#kyzr_orderList").html(html);
						}
				})
			}
		}
	//1.类似确认收获，用户确认咨询完成了 || 咨询师确认咨询完成了
	function passOrder(obj){
		var id = $(obj).attr("pass-id");
		if(confirm("确认咨询完成了吗?")){
			$.ajax({
				url:"${pageContext.request.contextPath}/chat/order/passOrder",
				type: "POST",
				data:{'id':id},
				success:function(data){
					orderList();
				}
			});
		}
	}
	//2.用户取消预约的咨询，将状态置为3，该操作在咨询师未审批之前
	function cancelOrder(obj){
		var id = $(obj).attr("cancel-id");
		if(confirm("确认取消本次咨询吗?")){
			$.ajax({
				url:"${pageContext.request.contextPath}/chat/order/cancelOrder",
				type: "POST",
				data:{'id':id},
				success:function(data){
					orderList();
				}
			});
		}
	}
	//3.心理咨询师接收用户的预约，将状态置为1
	function acceptOrder(obj){
		var id = $(obj).attr("accept-id");
		if(confirm("确认批准本次咨询吗?")){
			$.ajax({
				url:"${pageContext.request.contextPath}/chat/order/acceptOrder",
				type: "POST",
				data:{'id':id},
				success:function(data){
					orderList();
				}
			});
		}
	}
	//4.心理咨询师拒绝用户的预约，将状态置为3
	function refuseOrder(obj){
		var id = $(obj).attr("refuse-id");
		var myInfo = prompt('请输入您的拒绝理由(用于反馈客户)');
		if(confirm("确认拒绝本次咨询吗?")){
			$.ajax({
				url:"${pageContext.request.contextPath}/chat/order/refuseOrder",
				type: "POST",
				data:{'id':id,'myInfo':myInfo},
				success:function(data){
					orderList();
				}
			});
		}
	}
	//5.管理员修改单条订单的提示信息
	function changeOrder(obj){
		var id = $(obj).attr("change-id");
		var myInfo = prompt('请输入修改的提示信息(用于反馈客户)');
		if(confirm("确认本次修改吗?")){
			$.ajax({
				url:"${pageContext.request.contextPath}/chat/order/changeOrder",
				type: "POST",
				data:{'id':id,'myInfo':myInfo},
				success:function(data){
					orderList();
				}
			});
		}
	}
	//首页加载个人发布的问题列表
	function answerList(){
		var id = "${myUser.id}";
		$.ajax({
			url:"${pageContext.request.contextPath}/answer/getAnswerListById",
			type: "POST",
			data:{'id':id},
			success:function(data){
				var html = "";
				for(var i=data.length-1;i>=0;i--){
					html += "<tr>"+
								"<td>"+ 
										"<a href=\"../jsp/user/answerPageContent.jsp\" answer-id=\"" + data[i].id +
										"\" onclick=\"getAnswer(this)\" style=\"color:black;\">" 
										+ data[i].title + "</a>" +
								"</td>"+
								"<td style=\"text-align:right;\">"+ data[i].createAt +"</td>"+
							"</tr>";
				}
				$("#answerList").html(html);
			}
		});
	}
	//点击每一个帖子时候所执行的函数
	function getAnswer(obj){
		var id = $(obj).attr("answer-id");
		$.ajax({
			url:"${pageContext.request.contextPath}/answer/getAnswer/"+id,
			data:{'id':id},
			success:function(data){
				
			}
		})
	}
	//咨询师点击订单内的用户名字可以看他的信息
	function customerMessage(obj){
		var id = $(obj).attr("user-id");
		//获取客户姓名、手机号并注入
		$.ajax({
			url:"${pageContext.request.contextPath}/user/getUserById",
			data:{'id':id},
			success:function(data){
				$(".whitefont").html(data.name);
				$("#Wddd_phone").attr("value",data.phone);
			}
		})
		//注入客户测评成绩
		$.ajax({
				url:"${pageContext.request.contextPath}/psyTest/getScoreList",
				type: "POST",
				data:{'id':id},
				success:function(data){
					$("#Wddd_one").attr("value",data[0]);
					$("#Wddd_two").attr("value",data[1]);
					$("#Wddd_three").attr("value",data[2]);
					$("#Wddd_four").attr("value",data[3]);
				}
			})
		//在下面查看历史成绩的a标签内注入用户的id
		$("#openhistory").attr("user_id",id);
		$("#wddd_dark").css("display","block");
	}
	function closewddd(){
		$("#wddd_dark").css("display","none");
	}
	//测评记录界面注入历史记录
	function historicalPsytest(){
		$.ajax({
			url:"${pageContext.request.contextPath}/psyTest/getHisScoreList",
			type: "POST",
			success:function(data){
				var html = "";
				for(var i=0;i<data.length;i++){
					if(data[i].title_id == "1"){
						data[i].title_id = "焦虑程度测试";
					}
					if(data[i].title_id == "2"){
						data[i].title_id = "亲密关系恐惧测试";
					}
					if(data[i].title_id == "3"){
						data[i].title_id = "测测你是杠精吗";
					}
					if(data[i].title_id == "4"){
						data[i].title_id = "测测你的油腻程度";
					}
					html += "<tr>"+
								"<td>"+ (i+1) + "</td>"+
								"<td>"+ data[i].title_id +"</td>"+
								"<td>"+ data[i].grades + "</td>"+
								"<td>"+ data[i].createAt + "</td>"+
							"</tr>";
				}
				$("#kyzr_psyTestList").html(html);
			}
		})
	}
	//点击查看该用户的历史测评记录
	function openHistory(obj){
		var id = $(obj).attr("user_id");
		$.ajax({
			url:"${pageContext.request.contextPath}/psyTest/getHisScoreListById",
			type: "POST",
			data:{'id':id},
			success:function(data){
				var html = "";
				for(var i=0;i<data.length;i++){
					if(data[i].title_id == "1"){
						data[i].title_id = "焦虑程度测试";
					}
					if(data[i].title_id == "2"){
						data[i].title_id = "亲密关系恐惧测试";
					}
					if(data[i].title_id == "3"){
						data[i].title_id = "测测你是杠精吗";
					}
					if(data[i].title_id == "4"){
						data[i].title_id = "测测你的油腻程度";
					}
					html += "<tr>"+
								"<td>"+ (i+1) + "</td>"+
								"<td>"+ data[i].title_id +"</td>"+
								"<td>"+ data[i].grades + "</td>"+
								"<td>"+ data[i].createAt + "</td>"+
							"</tr>";
				}
				$("#kyzr_historyTest").html(html);
				$("#wddd_dark").css("display","none");
				$("#kyzr_historyDark").css("display","block");
			}
		})
	}
	function closeHistory(){
		$("#kyzr_historyDark").css("display","none");
	}
	</script>
	<nav class="kyzr_header">
		<div class="navbar navbar-default" style="background-color:#333333 !important;">
			<div class="navbar-header">
				<a href="<%=basePath%>index.jsp" class="navbar-brand">心理咨询系统</a>
			</div>
			<ul class="nav navbar-nav navbar-right">
				<li><a id="myname" href="<%=basePath%>user/main" style="display:none;">${myName}</a></li>
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
		<div class="kyzr_content">
			<!-- 左侧菜单 -->
			<div class="kyzr_left">
				<button class="btn btn-default kyzr_active kyzr_btn" id="kyzr_sy" onclick="sy()">首页</button>
				<button class="btn btn-default kyzr_btn" id="kyzr_wdqb" onclick="wdqb()">我的钱包</button>
				<button class="btn btn-default kyzr_btn" id="kyzr_wddd" onclick="wddd()">我的订单</button>
				<button class="btn btn-default kyzr_btn" id="kyzr_cpjl" onclick="cpjl()">测评记录</button>
				<button class="btn btn-default kyzr_btn" id="kyzr_zcxlzxs" onclick="zcxlzxs()">注册心理咨询师</button>
				<button class="btn btn-default kyzr_btn" id="kyzr_sz" onclick="sz()">设置</button>
				<a class="btn btn-default kyzr_btn" id="kyzr_glyjm" href="<%=basePath%>manage/main" onclick="glyjm()" style="display:none;">管理员界面</a>
			</div>
			<!-- 右侧内容 -->
			<div class="kyzr_right">
				<!-- 没登录的时候显示 -->
				<div id="nologin">
					您还未登录，请登陆后进入此页面！
				</div>
				<!-- button选择首页时候的内容（默认内容） -->
				<div id="sy">
					<div class="sy_topMessage">
						<div id="sy_topStatus">
							<div class="myStatus" style="position:relative;text-align:center;top:46px;"></div>
						</div>
						<div class="sy_topRight">
							<div class="sy_nameAcc">
								<div class="nameAcc">${myUser.name}(${myUser.account})</div>
							</div>
							<div class="sy_sexCreateEmail">
								<div class="sexCreateEmail">${myUser.sex}&nbsp;|&nbsp;创建日期：${myUser.createAt}&nbsp;|&nbsp;电子邮箱：${myUser.email}</div>
							</div>
						</div>
					</div>
					<hr style="position:relative;border:1px darkgray solid;width:102%;left:-50px;"/>
					<div class="sy_downMessage">
						<div class="sy_downInfo">最新话题/最新回复</div>
						<div class="sy_downContent">
							<table style="position:relative;font-size:15px;border-radius:25px;" class="table table-hover">
								<tbody id="answerList">
									
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!-- button选择我的钱包时候的内容 -->
				<div id="wdqb">
					<div class="kyzr_money">钱包余额：<i id="qbRed"></i></div>
					<!-- 充值提现界面 -->
					<div class="kyzr_inAndOut">
							<form action="/Kyzr2000/Alipay">
								<div class="form-group">
									<input type="text" id="cz" name="alipayMoeny" onblur="czInfo()" class="form-control" style="width:80%;height:40px;margin:0 auto;margin-top: 30px;" placeholder="请输入充值金额" />
								</div>
								<div class="form-group">
									<input type="text" id="tx" onblur="txInfo()" class="form-control" style="width:80%;height:40px;margin:0 auto;margin-top: 30px;" placeholder="请输入提现金额" />
								</div>
								<div class="kyzr_iobtn">
									<button type="button" onclick="czBtn()" class="btn btn-info btn-lg" style="margin-right:25px;">充值</button>
									<button type="button" onclick="txBtn()" class="btn btn-info btn-lg" style="margin-right:25px;">提现</button>
									<button type="submit" onclick="alipayCZ()" class="btn btn-info btn-lg">支付宝充值</button>
								</div>
							</form>
						<!-- 根据充值和提现的状态来为用户输出一个提示信息 -->
						<div id="kyzr_purseMsg"></div>
					</div>
				</div>
				<!-- button选择我的订单时候的内容 -->
				<div id="wddd">
					<table class="table table-hover">
						<tr>
							<td>#</td>
							<td>订单号（房间号）</td>
							<td>心理咨询师</td>
							<td>用户</td>
							<td>价格</td>
							<td>预约时间</td>
							<td>执行状态</td>
							<td>提示信息</td>
							<td>操作</td>
						</tr>
						<tbody id="kyzr_orderList">
							
						</tbody>
					</table>
					<!-- 点击出现的弹窗 -->
					<div id="wddd_dark">
						<div id="wddd_white">
							<!-- × -->
							<div class="wddd_cha">
								<button type="button" onclick="closewddd()" class="kyzr_cha">×</button>
							</div>
							<!-- 用户信息 -->
							<div class="wddd_message">
								<!-- 姓名 -->
								<div class="wddd_name">
									<div class="wddd_myName"><div class="whitefont">测试名字</div></div>
								</div>
								<!-- 表单 -->
								<div class="wdddMessage_content">
									<form class="form-horizontal" action="" id="wdddMessage">
									    <div class="form-group">
										    <label for="Wddd_one" class="col-sm-2 control-label">题目一</label>
										    <div class="col-sm-10">
										      <input class="form-control" id="Wddd_one" type="text"  disabled>
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="Wddd_two" class="col-sm-2 control-label">题目二</label>
										    <div class="col-sm-10">
										      <input class="form-control" id="Wddd_two" type="text" disabled>
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="Wddd_three" class="col-sm-2 control-label">题目三</label>
										    <div class="col-sm-10">
										      <input class="form-control" id="Wddd_three" type="text" disabled>
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="Wddd_four" class="col-sm-2 control-label">题目四</label>
										    <div class="col-sm-10">
										      <input class="form-control" id="Wddd_four" type="text" disabled>
										    </div>
									    </div>
									    <div class="form-group">
										    <label for="Wddd_phone" class="col-sm-2 control-label">手机号</label>
										    <div class="col-sm-10">
										      <input class="form-control" id="Wddd_phone" type="text" disabled>
										    </div>
									    </div>
									</form>
								</div>
								<!-- 查看历史记录 -->
								<div class="wdddHistory_content">
									<div class="wdddHistory_info">或许您也可以<a id="openhistory" href="javascript:void(0)" onclick="openHistory(this)" style="color:red;">点击此处</a>查看本客户的历史记录</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 历史记录弹窗 -->
					<div id="kyzr_historyDark">
						<div class="kyzr_historyWhite">
							<!-- × -->
							<div class="wddd_cha">
								<button type="button" onclick="closeHistory()" class="kyzr_cha">×</button>
							</div>
							<!-- 历史测评分数 -->
							<div class="historyTest">
								<table class="table" style="text-align:center;">
									<tr>
										<td>#</td>
										<td>测评题目</td>
										<td>测评得分</td>
										<td>测评时间</td>
									</tr>
									<tbody id="kyzr_historyTest">
										
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- button选择测评记录时候的内容 -->
				<div id="cpjl">
					<div class="cpjlImg">
						<!-- 左侧插入的长图片 -->
						<img src="http://nickyzj.run:12450/lychee/uploads/big/eb40a7ae9cc2676c728abf4f64982380.jpg" style="height: 748px;" />
					</div>
					<div class="cpjlContent">
						<!-- 四个测评，四个框 -->
						<div class="kyzr_psyTestOne">
							<img src="http://nickyzj.run:12450/lychee/uploads/big/72ca96974e3bcd82fef4ba19ffcc96f1.jpeg" class="psyTestImg" />
							<div class="psyTestTitle">焦虑程度测试</div>
							<div class="psyTestBtn">
								<a href="../jsp/user/psyTestReport.jsp" onclick="getTestSore(this)" title_id="1" style="font-size:30px;color:cornflowerblue;">查看报告</a>
							</div>
							<div id="psyTestScore1"></div>
						</div>
						<div class="kyzr_psyTestOne">
							<img src="http://nickyzj.run:12450/lychee/uploads/big/d2b7b41b686df8d27fe97e8b1ec13e58.jpg" class="psyTestImg" />
							<div class="psyTestTitle">亲密关系恐惧测试</div>
							<div class="psyTestBtn">
								<a href="../jsp/user/psyTestReport.jsp" onclick="getTestSore(this)" title_id="2" style="font-size:30px;color:cornflowerblue;">查看报告</a>
							</div>
							<div id="psyTestScore2"></div>
						</div>
						<div class="kyzr_psyTestOne">
							<img src="http://nickyzj.run:12450/lychee/uploads/big/3aca6e4aead1e071f6b38507fc8e1547.jpg" class="psyTestImg" />
							<div class="psyTestTitle">测测你是杠精吗</div>
							<div class="psyTestBtn">
								<a href="../jsp/user/psyTestReport.jsp" onclick="getTestSore(this)" title_id="3" style="font-size:30px;color:cornflowerblue;">查看报告</a>
							</div>
							<div id="psyTestScore3"></div>
						</div>
						<div class="kyzr_psyTestOne">
							<img src="http://nickyzj.run:12450/lychee/uploads/big/75ffb6c64c17463e26d1651e61a9d51f.jpeg" class="psyTestImg" />
							<div class="psyTestTitle">测测你的油腻程度</div>
							<div class="psyTestBtn">
								<a href="../jsp/user/psyTestReport.jsp" onclick="getTestSore(this)" title_id="4" style="font-size:30px;color:cornflowerblue;">查看报告</a>
							</div>
							<div id="psyTestScore4"></div>
						</div>
					</div>
					<hr style="position:relative;float:left;width:78%;"/>
					<!-- 历史测评分数 -->
					<div class="historicalPsyTest">
						<table class="table table-hover" style="text-align:center;">
							<tr>
								<td>#</td>
								<td>测评题目</td>
								<td>测评得分</td>
								<td>测评时间</td>
							</tr>
							<tbody id="kyzr_psyTestList">
								
							</tbody>
						</table>
					</div>
				</div>
				<!-- button选择注册心理咨询师时候的内容 -->
				<div class="kyzr_registExpert">
					<!-- 弹出白色的区域 -->
					<div class="kyzr_regist">
						<!-- 按钮 -->
						<div class="kyzr_chaBtn">
							<button onclick="closeRegistExpert()" class="kyzr_cha">×</button>
						</div>
						<div class="regist_form">
							<!-- 表单 -->
							<form class="form-horizontal" action="" id="registExpertForm">
							    <div class="form-group">
								    <label for="regist_name" class="col-sm-2 control-label">姓名</label>
								    <div class="col-sm-10">
								      <input class="form-control" id="regist_name" type="text" placeholder=${myName} disabled>
								    </div>
							    </div>
							    <div class="form-group">
									<label for="regist_imgURL" class="col-sm-2 control-label">照片</label>
									<div class="col-sm-10">
										<input type="text" name="img" class="form-control" id="img" placeholder="照片URL"/>
									</div>
								</div>						
								<div class="form-group">
									<label for="regist_content" class="col-sm-2 control-label">个人介绍</label>
									<div class="col-sm-10">
										<textarea class="form-control" name="introduction" rows="3" id="introduction" style="resize:none;" placeholder="请在此输入心理咨询师的简介"></textarea>
									</div>
								</div>
								<div class="form-group">
									<label for="regist_value" class="col-sm-2 control-label">起步价</label>
									<div class="col-sm-10">
										<input type="text" name="value" class="form-control" id="value" placeholder="预期起步价"/>
									</div>
								</div>
								<div class="form-group">
									<label for="regist_tag" class="col-sm-2 control-label">标签</label>
									<div class="col-sm-10">
										<input type="text" name="tagOne" class="form-control" id="tagOne" placeholder="标签1"/>
										<input type="text" name="tagTwo" class="form-control" id="tagTwo" placeholder="标签2"/>
										<input type="text" name="tagThree" class="form-control" id="tagThree" placeholder="标签3"/>
									</div>
								</div>
								<div class="form-group">
								    <div class="col-sm-offset-2 col-sm-10">
								      <button type="button" onclick="registExpertBtn()" class="btn btn-default">提交</button>
								    </div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<!-- button选择设置时候的内容 -->
				<div id="sz">
					<div class="changeMessage_Info">修改个人信息</div>
					<div class="changeMessage_form">
						<!-- 表单 -->
						<form class="form-horizontal" action="" id="changeMessageForm">
						    <div class="form-group">
							    <label for="CMaccount" class="col-sm-2 control-label">账号</label>
							    <div class="col-sm-10">
							      <input class="form-control" name="account" id="CMaccount" type="text" value=${myUser.account} disabled>
							    </div>
						    </div>
						    <div class="form-group">
							    <label for="CMname" class="col-sm-2 control-label">姓名</label>
							    <div class="col-sm-10">
							      <input class="form-control" onblur="checkCMName()" name="name" id="CMname" type="text" value=${myUser.name}>
							    </div>
						    </div>
						    <div class="form-group">
							    <label for="CMemail" class="col-sm-2 control-label">邮箱</label>
							    <div class="col-sm-10">
							      <input class="form-control" onblur="checkCMEmail()" name="email" id="CMemail" type="text" value=${myUser.email}>
							    </div>
						    </div>
						    <div class="form-group">
							    <label for="CMphone" class="col-sm-2 control-label">手机号</label>
							    <div class="col-sm-10">
							      <input class="form-control" onblur="checkCMPhone()" name="phone" id="CMphone" type="text" value=${myUser.phone}>
							    </div>
						    </div>
							<div class="form-group">
							    <div class="col-sm-offset-2 col-sm-10">
							      <button type="button" onclick="cmSubmit()" class="btn btn-default">提交修改</button>
							    </div>
							</div>
						</form>
					</div>
					<hr class="szHR" />
					<div class="changePsw_Info">修改账号密码</div>
					<div class="changePsw_form">
						<!-- 表单 -->
						<form class="form-horizontal" action="" id="changePswForm">
						    <div class="form-group">
							    <label for="CMaccount" class="col-sm-2 control-label">账号</label>
							    <div class="col-sm-10">
							      <input class="form-control" name="account" id="CPaccount" type="text" value=${myUser.account} disabled>
							    </div>
						    </div>
						    <div class="form-group">
							    <label for="CPname" class="col-sm-2 control-label">原密码</label>
							    <div class="col-sm-10">
							      <input class="form-control" name="password" id="CPpwd" type="text" >
							    </div>
						    </div>
						    <div class="form-group">
							    <label for="CMemail" class="col-sm-2 control-label">新密码</label>
							    <div class="col-sm-10">
							      <input class="form-control" name="newPassword1" id="CPpwd1" type="text" >
							    </div>
						    </div>
						    <div class="form-group">
							    <label for="CMphone" class="col-sm-2 control-label">确认新密码</label>
							    <div class="col-sm-10">
							      <input class="form-control" name="newPassword1" id="CPpwd2" type="text" >
							    </div>
						    </div>
							<div class="form-group">
							    <div class="col-sm-offset-2 col-sm-10">
							      <button type="button" onclick="cpSubmit()" class="btn btn-default">提交修改</button>
							    </div>
							</div>
						</form>
					</div>

				</div>
				<!-- button选择管理员界面时候的内容 -->
				<div id="glyjm">
					
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