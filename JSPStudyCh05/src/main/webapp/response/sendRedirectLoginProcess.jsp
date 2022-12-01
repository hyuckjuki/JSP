<%-- response 내장객체의 sendRedirect()를 이용한 초간단 로그인 처리 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");	
	
	/* 아이디와 비밀번호가 맞으면 response 내장객체의 sendRedirect()를 이용해 
	 * 로그인 성공 페이지로 리다이렉트 시킨다. sendRedirect() 메소드는 브라우저에게
	 * 요청한 자원이 다른 곳으로 이동되었다고 응답하면서 URL을 알려주고 다시 요청하라고 
	 * 응답하는 메소드이다. Redirect 기법은 웹 브라우저를 새로 고침(F5) 했을 때 동일한
	 * 코드가 재실행되면 문제가 될 수 있는 경우 클라이언트의 요청을 처리한 후 특정 
	 * URL로 이동시키기 위해 주로 사용한다. 예를 들어 게시 글쓰기에 대한 요청을
	 * 처리한 후 Redirect 시키지 않으면 게시 글쓰기 후에 사용자가 새로 고침(F5)
	 * 동작을 하게 되면 바로 이전에 작성된 게시 글쓰기와 동일한 작업이 다시 발생하여 
	 * 중복된 데이터가 게시 글 테이블에 저장되는 문제가 발생한다. 이를 방지하기 위해서
	 * 게시 글쓰기가 완료되면 게시 글 리스트(select 문은 반복 사용해도 문제되지 않음)로
	 * 이동시키기 위해서 response 내장객체의 sendRedirect() 메소드를 사용해 게시 글 
	 * 리스트의 요청 URL을 웹 브라우저에게 응답하고 웹 브라우저는 응답 받은 URL로 다시
	 * 요청하도록 하는 것이다. 이렇게 게시 글쓰기와 같이 DB 입력 작업이 연동되는 경우
	 * 사용자의 새로 고침(F5) 동작에 의해 동일한 요청이 다시 발생하여 DB에 입력되는 
	 * 데이터의 중복이 발생하거나 SQLException을 발생 시킬 수 있어 Redirect 기법을
	 * 사용한다. 이외에 다른 사이트로 이동시킬 필요가 있을 때에도 Redirect 기법을 사용 한다.
	 **/
	if(id.equals("admin") && pass.equals("1234")) {
		response.sendRedirect("sendRedirectLoginOk.jsp?id=" + id);
		
	} else {	
%>
<!DOCTYPE html>
<html>
<head>
<title>Redirect</title>
<script type="text/javascript">
	alert("아이디나 패스워드가 맞지 않습니다.");
	document.location.href("sendRedirectLoginForm.jsp");
</script>   
<%
	}
%>
</head>
<body><h2>로그인 실패</h2></body>
</html>