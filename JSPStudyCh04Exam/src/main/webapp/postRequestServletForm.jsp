<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
	<form name="f1" action="postRequest" method="post">
		<h1>회원 가입</h1>
		이 름 : <input type="text" name="id" /><br/>
		나 이 : <input type="text" name="pass" /><br/>
		성 별 : <input type="radio" name="gen" value="남성"/><label for="남성">남성</label>
		<input type="radio" name="gen" value="여성"/><label for="여성">여성</label><br/>
		주 소 : <input type="text" name="adress" style="width: 400px;" /><br/>
		<input type="reset" value="다시쓰기" />
		<input type="submit" value="전송하기" />
	</form>
</body>
</html>