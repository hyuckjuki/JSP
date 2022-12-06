<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<header>
	<div id="logo">
		<img src="https://via.placeholder.com/176x67" alt="Books2U" width="176" 
			height="67" />
	</div>
	<div id="header_link">
		<ul>	
			<!--  로그인 상태일 때 " 로그아웃 , 로그인이 아닐 때 " 로그인 " -->		
			<li>		
				<a href='${ sessionScope.isLogin ? "sessionLogout.jsp" 
							: "sessionLoginMain.jsp?body=pages/loginForm.html"}'>
				${sessionScope.isLogin ? "로그아웃" : "로그인"}
				</a>		
			</li>	
			<li>	
			<c:if test="${ not sessionScope.isLogin }" >	
				<a href="#">회원가입</a>
			</c:if>
			<c:if test="${ sessionScope.isLogin }" >	
				<a href="#">정보수정</a>
			</c:if>			
			<li><a href="#">장바구니</a></li>			
			<li><a href="#">주문/배송조회</a></li>
			<li class="no_line"><a href="?body=pages/boardList.html">게시판</a></li>
		</ul>
	</div><br/>	
	<div id="member_msg">		
		<c:if test="${ sessionScope.isLogin }">			
			<span>안녕하세요 ${ sessionScope.id }님!</span>			
		</c:if>
	</div>		
</header>