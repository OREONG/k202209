<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="ch10.*"%>
<%@ include file="sessionChk.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="common.css">
</head>
<body>
	<%
		session.invalidate();
		//초단위 시간이 지나면 세션을 삭제
		session.setMaxInactiveInterval(60);
	%>
	<script type="text/javascript">
		alert("로그아웃 되었습니다.");
		location.href="loginForm.jsp";
	</script>
	
</body>
</html>