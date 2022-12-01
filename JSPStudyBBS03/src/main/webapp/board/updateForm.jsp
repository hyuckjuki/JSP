<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.bbs.dao.*,com.jspstudy.bbs.vo.*" %>    
<%
	String sNo = request.getParameter("no");
	String pass = request.getParameter("pass");
	String pageNum = request.getParameter("pageNum");
	
	// no와 pass 그리고 pageNum이 비어 있으면 비정상 요청임
	if(sNo == null || sNo.equals("") || pass == null || pass.equals("")
		|| pageNum == null || pageNum.equals("")) {
		out.println("<script>");
		out.println("	alert('잘못된 접근입니다.');");
		out.println("	history.back();");
		out.println("</script>");
		return;
	}	
	
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
					&nbsp;&nbsp;<input type="button" id="detailList" value="목록으로" 
						onclick="javascript:window.location.href=
						'boardList.jsp?pageNum=<%= pageNum %>'"/>			
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