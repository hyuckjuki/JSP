<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>세션을 이용한 사용자 로그인 유지하기</title>
<link type="text/css" href="../css/index.css" rel="stylesheet" />
</head>
<body>
	<div id="wrap">
	<!-- !!!!!!!!!!!! $ << 구문이 el 구문 -->
		<!--  header -->
		<%@ include file="pages/header.jsp" %>
		<!-- 그때 그때 바뀌도록  boardList, loginForm -->
		<c:if test="${ not empty param.body }">
			<jsp:include page="${ param.body }" />	
		</c:if>
		<c:if test="${ empty param.body }">
			<jsp:include page="pages/boardList.html" />	
		</c:if>		
		<%@ include file="pages/footer.jsp" %>
	</div>
</body>
</html>