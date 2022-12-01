<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.ch06.vo.*,com.jspstudy.ch06.dao.*" %>
<%@ page import="java.util.*,java.io.*"%> 
<%@ page import="com.oreilly.servlet.*,com.oreilly.servlet.multipart.*"%> 

<%!
	static String uploadDir;
	static File parentFile;
	
	public void jspInit(){
		uploadDir = getServletContext().getInitParameter("uploadDir");
		String realPath = getServletContext().getRealPath(uploadDir);
		parentFile = new File(realPath);
		
		// 파일 객체에 지정한 위치에 디렉토리가 존재하지 않으면 새롭게 생성
		if(!(parentFile.exists() && parentFile.isDirectory())){
			parentFile.mkdir();
		}
		System.out.println("init - " + parentFile);
	}
%>
<%
	// 기존의 파라미터를 받는 방식은 문자 데이터를 받는 방식
	// MultipartRequest 객체에 필요한 매개 변수에 지정할 데이터 변수로 선언
	String realPath = application.getRealPath(uploadDir);
	
	// 업로드 되는 파일의 최대 크기 지정 - 100mb
	int maxFileSize = 1024 * 1024 * 100; // << 1mb  2^10 = 10^3 >> 1024 = 1kb
	
	String encoding = "utf-8";
	
	MultipartRequest multi = new MultipartRequest(
														request, realPath, maxFileSize, encoding,
														new DefaultFileRenamePolicy());
	
	String title = multi.getParameter("title");
	String writer = multi.getParameter("writer");
	String pass = multi.getParameter("pass");
	String content = multi.getParameter("content");

	// 2. Board 객체로 만들어서 DAO 넘겨줌 - BoardDao 사용
	Board b = new Board();
	b.setTitle(title);
	b.setWriter(writer);
	b.setPass(pass);
	b.setContent(content);

	// 파일 업로드에 대한 추가 - db에 파일정보를 추가하기
	String fileName = multi.getFilesystemName("file");
	System.out.println("업로드된 파일 명 : " + fileName);
	System.out.println("원본 파일 명 : " + multi.getOriginalFileName("file"));
	b.setFile(fileName);
		
	DBCPBoardDao dao = new DBCPBoardDao();
	dao.insertBoard(b);
	//데이터 넘기고...
	
	// 3. 특정 주소로 이동 시켜야 함 - Redirect
	// 같은 동작을 계속하게 되는 문제가 발생
	response.sendRedirect("boardList.jsp");
%>