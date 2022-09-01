<%@page import="ch10.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	MemberDao md = MemberDao.getInstance();
	int result = md.cofirm(id);
	if (result > 0) out.println("이미 사용중인 아이디 입니다.");
	else out.println("사용 가능한 아이디 입니다.");
%>
</body>
</html>