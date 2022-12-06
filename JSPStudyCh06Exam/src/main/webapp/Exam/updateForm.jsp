<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Ch06ExamVo.*, Ch06ExamDao.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	//	어떤 게시 글을 읽어와서 아래폼에 출력해야되는지를 알아야함
	// 게시 글의 비밀번호를 체크하기 위해서 필요한 데이터
	String sNo = request.getParameter("no");
	String pass = request.getParameter("pass");
	int no = Integer.parseInt(sNo);
	
	// 사용자가 입력한 데이터하고 DB에 있는  데이터가 일치 - 비밀번호가 일치하는지 체크
	ExamDao dao = new ExamDao();
	
	// 기존의 메소드 활용 getBoard(no)
	// 비밀번호 체크만 해주는 새로운 메소드 추가 -  isPassCheck
	boolean isPassCheck = dao.isPassCheck(no, pass);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시 글 수정 폼</title>
	<link type="text/css" href="../css/myboard.css" rel="stylesheet" /> 
	<script src="../js/jquery-3.3.1.min.js"></script>
	<script src="../js/formcheck.js"></script>
</head>
<body>	
<%
	if(isPassCheck){
		ExamVo b = dao.getBoard(no);
%>
	<form name="updateForm" action="updateProcess.jsp" id="updateForm"
			 method="post" enctype="multipart/form-data">
		<input type="hidden" name="no" value="<%=b.getNo() %>">
		<h2 class="Titlecss">음반 정보 수정</h2>
	<table style="width: 600px;">
		<tr>
			<td colspan="4">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="4" class="contentTh, th"><input type="text" name="mname" value="<%=b.getMname() %>"></td>
		</tr>
			<%if(b.getCover() != null) {%>
		<tr style="text-align:center;">
			<td colspan="4" class="contentTd"><img class="imgform" src="../image/<%=b.getCover()%>"/></td>
		</tr>
			<%} %>
		<tr>
			<td class="contentTh">글쓴이</td>
			<td class="contentTd"><input type="text" name="writer" value="<%=b.getWriter() %>"></td>
			<td class="contentTh">발매일</td>
			<td class="contentTd">
				<input type="date" name="wdate" value="<%=b.getWdate() %>">
			</td>
		</tr>
		<tr>		
			<td class="contentTh">비밀번호</td>
			<td class="contentTd"><input type="password" name="pass" id="pass"></td>
			<td class="contentTh">가수명</td>
			<td class="contentTd"><input type="text" name="vocal" value="<%=b.getVocal() %>"></td>
		</tr>	
		<tr>
			<td class="contentTh">파&nbsp;&nbsp;&nbsp;&nbsp;일</td>
			<td class="contentTd" colspan="3">
				<input type="file" name="cover" size="70" id="cover" maxlength="50" value=<%=b.getCover()%>/>
			</td>
		</tr>
		<tr>		
			<td style="text-align:center;" class="readContent" colspan="4" style="white-space: pre;">
			<textarea name="content" id="content" rows="20" cols="80"><%=b.getContent()%></textarea></td>
		</tr>	
		<tr>
			<td colspan="4">&nbsp;</td>
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