<%@page import="ch10.MemberDao"%>
<%@page import="ch10.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%String id = request.getParameter("id");%>
<script type="text/javascript">
function wincl() {
<%-- opener : joinForm.jsp, <%=id%> 자바스크립트에서는 ""안에 넣어야함 --%>
	opener.frm.id.value = "<%=id%>";
	window.close(); // 현재 창 닫기
}
</script>
</head>
<body>
<%
	MemberDao md = MemberDao.getInstance();
	int result = md.cofirm(id);
	if (result > 0) {
%>
<h2>이미 사용중인 아이디 입니다.</h2>
<!-- 	action에 값이 없으면 현재 작업(confirm1.jsp)을 다시 실행 -->
	<form action="">
		아이디 : <input type="text" name="id" required="required"><p>
		<input type="submit" value="확인">
	</form>
<%	} else { %>
<h4>사용 가능한 아이디 입니다.</h4>
<button onclick="wincl()">창닫기</button>
<%	} %>
</body>
</html>