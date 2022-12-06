<%-- <jap:include> 액션태그를 이용해 다른 JSP페이지 포함하기 - 부모 페이지 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// <jsp:param> 태그에 대한 문자 셋 처리
	request.setCharacterEncoding("utf-8");
	
	String book = "백견불여일타 JSP&Servlet";
	String image = "images/jsp&servlet.jpg";	
	int price = 27000;
%>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="font-size: 12px;">
</body>
</html>