<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%
	session.setMaxInactiveInterval(60);
	Calendar ca = Calendar.getInstance();
	SimpleDateFormat formatter = 
			new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>세션 정보 출력</h2>
	새로운 세션 여부 : <%= session.isNew() %><br>
	현재 세션 ID : <%= session.getId() %><br>
	<%
		ca.setTimeInMillis(session.getCreationTime());
	%>
	세션 생성 시간 : <%= String.format("%TY년 %Tm월 %Td %TT", ca, ca, ca, ca) %><br>
	<%
		ca.setTimeInMillis(session.getLastAccessedTime());
	%>
	마지막 접근 시간 : <%= formatter.format(ca.getTime()) %><br>
	세션의 유효시간 : <%= session.getMaxInactiveInterval() %>
</body>
</html>