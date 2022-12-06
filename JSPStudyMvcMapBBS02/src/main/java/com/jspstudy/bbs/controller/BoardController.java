package com.jspstudy.bbs.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jspstudy.bbs.service.CommandProcess;

//@WebServlet 애노테이션을 삭제하고 클래스 이름을 BoardController로 바꿀 것
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	/* 뷰 페이지 정보 중에서 앞부분과 뒷부분에서 중복되는 데이터를
	 * 최소화하기 위해서 사용하는 접두어와 접미어를 상수로 설정
	 *
	 * 이번 프로젝트는 뷰 페이지를 구성할 때 중복되는 코드를 최소화하기 위해서
	 * 웹 템플릿을 사용하는 프로젝트로 여러 JSP 페이지를 모듈화 하여 분리해 놓고
	 * 실행될 때 웹 템플릿을 통해서 하나의 JSP 페이지로 동작하도록 구현되어 있다.
	 * 그러므로 포워딩을 해야 할 경우에는 웹 템플릿 역할을 하는 index.jsp에
	 * 동적으로 포함시킬 컨텐츠 페이지를 body라는 파라미터를 통해서 전달하여
	 * 웹 템플릿 페이지인 index.jsp에서 body라는 파라미터 값을 읽어서 동적으로
	 * 포함되는 컨텐츠 페이지를 include 하도록 상대 참조 방식으로 지정하면 된다.
	 **/
	private final String PREFIX = "/WEB-INF/index.jsp?body=";
	private final String SUFFIX = ".jsp";	
	
	// 요청 명령과 이 명령을 처리할 모델 클래스의 인스턴스를 저장할 Map 객체 생성
	Map<String, CommandProcess> commandMap = 
			new HashMap<String, CommandProcess>();   

	/* 서블릿 초기화 메서드
	 * 이 서블릿 클래스의 인스턴스가 생성되고 아래 초기화 메서드가 딱 한 번 호출 된다.
	 **/
	public void init() throws ServletException {
		
		/* 요청 명령어와 명령어를 처리할 클래스 이름이 맵핑되어 있는 
		 * uriCommand.properties 파일의 위치를 web.xml에 지정한 
		 * 서블릿 초기화 파라미터로 부터 읽어와 변수에 저장 한다.
		 **/
		String uriCommand = getInitParameter("uriCommand");
		
		/* 서블릿 초기화 파라미터로 읽어온 이미지가 저장될 폴더의 
		 * 로컬 경로를 구하여 그 경로와 파일명으로 File 객체를 생성한다.
		 **/
		ServletContext sc = getServletContext();
		String uploadDir = sc.getInitParameter("uploadDir");
		String realPath = sc.getRealPath(uploadDir);
		File parentFile = new File(realPath);
		
		/* 파일 객체에 지정한 위치에 디렉토리가 존재하지 않거나 
		 * 파일 객체가 디렉토리가 아니라면 디렉토리를 생성한다.
		 **/
		if(! (parentFile.exists() && parentFile.isDirectory())) {
			parentFile.mkdir();
		}
		
		/* properties 파일에 저장된 요청 명령어와 명령어를 처리할 
		 * 클래스 이름을 저장할 Properties 객체 생성		
		 * HashTable을 상속해 구현한 Properties 클래스는 key와 value를
		 * 모두 String 타입으로 관리할 수 있도록 구현한 Map계열의 클래스 이다.
		 * Properties는 주로 응용프로그램의 환경정보를 관리하는데 사용한다.
		 * Properties 클래스도 Map 계열의 클래스로 key의 중복을 허용하지
		 * 않고 데이터의 저장 순서를 유지하지 않는 특징을 가지고 있다.
		 * 중복된 key의 데이터가 입력되면 기존의 데이터를 덮어 쓴다.
		 **/ 		
		Properties prop = new Properties();
		
		/* properties 파일을 읽기 위해 Stream을 선언하고 null로 초기화 한다.
		 * FileInputStream은 File의 내용을 Byte 단위로 읽을 수 있는 기반 스트림이고
		 * BufferedInputStream은 File을 Byte 단위로 읽을 때 작업 성능을 높이기 위해
		 * 임시 저장소(buffer) 역할을 담당하는 보조 스트림 이다. 
		 **/		
		FileInputStream fis = null;
		BufferedInputStream bis = null;
		try {
			
			// 현재 시스템에서 uriCommand.properties 파일이 위치한 실제 경로를 구한다.
			String propPath = sc.getRealPath(uriCommand);
			
			/* uriCommand.properties의 파일의 내용을 읽기 위해
			 * FileInputStream을 생성하고 현재 시스템에서 uriCommand.properties
			 * 파일이 위치한 실제 경로를 생성자의 인수로 지정 한다.
			 **/ 
			fis = new FileInputStream(propPath);
			bis = new BufferedInputStream(fis);

			/* 파일에 연결된 스트림 객체를 Properties 클래스의 load()의 인수로
			 * 지정하면 properties 파일에 저장된 String 데이터를 한 라인씩 읽어
			 * 첫 번째 오는 '=' 문자나 ':' 문자를 기준으로 key와 value로 저장해 준다.
			 **/
			prop.load(bis);			
		} catch(IOException e) {
			e.printStackTrace();
		} finally {
			try {
				// 보조 스트림을 먼저 닫고 기반 스트림을 닫는다.
				if(bis != null) bis.close();
				if(fis != null) fis.close();
			} catch(IOException e) { }
		}

		/* Propertiest 객체에 저장된 key 리스트를 Set 타입으로 리턴하는 
		 * keySet()을 호출하고 Set 객체에 접근하기 위해 Iterator 객체를 얻어 온다.
		 **/ 
		Iterator<Object> keyIter = prop.keySet().iterator();
		while(keyIter.hasNext()) {
			String cmd = (String) keyIter.next();
			String className = prop.getProperty(cmd);
			
			try {
				/* Class 클래스 타입의 변수를 선언하고 key에 해당하는 요청 
				 * 명령을 처리할 모델 클래스의 정보를 메모리에 로딩 시킨다.
				 **/
				Class<?> commandClass = Class.forName(className);
				
				/* 요청 명령을 처리할 모델 클래스의 슈퍼 인터페이스 타입의 변수를 
				 * 선언하고 메모리에 로딩된 모델 클래스의 인스턴스를 생성하여 할당 한다.
				 **/
				CommandProcess service = 
						(CommandProcess) commandClass.newInstance();

				/* 요청 명령어를 key로 하고 요청 명령을 처리할 모델 클래스의
				 * 인스턴스를 value로 하여 Map에 저장 한다.
				 **/
				commandMap.put(cmd, service);
			} catch(ClassNotFoundException e) {
				e.printStackTrace();
			} catch(InstantiationException e) {
				e.printStackTrace();
			} catch(IllegalAccessException e) {
				e.printStackTrace();
			}
		}
		
		/* 업로드 폴더 정보를 ServletContext 객체의 속성에 저장한다.
		 * ServletContext 객체는 웹 애플리케이션 당 1개가 생성되며 웹 애플리케이션이
		 * 구동되는데 필요한 정보를 담고 있는 객체로 JSP 페이지에서는 application
		 * 내장객체로 접근할 수 있다. 아래와 같이 ServletContext 객체의 속성에
		 * 저장되면 이 웹 애플리케이션의 모든 컴포넌트에서 이 정보를 사용할 수 있다. 
		 **/
		sc.setAttribute("uploadDir", uploadDir);
		sc.setAttribute("parentFile", parentFile);
	}
	
	// get 방식의 요청을 처리하는 메소드
	protected void doGet(
			HttpServletRequest request, HttpServletResponse response) 
					throws ServletException, IOException {
		doProcess(request, response);
	}

	// post 방식의 요청을 처리하는 메소드
	protected void doPost(
			HttpServletRequest request, HttpServletResponse response) 
					throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doProcess(request, response);
	}	

	/* doGet(), doPost()에서 호출하는 메소드
	 * 즉 get방식과 post방식 요청을 모두 처리하는 메소드 이다.
	 * 컨트롤러는 이 메소드 안에서 브라우저의 요청에 대한 처리를 요청 URL을 분석해
	 * 요청을 처리할 모델 클래스를 결정하고 해당 모델 클래스의 객체를 사용해(위임)
	 * 클라이언트의 요청을 처리한 후 그 결과를 뷰로 전달해 결과 화면을 만들게 된다.
	 * 뷰로 전달된 데이터는 html 형식의 문서에 출력하여 브라우저에게 응답한다.
	 **/
	public void doProcess(
			HttpServletRequest request, HttpServletResponse response) 
					throws ServletException, IOException {		
		
		
		/* 컨트롤러에 어떤 요청이 들어왔는지 파악하기 위해 Request 객체로 부터
		 * 웹 어플리케이션의 컨텍스트 루트를 포함한 요청 페이지의 URI 정보와
		 * ContextPath를 얻어와 String 클래스의 substring()을 이용해 
		 * 웹 어플리케이션 루트부터 요청한 페이지의 정보를 추출 한다. 
		 **/
		/* 요청 정보를 담고 있는 Request 객체로 부터 요청 URI를 구한다.
		 * /JSPStudyMvcMapBBS02/boardList.mvc
		 **/ 
		String requestURI = request.getRequestURI();
		
		/* 요청 정보를 담고 있는 Request 객체로 부터 ContextPath를 구한다. 
		 * /JSPStudyMvcMapBBS02
		 **/
		String contextPath = request.getContextPath();
		System.out.println("uri : " + requestURI + ", ctxPath : " + contextPath);
		
		/* 요청 URI에서 ContextPath를 제외한 요청 명령을 추출 한다.
		 * /boardList.mvc
		 **/
		String command = requestURI.substring(contextPath.length());
		System.out.println("command : " + command);
		
		/* 요청 명령과 이 명령을 처리할 모델 클래스의 인스턴스를 저장하고 있는 
		 * Map으로 부터 사용자의 요청을 처리하기 위해 요청 URI에서 추출한
		 * 요청 명령에 해당하는 요청을 처리할 모델 클래스의 인스턴스를 구해
		 * 부모 타입인 CommandProcess 타입의 변수에 저장하고 오버라이딩된
		 * requestProcess()를 호출하여 클라이언트의 요청을 처리한다.
		 * 
		 * viewPage는 클라이언트의 요청을 처리한 결과를 출력할 뷰 페이지의
		 * 정보를 저장한 데이터로 모든 모델 클래스의 requestProcess() 메서드가
		 * 반환하는 데이터 이다.
		 **/ 
		CommandProcess service = commandMap.get(command);
		String viewPage =  service.requestProcess(request, response);

		/* Redirect 정보와 View 페이지의 경로 정보를 저장하는 viewPage가
		 * null이 아니면 Redirect 여부를 판단하여 Redirect라면 Response 객체의
		 * sendRedirect()를 이용해 Redirect 시키고 Redirect가 아니라면
		 * RequestDispatcher를 이용해 View 페이지로 포워딩 시킨다.
		 **/
		if(viewPage != null) {
			
			/* 모델 클래스가 반환한 viewPage에 "redirect" 또는 "r" 접두어가
			 * 존재하면 아래의 viewPage.split(":")[0] 코드에서 "redirect" 또는
			 * "r" 문자열이 반환되고 그렇지 않으면 Forward 할 뷰 페이지의 경로가
			 * 반환되므로 다음과 같이 Redirect와 Forward를 구분하여 처리할 수 있다. 
			 **/  
			String view = viewPage.split(":")[0];
			System.out.println("view : " + view);
			
			if(view.equals("r") || view.equals("redirect")) {
				response.sendRedirect(viewPage.split(":")[1]);
				
			} else {
				
				/* PREFIX는 view 정보 중 앞에서 중복되는 부분을 없애기 위해 사용
				 * SUFFIX는 view 정보 중 뒤에서 중복되는 부분을 없애기 위해 사용
				 **/
				RequestDispatcher rd = 
						request.getRequestDispatcher(PREFIX + view + SUFFIX);	
				rd.forward(request, response);
			}
		}	
	}
}
