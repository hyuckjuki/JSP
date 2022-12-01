<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.ch06.vo.*,com.jspstudy.ch06.dao.*" %>
<%
	//	어떤 게시 글을 읽어와서 아래폼에 출력해야되는지를 알아야함
	// 게시 글의 비밀번호를 체크하기 위해서 필요한 데이터
	String sNo = request.getParameter("no");
	String pass = request.getParameter("pass");
	int no = Integer.parseInt(sNo);
	
	// 사용자가 입력한 데이터하고 DB에 있는  데이터가 일치 - 비밀번호가 일치하는지 체크
	BoardDao dao = new BoardDao();
	
	// 기존의 메소드 활용 getBoard(no)
	// 비밀번호 체크만 해주는 새로운 메소드 추가 -  isPassCheck
	boolean isPassCheck = dao.isPassCheck(no, pass);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시 글 수정 폼</title>
	<link type="text/css" href="../css/board.css" rel="stylesheet" /> 
	<script src="../js/jquery-3.3.1.min.js"></script>
	<script src="../js/formcheck.js"></script>
</head>
<body>	
<%
	if(isPassCheck){
		Board b = dao.getBoard(no);
%>
	<form name="updateForm" action="updateProcess.jsp" id="updateForm"
			 method="post">
		<input type="hidden" name="no" value="<%=b.getNo() %>">
		<table class="readTable">
			<tr>
				<td colspan="4" class="boardTitle"><h2>게시 글 수정하기</h2></td>
			</tr>
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr>
				<td class="readTh">글쓴이</td>
				<td class="readTd">
					<input type="text" name="writer" size="30" id="writer" maxlength="10"
						value="<%=b.getWriter() %>" readonly />
				</td>
				<td class="readTh">비밀번호</td>
				<td class="readTd">
					<input type="password" name="pass" size="30" id="pass" 
						maxlength="10"/>
				</td>
			</tr>		
			<tr>
				<td class="readTh">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td class="readTd" colspan=3>
					<input type="text" name="title" size="90" id="title" maxlength="50"
						value="<%=b.getTitle() %>"/>
				</td>
			</tr>			
			<tr>
				<td class="readTh">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
				<td class="readTd" colspan="3">
					<textarea name="content" id="content" rows="20" cols="80"><%=b.getContent() %></textarea>
				</td>
			</tr>
			<tr>
				<td class="readTh">파일첨부</td>
				<td class="readTd" colspan=3>
					<input type="file" name="file" size="70" id="file" maxlength="50"
						<%=b.getFile() == null ? "" : "disabled" %>/>
				</td>
			</tr>
			<tr>
				<td colspan="4">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4" class="tdSpan"><input type="reset" value="다시쓰기"/>
					&nbsp;&nbsp;<input type="submit" value="등록하기" />
					&nbsp;&nbsp;<input type="button" value="목록보기" 
						onclick="javascript:window.location.href='boardList.jsp'"/></td>
			</tr>
		</table>
	</form>
<%
	} else {
%>
	<script>
		alert("비밀번호가 틀립니다.");
		history.back();
		//사용자가 가지고 있던 히스토리, 내역의 전단계로 돌려라.
	</script>
<%
	}
%>
</body>
</html>