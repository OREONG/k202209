<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ch10.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="sessionChk.jsp" %>
<!DOCTYPE html>
<html>                                                                            
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">@import url("common.css");</style>
</head>
<body>
<%
	final int ROW_PER_PAGE = 10;
	final int PAGE_PER_BLOCK = 10;
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null || pageNum.equals("")) pageNum = "1";
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * ROW_PER_PAGE + 1;
	int endRow = startRow + ROW_PER_PAGE - 1;
	MemberDao md = MemberDao.getInstance();
	int total = md.getTotal(); 
	int totalPage = (int)Math.ceil((double)total / ROW_PER_PAGE);
	List<Member> list = md.list(startRow, endRow);
	int startPage = currentPage - (currentPage - 1) % PAGE_PER_BLOCK;
	int endPage = startPage + PAGE_PER_BLOCK - 1;
	if (endPage > totalPage) endPage = totalPage;
	pageContext.setAttribute("currentPage", currentPage);
	pageContext.setAttribute("list", list);
%>
<table><caption>회원 목록</caption>
	<tr><th>아이디</th><th>이름</th><th>주소</th><th>전화번호</th><th>가입일</th><th>탈퇴여부</th></tr>
<c:if test="${empty list }">
	<tr><th colspan="6">데이터가 없습니다.</th></tr>
</c:if>
<c:if test="${not empty list }">
	<c:forEach var="member" items="${list }">
		<tr><td>${member.id }</td><td>${member.name }</td><td>${member.address }</td>
			<td>${member.tel }</td><td>${member.reg_date }</td><td>${member.del }</td></tr>
	</c:forEach>
</c:if>
</table>
<div align="center">
	<%  if (startPage > PAGE_PER_BLOCK) { %>
		<button onclick="location.href='list.jsp?pageNum=<%=startPage-1%>'">이전</button>
	<%  } %>
	<c:forEach var="i" begin="<%=startPage %>" end="<%=endPage %>">
		<c:if test="${currentPage == i }">
			<button onclick="location.href='list.jsp?pageNum=${i}'"
				style="background: black; color: white">${i }</button>
		</c:if>
		<c:if test="${currentPage != i }">
			<button onclick="location.href='list.jsp?pageNum=${i}'">${i }</button>
		</c:if>
	</c:forEach>
	<%  if (endPage < totalPage) { %>
		<button onclick="location.href='list.jsp?pageNum=<%=endPage+1%>'">다음</button>
	<%  } %>
</div>
<br><button onclick="location.href='main.jsp'">메인</button>
</body>
</html>