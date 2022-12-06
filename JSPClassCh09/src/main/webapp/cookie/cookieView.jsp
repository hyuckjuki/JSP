<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Cookie[] cookies = request.getCookies();

	if(cookies != null) {
		for(Cookie c : cookies) {
			String name = c.getName();
			out.println(c.getName() + ", " + c.getValue() + "<br>");
		}
	}
%>