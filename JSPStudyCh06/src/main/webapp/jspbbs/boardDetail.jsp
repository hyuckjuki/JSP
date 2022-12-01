<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.ch06.vo.*, com.jspstudy.ch06.dao.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	/* 테이블에서 하나의 게시 글 정보를 읽어오기 위해서 boardList.jsp에서 
	 * 게시 글 상세보기 요청을 하면서 테이블에서 게시 글 하나를 유일하게 구분할 수 있는
	 * 게시 글 번호를 요청 파라미터로 보냈기 때문에 이 게시 글 번호를 요청 파라미터로 
	 * 부터 읽어 BoardDao를 통해서 no에 해당하는 게시 글 정보를 읽을 수 있다.
	 *
	 * 아래에서 no라는 요청 파라미터가 없다면 NumberFormatException 발생
	 **/
	String no = request.getParameter("no");	
	
	// BoardDao 객체를 생성하고 게시 글 번호(no)에 해당하는 게시 글을 정보를 읽어온다.
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
<%--
	아래는 게시 글 수정 폼 요청과 게시 글 삭제 요청에 사용할 숨김 폼 이다.
	
	아래의 수정하기 버튼과 삭제하기 버튼이 클릭되면 jQuery를 이용해 게시 글
	비밀번호가 입력되었는지 체크하여 입력되지 않았으면 게시 글 비밀번호를 
	입력해 달라고 팝업 창을 띄우고 비밀번호가 입력되었으면 게시 글 번호와
	비밀번호를 각각 no와 pass에 설정하고 게시 글 수정 폼페이지 요청과 삭제하기
	요청을 수행한다.	
	
	게시 글 수정은 게시 글 등록과는 다르게 기존의 게시 글을 수정 폼에 보여줘야
	한다. 게시 글 수정 폼 요청시 테이블에서 수정하고자 하는 게시 글을 유일하게
	구분할 수 있는 데이터를 요청 파라미터로 보내야 그 게시 글에 해당하는 정보를
	읽어와 게시 글 수정 폼에 출력할 수 있다. 또한 게시 글 삭제 요청도 테이블에서 
	삭제하고자 하는 게시 글의 정보를 유일하게 구분할 수 있는 게시 글 번호를 요청
	파라미터로 보내야 그 게시 글에 해당하는 정보를 테이블 삭제할 수 있다. 	  
--%>
<form name="checkForm" id="checkForm">
	<input type="hidden" name="no" id="rNo" />
	<input type="hidden" name="pass" id="rPass" />
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
					'boardList.jsp'"/></td>
	</tr>
</table>
</body>
</html>