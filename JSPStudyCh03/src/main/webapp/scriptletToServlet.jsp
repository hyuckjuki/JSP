<%-- JSP 페이지의 서블릿 클래스 변환 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%-- 
	여기는 JSP의 주석
	JSP 페이지에 작성된 HTML 태그와 텍스트는 서블릿 클래스 안에서
	현재 위치에 HTML 태그와 텍스트를 출력하는 자바 소스 코드로 변환된다. 
--%>    
<!DOCTYPE html>
<html>
<head><title>JSP 페이지의 서블릿 클래스 변환</title></head>
<body>
	<%
		/* 스크립틀릿에서의 주석은 자바 주석을 그대로 사용하면 된다.
		 *
		 * JSP 페이지의 스크립틀릿에 작성된 자바 명령문은
		 * 서블릿 클래스 안에서 자바 명령문으로 변환된다.
		 **/
		int sum = 0;
		for(int i = 0; i <= 100; i += 2) {
			sum += i;
		}
	%>
	
	<%-- 
		JSP 페이지의 표현식에 사용된 변수 또는 자바식은
		서블릿 클래스 안에서 결과를 출력하는 자바 코드로 변환된다. 
	--%>
	1 ~ 100 짝수의 합 : <%= sum %>
</body>
</html>