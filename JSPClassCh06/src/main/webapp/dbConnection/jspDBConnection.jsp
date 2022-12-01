<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*, com.jspstudy.ch06.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 오라클 사용자 정보, 접속 드라이버 정보, URL
	String user = "hr";
	String pass = "hr";
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String select = "SELECT * FROM jspbbs";
	
	// 1. 드라이버 로딩
	Class.forName(driver);
	
	// 2. DriverManager를 이용해 db 연결
	Connection conn = DriverManager.getConnection(url, user, pass);
	
	// 3. DB에 쿼리를 발행해 주는 객체 
	//  Statement, PreparedStatement
	// "SELECT * FROM jspbbs where no = 10"
	// Statement stmt = conn.createStatement();
	PreparedStatement pstmt = conn.prepareStatement(select);
	
	// 4. DB에 쿼리를 발행
	// SELECT : executeQuery()
	// INSERT, UPDATE, DELETE : executeUpdate()
	ResultSet rs = pstmt.executeQuery();	
	
	ArrayList<Board> boardList = new ArrayList<Board>();
	
	while(rs.next()) {
		Board b = new Board();
		b.setNo(rs.getInt("no"));
		b.setTitle(rs.getString("title"));
		b.setWriter(rs.getString("writer"));
		b.setRegDate(rs.getTimestamp("reg_date"));
		b.setReadCount(rs.getInt("read_count"));
		b.setFile(rs.getString("file1"));
		
		boardList.add(b);
	}
	
	
	// 5. DB 작업이 완료되면 접속을 종료함
	// DB 작업에서 사용한 객체를 취득한 역순으로 닫는다.
	if(rs != null) rs.close();
	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();
	
	String title = "게시글 리스트";
	//pageContext.setAttribute("title", title);
%>    
<c:set var="title" value="<%= title %>" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table{
		border: 1px solid blue;
		border-collapse: collapse;
	}
	th, td {
		border: 1px dotted blue;
		padding: 5px 10px;
	}
</style>
</head>
<body>
	<h1>${ title }</h1>
	<table>
	<tr>
		<th>no</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	
	<c:forEach var="board" items="<%= boardList %>">
	<tr>
		<td>${ board.no }</td>
		<td><a href="boardDetail.jsp?no=${ board.no }">${ board.title }</a></td>
		<td>${ board.writer }</td>
		<td>${ board.regDate }</td>
		<td>${ board.readCount }</td>
	</tr>
	</c:forEach>
	
	</table>

</body>
</html>