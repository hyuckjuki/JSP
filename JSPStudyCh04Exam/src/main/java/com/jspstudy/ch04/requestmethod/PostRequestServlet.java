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
		request.setCharacterEncoding("utf-8");//한글깨지는거 막기
		
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String gen = request.getParameter("gen");
		String adress = request.getParameter("adress");
		
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();		
		
		out.println("<h1>회원정보</h2>");
		out.println("이름 : " + id + "<br/>");
		out.println("나이 : " + pass + "<br/>");
		out.println("성별 : " + gen + "<br/>");
		out.println("주소 : " + adress + "<br/>");
		
		out.close();
	}
	
}
