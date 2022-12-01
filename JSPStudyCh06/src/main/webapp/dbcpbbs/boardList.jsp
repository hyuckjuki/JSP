<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.ch06.dao.*, com.jspstudy.ch06.vo.*" %>    
<%@ page import="java.util.*" %>
<%-- 
	JSP 표준 태그 라이브러리(JSTL)를 사용하기 위한 taglib 지시자
	http://jakarta.apache.org, http://tomcat.apache.org 에서
	다운로드 하여 WEB-INF/lib 폴더에 추가해야 표준 태그를 사용할 수 있다. 
	이 페이지에서는 JSTL의 코어 라이브러리에 속한 <c:set> 태그를 사용하여
	pageContext, request, session, application 4개의 영역에 
	속성으로 데이터를 저장하고 EL 식을 이용해 출력하는 기법을 소개하고 있다.
	JSTL의 코어 라이브러리는 말 그대로 JSTL의 가장 핵심적인 기능을 제공하는
	라이브러리로 프로그래밍 언어에서 일반적으로 제공하고 있는 변수 선언, 조건문,
	반복문에 해당하는 태그를 지원한다. 또한 익셉션, URL 저장, 데이터 출력과 관련된
	태그와 다른 JSP 페이지 호출(import, redirect)과 관련된 태그를 지원한다.	   
 --%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	// DBCPBoardDao 객체를 생성하고 데이터베이스에서 게시 글 리스트를 읽어온다.
	DBCPBoardDao dao = new DBCPBoardDao();
	ArrayList<Board> bList = dao.boardList();
%> 
<%-- 
	JSP 페이지에서 사용할 변수를 선언하고 초기 값을 설정하고 있다.
	<c:set> 태그로 변수를 선언할 때는 변수의 타입은 지정하지 않으며 var 속성에
	변수의 이름을 지정하고 value 속성에 변수의 초기 값을 필히 지정해야 한다. 
	scope 속성에는 page, request, session, application 중 하나를
	지정할 수 있으며 생략 가능하다. 생략하게 되면 기본 값은 page로 지정된다.
	scope 속성을 지정하는 것에서 알 수 있듯이 여기에 선언한 변수는 EL식 안에서
	사용할 수 있고 스크립팅 요소에서는 사용할 수 없다. 즉 스크립팅 요소에서 선언한
	자바 코드의 변수가 되는 것이 아니라 위의 4개 영역에 속성으로 저장하는 방식인
	setAttribute()가 호출되어 scope에 지정한 영역에 속성으로 저장된다.
--%>
<c:set var="bList" value="<%= bList %>" scope="page"/>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시 글 리스트</title>
<link type="text/css" href="../css/board.css" rel="stylesheet">
</head>
<body>	
	<table class="listTable">
		<tr><td class="boardTitle" colspan="5"><h2>게시 글 리스트</h2></td></tr>
		<tr>
			<td colspan="5">
				<form name="searchForm" id="searchForm" action="#">
					<select name="type">
						<option value="title">제목</option>
						<option value="writer">작성자</option>
						<option value="content">내용</option>
					</select>
					<input type="text" name="keyword" />
					<input type="submit" value="검색" />
				</form>
			</td>
		</tr>
		<tr>
			<td colspan="5" class="listWrite"><a href="writeForm.jsp">글쓰기</a></td>
		</tr>
		<tr>
			<th class="listThNo">NO</th>
			<th class="listThTitle">제목</th>
			<th class="listThWriter">작성자</th>
			<th class="listThRegDate">작성일</th>
			<th class="listThReadCount">조회수</th>
		</tr>	
	<%-- 
		<c:if> 태그의 test 속성에 조건식을 기술하며 이 조건식이 참일 때 
		<c:if> ~ </c:if> 사이의 코드가 실행된다.
		
		게시 글 리스트가 존재하면 게시 글 수만큼 반복하면서 게시 글을 출력		
	--%>	
	<c:if test="${ not empty bList }">
		<%-- 
			<c:forEach> 태그는 자바의 for문과 forEach문 두 가지 기능을 제공한다.
			자바의 for문과 같이 초깃값부터 순차적으로 반복하기 위해 아래와 같은 
			속성을 지정하여 사용한다. var 속성에는 forEach문 안에서 사용할 변수 
			이름을 지정하고 begin 속성은 var 속성에 지정한 변수의 시작 값을 지정하며
			end 속성에는 변수의 끝 값을 지정한다.(i <= end 가 적용된다.)
			step 속성은 생략할 수 있고 생략하게 되면 기본 값은 1이 된다.
			
			<c:forEach var="i" begin="0" end="10" step="1" >
			
			아래에 사용된 코드는 forEach문의 기능을 하는 코드로 items 속성에 배열
			변수의 이름을 지정하고 var 속성에 forEach문 안에서 배열의 각 항목을
			저장하는 변수의 이름을 지정한다. items 속성에 지정할 수 있는 변수는
			스크립틀릿에서 선언한 변수를 표현식<%= member %>으로 지정할 수
			있고 아래와 같이 속성에 저장된 속성 이름을 EL 식을 이용해 지정할 수도 있다. 
			items 속성에 지정할 수 있는 데이터는 배열, Collection 객체,	Iterator 객체, 
			Enumeration 객체, Map 객체와 콤마(,)로 구분된 문자열 등을 지정할 수 있다. 
		 --%>
	<c:forEach var="b" items="${ bList }" varStatus="status">		
		<tr class="listTr">
			<td class="listTdNo">${ b.no  }</td>
			<td class="listTdTitle">
				<%-- 
					반복문 안에서 한 행의 게시 글을 출력하면서 
					게시 글 세부 보기로 넘어갈 수 있도록 링크를 설정 
				--%>
				<a href="boardDetail.jsp?no=${ b.no }" >${ b.title }</a></td>
			<td class="listTdWriter">${ b.writer }</td>
			<td class="listTdRegDate"><fmt:formatDate value="${ b.regDate }" 
				pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td class="listTdReadCount">${ b.readCount }</td>
		</tr>
	</c:forEach>
	</c:if>	
	<%-- 게시 글 리스트가 존재하지 않으면 --%>
	<c:if test="${ empty bList }">
		<tr>
			<td colspan="5" class="listTdSpan">게시 글이 존재하지 않습니다.</td>
		</tr>
	</c:if>
	<%-- 
		위에서 사용한 <c:if>을 다음과 같이 <c:choose>를 이용해 구현할 수도 있다. 
		<c:choose>는 자바의 switch문과 비슷하다. <c:choose> 태그 안에
		<c:when> 태그의 test 속성에 표현식과 EL 식을 이용해 조건식을 지정한다.
		<c:otherwise> 태그는 어떠한 조건식도 만족하지 않을 경우 실행 된다.
	--%>	
	<%-- 
	<c:choose>
		<c:when test="${ not empty bList }">
			<c:forEach var="b" items="${ bList }" varStatus="status">		
				<tr class="listTr">
					<td class="listTdNo">${ b.no  }</td>
					<td class="listTdTitle">
						<a href="boardDetail.jsp?no=${ b.no }" >${ b.title }</a></td>
					<td class="listTdWriter">${ b.writer }</td>
					<td class="listTdRegDate"><fmt:formatDate value="${ b.regDate }" 
						pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td class="listTdReadCount">${ b.readCount }</td>
				</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="5" class="listTdSpan">게시 글이 존재하지 않습니다.</td>
			</tr>
		</c:otherwise>		
	</c:choose>
	 --%>
	</table>
</body>
</html>