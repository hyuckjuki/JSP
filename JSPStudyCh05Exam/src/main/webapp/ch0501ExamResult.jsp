<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선호도 테스트 결과</title>
</head>
<body>
	<h1>선호도 테스트 결과</h1>
<br/>
<b><%= request.getAttribute("name")%>님의 선호도 테스트 결과</b>
<br/>
<pre><%= request.getAttribute("name") %>님은 <%= request.getAttribute("color") %>을 좋아하고, <%= request.getAttribute("food") %> 를 좋아하며,
좋아하는 동물은 <%= request.getAttribute("animal") %>이고,
<%= request.getAttribute("hobby") %>의 취미를 가지고 계십니다.</pre>
</body>
</html>