<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	int result = 0;
 	for (int i = 0 ; i <= 100 ; i++ ){
 		if(i % 2 == 0) {
 			result = result + i ;
 		}
 	}
  
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>1부터 100까지 짝수의 합은 <%=result %> 이다.</h2>
</body>
</html>