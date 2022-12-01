<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.jspstudy.ch06.vo.*, com.jspstudy.ch06.dao.*" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%	
	// 1. 게시 글 상세보기 결과를 만들기 위해서 필요한 데이터 읽어와야 함 - 요청 파라미터를 읽기 - no
	String no = request.getParameter("no");
	
	// no가 없는 경우
	if(no == null || no.equals("")){%>
<!-- 		// 바로 다른데로 보낸다. -->
<!-- 		// 안내를 하고 리스트로 보내고 싶다? - 자바 스크립트 -->
<!-- // 		response.setContentType("text/html; charset=utf-8"); //html뒤의 세미콜론 중요 -->
		<script>
		alert('비정상적인 접근입니다.');
		location.href='boardList.jsp';
		</script>
		<% 
		// 아래는 서버에서 임의적으로 처리
// 		response.sendRedirect("boardList.jsp");
		return;
		
		// return으로 함수 종료
	}
	// 2. DB에서 입력 값으로 받은 no에 해당하는 게시 글 하나를 읽어와서
	// BoardDao를 이용해서 
	// 위에 import 까지.
	BoardDao dao = new BoardDao();
	Board b = dao.getBoard(Integer.parseInt(no));
	
	// 3. 아래에 출력해서 응답하면 끝!
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/board.css" type="text/css" rel="stylesheet">
<script src="../js/jquery-3.3.1.min.js"></script>
<script src="../js/formcheck.js"></script>
</head>
<body>
<form name="checkForm" id="checkForm">
	<input type="hidden" name="no" id="rNo">
	<input type="hidden" name="pass" id="rPass">
</form>
<table class = "contentTable">
	<tr>
		<td colspan="4" class="boardTitle"><h2>글 내용 보기</h2></td>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td class="contentTh">제&nbsp;&nbsp;&nbsp;목</td>
		<td colspan="3" class="contentTd"><%= b.getTitle()%></td>
	</tr>
	<tr>
		<td class="contentTh">글쓴이</td>
		<td class="contentTd"><%=b.getWriter() %></td>
		<td class="contentTh">작성일</td>
		<td class="contentTd">
			<fmt:formatDate value="<%=b.getRegDate() %>" pattern="yyyy-MM-dd HH:mm:ss"/>
		</td>
	</tr>
	<tr>		
		<td class="contentTh">비밀번호</td>
		<td class="contentTd"><input type="password" name="pass" id="pass"></td>
		<td class="contentTh">조회수</td>
		<td class="contentTd"><%= b.getReadCount() %></td>
	</tr>	
	<tr>
		<td class="contentTh">파&nbsp;&nbsp;&nbsp;&nbsp;일</td>
		<td class="contentTd" colspan="3">
		<c:if test='<%= b.getFile() == null || b.getFile().equals("")%>'>
			첨부파일 없음
		</c:if>
		<c:if test='<%= b.getFile() != null && !b.getFile().equals("")%>'>
			<a href="../upload/<%= b.getFile() %>">파일 다운로드</a>
		</c:if>
		</td>		
	</tr>
	<tr>		
		<td class="readContent" colspan="4" style="white-space: pre;"><%= b.getContent() %>
		</td>
	</tr>	
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4" class="tdSpan">
			<input type="button" id="detailUpdate" value="수정하기" data-no="<%= b.getNo() %>"/>
			&nbsp;&nbsp;<input type="button" id="detailDelete" value="삭제하기" />			
			&nbsp;&nbsp;<input type="button" value="목록보기" 
				onclick="javascript:window.location.href=
					'boardList.jsp'"/></td>
	</tr>
</table>
</body>
</html>