<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*" %>    
<%@ page import="java.sql.*, java.io.*"  %>
<%@ page import="com.jspstudy.bbs.vo.*, com.jspstudy.bbs.dao.*"  %>
<%!
	static String uploadDir;
	static File parentFile;

	public void jspInit() {		
		// web.xml에 지정한 웹 어플리케이션 초기화 파라미터를 읽는다.
		uploadDir = getServletContext().getInitParameter("uploadDir");
		
		/* 웹 어플리케이션 초기화 파라미터로 읽어온 이미지가 저장될 폴더의 
		 * 로컬 경로를 구하여 그 경로와 파일명으로 File 객체를 생성한다.
		 **/
		String realPath = getServletContext().getRealPath(uploadDir);		
		parentFile = new File(realPath);
		
		/* 파일 객체에 지정한 위치에 디렉토리가 존재하지 않거나 
		 * 파일 객체가 디렉토리가 아니라면 디렉토리를 생성한다.
		 **/
		if(! (parentFile.exists() && parentFile.isDirectory())) {
			parentFile.mkdir();
		}
		System.out.println("init - " + parentFile);		
	}
%>
<%
	/* cos 라이브러리를 이용한 파일 업로드 구현하기 
	 * 
	 * 1. MultipartRequest의 생성자 매개변수에 지정할 데이터를 설정 
	 *
	 * 파일이 저장될 폴더의 로컬 경로를 구한다. 
	 **/
	String realPath = application.getRealPath(uploadDir);
	
	// 업로드 파일의 최대 크기를 100MB로 지정
	int maxFileSize = 100 * 1024 * 1024;
	
	// 파일의 인코딩 타입을 UTF-8로 지정
	String encoding = "UTF-8"; 
		
	/* 2. 파일 업로드를 처리할 MultipartRequest 객체 생성
	 * 
	 * WEB-INF/lib/cos.jar 파일을 살펴보면 MultipartRequet 클래스는 
	 * com.oreilly.servlet 패키지에 위치하며 파일 업로드를 직접적으로 처리하는
	 * 역할을 담당하는 클래스로 파일 업로드와 관련된 다양한 메소드를 정의하고 있다.
	 * 생성자는 5개로 오버로딩 되어 있고 아래 생성자가 호출되도록 정의되어 있다.
	 *
	 *	public MultipartRequest(HttpServletRequest request,
	 *			String saveDirectory,
	 *			int maxPostSize,
	 *			String encoding,
	 *			FileRenamePolicy policy) throws IOException {...}
	 *
	 * 이 생성자를 살펴보면 request, saveDirectory, maxPostSize는 필수사항으로
	 * 이 매개변수가 null이거나 0보다 작다면 생성자 안에서 예외를 발생시킨다.
	 * 
	 * request : MultipartRequest에 연결할 사용자의 요청 정보가 담긴 객체 
	 * saveDirectory : 업로드 된 파일을 저장할 서버의 디렉토리 지정
	 * maxPostSize : 업로드 파일의 최대 크기 지정
	 * encoding : 파일의 인코딩 방식 지정, 파일 이름이 한글일 경우 필히 utf-8 지정
	 * policy : 사용자가 업로드 한 파일을 저장할 서버의 디렉토리에 현재 업로드 되는
	 *            파일과 이름이 중복된 파일이 존재할 경우 현재 업로드 되는 파일의
	 *            이름을 어떻게 변경할지에 대한 정책을 지정하는 매개변수 이다.
	 *            일반적으로 new DefaultFileRenamePolicy()를 사용하며
	 *            이 클래스는 abc.jpg 파일을 업로드 할때 이미 같은 이름의 파일이 
	 *            존재하면 자동으로 abc1.jpg와 같이 파일을 변경해 준다.
	 *
	 * 아래와 같이 MultipartRequest 객체를 생성하면 saveDirectory에 지정한
	 * 서버의 디렉토리로 파일이 바로 업로드 된다.
	 **/	 
	MultipartRequest multi = new MultipartRequest(request, realPath, 
						maxFileSize, encoding, new DefaultFileRenamePolicy());	
		 
	/* 3. MultipartRequest 객체를 이용해 클라이언트로부터 요청된 데이터를 처리 
	 *
	 * 파일 업로드 처리를 위해서는 모든 요청에 대한 처리를 MultipartRequest 객체를
	 * 이용해 접근해야 한다. 위에서 MultipartRequest 객체를 생성할 때 요청에 대한
	 * 정보를 담고 있는 request를 생성자의 매개변수로 지정해 MultipartRequest를
	 * 통해 사용자의 요청 정보에 접근할 수 있다.
	 *
	 * MultipartRequest 클래스에 정의된 주요 메소드는 아래와 같다.
	 * getParameter(name) : name에 지정한 파라미터 값을 반환
	 * getParameterNames() : 폼에서 전송된 모든 파라미터 이름을 
	 *                                  Enumeration 타입으로 반환  
	 * getParameterValues(name) : name에 지정한 파라미터 값을 String 배열로 반환
	 * getFile(fileName) : 업로드 된 파일 중에서 fileName에 지정한 파라미터
	 *                            이름을 가진 파일의 정보를 File 객체로 반환 
	 * getFileNames() : 폼에서 전송된 모든 파일의 이름을 Enumeration 타입으로 반환
	 * getFileSystemName(name) : name에 지정한 파라미터 이름을 가진
	 *                                         파일의 이름을 반환
	 * getOriginalFileName() : 사용자가 업로드 한 파일의 원본 이름을 반환
	 * getContentType() : 사용자가 업로드 한 파일의 컨텐트 타입을 반환
	 **/
	
	/* 사용자가 폼에 입력한 데이터 처리
	 * MultipartRequest 객체를 통해 파라미터를 읽어 변수에 저장한다. 
	 **/	
	String title = multi.getParameter("title");
	String writer = multi.getParameter("writer");
	String pass = multi.getParameter("pass");
	String content = multi.getParameter("content");		
	
	/* 하나의 게시 글 정보를 저장하는 자바빈 객체를 생성하고 요청 데이터를
	 * Board 객체에 저장한다.
	 **/
	Board board = new Board();
	board.setTitle(title);
	board.setWriter(writer);
	board.setPass(pass);	
	board.setContent(content);	
		
	/* 사용자가 업로드한 파일 데이터 처리
	 * MultipartRequest 객체를 통해 파일 이름을 구하여 변수에 저장한다.
	 * 파일이 업로드 되지 않으면 fileName은 null 값을 받는다.
	 **/
	String fileName = multi.getFilesystemName("file");
	System.out.println("업로드 된 파일명 : " + fileName);
	System.out.println("원본 파일명 : " + multi.getOriginalFileName("file"));
	
	// 파일명이 존재하면 파일명을 지정하고 존재하지 않으면 null로 지정 한다.	 
	board.setFile(fileName != null ? fileName : null);
	
	if(board.getFile() == null) {		
		System.out.println("파일이 업로드 되지 않았음");		
	}	
	
	// BoardDao 객체를 생성하고 DB에 새로운 게시 글을 추가한다.
	BoardDao dao = new BoardDao();
	dao.insertBoard(board);
	
	/* DB에 게시 글을 추가하고 브라우저에게 게시 글 리스트를 요청하라고 응답
	 * 게시 글쓰기가 완료된 후 Redirect 시키지 않으면 이 페이지를 새로 고침 하여
	 * 재요청 할 때 마다 이미 추가된 게시 글을 계속하여 추가하는 문제가 발생 한다.	 
	 * 이런 경우에는 Redirect 기법을 이용해 DB에 추가, 수정, 삭제하는 동작이 아닌
	 * 조회하는 곳으로 이동하도록 하면 문제를 해결 할 수 있다. 	 
	 **/	
	response.sendRedirect("boardList.jsp");
%>