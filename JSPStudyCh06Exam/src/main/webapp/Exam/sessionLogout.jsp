<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <% 
 	session.invalidate(); 
//  	request.removeAttribute(""); 세션에서 특정한 값만 지우려고 한다.
%>

<c:redirect url="sessionLoginMain.jsp"/>