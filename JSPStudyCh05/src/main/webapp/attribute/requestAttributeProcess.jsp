<%-- request 내장 객체의 속성 사용하기 처리 페이지 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	/* POST 방식 요청인 경우 setCharacterEncoding("UTF-8")을 호출해
	 * 웹 브라우저의 인코딩 방식과 동일한 문자 셋인 UTF-8을 지정해야 
	 * 한글 데이터와 같은 유니코드 문자를 깨지지 않게 처리할 수 있다.
	 * 
	 * getParameter() 메서드가 호출되기 전에 setCharacterEncoding("UTF-8")
	 * 메서드를 먼저 호출해 request 영역의 문자 셋을 먼저 처리해야 한다.  
	 **/
	request.setCharacterEncoding("utf-8");

	String pName = request.getParameter("pName");	
	int price = Integer.parseInt(request.getParameter("price"));
	String manufacturer = request.getParameter("manufacturer");
	int discount = Integer.parseInt(request.getParameter("discount"));	
	
	/* request 내장객체의 속성은 한 번의 요청을 처리하는 서블릿과 JSP 페이지 간에
	 * 데이터를 공유하기 위해 사용되며 RequestDispatcher나 pageContext 객체의
	 * forward() 메소드를 이용해 요청 제어를 다른 페이지로 넘길 때 사용한다.
	 * forward 되는 JSP 페이지의 스크립틀릿이나 표현식에서 getAttribute() 메소드로
	 * 속성의 데이터를 읽어 올 수 있으며 EL을 이용해도 속성의 데이터를 읽어 올 수 있다. 
	 *
	 * 아래는 request 내장 객체의 setAttribute() 메소드로 사용해 request 영역의
	 * 속성에 데이터를 저장한다.
	 * request 영역의 속성에 저장할 수 있는 데이터는 기본형과 참조형 모두 가능하다.
	 **/   
	request.setAttribute("pName", pName);
	request.setAttribute("price", price);
	request.setAttribute("manufacturer", manufacturer);
	request.setAttribute("discount", discount);
	request.setAttribute("sPrice", (int) (price - (price * (discount / (float) 100))));
		
	pageContext.forward("requestAttributeResult.jsp");
	
	/* 다음과 같이 RequestDispatcher의 forward()를 사용해도 동일한 결과를 얻을 
	 * 수 있지만 JSP 페이지에서는 주로 pageContext를 사용해 포워딩 처리를 한다. 
	 **/	
	/* RequestDispatcher rd = 
		request.getRequestDispatcher("requestAttributeResult.jsp");
	rd.forward(request, response); */
%>   
