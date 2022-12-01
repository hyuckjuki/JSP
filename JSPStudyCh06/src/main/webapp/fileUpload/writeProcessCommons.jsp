<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.io.*"%>    
<%@ page import="com.jspstudy.ch06.vo.*, com.jspstudy.ch06.dao.*"  %>

<%-- Commons FileUpload 라이브러리 import --%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>

<%!
	/* JSP 선언부를 이용해 JSP 초기화 메서드를 정의하고 애플리케이션
	 * 초기화 파라미터인 uploadDir을 읽어서 파일이 저장되는 폴더로 사용할 것임 
	 **/
	static String uploadDir;
	static File parentFile;

	public void jspInit() {		
		/* web.xml에서 설정한 웹 어플리케이션 초기화 파라미터를 읽는다.
		 **/
		uploadDir = getServletContext().getInitParameter("uploadDir");
		
		/* 웹 어플리케이션 초기화 파라미터에서 읽어온 파일이 저장될 폴더의 
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
	/* commons-upload 라이브러리를 이용한 파일 업로드 구현하기
     *	
	 * 1. 폼에서 전송된 데이터가 multipart/form-data 인지 체크
	 * ServletFileUpload 클래스의 isMultipartContent(request) 메소드는
	 * 요청 정보에 포함되어 전송된 데이터가 multipart/form-data 이면 true를
	 * 그렇지 않으면 false를 반환한다.
	 **/
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);	
	if(isMultipart) {

		// 2. 메모리나 파일로 업로드된 파일을 보관하는 FileItem의 Factory 객체 생성
		/* 요청 데이터가 multipart/form-data 일 때 서버로 전송된 파라미터와
		 * 파일을 보관하여 파일 업로드를 처리하기 위해 FileItem 객체를 사용해야 한다.
		 * FileItem 객체는 multipart/form-data로 전송된 파라미터 정보와
		 * 파일 정보를 저장하고 있는 객체이다.
		 * 
		 * FileItem 객체를 생성해 주는 DiskFileItemFactory 객체를 생성한다.
		 *
		 * DiskFileItemFactory 객체는 업로드된 파일의 크기가 지정한 크기를
		 * 넘기 전까지는 업로드된 파일을 메모리에 저장하고 지정한 크기를 초과하면
		 * 임시 디렉터리에 파일로 저장해 작업한다.
		 * setSizeThreshold(int sizeThreshold) 메소드를 이용해 메모리에
		 * 저장할 수 있는 최대 크기를 byte 단위로 지정할 수 있다. 이 작업을 생략하면
		 * 기본 크기는 10240byte(10kb) 이다. 또한 setRepository(File repository)
		 * 메소드를 이용해 지정한 메모리 크기를 초과할 경우 사용할 임시 디렉터리를
		 * 지정할 수 있다. 이를 생략하면 시스템의 기본 임시 디렉터리를 사용하게 된다.
		 * 시스템의 기본 임시 디렉터리는 System.getProperty("java.io.tmpdir")
		 * 메소드를 통해 알아낼 수 있다.
		 **/
		DiskFileItemFactory factory = new DiskFileItemFactory();
		System.out.println("임시 디렉터리 : " + System.getProperty("java.io.tmpdir"));		
		
		// 3. 업로드 요청을 처리하는 ServletFileUpload 객체 생성한다.
		/* ServletFileUpload 객체의 setSizeMax(long sizeMax) 메소드를
		 * 사용해 업로드 되는 전체 파일의 최대 크기를 byte 단위로 지정할 수 있다. 
		 * 또한 개별 파일의 최대 크기를 지정하려면 setFileSizeMax(long fileSizeMax)
		 * 메소드를 사용해 byte 단위로 각 파일의 최대 크기를 지정할 수 있다. 
		 **/
		ServletFileUpload upload = new ServletFileUpload(factory);		

		// 4. 요청 정보에 포함되어 전송된 데이터를 처리하기 위해 FileItem 목록 구함
		/* FileItem은 multipart/form-data로 전송된 파라미터 또는 파일 정보를
		 * 저장하고 있는 객체로 ServletFileUpload 클래스의 parseRequest()를
		 * 이용해 서버로 전송된 FileItem의 리스트를 List 타입으로 얻을 수 있다. 
		 **/		 
		List<FileItem> items = upload.parseRequest(request);
		
		// 5. 전송된 데이터에 접근하기 위해 Iterator 객체를 얻는다.
		Iterator<FileItem> iter = items.iterator();
		
		// 하나의 게시 글 정보를 저장하는 자바빈 객체 생성		 
		Board board = new Board();		
		
		while(iter.hasNext()) {
			
			FileItem item = iter.next();
			
			/* 6. 현재 목록(item)이 폼 컨트롤에 입력된 문자열 데이터 인지 또는
			 * 업로드된 파일 데이터 인지를 구분해 처리한다.
			 *
			 * 아래는 현재 목록(item)이 폼에 입력된 파라미터 데이터 인지를 체크한다.
			 * isFormField() 메소드는 입력 파라미터일 경우 true를 반환 한다.
			 *
			 * file 선택상자가 아니라 일반적인 폼 필드에 입력된 데이터면
			 * 아래 if() 문이 실행되고 파일이면 else 문이 실행된다.
			 **/
			if(item.isFormField()) { // 파일이 아니라 일반 폼 컨트롤(문자) 데이터라면
				
				/* 6-1. 폼에서 전송된 폼 데이터의 파라미터 이름과 값을 읽는다.
				 *
				 * getFieldName() 메소드는 현재 목록(item)의 파라미터				 
				 * 이름을 반환한다. getString() 메소드는 지정한 문자 셋을 
				 * 적용해 현재 목록(item)의 파라미터의 값을 반환한다.
				 **/				
				String paramName = item.getFieldName();
				String paramValue = item.getString("utf-8");
				
				// 파라미터를 구분하여 Member 객체에 저장한다. 
				if(paramName.equals("title")) {
					board.setTitle(paramValue);
					
				} else if(paramName.equals("writer")) {
					board.setWriter(paramValue);
					
				} else if(paramName.equals("pass")) {
					board.setPass(paramValue);
					
				} else if(paramName.equals("content")) {
					board.setContent(paramValue);
					
				}
				
			} else { // 파일 데이터라면
				
				/* 6-2. 폼으로 부터 전송된 파일 데이터라면 전송된 파일을
				 * 서버의 특정 폴더에 저장하는 작업을 한다.
				 *
				 * 현재 목록(item)에 해당하는 파일 데이터의 파라미터 이름을 구한다.
				 **/
				String paramName = item.getFieldName();
				
				/* 파라미터 이름이 file 이라면 폼의 파일선택 상자에서 선택한
				 * 파일 데이터이므로 이 파일을 서버에 저장하는 작업을 한다.
				 **/
				if(paramName.equals("file")) {		
					
					/* 웹 어플리케이션 초기화 파라미터로 부터 읽어온 이미지 파일이
					 * 저장될 폴더의 로컬 경로를 구하여 그 경로와 파일명으로 File
					 * 객체를 생성한다.
					 **/
					String realPath = application.getRealPath(uploadDir);
					
					/* 초기의 IE 11에서 에러가 발생하였다. 
					 * Chrome과 IE10에서 정상동작 하지만 IE11에서 item.getName()
					 * 메소드를 호출하면 파일의 전체 경로가 포함된 이름이 반환 되기
					 * 때문에 에러가 발생하였다. 원래 getName() 메소드는 경로를
					 * 제외한 파일의 이름을 반환하는 메소드로 아래와 같이 파일 객체를
					 * 생성해 파일 작업을 하면 되지만 IE 11에서와 같이 파일명에
					 * 경로가 포함되어 넘어오는 경우를 대비해야 하기 때문에 이 방식을
					 * 사용하지 않고 아래와 같은 방식으로 파일명을 구하였다.
					 *					 
					 * File file = new File(realPath, item.getName());
					 **/											 
					 System.out.println("전송된 파일명 : " + item.getName());
					 
					/* item.getName()이 리턴 하는 문자열 중에서 마지막 "/" 문자열
					 * 다음 index 부터 실제 파일명이 되므로 lastIndexOf()를 이용해
					 * 문자열의 끝에서 부터 검색해 첫 번째 만나는 "\"의 index를 구하고
					 * substring()을 index + 1 부터 문자열을 추출하여 파일명을 구한다.
					 * 전체 경로가 아닌 파일명만 리턴 된다면 즉 chrome이나 IE10에서
					 * index가 -1이 되므로 첫 번째 문자부터 추출하여 파일명을 구한다. 
					 *
					 * Java는 플랫폼(OS) 독립적인 프로그래밍 언어로 OS마다 파일경로나 
					 * 파일 이름 또는 디렉터리를 구분하는 구분자가 다를 수 있기 때문에
					 * File 클래스의 static 멤버 변수인 separator를 이용해 프로그램이
					 * 실행되는 플랫폼(OS)에서 사용하는 경로 구분자나 이름 구분자를
					 * 적용하여 파일의 경로를 지정하게 되면 Java의 플랫폼 독립적인 
					 * 특징을 최대한 활용할 수 있으며 프로그램 실행 중에 플랫폼 마다
					 * 다른 구분자로 인해 발생할 수 있는 에러를 미연에 방지할 수 있다.
					 **/
					int index = item.getName().lastIndexOf(File.separator);
					String fileName = item.getName().substring(index + 1);
					System.out.println("파일 구분자 : " + File.separator);
					
					File childFile = new File(parentFile, fileName);
					System.out.println("childFile : " + childFile);
					
					/* 파일명의 길이가 0보다 크면 이미지를 폴더에 저장한다.
					 * 파일명이 아닌 실제 전송된 파일의 크기로 유효한 파일인지를
					 * 검사하려면 파일의 크기를 byte 단위로 환산해 long 형으로
					 * 반환하는 getSize() 메소드를 사용해 파일의 크기를 구하면 된다.
					 * 업로드된 파일의 크기가 0인 경우 즉 사용자가 업로드 하는 파일을
					 * 선택하지 않고 폼을 전송하는 경우 적절한 예외 처리가 필요하다.
					 **/
					System.out.println("업로드된 파일 크기 : " + item.getSize());
					
					if(fileName.length() > 0) {
						
						/* commons-fileupload는 동일한 파일명이
						 * 존재하면 기존의 파일을 덮어쓰기 때문에 아래와
						 * 같이 동일한 파일명이 존재하면 새롭게 업로드되는
						 * 파일명을 변경하는 처리가 필요하다.						 
						 **/
						if(childFile.exists()) {
														
							// 파일 이름만 추출
							String rename = childFile.getName().substring(
										0, childFile.getName().lastIndexOf("."));
							
							// . 을 포함한 확장자 추출
							String ext = childFile.getName().substring(
										childFile.getName().lastIndexOf("."));
							
							// Calendar 객체를 이용해 밀리초를 구해서 파일 이름을 생성함
							Calendar ca = Calendar.getInstance();
							String newName = rename + ca.getTimeInMillis() + ext; 
							
							// 새로운 파일명으로 변경
							childFile = FileUtils.getFile(parentFile, newName);
							System.out.println("if() childFile : " + childFile.getName());
						}
						
						// 동일한 파일명이 있으면 덮어쓴다.
						item.write(childFile);
					}
					
					/* 파일 업로드시 사용된 임시 파일을 제거 한다. 
					 * 가비지 컬렉터가 알아서 하니 필수는 아니다.
					 **/
					item.delete();
					
					/* 업로드 파일명이 존재하면 파일명을 지정하고
					 * 파일명이 존재하지 않으면 파일 정보를 null로 지정 한다.
					 **/
					board.setFile(fileName.length() > 0 ? childFile.getName() : null);
				}
			} // end if(item.isFormField())
		} // end while
						
		// DBCPBoardDao 객체를 생성해 게시 글을 DB에 추가한다.
		DBCPBoardDao dao = new DBCPBoardDao();
		dao.insertBoard(board);
		
		/* 게시 글쓰기가 완료된 후 response 내장객체의 sendRedirect() 메서드를
		 * 이용해 게시 글 리스트로 Redirect 시킨다. response 내장객체의 sendRedirect()
		 * 메서드는 요청한 자원이 다른 곳으로 이동되었다고 응답하면서 URL을 알려주고 
		 * 그 쪽으로 다시 요청하라고 응답하는 메소드이다. 브라우저가 요청한 컨텐츠가 
		 * 이동했으니 그 쪽으로 다시 요청하라고 응답 데이터로 웹 주소를 알려주면
		 * 브라우저는 그 웹 주소로 다시 요청하게 되는데 이를 리다이렉션이라고 한다.
		 *	 
		 * Redirect 기법은 웹 브라우저를 새로 고침(F5) 했을 때 동일한 코드가 다시
		 * 실행되면 문제가 될 수 있는 경우 클라이언트의 요청을 처리한 후 특정 URL로
		 * 이동시키기 위해 사용하는 기법이다. 예를 들어 게시 글쓰기에 대한 요청을 처리한
		 * 후 Redirect 시키지 않으면 게시 글쓰기 후에 사용자가 새로 고침(F5) 동작을
		 * 하면 바로 이전에 작성한 게시 글 내용과 동일한 내용을 다시 DB에 등록하는 작업을 
		 * 하게 되는데 이렇게 되면 중복된 데이터를 계속해서 저장하는 문제가 발생한다.
		 * 이를 방지하기 위해서 게시 글쓰기가 완료되면 게시 글 리스트(select 문은 반복
		 * 사용해도 중복된 데이터가 발새하지 않음)로 이동시키기 위해서 response 
		 * 내장객체의 sendRedirect() 메소드를 사용해 게시 글 리스트의 URL을
		 * 웹 브라우저에게 응답하고 웹 브라우저는 응답 받은 URL로 다시 요청하도록 하는
		 * 것이다. 이렇게 게시 글쓰기와 같이 DB 입력 작업이 연동되는 경우 사용자의
		 * 새로 고침(F5) 동작에 의해 동일한 요청이 다시 발생하여 DB에 입력되는 데이터의 
		 * 중복이 발생하거나 SQLException을 발생 시킬 수 있어 Redirect 기법을
		 * 사용한다. 이외에 다른 사이트로 이동시킬 때 Redirect 기법을 사용 한다.
		 **/
		response.sendRedirect("boardList.jsp");
		
	} else {
		System.out.println("폼에서 전송된 요청이 mutipart/form-data가 아님");
	}	
%>
