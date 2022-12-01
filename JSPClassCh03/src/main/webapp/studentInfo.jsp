<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.jspstudy.ch03.vo.*" %>
<%
	Student s1 = new Student("이순신",23,"남성");

	Student s2 = new Student();
	s2.setName("홍길동");
	s2.setAge(30);
	s2.setGender("남성");
		
	request.setAttribute("s1",s1);
	pageContext.forward("studentInfoResult.jsp");
%>
