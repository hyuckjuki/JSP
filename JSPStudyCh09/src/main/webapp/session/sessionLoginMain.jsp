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
		<%-- 
			include 지시자를 이용해 header.jsp, footer.jsp 
			페이지를 컴파일 타임에 index.jsp 파일에 포함 시킨다.  
		--%>		
		<%@ include file="pages/header.jsp" %>
		<%-- 
			<jsp:include> 표준 액션태그를 이용해 실행 시간에 jsp를 포함한다. 
		--%>
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