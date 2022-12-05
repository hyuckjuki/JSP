<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Ch06ExamVo.*, Ch06ExamDao.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시 글쓰기 폼</title>
	<link type="text/css" href="../css/myboard.css" rel="stylesheet" /> 
	<script src="../js/jquery-3.3.1.min.js"></script>
	<script src="../js/formcheck.js"></script>
</head>
<body>	
				<h2 class="Titlecss">게시 글쓰기</h2>
	<form name="writeForm" action="writeProcess.jsp" id="writeForm"
			 method="post" enctype="multipart/form-data">
		<table style="width: 600px;">
			<tr>
				<td colspan="4" class="contentTh, th"><input type="text" name="mname" value="음반이름"/></td>
			</tr>
			<tr>
				<td class="contentTh">글쓴이</td>
				<td class="contentTd">
					<input type="text" name="writer"/>
				</td>
			</tr>
			<tr>
				<td class="contentTh">비밀번호</td>
				<td class="contentTd">
					<input type="password" name="pass" size="30" id="pass" 
						maxlength="10"/>
				</td>
			</tr>		
			<tr>
				<td class="contentTh">곡이름</td>
				<td class="contentTd" colspan=3>
					<input type="text" name="mname" size="90" id="mname" maxlength="50"/>
				</td>
			</tr>	
			<tr>
				<td class="contentTh">가수명</td>
				<td class="contentTd" colspan=3>
					<input type="text" name="vocal" size="90" id="vocal" maxlength="50"/>
				</td>
			</tr>	
			<tr>
				<td class="contentTh">발매일</td>
				<td class="contentTd" colspan=3>
					<input type="date" name="wdate" size="90" id="wdate" maxlength="50"/>
				</td>
			</tr>			
			<tr>
				<td class="contentTh">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
				<td class="contentTd" colspan="3">
					<textarea name="content" id="content" rows="20" cols="80"></textarea>
				</td>
			</tr>
			<tr>
				<td class="contentTh">파일첨부</td>
				<td class="contentTd" colspan=3>
					<input type="file" name="cover" size="70" id="cover" maxlength="50"/>
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
</body>
</html>