<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GET 방식 요청처리</title>
</head>
<body>
	<!-- form 태그의 method 속성을 생략했기 때문에 default인 get 방식이 적용된다. -->
	<form name="f1" action="getRequest" >
		<h1>숫자1과 숫자2사이의 합 구하기</h1>
		숫자 1 : <input type="number" name="num1" min="1" /><br/>
		숫자 2 : <input type="number" name="num2" min="1" /><br/>
		<input type="submit" value="계산결과보기" />
	</form>
</body>
</html>