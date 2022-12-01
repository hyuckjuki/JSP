<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.ch06.dao.*, com.jspstudy.ch06.vo.*" %>    
<%
	/* 게시 글 수정 폼에는 게시 글 등록 폼과는 다르게 기존의 게시 글 정보를 출력해야 한다.
	 * 테이블에서 하나의 게시 글 정보를 읽어오기 위해서 boardDetail.jsp에서 
	 * 게시 글 수정 폼 요청을 하면서 테이블에서 하나의 게시 글을 유일하게 구분할 수 있는
	 * 게시 글 번호를 요청 파라미터로 보냈기 때문에 이 게시 글 번호를 요청 파라미터로 
	 * 부터 읽어 DBCPBoardDao를 통해서 게시 글 번호에 해당하는 게시 글을 읽을 수 있다.
	 *
	 * 아래에서 no라는 요청 파라미터가 없다면 NumberFormatException 발생
	 **/	
	String sNo = request.getParameter("no");
	String pass = request.getParameter("pass");
	
	/* DBCPBoardDao 객체를 생성하고 DB에서 게시 글 번호와 사용자가 입력한 게시 글
	 * 비밀번호가 맞는지를 체크하여 맞으면 게시 글 번호에 해당하는 게시 글을 읽어온다.
	 **/	
	DBCPBoardDao dao = new DBCPBoardDao();
	int no = Integer.parseInt(sNo);
	boolean isPassCheck = dao.isPassCheck(no, pass);
	
	if(isPassCheck) {
		
		/* 앞에서 isPassCheck() 메서드 안에서 Connection을 닫았으므로
		 * DBCPBoardDao 객체를 다시 생성해 생성자 안에서 Connection 다시 연결한다.
		 **/
		dao = new DBCPBoardDao();
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
	<!--
		게시 글을 수정하기 위해서는 테이블에서 게시 글을 유일하게 구분할 수 있는 
		데이터가 필요하다. 아래에서 no는 테이블에서 하나의 게시 글을 유일하게
		구분할 수 있는 데이터로 아래 폼이 서버로 전송될 때 이 no도 같이 서버로
		전송되어야 게시 글 정보를 제대로 수정할 수 있기 때문에 화면에는 보이지 
		않고 폼이 전송될 때 요청 파라미터에 추가될 수 있도록 hidden 폼 컨트롤로
		폼에 추가하였다.
	-->
	<form name="updateForm" id="updateForm" action="updateProcess.jsp"
		method="post">
		<input type="hidden" name="no" value="<%= board.getNo() %>" />
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
			<%-- 
				폼 컨트롤을 disabled로 설정하면 이 폼이 submit될 때 disabled된
				폼 컨트롤의 데이터는 파라미터로 전송되지 못한다. 현재 file은 수정 대상이 
				아니기 때문에 화면에만 표시하고 서버로 전송되지 않도록 disabled 시켰다. 
				이와는 다르게 폼 컨트롤에 readonly를 설정하면 disabled 설정한 것과
				동일하게 폼 컨트롤의 값을 사용자가 변경할 수 없지만 이 폼이 submit될 때 
				readonly로 설정된 폼 컨트롤의 데이터는 파라미터로 전송된다.
			--%>
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
						onclick="javascript:window.location.href='boardList.jsp'"/>			
				</td>
			</tr>
		</table>
	</form>
<%
	/* 게시 글 번호에 해당하는 비밀번호가 틀리면 비밀번호가 틀리다. 라고 알려주고 
	 * 브라우저의 history 객체를 이용해 바로 이전에 있었던 주소로 돌려보낸다. 
	 **/
	} else {
%>
	<script>
		alert("비밀번호가 다릅니다.");
		history.back();
	</script>	
<% }%>			
</body>
</html>
