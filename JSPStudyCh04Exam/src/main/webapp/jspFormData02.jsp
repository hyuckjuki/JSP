<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 기본 정보 입력 폼</title>
</head>
<body>
	<h1>학생 등록 정보</h1>	
	<form name="fMember1" action="formData02" >
		<p>학&nbsp;&nbsp;생&nbsp;&nbsp;명 : 
			<input type="text" name="name" /></p>
		<p>성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;별 : 
			<input type="radio" name="gender" value="male"/><label for="male">남</label>&nbsp;&nbsp;&nbsp;
		<input type="radio" name="gender" value="female"/><label for="female">여</label><br/>
		<p>연&nbsp;&nbsp;락&nbsp;&nbsp;처 : <select name="call">
				<option>010</option>
				<option>02</option>
				<option>032</option>
				<option>041</option>
			</select>-<input type="text" name="call1" style="width: 50px;"/>-<input type="text" name="call2" style="width: 50px;"/></p>		
		<p>희망 취업 분야 : <br/>
			<input type="checkbox" name="job" value="si"/>
				SI 업체&nbsp;&nbsp;&nbsp;
			<input type="checkbox" name="job" value="sm"/>
				SM 업체&nbsp;&nbsp;&nbsp;
			<input type="checkbox" name="job" value="solution"/>
				솔루션 업체&nbsp;&nbsp;&nbsp;</p>	
			<P/>관심분야 : 
			<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<select multiple size=4 name="interest">
			      <option value="Android">안드로이드
			      <option value="JavaScript">자바스크립트
			      <option value="Spring">스프링
			      <option value="JQuery">제이쿼리
			   </select></P>
			<p><input type="reset" value="다시쓰기" />
		<input type="submit" value="학생등록" /></p>
	</form>
</body>
</html>