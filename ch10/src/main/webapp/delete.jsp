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
	MemberDao md = MemberDao.getInstance();
	int result = md.delete(id);
	if (result > 0) {
		//탈퇴했스면 브라우저를 닫지 않더라도 현재 사이트의 세션을 사용 못하게 하기위해 세션 제거
		session.invalidate();
	%>
	<script type="text/javascript">
		alert("성공적으로 탈퇴되었습니다.");
		location.href = "loginForm.jsp";
	</script>
	<%
	} else {
	%>
	<script type="text/javascript">
		alert("탈퇴 실패");
		history.back(); // go(-1);
	</script>
	<%
	}
	%>
</body>
</html>