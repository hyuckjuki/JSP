<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.bbs.dao.*,com.jspstudy.bbs.vo.*" %>    
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%!
	// 한 페이지에 보여 줄 게시 글의 수를 상수로 선언하고 있다.
	final int PAGE_SIZE = 5;
	 
	/* 한 페이지에 보여 질 페이지 그룹의 수를 상수로 선언하고 있다.
	 * [이전] 1 2 3 4 5 6 7 8 9 10 [다음]	
	 **/
	final int PAGE_GROUP = 10;	
%>
<%
	// 요청 파라미터로 넘어 온 페이지 번호를 읽어온다.
	String pageNum = request.getParameter("pageNum");
	
	/* pageNum이 null 이면 처음 게시 글 리스트를 요청하거나 게시 글쓰기에서 
	 * Redirect 되어 넘어온 요청으로 pageNum을 1페이지로 설정한다.
	 * 즉 첫 번째 페이지에 해당하는 게시 글 리스트를 화면에 출력한다. 
	 **/
	if(pageNum == null) {
		pageNum = "1";
	}

	// 요청 파라미터의 pageNum을 int 형으로 변환하여 현재 페이지로 설정
	int currentPage = Integer.parseInt(pageNum);
	
	/* 요청한 페이지에 해당하는 게시 글의 첫 번째 행의 값을 계산한다.
	 * 현재 페이지가 1일 경우 startRow는 1, 2페이지 일 경우 startRow는 6이 된다.	 
	 * 
	 * 테이블에서 현재 페이지에 해당하는 게시 글을 검색할 때 ROWNUM을 사용했다.
	 * ROWNUM은 쿼리의 결과로 검색되는 행들의 순서 값을 가진 의사컬럼으로
	 * 1부터 시작한다. 예를 들어 3페이지에 해당하는 게시 글 리스트를 가져 온다면
	 * 한 페이지에 보여줄 게시 글의 수가 5개로 지정되어 있으므로 startRow는 11이 된다. 
	 * 즉 아래의 공식에 의해 startRow(11) = 3 * 5 - (5 - 1);
	 * 첫 번째 페이지 startRow = 1, 두 번째 페이지 startRow = 6이 된다.
	 **/ 
	int startRow = currentPage * PAGE_SIZE - (PAGE_SIZE - 1);
	//int startRow = (currentPage - 1) * PAGE_SIZE + 1;
	
	int endRow = startRow + PAGE_SIZE - 1;	
	int listCount = 0;	
	
	// BoardDao 객체를 생성하고 게시 글 개수를 읽어온다.
	BoardDao dao = new BoardDao();
	listCount = dao.getBoardCount();
	
	// 현재 페이지에 해당하는 게시 글 리스트를 DB에서 읽어온다.
	ArrayList<Board> bList = dao.boardList(startRow, endRow);	
	
	/* 페이지 그룹 이동 처리를 위해 게시판의 전체 페이지 수를 계산한다.
	 * [이전] 11 12 13...   또는   ... 8 9 10 [다음] 처리
	 * 전체 페이지 = 전체 게시 글 수 / 한 페이지에 표시할 게시 글 수가 되는데 
	 * 이 계산식에서 나머지가 존재하면 전체 페이지 수는 전체 페이지 + 1이 된다.
	 **/
	int pageCount = listCount / PAGE_SIZE 
				+ (listCount % PAGE_SIZE == 0 ? 0 : 1);
	
	/* 페이지 그룹 처리를 위해 페이지 그룹별 시작 페이지와 마지막 페이지를 계산하여
	 * 페이지 그룹의 시작 페이지 : 1, 11, 21, 31...
	 * 첫 번째 페이지 그룹에서 페이지 리스트는 1 ~ 10 되므로 currentPage가
	 * 1 ~ 10 사이에 있으면 startPage는 1이 되고 11 ~ 20 사이는 11이 된다. 
	 *
	 * 정수형 연산의 특징을 이용해 startPage를 아래와 같이 구할 수 있다.
	 * 아래 계산식으로 계산된 결과를 보면 현재 그룹의 마지막 페이지일 경우
	 * startPage가 다음 그룹의 시작 페이지가 나오게 되므로 삼항 연산자를
	 * 사용해 현재 페이지가 속한 그룹의 startPage가 되도록 조정 하였다.
	 **/
	 int startPage = (currentPage / PAGE_GROUP) * PAGE_GROUP + 1
		- (currentPage % PAGE_GROUP == 0 ? PAGE_GROUP : 0);
		
	// 현재 페이지 그룹의 마지막 페이지 : 10, 20, 30...
	int endPage = startPage + PAGE_GROUP - 1;
	
	/* 위의 식에서 endPage를 구하게 되면 endPage는 항상 PAGE_GROUP의
	 * 크기만큼 증가(10, 20, 30 ...) 되므로 맨 마지막 페이지 그룹의 endPage가
	 * 정확하지 못할 경우가 발생하게 된다. 다시 말해 전체 페이지가 53페이지 라고
	 * 가정하면 위의 식에서 계산된 endPage는 60 페이지가 되지만 실제로 
	 * 60페이지는 존재하지 않는 페이지이므로 문제가 발생하게 된다.
	 * 그래서 맨 마지막 페이지에 대한 보정이 필요하여 아래와 같이 endPage와
	 * pageCount를 비교하여 현재 페이지 그룹에서 endPage가 pageCount 보다
	 * 크다면 pageCount를 endPage로 지정 하였다. 즉 현재 페이지 그룹이
	 * 마지막 페이지 그룹이면 endPage는 전체 페이지 수가 되도록 지정한 것이다.
	 **/
	if(endPage > pageCount) {
		endPage = pageCount;
	}	
%>
<!-- 아래에서 EL로 접근하기 위해서 pageContext 영역의 속성으로 저장 -->
<c:set var="bList" value="<%= bList %>" />
<c:set var="currentPage" value="<%= currentPage %>" />
<c:set var="pageGroup" value="<%= PAGE_GROUP %>" /> 
<c:set var="pageCount" value="<%= pageCount %>" />
<c:set var="startPage" value="<%= startPage %>" />
<c:set var="endPage" value="<%= endPage %>" />
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
	<!-- 게시 글 리스트가 존재할 경우 -->	
	<c:if test="${ not empty bList }">
		<c:forEach var="b" items="${ bList }" varStatus="status">		
		<tr class="listTr">
			<td class="listTdNo">${ b.no  }</td>
			<td class="listTdTitle">
				<a href="boardDetail.jsp?no=${ b.no }&pageNum=
					<%= currentPage %>" >${ b.title }</a></td>
			<td class="listTdWriter">${ b.writer }</td>
			<td class="listTdRegDate"><fmt:formatDate value="${ b.regDate }" 
				pattern="yyyy-MM-dd HH:mm:ss" /></td>
			<td class="listTdReadCount">${ b.readCount }</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="5" class="listPage">
			<%--
			/* 현재 페이지 그룹의 시작 페이지가 pageGroup보다 크다는 것은
			 * 이전 페이지 그룹이 존재한다는 것으로 현재 페이지 그룹의 시작 페이지에
			 * pageGroup을 마이너스 하여 링크를 설정하면 이전 페이지 그룹의
			 * startPage로 이동할 수 있다.
		 	 **/
		 	 --%>
			<c:if test="${ startPage > pageGroup}">
				<a href="boardList.jsp?pageNum=${startPage - pageGroup}">[이전]</a>
			</c:if>
			<%--
			/* 현재 페이지 그룹의 startPage 부터 endPage 만큼 반복하면서
		 	 * 현재 페이지와 같은 그룹에 속한 페이지를 화면에 출력하고 링크를 설정한다.
		 	 * 현재 페이지는 링크를 설정하지 않는다.
		 	 **/
		 	--%>
		 	<c:forEach var="i"  begin="${startPage}" end="${endPage}" >
		 		<c:if test="${ i eq currentPage }">
		 			[ ${i} ]
		 		</c:if>
		 		<c:if test="${ i != currentPage }">		 			
		 			<a href="boardList.jsp?pageNum=${i}"> [ ${i} ] </a>
		 		</c:if>
		 	</c:forEach>
		 	
		 	<%-- 
			/* 현재 페이지 그룹의 마지막 페이지가 전체 페이지 보다 작다는 것은
			 * 다음 페이지 그룹이 존재한다는 것으로 현재 페이지 그룹의 시작 페이지에
			 * pageGroup을 플러스 하여 링크를 설정하면 다음 페이지 그룹의
			 * startPage로 이동할 수 있다.
		 	 **/
		 	 --%>
		 	 <c:if test="${endPage < pageCount}">
		 	 	<a href="boardList.jsp?pageNum=${startPage + pageGroup}">[다음]</a>	
		 	 </c:if>
			</td>
		</tr>
	</c:if>
	<!-- 게시 글 리스트가 존재하지 않을 경우 -->
	<c:if test="${ empty bList }">
		<tr>
			<td colspan="5" class="listTdSpan">게시 글이 존재하지 않습니다.</td>
		</tr>
	</c:if>
	</table>
</body>
</html>



