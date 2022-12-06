<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선호도 테스트</title>
</head>
<body>
	<h1>선호도 테스트</h1>	
	<form action="ch0501ExamProcess.jsp" method="post">
		<p>이&nbsp;&nbsp;름 : 
			<input type="text" name="name" /></p>
		<p>좋아하는색 : 
			<input type="radio" name="color" value="빨강색"/><label for="빨강색">빨강색</label>&nbsp;&nbsp;
			<input type="radio" name="color" value="초록색"/><label for="초록색">초록색</label>&nbsp;&nbsp;
			<input type="radio" name="color" value="파랑색"/><label for="파랑색">파랑색</label><br/>
		<p>좋아하는 음식 : 
		<select name="food">
				<option>짜장면</option>
				<option>짬뽕</option>
				<option>볶음밥</option>
				<option>탕수육</option>
		</select>
		<p>좋아하는 동물(모두 고르세요): <br/>
			<input type="checkbox" name="animal" value="햄스터"/>
				햄스터&nbsp;&nbsp;
			<input type="checkbox" name="animal" value="고양이"/>
				고양이&nbsp;&nbsp;
			<input type="checkbox" name="animal" value="호랑이"/>
				호랑이&nbsp;&nbsp;
			<input type="checkbox" name="animal" value="사자"/>
				사자&nbsp;&nbsp;
			<input type="checkbox" name="animal" value="개"/>
				개&nbsp;&nbsp;
		</p>	
			<P/>취미(모두 고르세요):
			<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<select multiple size=4 name="hobby">
			      <option value="게임">게임
			      <option value="여행">여행
			      <option value="독서">독서
			      <option value="낚시">낚시
			   </select></P>
			<p><input type="reset" value="다시쓰기" />
		<input type="submit" value="전송하기" /></p>
	</form>
</body>
</html>