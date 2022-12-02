<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="Ch06ExamVo.*, Ch06ExamDao.*, java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	/* BoardList 요청을 처리하는 페이지// 개발자로드맵
		BoardDao를 이용해서(의존해서) DB로부터 게시글 리스트를 읽어와 출력 
	*/
	/*  1*/
	ExamDao dao = new ExamDao();
	ArrayList<ExamVo> bList = dao.boardList();
	
	// pageContext.setAttribute("bList", bList);
%>
<c:set var="bList" value="<%= bList %>" scope="page"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> 
<link type="text/css" href="../css/myboard.css" rel="stylesheet">
</head>
<body>
	<table class="listTable">
		<tr>
			<td class="boardTitle" colspan="5"><h2>음반 정보 열람</h2></td>
		</tr>
		<tr>
			<td colspan="5" class="listWrite"><a href="writeForm.jsp">음반 등록하기</a></td>
		</tr>
		<tr>
			<th class="th">NO</th>
			<th class="th">제목</th>
			<th class="th">가수명</th>
			<th class="th">발매일</th>
		</tr>
		<!-- 게시글이 있는 경우 -->
		<c:if test="${ not empty bList }">
			<c:forEach var="b" items="${ bList }">
			<tr>
				<td class="listTdNo">${ b.no }</td>
				<!-- 이 부분에서 detail 로 넘어가는 것.. --> 
				<td class="listTdTitle"><a href="boardDetail.jsp?no=${b.no}">${ b.mname }</a></td>
				<td class="listTdReadCount">${ b.vocal }</td>
				<td class="listTdRegDate">
					<fmt:formatDate value="${ b.wdate }" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
			</c:forEach>
		</c:if>
		
		<!-- 게시글이 없는 경우 -->
		<c:if test="${ empty bList }">
			<script>
				alert("!!게시글이 없습니다!!");
				history.back();
			</script>
			
		</c:if>
	</table>
</body>
</html>