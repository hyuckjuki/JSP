<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.ch03.vo.Student, java.util.*" %>
<% ArrayList<Student> stu = (ArrayList<Student>)request.getAttribute("studentInfo");%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스크립틀릿과 표현식을 이용한 학생 리스트 출력</title>
</head>
<body>
<h2>스크립틀릿과 표현식을 이용한 학생 리스트 출력</h2>
<ul>
	<%for(Student s : stu){%>
		<li><%=s.getName()%>(<%=s.getAge()%>) - <%=s.getGender()%></li>
	<% }%>
</ul><br>
<h2>JSTL과 EL을 이용한 학생 리스트 출력</h2>
<ul>
<c:forEach var="studentli" items="${studentInfo }">
	<li>${studentli.name }(${studentli.age }) - ${studentli.gender }</li>
</c:forEach>
</ul>
</body>
</html>