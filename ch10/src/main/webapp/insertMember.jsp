<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ch10.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	MemberDao md = MemberDao.getInstance();

	for (int i = 0; i < 230; i++) {
		Member member = new Member();
		member.setId("a"+i);
		member.setPassword("1");
		member.setName("a"+i);
		member.setAddress("강남"+i);
		member.setTel("010-0000-"+(1000+i));
		member.setDel("n");
		md.insert(member);
	}
%>
</body>
</html>