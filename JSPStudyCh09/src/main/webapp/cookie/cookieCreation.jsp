<%-- 쿠키(Cookie) 생성하기 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* 쿠키는 Windows 10, Chrome의 경우 다음의 폴더에 Cookies라는 파일로 저장된다.
	 * C:\Users\<사용자계정명>\AppData\Local\Google\Chrome\User Data\Default	  
	 *
	 * Windows 10, Microsoft Edge의 경우 다음의 폴더에 Cookies라는 파일로 저장된다.
	 * C:\Users\midastop\AppData\Local\Microsoft\Edge\User Data\Default
	 *
	 * 쿠키 이름을 "id"로 쿠키 값을 "midas"로 지정해 Cookie 객체를 생성하고 쿠키의
	 * 유효기간을 60초로 설정하여 response 내장 객체의 addCookie() 메서드를 사용해
	 * 응답 데이터에 쿠키를 추가하면 웹 브라우저로 쿠키가 전달되고 웹 브라우저는 
	 * 이 쿠키를 받아서 사용자 컴퓨터의 메모리 또는 하드 디스크에 쿠키를 저장한다.
	 **/
	Cookie cookie = new Cookie("id", "midas");
	
	/* 쿠키의 유효기간을 3분으로 설정하고 있다.
	 * 쿠키의 유효기간을 지정하지 않으면 브라우저가 실행되는 동안 유효하다.
	 **/
	cookie.setMaxAge(60 * 3);
	
	/* 응답 데이터의 정보를 저장하고 있는 response 객체에 쿠키를 추가한다.
	 * 아래와 같이 응답 데이터에 쿠키를 추가하면 웹 브라우저로 쿠키가 전달되고 웹 브라우저는
	 * 이 쿠키를 받아서 사용자 컴퓨터의 메모리나 하드 디스크에 쿠키를 저장하게 된다. 
	 * 쿠키는 하나의 도메인 당 20개, 쿠키 1개당 4KB 총 300개를 저장할 수 있다. 
	 **/
	response.addCookie(cookie);
	response.addCookie(new Cookie("name", "John"));
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키 생성하기</title>
</head>
<body>
	쿠키 이름 : <%= cookie.getName() %><br/>
	쿠키 값 : <%= cookie.getValue() %><br/>
	쿠키 유효기간 : <%= cookie.getMaxAge() %>초<br/>
</body>
</html>