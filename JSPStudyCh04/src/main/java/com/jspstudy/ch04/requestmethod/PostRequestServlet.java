package com.jspstudy.ch04.requestmethod;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// POST 방식과 GET 방식 요청 모두 처리하기
public class PostRequestServlet extends HttpServlet {
	
	// POST 방식 요청을 처리하기 위해서 doPost() 메서드를 오버라이딩 한다.
	@Override
	public void doPost(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		
		/* 웹 브라우저가 POST 방식으로 요청한 파라미터 읽기
		 * 
		 * POST 방식의 요청은 웹 브라우저가 서버로 요청을 보낼 때 HTML 문서의 폼에
		 * 입력된 데이터를 HTTP 요청 본문(Body)에 추가하여 서버로 요청을 보낸다.
		 * 클라이언트가 서버로 요청을 보낼 때 서버로 보내는 데이터를 요청 파라미터라 한다. 
		 *		 
		 * POST 방식의 요청도 요청에 대한 정보를 저장하고 있는 HttpServletRequest 
		 * 객체의 getParameter() 메서드를 이용해 아래와 같이 읽어올 요청 파라미터의
		 * 이름을 지정하면 클라이언트로부터 전송된 요청 파라미터를 읽을 수 있다.
		 **/
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		
		boolean isLogin = false;
		if(id.equals("admin") && pass.equals("1234")) {
			isLogin = true;
		} 		
		
		// 웹 브라우저에 출력될  응답문서의 형식과 문자 셋을 지정
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();		
		
		out.println("<h2>POST 방식 요청 처리</h2>");
		out.println(	isLogin ? "로그인 성공<br/>" : "로그인 실패<br/>");
		out.println("입력된 아이디 : " + id + ", 비밀번호 : " + pass + "<br/>");
		
		// 작업이 끝나면 스트림을 닫는다.
		out.close();
	}
	
	// GET 방식의 요청 처리하기 위해서 doGet() 메서드를 오버라이딩 한다.
	@Override
	public void doGet(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		
		/* 웹 브라우저가 GET 방식으로 요청한 파라미터 읽기
		 * 
		 * GET 방식의 요청은 웹 브라우저가 서버로 요청을 보낼 때 URL의 뒷부분에
		 * 필요한 데이터를 추가하여 서버로 보낸다. 클라이언트가 서버로 요청을 보낼 때
		 * 서버로 보내는 데이터를 요청 파라미터라 한다.
		 * 
		 * 요청에 대한 정보를 저장하고 있는 HttpServletRequest 객체의 
		 * getParameter() 메서드를 이용해 아래와 같이 읽어올 요청 파라미터의
		 * 이름을 지정하면 클라이언트로부터 전송된 요청 파라미터를 읽을 수 있다.
		 **/
		String id = request.getParameter("id");
		
		// 웹 브라우저에 출력될  응답문서의 형식과 문자 셋을 지정
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();		
		
		out.println("<h2>GET 방식 요청 처리</h2>");
		out.println("		안녕하세요 " + id +"님!<br/>");		
		
		// 작업이 끝나면 스트림을 닫는다.
		out.close();
	}
}
