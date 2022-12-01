<%-- requEst 내장 객체의 속성 사용하기 폼 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>request 내장 객체의 속성 사용하기</title>
</head>
<body>
	<h3>상품 등록</h3>
	<form action="requestAttributeProcess.jsp" method="post">
		<p>상품명 : <input type="text" name="pName" /></p>
		<p>가&nbsp;&nbsp;&nbsp;&nbsp;격 : <input type="text" name="price" /></p>
		<p>제조사 : <select name="manufacturer">
			<option>삼성전자</option>
			<option>엘지전자</option>
			<option>대우전자</option>
			<option>신일전자</option>
			<option>기타</option>
		</select></p>
		<p>할인율 : 
			<label><input type="radio" name="discount" value="10"/>10%</label>
			<label><input type="radio" name="discount" value="20"/>20%</label>
			<label><input type="radio" name="discount" value="30"/>30%</label></p>
		<p><input type="reset" value="다시쓰기" />
			<input type="submit" value="등록하기" /></p>
	</form>
</body>
</html>