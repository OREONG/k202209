<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="common.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	function chk() {
		if (frm.password.value != frm.confirmPass.value) {
			alert("암호와 암호 확인이 다릅니다");
			frm.password.focus();
			frm.password.value = "";
			frm.confirmPass.value = "";
			return false;
		}
	}
	function dupChk() {
		if (!frm.id.value) {
			alert("아이디를 입력하고 체크하시오");
			frm.id.focus();
			return false;
		}
		/* jQuery Ajax이용하는 방법 data는 confirm2.jsp를 실행한 결과 */
		$.post("confirm2.jsp", "id=" + frm.id.value, function(data) {
			/* #은 id, .은 클래스 #err은 아이디가 err인 곳에 data를 html형식으로 넣어라 */
			$('#err').html(data);
		});
		/* 팝업창으로 처리하는 방법 */
		/* window.open("confirm1.jsp?id="+frm.id.value,"","width=300 height=300"); */
	}
</script>
</head>
<body>
	<form action="join.jsp" method="post" name="frm"
		onsubmit="return chk()">
		<table>
			<caption>회원 가입</caption>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="id" required="required"
					autofocus="autofocus"> <input type="button" value="중복체크"
					onclick="dupChk()">
					<div id="err"></div></td>
			</tr>
			<tr>
				<th>암호</th>
				<td><input type="password" name="password" required="required"></td>
			</tr>
			<tr>
				<th>암호확인</th>
				<td><input type="password" name="confirmPass"
					required="required"></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" required="required"></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="address" required="required"></td>
			</tr>
			<!-- 	010-\d{3,4}-\d{4} 010-숫자 3또는 4자리-숫자 4자리
		placeholder는 뒤에 글자가 보이지만 데이터를 입력하면 지워라 
		title는 에러 발생될 때 뒤에 있는 글자를 보여줘라  -->
			<tr>
				<th>전화</th>
				<td><input type="tel" name="tel" required="required"
					pattern="010-\d{3,4}-\d{4}" placeholder="010-1111-1111"
					title="형식 010-1111-1111"></td>
			</tr>
			<tr>
				<th colspan="2"><input type="submit" value="확인"></th>
			</tr>
		</table>
	</form>
	<button oncancel="location.href='loginForm.jsp'">로그인</button>
</body>
</html>