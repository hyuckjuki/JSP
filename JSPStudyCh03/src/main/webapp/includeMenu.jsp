<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h3>♣ 저녁 특선 메뉴</h3>
- 참치회 정식  20,000원<br/><br/>

<%-- java.lang 패키지는 기본 패키지로 import 없이 사용 가능하다. --%>
<%-- 
	include 지시자를 사용하면 이 JSP 페이지를 include 하는 부모 JSP 페이지가
	컴파일 될 때 이 JSP 페이지가 포함되어 하나의 Servlet 클래스로 만들어지므로
	부모 JSP 페이지의 스크립틀릿에 선언된 변수를 별도의 선언이나 값 전달 없이
	아래와 같이 그대로 사용할 수 있다.
--%>
<%= String.format("%TY년 %Tm월 %Td일", now, now, now) %>
