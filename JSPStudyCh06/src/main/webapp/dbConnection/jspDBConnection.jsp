<%-- JSP페이지에서 데이터베이스 접속해 데이터 읽어오기 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, com.jspstudy.ch06.vo.*" %>
<%-- 
	JSP 표준 태그 라이브러리(JSTL)를 사용하기 위한 taglib 지시자
	http://jakarta.apache.org, http://tomcat.apache.org 에서
	다운로드 하여 WEB-INF/lib 폴더에 추가해야 표준 태그라이브러리를 사용할 수 있다.
 --%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	// 오라클 사용자 정보와 접속 드라이버 이름 및 접속 URL 등을 변수에 저장
	String user = "hr";
	String pass = "hr";
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url ="jdbc:oracle:thin:@localhost:1521:xe";	
	String title = "게시 글 리스트";	
	String select = "SELECT * FROM jspbbs";
	
	/* 1. 접속하려는 DBMS의 드라이버를 로딩 한다.
	 * Oracle 드라이버를 다운로드 하여 WEB-INF/lib 폴더에 추가해야 한다.
	 **/
	Class.forName(driver);	
	
	// 2. 데이터베이스 연결 - DB 커넥션을 생성한다.
	Connection conn = DriverManager.getConnection(url, user, pass);	
	
	/* 3. DBMS에 SQL 쿼리를 발생하기 위해 활성화된 
	 * Connection 객체로 부터 Statement 객체를 얻는다.
	 **/
	Statement stmt = conn.createStatement();
	
	// 4. 쿼리를 실행하여 SELCET한 결과를 ResultSet 객체로 받는다.
	ResultSet rs = stmt.executeQuery(select);
	
	// 여러 개의 게시 글을 ArrayList에 저장하기 위한 객체 생성 
	ArrayList<Board> boardList = new ArrayList<Board>();
	
	/* 5. 쿼리 실행 결과를 바탕으로 while문을 이용해 데이터를 출력한다.
	 *	ResultSet의 next() 메서드는 다음 행의 데이터가 존재하면 true를 반환하므로
	 * while 문을 이용해 첫 번째 행부터 마지막 행까지 이동하면서 데이터를 추출할 수 있다.
	 *
	 * 반복문 안에서 ResultSet 객체의 getXXX() 메서드를 이용해 데이터를 
	 *	읽어올 수 있다. ResultSet 객체는 자바의 모든 타입에 대응되는 getXXX()
	 *	메서드를 제공하고 있으며 아래와 같이 컬럼의 위치(첫 번째, 두 번째...) 값을 
	 *	정수로 지정하거나 컬럼 이름을 지정해 데이터를 읽어 올 수 있다.
	 **/	 
	while(rs.next()) {
		Board b = new Board();
		b.setNo(rs.getInt(1));
		b.setTitle(rs.getString("title"));
		b.setWriter(rs.getString(3));
		b.setRegDate(rs.getTimestamp(5));
		b.setReadCount(rs.getInt("read_count"));
		
		boardList.add(b);
	}
	
	/* 6. 사용한 ResultSet과 Statement 객체를 종료 한다.
	 * 객체를 생성한 역순으로 닫으면 된다.
	 **/
	if(rs != null) rs.close();
	if(stmt != null) rs.close();
	
	// 7. DBMS 연결을 종료한다.
	if(conn != null) rs.close();
%>
<%--
	이 페이지에서는 JSTL의 코어 라이브러리에 속한 <c:set> 태그를 사용하여
	pageContext, request, session, application 4개의 영역에 
	속성으로 데이터를 저장하고 EL 식을 이용해 출력하는 기법을 소개하고 있다.
	
	JSTL의 코어 라이브러리는 말 그대로 JSTL의 가장 핵심적인 기능을 제공하는
	라이브러리로 프로그래밍 언어에서 일반적으로 제공하고 있는 변수 선언, 조건문,
	반복문에 해당하는 태그를 지원한다. 또한 익셉션, URL 저장, 데이터 출력과 관련된
	태그와 다른 JSP 페이지 호출(import, redirect)과 관련된 태그를 지원한다.
	
	아래는 <c:set> 태그를 이용해 pageContext 영역의 속성에 title 이라는
	속성 이름으로 위에서 title 변수에 저장한 문자열 데이터를 저장하고 있다. 
	아래와 같이 scope에 데이터를 저장할 수 있는 속성을 제공하는 내장 객체를
	의미하는 page, request, session, application을 지정할 수 있다.
	scope가 생략되면 기본 값은 page로 설정되어 pageContext 객체에 저장된다.
--%>
<c:set var="title" value="<%= title %>" scope="page"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP페이지에서 데이터베이스에 접속해 데이터 읽어오기</title>
<style type="text/css">
	table{
		border: 1px solid blue;
		border-collapse: collapse;
	}
	td {
		border: 1px dotted blue;
		padding: 5px 10px;
	}
</style>
</head>
<body>
	<%-- <c:set> 태그를 사용해 pageContext 속성에 저장한 데이터 출력  --%>	
	<h1>${ title }</h1>
	<table>
		<tr>
			<td>no</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>	
		<!-- items에 스크립틀릿에서 정의한 boardList를 표현식으로 지정할 수 있다. -->
		<c:forEach var="board" items="<%= boardList %>"> 
		<tr>
			<td>${ board.no }</td>
			<td>${ board.title }</td>
			<td>${ board.writer }</td>
			<td>${ board.regDate }</td>
			<td>${ board.readCount }</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>