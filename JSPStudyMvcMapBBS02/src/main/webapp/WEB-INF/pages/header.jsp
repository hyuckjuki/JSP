<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- 
	/* 이 페이지에 taglib 지시자를 기술하지 않아도 jstl을 사용하는데 문제되지 않는다.
	 * 웹 템플릿 파일인 index.jsp가 서블릿 소스 파일로 변경될 때 include 지시자에
	 * 의해서 이 페이지도 java 소스 파일로 변경되어 index.jsp의 서블릿 소스 파일에
	 * 코드 조각으로 포함되기 때문이다. 즉 jstl과 관련된 설정이 이미 index.jsp에 
	 * 기술되어 있으므로 컴파일 타임에 하나의 소스 파일로 합쳐져 하나의 class 파일로 
	 * 컴파일 되기 때문에 이 페이지 에서 jstl을 문제없이 사용할 수 있는 것이다.
	 *<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	 **/
--%>
<header>
	<div id="logo">		
		<a href="${ pageContext.servletContext.contextPath }/boardList.mvc">
		<img src="https://via.placeholder.com/176x67" alt="Books2U" width="176" 
			height="67" /></a>
	</div>
	<div id="header_link">
		<ul>			
			<li>
				<a href='${ sessionScope.isLogin ? "logout.mvc" : "loginForm.mvc" }'>
					${ sessionScope.isLogin ? "로그아웃" : "로그인" }</a>
			</li>	
			<li>
			<c:if test="${ not sessionScope.isLogin }" >	
				<a href="#">회원가입</a>
			</c:if>
			<c:if test="${ sessionScope.isLogin }" >	
				<a href="#">정보수정</a>
			</c:if>
			</li>
			<li><a href="#">장바구니</a></li>			
			<li><a href="#">주문/배송조회</a></li>
			<li class="no_line"><a href="boardList.mvc">게시판</a></li>
		</ul>
	</div><br/>
	<div id="member_msg">
		<c:if test="${ sessionScope.isLogin }">			
			<span>안녕하세요 ${ sessionScope.id }님!</span>			
		</c:if>
	</div>
</header>