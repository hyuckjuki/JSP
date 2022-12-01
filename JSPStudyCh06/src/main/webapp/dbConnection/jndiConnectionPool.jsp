<%-- Apache Commons DBCP와 JNDI를 이용해 커넥션 풀 사용하기 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*" %>
<%@ page import="java.util.*,com.jspstudy.ch06.vo.Board" %>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	
	String select = "SELECT * FROM jspbbs";	

	/* 1. 자바 네이밍 서비스를 사용하기 위해 
	 * javax.naming 패키지의 InitialContext 객체를 생성한다.
	 *
	 * 이 예제는 commons-dbcp2-2.8.x.jar, commons-pool2-2.10.x.jar
	 * 그리고 commons-logging-1.2.jar를 참조하므로 이들 라이브러리를 
	 * http://commons.apache.org에서 다운 받아 WEB-INF/lib에 추가해야 한다. 
	 * 또한 오라클 접속 드라이버도 필요하므로 http://www.oracle.com에서
	 * 다운로드 받아  WEB-INF/lib 폴더에 추가해야 한다.
	 **/ 
	Context initContext = new InitialContext();
	
	/* 2. InitialContext 객체를 이용해 디렉토리 서비스에서 필요한 객체를
	 * 찾기 위해 기본 네임스페이스를 인자로 지정해 Context 객체를 얻는다.
	 *
	 * 디렉토리 서비스에서 필요한 객체를 찾기 위한 일종의 URL 개념으로 
	 * 디렉토리 방식을 사용하므로 java:comp/env와 같이 지정한다.
	 **/
	Context envContext = (Context) initContext.lookup("java:/comp/env");
	
	/* 3. "jdbc/membersDBPool" 이름을 가진 DBCP에서 DataSource 객체를 얻는다.
	 * context.xml 파일에서 지정한 수의 커넥션을 생성해 커넥션 풀에 저장한다.
	 * "java:/comp/env"는 JNDI에서 기본적으로 사용하는 네임스페이스 이고 
	 * "jdbc/bbsDBPool"은 DBCP 이름으로 임의로 지정하여 사용할 수 있다.
	 **/
	DataSource ds = (DataSource) envContext.lookup("jdbc/bbsDBPool");
	
	// 4. DataSource 객체를 이용해 DPCP로 부터 커넥션을 대여한다.
	Connection conn = ds.getConnection();
	
	/* 5. DBMS에 SQL 쿼리를 발생하기 위해 활성화된 
	 * Connection 객체로 부터 PreparedStatement 객체를 얻는다.
	 **/
	PreparedStatement pstmt = conn.prepareStatement(select);
	
	// 6. 쿼리를 실행하여 SELCET한 결과를 ResultSet 객체로 받는다.
	ResultSet rs = pstmt.executeQuery();
	
	/* 7. 반복문 안에서 Board 객체를 생성하고 ResultSet으로 부터 데이터를
	 * 읽어와 Board 객체의 각 프로퍼티의 값으로 설정하고 ArrayList에 추가한다.
	 **/	
	ArrayList<Board> bList = new ArrayList<Board>();
	
	while(rs.next()) {
		/* 반복문 안에서 ResultSet 객체의 getXXX() 메서드를 이용해 데이터를 
		 * 읽어올 수 있다. ResultSet 객체는 자바의 모든 타입에 대응되는 getXXX()
		 * 메서드를 제공하고 있으며 아래와 같이 컬럼의 위치(첫 번째, 두 번째...) 값을 
		 * 정수로 지정하거나 컬럼 이름을 지정해 데이터를 읽어 올 수 있다. 
		 **/
		int no = rs.getInt(1);
		String title = rs.getString(2);
		String writer = rs.getString(3);
		String content = rs.getString(4);
		Timestamp regDate = rs.getTimestamp("reg_date");
		int readCount = rs.getInt("read_count");
		String pass = rs.getString("pass");
		String file = rs.getString("file1");
		
		Board board = new Board(no, title, writer, content, regDate, readCount, pass, file);
		bList.add(board);
	}

	request.setAttribute("bList", bList);	
	
	// 8. 사용한 ResultSet과 PreparedStatement를 종료한다.
	if(rs != null) rs.close();
	if(pstmt != null) pstmt.close();
	
	// 9. 커넥션 풀로 Connection 객체를 반환한다.
	if(conn != null) conn.close();		
	
	// View 페이지를 지정하여 pageContext 내장객체의 forward() 메소드 호출
	pageContext.forward("jndiConnectionPoolView.jsp");	
%>
