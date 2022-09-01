<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ch10.*"%>
<%@ include file="sessionChk.jsp" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">@import url("common.css");</style>
<script type="text/javascript">
	function chk() {
		if (frm.password.value != frm.confirmPass.value) {
			alert("암호와 암호 확인이 다릅니다");  frm.password.focus();
			frm.password.value = "";  frm.confirmPass.value = ""; return false;
		}
	}
</script></head><body>
<%	
	MemberDao md = MemberDao.getInstance();
	Member member = md.select(id);
	pageContext.setAttribute("member", member);
%>
<form action="update.jsp" method="post" name="frm" onsubmit="return chk()">
	<input type="hidden" name="id" value="${member.id }">
<table><caption>회원정보 수정</caption>
	<tr><th>아이디</th><td>${member.id }</td></tr>
	<tr><th>암호</th><td><input type="password" name="password" required="required"></td></tr>
	<tr><th>암호확인</th><td><input type="password" name="confirmPass" required="required"></td></tr>
	<tr><th>이름</th><td><input type="text" name="name" required="required"
		value="${member.name }"></td></tr>
	<tr><th>주소</th><td><input type="text" name="address" required="required"
		value="${member.address }"></td></tr>
	<tr><th>전화</th><td><input type="tel" name="tel" required="required"
		pattern="010-\d{3,4}-\d{4}" placeholder="010-0000-0000" title="형식 010-0000-0000"
		value="${member.tel }"></td></tr>
	<tr><th colspan="2"><input type="submit" value="확인"></th></tr>
</table>
</form>
</body>
</html>