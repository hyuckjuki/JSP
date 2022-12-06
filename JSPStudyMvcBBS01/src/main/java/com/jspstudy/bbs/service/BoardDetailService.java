package com.jspstudy.bbs.service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jspstudy.bbs.dao.BoardDao;
import com.jspstudy.bbs.vo.Board;

// 게시 글 상세보기 요청을 처리하는 서비스 클래스
public class BoardDetailService {
	
	public String requestProcess(
			HttpServletRequest request, HttpServletResponse response)
					throws ServletException, IOException {
		
		//요청 파라미터로 넘어 온 게시 글 번호와 페이지 번호를 읽어온다.
		String no = request.getParameter("no");	
		String pageNum = request.getParameter("pageNum");
		String type = request.getParameter("type");	
		String keyword = request.getParameter("keyword");	
		
		// no와 pageNum이 비어 있으면 비정상 요청임
		if(no == null || no.equals("") || pageNum == null || pageNum.equals("")) {
			
			/* 스트림에 직접 쓰기위해 응답 객체로 부터 스트림을 구한다.
			 * 응답 객체의 스트림을 구하기 전해 ContentType이 설정되어야 한다. 
			 * 그렇지 않으면 한글과 같은 데이터는 깨져서 출력된다.
			 **/
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("	alert('정상적인 접근이 아닙니다.');");
			out.println("	history.back();");
			out.println("</script>");
			
			/* viewPage 정보가 null 이면 컨트롤러에서 뷰를 거치지 않고
			 * 그대로 응답되기 때문에 자바스크립트 구문이 클라이언트로 응답된다.
			 **/
			return null;
		}
		
		/* 요청 파라미터에서 type이나 keyword가 비어 있으면 일반 
		 * 게시 글 리스트에서 넘어온 요청으로 간주하여 false 값을 갖게 한다.
		 * 이 정보는 게시 글 리스트와 검색 리스트로 구분해 돌려보내기 위해 필요하다.
		 **/
		boolean searchOption = (type == null || type.equals("") 
				|| keyword == null || keyword.equals("")) ? false : true; 		
		
		/* BoardDao 객체를 생성하고 요청한 게시 글 하나를 가져온다.
		 * 게시 글 읽기 요청이므로 두 번째 인수를 true로 지정해 DAO에서
		 * 게시 글 읽은 횟수를 1 증가 시키게 된다. 
		 **/
		BoardDao dao = new BoardDao();
		Board board = dao.getBoard(Integer.valueOf(no), true);
		
		/* View 페이지에서 필요한 데이터를 Request 영역의 속성에 저장한다.
		 * 게시 글 하나의 내용, 현재 페이지 번호를 속성에 저장 했다. 
		 **/
		request.setAttribute("board", board);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("searchOption", searchOption);
		
		// 검색 요청이면 type과 keyword를 request 영역에 저장한다.
		if(searchOption) {			
			request.setAttribute("type", type);			
			request.setAttribute("keyword", keyword);
		}
						
		/* 최종적으로 Redirect 정보와 View 페이지 정보를 문자열로 반환하면 된다.
		 * 
		 * 게시 글 상세보기 요청에 대한 결과(모델)를 request 영역의 속성에 저장하고
		 * 요청에 대한 결과(모델)를 출력할 View 페이지와 View 페이지를 호출하는 방식을
		 * 아래와 같이 문자열로 지정하면 된다. 현재 요청을 처리한 후에 Redirect 하려면
		 * 뷰 페이지를 지정하는 문자열 맨 앞에 "r:" 또는 "redirect:"를 접두어로 붙여서
		 * 반환하고 Redirect가 아니라 Forward 하려면 뷰 페이지의 경로만 지정하여
		 * 문자열로 반환하면 Controller에서 판단하여 Redirect 또는 Forward로 연결된다.   
		 * 또한 Forward 할 때 뷰 페이지의 정보 중에서 앞부분과 뒷부분에서 중복되는 
		 * 정보를 줄이기 위해서 Controller에서 PREFIX와 SUFFIX를 지정해 사용하기
		 * 때문에 매번 중복되는 부분을 제외하고 뷰 페이지의 정보를 지정하면 된다. 
		 **/
		return "board/boardDetail";
	}
}
