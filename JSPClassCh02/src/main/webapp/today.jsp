<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<% // 스크립틀릿 scriptlet - 자바 코드를 작성하는 영역 
    	//@ 지시자
	Date d = new Date();
	Calendar today = Calendar.getInstance();
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>오늘의 날짜</h2>
	오늘은 <%= today.get(Calendar.YEAR) %>년
	<%= today.get(Calendar.MONTH) + 1 %>월
	<%= today.get(Calendar.DAY_OF_MONTH) %>일
	<%= today.get(Calendar.HOUR_OF_DAY) %>:
	<%= today.get(Calendar.MINUTE) %>:
	<%= today.get(Calendar.SECOND) %>
</body>
</html>