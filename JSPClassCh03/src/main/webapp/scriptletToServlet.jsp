<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%!
//!는 선언부
	final int num = 100;

	public void write() {
		System.out.println("출력");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 페이지의 서블릿 변환</title>
</head>
<body>
	<%
		// 스클립틀릿 - Scriptlet - 자바 코드를 작성하는 영역
		int sum = 0;
		for(int i = 0 ; i <= 100 ; i+=2){
			sum += i;
		}
		
	%>
	1 ~ 100 짝수의 합 : <%=  sum%>
</body>
</html>