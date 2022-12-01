<%-- pageContext 내장 객체의 속성 사용하기 폼 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pageContext 속성 사용하기</title>
</head>
<body>
	<h3>메모하기</h3>
	<form action="pageContextAttribute.jsp" method="post">
		제목 : <input type="text" name="title" /><br/>
		메모 : <br/>
			<textarea name="memo" rows="5" cols="35"></textarea><br/>
		<input type="reset" value="다시쓰기" />
		<input type="submit" value="메모저장" />
	</form>
</body>
</html>