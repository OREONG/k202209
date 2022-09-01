<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ch10.*"%>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="common.css"></head><body>
<%	request.setCharacterEncoding("utf-8"); %>
<!-- DTO객체 생성 member -->
<jsp:useBean id="member" class="ch10.Member"></jsp:useBean>
<!-- member 각각의 변수에 값을 setter method를 이용하여 담은 것 -->
<jsp:setProperty property="*" name="member"/>
<%
	MemberDao md = MemberDao.getInstance();
	int result = md.insert(member);
	if (result > 0) {
%>
<script type="text/javascript">
	alert("입력 성공");
	location.href = "loginForm.jsp";
</script>
<%  } else { %>
<script type="text/javascript">
	alert("입력 실패");
	history.back();  // go(-1);
</script>
<%  } %>
</body>
</html>