<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.bbs.vo.*, com.jspstudy.bbs.dao.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	//요청 파라미터로 넘어 온 게시 글 번호와 페이지 번호를 읽어온다.
	String no = request.getParameter("no");	
	String pageNum = request.getParameter("pageNum");
	
	// no와 pageNum이 비어 있으면 비정상 요청임
	if(no == null || no.equals("") || pageNum == null || pageNum.equals("")) {
		out.println("<script>");
		out.println("	alert('잘못된 접근입니다.');");
		out.println("	history.back();");
		out.println("</script>");
		return;
	}
	
	// BoardDao 객체를 생성하고 no에 해당하는 게시 글 하나를 가져온다.
	BoardDao dao = new BoardDao();
	Board board = dao.getBoard(Integer.valueOf(no));	
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시 글 내용보기</title>
	<link type="text/css" href="../css/board.css" rel="stylesheet" />
	<script src="../js/jquery-3.3.1.min.js"></script>
	<script src="../js/formcheck.js"></script>
</head>
<body>
<form name="checkForm" id="checkForm">
	<input type="hidden" name="no" id="rNo" />
	<input type="hidden" name="pass" id="rPass" />
	<input type="hidden" name="pageNum" value="<%= pageNum %>" />
</form>
<table class="contentTable">
	<tr>
		<td colspan="4" class="boardTitle"><h2>글 내용 보기</h2></td>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td class="contentTh">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
		<td class="contentTd" colspan="3"><%= board.getTitle() %></td>		
	</tr>
	<tr>
		<td class="contentTh">글쓴이</td>
		<td class="contentTd"><%= board.getWriter() %></td>
		<td class="contentTh">작성일</td>
		<td class="contentTd"><fmt:formatDate value="<%= board.getRegDate() %>" 
			pattern="yyyy-MM-dd HH:mm:ss" /></td>		
	</tr>
	<tr>		
		<td class="contentTh">비밀번호</td>
		<td class="contentTd"><input type="text" name="pass" id="pass"></td>
		<td class="contentTh">조회수</td>
		<td class="contentTd"><%= board.getReadCount() %></td>
	</tr>	
	<tr>
		<td class="contentTh">파&nbsp;&nbsp;&nbsp;&nbsp;일</td>
		<td class="contentTd" colspan="3">
		<c:if test='<%= board.getFile() == null || board.getFile().equals("")%>'>
			첨부파일 없음
		</c:if>
		<c:if test='<%= board.getFile() != null && !board.getFile().equals("")%>'>
			<a href="../upload/<%= board.getFile() %>">파일 다운로드</a>
		</c:if>
		</td>		
	</tr>
	<tr>		
		<td class="readContent" colspan="4">
			<pre><%= board.getContent() %></pre>
		</td>
	</tr>	
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4" class="tdSpan">
			<input type="button" id="detailUpdate" data-no="<%= no %>" value="수정하기"/>
			&nbsp;&nbsp;<input type="button" id="detailDelete" value="삭제하기" />
			&nbsp;&nbsp;<input type="button" value="목록보기" 
				onclick="javascript:window.location.href=
					'boardList.jsp?pageNum=<%= pageNum %>'"/></td>
	</tr>
</table>
</body>
</html>