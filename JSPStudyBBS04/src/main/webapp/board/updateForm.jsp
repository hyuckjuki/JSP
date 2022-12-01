<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.bbs.dao.*,com.jspstudy.bbs.vo.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
	/* boardDetail.jsp에서 요청시 post로 넘어오기 때문에 
	 * request 영역의 문자 셋 처리가 필요하다.
	 **/
	request.setCharacterEncoding("utf-8");

	String sNo = request.getParameter("no");
	String pass = request.getParameter("pass");
	String pageNum = request.getParameter("pageNum");
	String type = request.getParameter("type");	
	String keyword = request.getParameter("keyword");	
	
	// no와 pass 그리고 pageNum이 비어 있으면 비정상 요청임
	if(sNo == null || sNo.equals("") || pass == null || pass.equals("")
		|| pageNum == null || pageNum.equals("")) {
		out.println("<script>");
		out.println("	alert('잘못된 접근입니다.');");
		out.println("	history.back();");
		out.println("</script>");
		return;
	}	

	/* 요청 파라미터에서 type이나 keyword가 비어 있으면 일반 
	 * 게시 글 리스트에서 넘어온 요청으로 간주하여 false 값을 갖게 한다.
	 * 이 정보는 게시 글 리스트와 검색 리스트로 구분해 돌려보내기 위해 필요하다.
	 **/
	boolean searchOption = (type == null || type.equals("") 
			|| keyword == null || keyword.equals("")) ? false : true; 	
	
	// BoardDao 객체를 생성하고 현재 게시 글의 비밀번호가 맞는지 체크한다.
	BoardDao dao = new BoardDao();
	int no = Integer.parseInt(sNo);
	boolean isPassCheck = dao.isPassCheck(no, pass);
	
	if(isPassCheck) {
		Board board = dao.getBoard(no);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시 글 수정 폼</title>
<link type="text/css" href="../css/board.css" rel="stylesheet">
<script src="../js/jquery-3.3.1.min.js"></script>
<script src="../js/formcheck.js"></script>
</head>
<body>
<form name="updateForm" id="updateForm" action="updateProcess.jsp"
	method="post" 
	<%= board.getFile() != null ?  "" : "enctype='multipart/form-data'"%>>
	<!--
		no는 DB에서 게시 글을 수정하기 위해 필요하고 pageNum은 게시 글이 
		수정된 후에 이전에 사용자가 머물렀던 게시 글 리스트의 동일한 페이지로
		보내기 위해 필요한 정보이다.  
	-->
	<input type="hidden" name="no" value="<%= board.getNo() %>" />
	<input type="hidden" name="pageNum" value="<%= pageNum %>" />
	<!-- 
		검색 요청일 경우 다시 keyword에 해당하는 검색 리스트로
		돌려보내기 위해서 아래의 파라미터가 필요하다.
	 -->
	<c:if test="<%= searchOption %>">
		<input type="hidden" name="type" value="<%= type %>" />
		<input type="hidden" name="keyword" value="<%= keyword %>" />
	</c:if>		
	<table class="readTable">
		<tr>
			<td colspan="4" class="boardTitle"><h2>게시 글 수정하기</h2></td>
		</tr>
		<tr><td colspan="4">&nbsp;</td></tr>
		<tr>
			<th class="readTh">글쓴이</th>
			<td class="readTd">
				<input type="text" name="writer" id="writer" size="30" 
					maxlength="10" value="<%= board.getWriter() %>"/>
			</td>
			<th class="readTh">비밀번호</th>
			<td class="readTd">
				<input type="password" name="pass" id="pass" size="30" 
					maxlength="10" />
			</td>
		</tr>
		<tr>
			<th class="readTh">제&nbsp;&nbsp;목</th>
			<td class="readTd" colspan="3">
				<input type="text" name="title" id="title" size="50" 
					maxlength="50" value="<%= board.getTitle() %>"/>
			</td>				
		</tr>
		<tr>
			<th class="readTh">내&nbsp;&nbsp;용</th>
			<td class="readTd" colspan="3">
				<textarea name="content" id="content" rows="20" 
					cols="72"><%= board.getContent() %></textarea>
			</td>				
		</tr>
		<tr>
			<th class="readTh">파일첨부</th>
			<td class="readTd" colspan="3">
				<input type="file" name="file" id="file" size="50" 
					<%= board.getFile() == null ? "" : "disabled" %>/>
			</td>				
		</tr>
		<tr>
				<td colspan="4">&nbsp;</td></tr>
		<tr>
		<tr>		
			<td class="tdSpan" colspan="4">
				<input type="reset" value="다시쓰기" />
				&nbsp;&nbsp;<input type="submit" value="수정하기" />
				<!-- 
					일반 게시 글 리스트에서 온 요청이면 일반 게시 글 리스트로 돌려보낸다. 
				-->
				<c:if test="<%= ! searchOption %>">		
					&nbsp;&nbsp;<input type="button" value="목록보기" 
						onclick="javascript:window.location.href=
							'boardList.jsp?pageNum=<%= pageNum %>'"/>
				</c:if>
				<!-- 
					검색 리스트에서 온 요청이면 검색 리스트의 동일한 페이지로 돌려보낸다. 
				-->
				<c:if test="<%= searchOption %>">
					&nbsp;&nbsp;<input type="button" value="목록보기" 
						onclick="javascript:window.location.href=
							'boardList.jsp?pageNum=<%= pageNum %>&type=<%= type %>&keyword=<%= keyword %>'"/>
					<!-- 
						위의 쿼리 스트링을 작성할 때 같은 줄에서 띄어쓰기 하는 것은 문제되지
						않지만 줄 바꿔서 작성하게 되면 스크립트 에러가 발생한다.
					-->		
				</c:if>				
			</td>
		</tr>
	</table>
</form>
<% } else {%>
	<script>
		alert("비밀번호가 다릅니다.");
		history.back();
	</script>	
<% }%>			
</body>
</html>