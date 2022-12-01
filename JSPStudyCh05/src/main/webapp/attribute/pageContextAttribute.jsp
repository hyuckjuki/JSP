<%-- pageContext 내장 객체의 속성 사용하기 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("utf-8");
	String title = request.getParameter("title");
	String memo = request.getParameter("memo");
	
	/* pageContext 내장객체의 속성은 한 번의 요청을 처리하는 같은 JSP 페이지 내에서
	 * 데이터를 공유하기 위해서 사용되며 주로 같은 JSP 내에서 스크립틀릿과 
	 * EL(Expression Language) 간의 데이터를 교환할 때 사용된다. 
	 * 아래는 pageContext 내장객체의 setAttribute()를 이용해 "title", "memo"라는
	 * 이름을 부여해 page 영역에 데이터를 저장하고 있다.
	 * pageContext 영역의 속성에 저장할 수 있는 데이터는 기본형과 참조형 모두 가능하다.
	 **/
	pageContext.setAttribute("title", title);
	pageContext.setAttribute("memo", memo);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pageContext 속성 사용하기</title>
</head>
<body>
	<%-- 
		EL를 사용해 속성 이름을 지정하면 pageContext, request, 
		session, application 4개의 영역에 저장된 속성을 작은 범위에서 
		큰 범위 순으로 검색하여 지정한 이름의 속성에 대한 값을 얻어 올 수 있다. 
		속성이 존재하지 않아도 NullPointerException은 발생하지 않는다.
	--%>		
	제목 : ${ title }<br/>
	내용 : <br/>${ memo }<br/>
</body>
</html>