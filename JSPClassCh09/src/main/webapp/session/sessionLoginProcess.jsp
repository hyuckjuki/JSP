<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
// 	application.setAttribute("ADIMIN_ID", "admin");

// 	String id = request.getParameter("id");
%>
<c:set var="ADMIN_ID" value="admin" scope="application" />
<c:set var="ADMIN_PASS" value="1234" scope="application" />

<c:if test="${ param.id == applicationScope.ADMIN_ID
	&& param.pass == applicationScope.ADMIN_PASS }" >
	<c:set var="isLogin" value="true" scope="session" />
	<c:set var="id" value="${ param.id }" scope="session" />
	
	<c:redirect url="sessionLoginMain.jsp" />
</c:if>
<c:if test="${ not (param.id == applicationScope.ADMIN_ID
	&& param.pass == applicationScope.ADMIN_PASS) }" >
	<script>
		alert("아이디 또는 비밀번호가 맞지 않습니다.");
		history.back();
	</script>
</c:if>	
