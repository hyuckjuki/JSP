<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.ch06.vo.*, com.jspstudy.ch06.dao.*" %>
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
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	/* 테이블에서 하나의 게시 글 정보를 읽어오기 위해서 boardList.jsp에서 
	 * 게시 글 상세보기 요청을 하면서 테이블에서 게시 글 하나를 유일하게 구분할 수 있는
	 * 게시 글 번호를 요청 파라미터로 보냈기 때문에 이 게시 글 번호를 요청 파라미터로 
	 * 부터 읽어 DBCPBoardDao를 통해서 no에 해당하는 게시 글 정보를 읽을 수 있다.
	 *
	 * 아래에서 no라는 요청 파라미터가 없다면 NumberFormatException 발생
	 **/
	String no = request.getParameter("no");	
	
	// DBCPBoardDao 객체를 생성하고 게시 글 번호(no)에 해당하는 게시 글을 정보를 읽어온다.
	DBCPBoardDao dao = new DBCPBoardDao();
	Board board = dao.getBoard(Integer.valueOf(no));	
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
	
	아래는 pageContext("board", board)와 같은 코드이다.
--%>
<c:set var="board" value="<%= board %>" scope="page" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시 글 내용보기</title>
	<link type="text/css" href="../css/board.css" rel="stylesheet" />
	<script src="../js/jquery-3.3.1.min.js"></script>
	<script src="../js/formcheck.js"></script>
</head>
<body>
<%--
	아래는 게시 글 수정 폼 요청과 게시 글 삭제 요청에 사용할 숨김 폼 이다.
	
	아래의 수정하기 버튼과 삭제하기 버튼이 클릭되면 jQuery를 이용해 게시 글
	비밀번호가 입력되었는지 체크하여 입력되지 않았으면 게시 글 비밀번호를 
	입력해 달라고 팝업 창을 띄우고 비밀번호가 입력되었으면 게시 글 번호와
	비밀번호를 각각 no와 pass에 설정하고 게시 글 수정 폼페이지 요청과 삭제하기
	요청을 수행한다.	
	
	게시 글 수정은 게시 글 등록과는 다르게 기존의 게시 글을 수정 폼에 보여줘야
	한다. 게시 글 수정 폼 요청시 테이블에서 수정하고자 하는 게시 글을 유일하게
	구분할 수 있는 데이터를 요청 파라미터로 보내야 그 게시 글에 해당하는 정보를
	읽어와 게시 글 수정 폼에 출력할 수 있다. 또한 게시 글 삭제 요청도 테이블에서 
	삭제하고자 하는 게시 글의 정보를 유일하게 구분할 수 있는 게시 글 번호를 요청
	파라미터로 보내야 그 게시 글에 해당하는 정보를 테이블 삭제할 수 있다. 	  
--%>
<form name="checkForm" id="checkForm">
	<input type="hidden" name="no" id="rNo" />
	<input type="hidden" name="pass" id="rPass" />
</form>
<table class="contentTable">
	<tr>
		<td colspan="4" class="boardTitle"><h2>글 내용 보기</h2></td>
	</tr>
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<%-- 
		표현언어(EL)를 사용해 내장객체의 속성 명을 지정하면 내장객체의 속성에 저장된
		데이터를 읽어 올 수 있다. 스크립팅요소를 사용하는 것에 비해 더 간단히 내장객체
		영역에 저장된 속성의 값을 읽을 수 있다. 
		표현언어(EL)를 사용해 속성 이름을 지정하면 pageContext, request, session, 
		application 4개의 영역에 저장된 속성을 작은 범위에서 큰 범위 순으로 검색하여
		지정한 이름의 속성에 대한 값을 얻어 올 수 있다. 속성이 존재하지 않아도 
		NullPointerException은 발생하지 않고 아무것도 출력되지 않는다.
		내장객체의 속성에 객체가 저장되어 있으면 내장객체의 속성 명과 dot 연자자(.)를 
		사용해 객체의 프로퍼티(인스턴스 변수) 값을 읽어 올 수 있다. 표현언어(EL)로 객체의
		프로퍼티를 읽기 위해서는 그 객체의 클래스에 읽어 올 프로퍼티에 대한 getter 
		메서드가 반드시 존재해야 한다. 그렇지 않으면 JasperException이 발생한다.
	--%>	
	<tr>
		<td class="contentTh">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
		<td class="contentTd" colspan="3">${ board.title }</td>		
	</tr>
	<tr>
		<td class="contentTh">글쓴이</td>
		<td class="contentTd">${ board.writer }</td>
		<td class="contentTh">작성일</td>
		<td class="contentTd"><fmt:formatDate value="${ board.regDate}" 
			pattern="yyyy-MM-dd HH:mm:ss" /></td>		
	</tr>
	<tr>		
		<td class="contentTh">비밀번호</td>
		<td class="contentTd"><input type="text" name="pass" id="pass"></td>
		<td class="contentTh">조회수</td>
		<td class="contentTd">${ board.readCount }</td>
	</tr>	
	<tr>
		<td class="contentTh">파&nbsp;&nbsp;&nbsp;&nbsp;일</td>
		<td class="contentTd" colspan="3">
		<c:if test="${ empty board.file }">
			첨부파일 없음
		</c:if>
		<c:if test="${ not empty board.file }">
			<a href="../upload/<%= board.getFile() %>">파일 다운로드</a>
		</c:if>
		</td>		
	</tr>
	<tr>		
		<td class="readContent" colspan="4">
			<pre>${ board.content }</pre>
		</td>
	</tr>	
	<tr>
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="4" class="tdSpan">
			<input type="button" id="detailUpdate" data-no="${ board.no }" value="수정하기"/>
			&nbsp;&nbsp;<input type="button" id="detailDelete" value="삭제하기" />			
			&nbsp;&nbsp;<input type="button" value="목록보기" 
				onclick="javascript:window.location.href=
					'boardList.jsp'"/></td>
	</tr>
</table>
</body>
</html>
