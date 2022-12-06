package com.jspstudy.bbs.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jspstudy.bbs.service.BoardDetailService;
import com.jspstudy.bbs.service.BoardListService;
import com.jspstudy.bbs.service.BoardWriteService;
import com.jspstudy.bbs.service.DeleteService;
import com.jspstudy.bbs.service.UpdateFormService;
import com.jspstudy.bbs.service.UpdateService;

/* 모델2 방식으로 게시판 구현하기
 * 게시판과 관련된 요청을 if문을 사용해 처리하는 Controller
 **/
@WebServlet(name="bbsController", urlPatterns="*.bbs",
		initParams=@WebInitParam(name="uploadDir", value="upload"))
public class BBSController extends HttpServlet {
	
	/* 뷰 페이지 정보 중에서 앞부분과 뒷부분에서 중복되는 데이터를
	 * 최소화하기 위해서 사용하는 접두어와 접미어를 상수로 설정
	 **/
	private final String PREFIX = "/WEB-INF/";
	private final String SUFFIX = ".jsp";
	
	// 서블릿 초기화 메서드
	@Override
	public void init() throws ServletException {
		
		// 이 클래스에 애노테이션으로 선언한 서블릿 초기화 파라미터를 읽는다.
		String uploadDir = getInitParameter("uploadDir");
		
		/* 서블릿 초기화 파라미터로 읽어온 이미지가 저장될 폴더의 
		 * 로컬 경로를 구하여 그 경로와 파일명으로 File 객체를 생성한다.
		 **/
		String realPath = getServletContext().getRealPath(uploadDir);		
		File parentFile = new File(realPath);
		
		/* 파일 객체에 지정한 위치에 디렉토리가 존재하지 않거나 
		 * 파일 객체가 디렉토리가 아니라면 디렉토리를 생성한다.
		 **/
		if(! (parentFile.exists() && parentFile.isDirectory())) {
			parentFile.mkdir();
		}
		
		/* ServletContext 객체의 속성으로 저장해 파일 업로드 
		 * 디렉토리 정보를 다른 컴포넌트에서 사용할 수 있도록 하였다.
		 **/ 
		getServletContext().setAttribute("uploadDir", uploadDir);
		getServletContext().setAttribute("parentFile", parentFile);
		System.out.println("init - " + parentFile);
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
	 * 즉 get방식과 post방식 요청을 모두 처리하는 메소드
	 * 컨트롤러는 이 메소드 안에서 브라우저의 요청에 대한 처리를 요청 URL을 분석해
	 * 요청을 처리할 모델 클래스를 결정하고 해당 모델 클래스의 객체를 사용해(위임)
	 * 클라이언트의 요청을 처리한 후 그 결과를 뷰로 전달해 결과 화면을 만들게 된다.
	 * 뷰로 전달된 데이터는 html 형식의 문서에 출력하여 브라우저에게 응답한다.
	 **/
	protected void doProcess(
			HttpServletRequest request, HttpServletResponse response) 
					throws ServletException, IOException {
		
		/* 컨트롤러에 어떤 요청이 들어왔는지 파악하기 위해 Request 객체로 부터
		 * 웹 어플리케이션의 컨텍스트 루트를 포함한 요청 페이지의 URI 정보와
		 * ContextPath를 얻어와 String 클래스의 substring()을 이용해 
		 * 웹 어플리케이션 루트부터 요청한 페이지의 정보를 추출 한다. 
		 **/
		/* 요청 정보를 담고 있는 Request 객체로 부터 요청 URI를 구한다.
		 * /JSPStudyMvcBBS01/boardList.bbs
		 **/ 
		String requestURI = request.getRequestURI();
		
		/* 요청 정보를 담고 있는 Request 객체로 부터 ContextPath를 구한다. 
		 * /JSPStudyMvcBBS01
		 **/
		String contextPath = request.getContextPath();
		System.out.println("uri : " + requestURI + ", ctxPath : " + contextPath);
		
		/* 요청 URI에서 ContextPath를 제외한 요청 명령을 추출 한다.
		 * /boardList.bbs
		 **/
		String command = requestURI.substring(contextPath.length());
		System.out.println("command : " + command);
		
		/* 뷰 페이지 정보를 저장할 변수
		 **/
		String viewPage = null;
		
		/* 요청 URI에서 추출한 명령을 비교해 요청을 처리할 모델 클래스를
		 * 결정하여 객체를 생성하고 메서드를 호출해 요청을 처리한다.
		 **/
		if(command.equals("/boardList.bbs")
				 || command.equals("/*.bbs")) {
				
			/* 게시 글 리스트 보기가 요청된 경우의 처리
			 * 한 페이지에 출력 할 게시 글 리스트를 DB로 부터 읽어오는 
			 * BoardListService 클래스의 인스턴스를 생성한 후 Request와
			 * Response 객체를 매개변수로 requestProcess()를
			 * 호출하여 게시 글 리스트 보기에 대한 요청을 처리 한다.
			 **/
			BoardListService list = new BoardListService();
			viewPage = list.requestProcess(request, response);
			
		} else if(command.equals("/boardDetail.bbs")) {
			
			/* 게시 글 내용보기가 요청된 경우의 처리
			 * 게시 글 하나의 내용을 DB로 부터 읽어오는 BoardDetailService
			 * 클래스의 인스턴스를 생성한 후 Request와 Response 객체를
			 * 매개변수로 requestProcess()를 호출하여 게시 글 내용보기에
			 * 대한 요청을 처리 한다.
			 **/
			BoardDetailService service = new BoardDetailService();
			viewPage = service.requestProcess(request, response);
			
		} else if (command.equals("/writeForm.bbs")) {
			
			/* 게시 글쓰기 폼을 요청한 경우의 처리
			 * 게시 글쓰기는 뷰 페이지에 출력할 모델이 없기 때문에 별도의 Service
			 * 클래스를 만들지 않고 아래에서 바로 Redirect와 View 페이지 정보를
			 * 저장하는 viewPage에 게시 글쓰기 폼을 출력하는 JSP의 경로를 지정 했다.
			 **/
			viewPage = "board/writeForm";
			
		} else if(command.equals("/writeProcess.bbs")) {
			
			/* 게시 글쓰기 폼에서 등록하기 버튼이 클릭된 경우의 처리 
			 * 사용자가 작성한 게시 글을 DB에 저장하는 BoardWriteService
			 * 클래스의 인스턴스를 생성한 후 Request와 Response 객체를
			 * 매개변수로 requestProcess()를 호출하여 새로운 게시 글을
			 * DB에 저장 한다.
			 */
			BoardWriteService service = new BoardWriteService();
			viewPage = service.requestProcess(request, response);
			
		} else if(command.equals("/updateForm.bbs")) {
			
			/* 게시 글 내용보기에서 수정하기 버튼이 클릭된 경우의 처리 
			 * 게시 글 수정 폼 요청을 처리하는  UpdateFormService 클래스의
			 * 인스턴스를 생성한 후 Request와 Response 객체를 매개변수로
			 * requestProcess()를 호출하여 게시 글 수정 폼 요청을 처리한다.
			 */
			UpdateFormService service = new UpdateFormService();
			viewPage = service.requestProcess(request, response);
			
		} else if(command.equals("/updateProcess.bbs")) {
			
			/* 게시 글 수정 폼에서 수정하기 버튼이 클릭된 경우의 처리 
			 * 게시 글 수정 요청을 처리하는 UpdateService 클래스의
			 * 인스턴스를 생성한 후 Request와 Response 객체를 매개변수로
			 * requestProcess()를 호출하여 게시 글을 DB에서 수정한다.
			 */	
			UpdateService service = new UpdateService();
			viewPage = service.requestProcess(request, response);
			
		} else if(command.equals("/deleteProcess.bbs")) {
			
			/* 게시 글 내용보기에서 수정하기 버튼이 클릭된 경우의 처리 
			 * 게시 글 수정 폼 요청을 처리하는  UpdateFormService 클래스의
			 * 인스턴스를 생성한 후 Request와 Response 객체를 매개변수로
			 * requestProcess()를 호출하여 게시 글을 DB에서 삭제한다.
			 */
			DeleteService service = new DeleteService();
			viewPage = service.requestProcess(request, response);			
		}
		
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
