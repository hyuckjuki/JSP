<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.ch03.vo.*" %>
<%
	Student s1 = (Student)request.getAttribute("s1");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>표현식(Expression) 출력</h2>
	이름 : <%= s1.getName() %><br>
	나이 : <%= s1.getAge() %><br>
	성별 : <%= s1.getGender() %><br>

	<h2>표현언어(EL,Expression Language)</h2>
	이름 : ${s1.name}<br>
	나이 : ${s1.age }<br>
	성별 : ${s1.gender }<br>
</body>
</html>