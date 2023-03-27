<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
</head>
<body>
	<script type="text/javascript">
		//画布用到的数据
		var jsondata;
		var colors=["#cb4539","#fec655"];
		var sum = 0;
		var lastsum=0;
		//左侧首页文章分页要用到的数据
		var passageList,topList; //一个用来存所有文章，另一个用来存每个文章是否置顶
		var page; //总页数
		var topNum=0; //置顶文章个数
		var passageNum=0; //普通文章个数
		var currentPage=1; //目前页数
		var endPage; //上一次递归到的最后一个位置
		window.onload=function(){
			//顶部显示隐藏问题
			var myName = "${myName}";
			//全局变量：用户所有信息
			var myUser = "${myUser}";
			//alert(myName);
			if(myName!="" && myUser!=""){
				//上方
				$("#navLogin").css("display","none");
				$("#navRegister").css("display","none");
				$("#navLogout").css("display","block");
				$("#myname").css("display","block");
			}
			//从后台数据库内拿首页的文章
			$.post("${pageContext.request.contextPath}/index/passage",function (data){
				//data是从数据库拿到的文章列表，先找一下置顶文章，先输出
				var top = new Array(data.length);
				var html = "";
				//全局变量赋值
				passageList = data;
				page = Math.ceil(data.length/6);
				
				//sum变量用于记录现在页面上显示几个文章了，每一页最多就6个
				var sum = 0;
				for(var i=data.length-1;i>=0;i--){
					//先循环一遍，把status值为1的都标记上，并呈现在网页上
					if(data[i].status == 1){
						top[i] = 1;
						topNum++;
						if(sum != 6){
							sum++;
							html += "<div class=\"kyzr_leftContent\">" +
										"<div class=\"kyzr_leftContent_img\">" +
											"<img class=\"kyzr_img\" src=" + data[i].img + ">" +
										"</div>" +
										"<div class=\"kyzr_leftContent_title\">" +
											"<a class=\"kyzr_article\" href="+"jsp/article/article.jsp"+ " passage-Id="+ data[i].id +" onclick=\"article(this)\" " + "><i style=\"color:red;font-style: normal;\">【置顶】</i>" + data[i].title + "</a>" +
										"</div>" +
										"<div class=\"kyzr_leftContent_time\">" +
											"发布时间：" + data[i].createAt +
										"</div>" +
									"</div>";
						}
					}
					else{
						top[i] = 0;
						passageNum++;
					}
				}
				//给toplist赋值
				topList = top;
				for(var i=data.length-1;i>=0;i--){
					if(sum != 6){
						//呈现不是置顶状态的文章
						if(top[i] == 0){
							sum++;
							html += "<div class=\"kyzr_leftContent\">" +
										"<div class=\"kyzr_leftContent_img\">" +
											"<img class=\"kyzr_img\" src=" + data[i].img + ">" +
										"</div>" +
										"<div class=\"kyzr_leftContent_title\">" +
											"<a class=\"kyzr_article\" href="+"jsp/article/article.jsp"+ " passage-Id="+ data[i].id +" onclick=\"article(this)\" >" + data[i].title + "</a>" +
										"</div>" +
										"<div class=\"kyzr_leftContent_time\">" +
											"发布时间：" + data[i].createAt +
										"</div>" +
									"</div>";
							endPage = i;
						}
					}
				}
				$("#kyzr_left_passage").html(html);
			});
			//获取男生、女生的数量
			$.ajax({
				url:"${pageContext.request.contextPath}/user/getNumberBySex",
				success:function(data){
					jsondata = [{name:"男生",num:parseInt(data[0])},{name:"女生",num:parseInt(data[1])}];
					//右上角，扇形图，画布
					var canvas = document.getElementById("cav");
					if(cav==null)return;
					ctx = canvas.getContext("2d");
					sumData();
					drawChart();
				}
			});
			//拿右下角数据
			answer();
			//统计分析
			tj();
			//统计分析时间
			getNowDate();
		}
		//点击进入每一个首页左侧的页面
		function article(obj){
			//拿id
			var id = $(obj).attr("passage-Id");
			$.ajax({
				url:"${pageContext.request.contextPath}/index/article/"+id,
				data:{'id':id},
				success:function(){
					
				},
				error:function(){
					
				}
			});
		}
		//右下角，ajax拿，按时间倒叙
		function answer(){
			$.ajax({
				url:"${pageContext.request.contextPath}/answer/list",
				success:function(data){
					var html = "";
					var len = 0;
					if(data.length<10)
						len = 0;
					else
						len = data.length - 10;
					for(var i=data.length-1;i>=len;i--){
						html += "<div class=\"kyzr_answer\">"+
									"<div class=\"kyzr_rightDown_title\">"+ "<a href=\"jsp/user/answerPageContent.jsp\" answer-id=\"" + data[i].id +
									"\" onclick=\"getAnswer(this)\" style=\"color:black;\">" + data[i].title + "</a>"  +"</div>"+
									"<div class=\"kyzr_rightDown_creator\">"+ "发布者:" + data[i].user.name +"</div>"+
									"<div class=\"kyzr_rightDown_time\">"+ data[i].createAt +"</div>"+
									"<hr class=\"kyzr_rightDown_hr\" />"+
								"</div>";
					}
					$("#kyzr_rightDownContent").html(html);
				}
			});
		}
		//点击右下角每一个帖子时候所执行的函数
		function getAnswer(obj){
			var id = $(obj).attr("answer-id");
			$.ajax({
				url:"${pageContext.request.contextPath}/answer/getAnswer/"+id,
				data:{'id':id},
				success:function(data){
					
				}
			})
		}
		//求数据总和
		function sumData(){
			for(var i=0;i<jsondata.length;i++){
			sum+=jsondata[i].num;
			};
		}
		//下一个起始
		function lastSum(i){
			lastsum=0;//重置为0
			for (var j = 0; j < i; j++) {
				lastsum+=jsondata[j].num;
			};
		}
		//画饼图
		//半径
		var radius=130;
		function drawChart(){
			for (var i = 0; i < jsondata.length;i++) {
				lastSum(i);//上一个结束弧度就是下一个起始弧度
				var startAngle= (Math.PI*2)*(lastsum/sum);//起始弧度
				lastSum(i+1);
				var endAngle=(Math.PI*2)*(lastsum/sum);//结束弧度
				ctx.save();
				ctx.fillStyle=this.colors[i];
				ctx.beginPath();
				ctx.moveTo(250,250);
				ctx.arc(250,250,radius,startAngle,endAngle,false);
				ctx.closePath();
				ctx.fill();
				ctx.restore();
				drawText(startAngle,endAngle,jsondata[i].name,jsondata[i].num/sum);
			};
		}
		//绘制文本和线段
		function drawText(s,e,jn,jsm){
			//文字的x，y坐标计算
			var x = Math.cos((s+e)/2)*(radius+60)+250;
			var y = Math.sin((s+e)/2)*(radius+60)+250;
			ctx.fillStyle="blue";
			ctx.fillText(jn,x,y);
			ctx.fillStyle="red";
			//百分比精确到小数后两位
			ctx.fillText((parseInt(jsm*10000)/100)+"%",x,y+20);
			//绘制由每个饼指向文字的线段 
			ctx.beginPath();
			//各端点坐标由每块的起始弧度和结束弧度求平均后计算得出
			ctx.moveTo(Math.cos((s+e)/2)*radius+250,Math.sin((s+e)/2)*radius+250);
			ctx.lineTo( Math.cos((s+e)/2)*(radius+40)+250, Math.sin((s+e)/2)*(radius+40)+250);
			ctx.closePath();
			ctx.fillStyle="red";
			ctx.stroke();
		}
		//通过文章名称，模糊搜索文章
		function searchPassage(){
			var title = $("#passageTitle").val();
			//alert(title);
			$.ajax({
				url:"${pageContext.request.contextPath}/index/searchList",
				type: "POST",
				data:{'title':title},
				contentType:"application/x-www-form-urlencoded; charset=UTF-8",
				success:function(data){
					//data是从数据库拿到的文章列表，先找一下置顶文章，先输出
					var top = new Array(data.length);
					var html = "";
					//全局变量赋值
					passageList = data;
					page = Math.ceil(data.length/6);
					
					//sum变量用于记录现在页面上显示几个文章了，每一页最多就6个
					var sum = 0;
					for(var i=data.length-1;i>=0;i--){
						//先循环一遍，把status值为1的都标记上，并呈现在网页上
						if(data[i].status == 1){
							top[i] = 1;
							topNum++;
							if(sum != 6){
								sum++;
								html += "<div class=\"kyzr_leftContent\">" +
											"<div class=\"kyzr_leftContent_img\">" +
												"<img class=\"kyzr_img\" src=" + data[i].img + ">" +
											"</div>" +
											"<div class=\"kyzr_leftContent_title\">" +
												"<a class=\"kyzr_article\" href="+"jsp/article/article.jsp"+ " passage-Id="+ data[i].id +" onclick=\"article(this)\" " + "><i style=\"color:red;font-style: normal;\">【置顶】</i>" + data[i].title + "</a>" +
											"</div>" +
											"<div class=\"kyzr_leftContent_time\">" +
												"发布时间：" + data[i].createAt +
											"</div>" +
										"</div>";
							}
						}
						else{
							top[i] = 0;
							passageNum++;
						}
					}
					//给toplist赋值
					topList = top;
					for(var i=data.length-1;i>=0;i--){
						if(sum != 6){
							//呈现不是置顶状态的文章
							if(top[i] == 0){
								sum++;
								html += "<div class=\"kyzr_leftContent\">" +
											"<div class=\"kyzr_leftContent_img\">" +
												"<img class=\"kyzr_img\" src=" + data[i].img + ">" +
											"</div>" +
											"<div class=\"kyzr_leftContent_title\">" +
												"<a class=\"kyzr_article\" href="+"jsp/article/article.jsp"+ " passage-Id="+ data[i].id +" onclick=\"article(this)\" >" + data[i].title + "</a>" +
											"</div>" +
											"<div class=\"kyzr_leftContent_time\">" +
												"发布时间：" + data[i].createAt +
											"</div>" +
										"</div>";
								endPage = i;
							}
						}
					}
					$("#kyzr_left_passage").html(html);
				}
			});
		}
		//点击下一页，切换下一页的首页文章
		function nextPassagePage(){
			//判断一下到第几页了
			if(currentPage == page)
				currentPage = 1;
			else
				currentPage++;
			if(endPage == 0)
				endPage = passageList.length;
			//先考虑置顶文章问题，置顶文章要先显示
			var start = endPage-1;
			//alert(start);
			var end; 
			var sum=0; //用来计数，每页sum只能到6
			var html = "";
			if(currentPage == 1){
				for(var i=passageList.length-1;i>=0;i--){
					if(topList[i] == 1){
						sum++;
						html += "<div class=\"kyzr_leftContent\">" +
									"<div class=\"kyzr_leftContent_img\">" +
										"<img class=\"kyzr_img\" src=" + passageList[i].img + ">" +
									"</div>" +
									"<div class=\"kyzr_leftContent_title\">" +
										"<a class=\"kyzr_article\" href="+"jsp/article/article.jsp"+ " passage-Id="+ passageList[i].id +" onclick=\"article(this)\" " + "><i style=\"color:red;font-style: normal;\">【置顶】</i>" + passageList[i].title + "</a>" +
									"</div>" +
									"<div class=\"kyzr_leftContent_time\">" +
										"发布时间：" + passageList[i].createAt +
									"</div>" +
								"</div>";
					}
				}
			}
			for(var i=start;i>=0;i--){
				if(sum != 6){
					if(topList[i] == 0){
						sum++;
						html += "<div class=\"kyzr_leftContent\">" +
									"<div class=\"kyzr_leftContent_img\">" +
										"<img class=\"kyzr_img\" src=" + passageList[i].img + ">" +
									"</div>" +
									"<div class=\"kyzr_leftContent_title\">" +
										"<a class=\"kyzr_article\" href="+"jsp/article/article.jsp"+ " passage-Id="+ passageList[i].id +" onclick=\"article(this)\" >" + passageList[i].title + "</a>" +
									"</div>" +
									"<div class=\"kyzr_leftContent_time\">" +
										"发布时间：" + passageList[i].createAt +
									"</div>" +
								"</div>";
						endPage = i;
					}
				}
			}
			$("#kyzr_left_passage").html(html);
			//每次最后判断一下endPage之后的所有top值是不是1，如果是1，就把endpage设置为0
			for(var i=endPage-1;i>=0;i--){
				if(topList[i]  == 0){
					break;
				}
				if(topList[i] == 1){
					endPage = i;
				}
			}
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
			courseNum();
			scoreNum1();
			scoreNum2();
			scoreNum3();
			scoreNum4();
			passageNums();
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
		//课程数量
		function courseNum(){
			$.post("${pageContext.request.contextPath}/user/courseNum",function (data){
				var html = data+"个";
				$("#courseNum").html(html);
			})
		}
		//首页文章数量
		function passageNums(){
			$.post("${pageContext.request.contextPath}/index/passageNum",function (data){
				var html = data+"个";
				$("#passageNum").html(html);
			})
		}
		//每个测评题目做过的人数
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
		function opentjfx(){
			$("#kyzr_tjfxDark").css("display","block");
		}
		function closetjfx(){
			$("#kyzr_tjfxDark").css("display","none");
		}
	</script>
	<div class="kyzr_homePageContent">
		<!-- 首页，左侧框内容 -->
		<div class="kyzr_homePageContent_left">
			<div class="kyzr_searchContent">
				<div class="kyzr_search input-group col-md-3" style="margin-top:0px;position:relative">
		        <input type="text" class="form-control" id="passageTitle" placeholder="请输入文章名进行搜索文章" style="height:50px;top:0px;" >
		            <span class="input-group-btn">
		               <button type="button" onclick="searchPassage()" class="btn btn-info btn-search" style="height:50px;">查找</button>
		            </span>
				</div>
			</div>
			<div id="kyzr_left_passage">
			
			</div>
			<div class= "kyzr_changePassagePage">
				<ul class="pager">
					<!-- 为a标签的href设置href="javascript:void(0)"，使得点击a标签不刷新页面 -->
					<li class=""><a href="javascript:void(0)" onclick="nextPassagePage()" style="color:black;">下一页</a></li>
				</ul>
			</div>
		</div>

		<!-- 首页，右上侧框内容，预计放统计数据 -->
		<div class="kyzr_homePageContent_rightUp">
			<div class="kyzr_rightUpContent">
				
				<canvas id="cav" width="500" height="500">
				对不起，您的浏览器版本过低，不支持HTML5.
				</canvas>
				<div id="kyzr_canvasTitle">
					<button type="button" onclick="opentjfx()" style="border:none;background-color:white;">统计分析-注册心理咨询系统的男女比例</button>
				</div>
			</div>
			
			<!-- 弹窗，统计分析 -->
			<div id="kyzr_tjfxDark">
				<!-- 白色区域 -->
				<div class="kyzr_tjfxWhite">
					<!-- × -->
					<div class="kyzr_cha">
						<button class="kyzr_chaBtn" onclick="closetjfx()">×</button>
					</div>
					<div id="tjfx">
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
		
		<!-- 首页，右下侧框内容，存放“公益解答”模块的前10条留言-->
		<div class="kyzr_homePageContent_rightDown">
			<!-- 右下角的标注 -->
			<div class="kyzr_rightDownTitle">
				实时解答
			</div>
			<div id="kyzr_rightDownContent">
				<!-- 前十条论坛的帖子 -->
				
				
			</div>
		</div>
	
	</div>
</body>
</html>