<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>模拟交易页面</title>
<script src="<%=basePath%>js/jquery-3.6.0.js"></script>
</head>
<body>
	<script>
		 window.onload=function(){
			//支付宝沙箱充值
			function alipayCZ(){
				var money = $("#cz").val();
				$.ajax({
					url:"${pageContext.request.contextPath}/Alipay",
					type: "POST",
					success:function(){
						
					}
				});
			}
		 }
	</script>
	<form action="/Kyzr2000/Alipay">
		付款金额<input type="text" name="alipayMoeny"/><br/>
		<button type="submit">充值</button>
	</form>
</body>
</html>