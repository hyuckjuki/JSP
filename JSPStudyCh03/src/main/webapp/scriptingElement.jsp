<%-- 스크립팅 요소(Scripting Element) 사용하기 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
	여기는 JSP의 주석
	선언부에는 클래스 멤버와 인스턴스 멤버를 선언할 수 있다. 
	JSP 페이지의 선언부에 선언된 변수와 메서드는 서블릿으로 변환된 클래스의
	멤버가 되므로 접근지정자, final, static 등의 예약어를 사용할 수 있다.  
	한 가지 주의할 점은 서블릿으로 변환된 클래스의 인스턴스는 멀티 스레드로
	동작하기 때문에 선언부에 인스턴스 변수를 선언하게 되면 동기화에 문제가
	발생할 수 있다. 그러므로 선언부에 인스턴스 변수를 선언하는 것은 피하고
	변수가 필요할 경우 static 상수로 선언해 사용하는 것이 바람직하다.
	
	jsp의 선언부는 요즘에는 거의 사용하지 않는 기법이다.
--%>    
<%!	
	private int add(int a, int b) {		
		return a + b;
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스크립팅 요소(Scripting Element) 사용하기</title>
</head>
<body>
	<%--		
		JSP 페이지의 스크립틀릿(Scriptlet)에 기술된 코드는 JSP가 서블릿 클래스로
		변환될 때 _jspService() 메서드 안에 기술되므로 위쪽의 스크립틀릿에서 선언된
		변수를 아래쪽의 여러 스크립틀릿과 표현식에서 사용할 수 있다. 
	--%>
	<%
		int sum = 0;
		for(int i = 1; i <= 100; i++) {
			sum += i;
		}
	%>
	
	<%-- 표현식 안의 자바식은 결과를 출력하는 서블릿 코드로 변환된다. --%>
	1 ~ 100 합 : <%= sum %><br/>
	
	<%
		for(int i = 1; i <= 10; i++) {
	%>
		<%-- 위의 스크립틀릿의 for 문에서 정의한 i를 출력 --%>
			<%= i %>번<br/>
	<%
		}
		
		// 위쪽의 스크립틀릿에서 선언한 sum에 0을 대입한다.
		sum = 0;
	%>	
	sum : <%= sum %><br/>
	
	<%-- 위쪽의 선언부에 선언한 메서드를 호출하여 덧셈 결과를 출력 --%>
	10 + 20 = <%= add(10, 20) %>
</body>
</html>