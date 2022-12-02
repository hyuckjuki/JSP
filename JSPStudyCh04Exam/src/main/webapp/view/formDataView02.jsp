<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학생 등록 정보</title>
</head>
<body>
	<h1>학생 등록 정보</h1>
	이 름 : ${ name }<br/>
	성 별 : ${ gender }<br/>
	연락처 : ${ call } ${ call1 } ${ call2 }<br/>
	희망취업분야 : ${ job }<br/>
	관심분야 : ${ interest }<br/>
</body>
</html>