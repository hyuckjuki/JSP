package com.jspstudy.ch04.urlmapping;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/* ContextRoot(JSPStudyCh04/) 아래의 *.led, *.do로
 * 들어오는 모든 요청을 이 서블릿이 처리하겠다고 선언하는 애노테이션 
 * 문자열 배열 형태로 여러 개의 url-pattern을 지정할 수 있다.
 * */
@WebServlet({ "*.led", "*.do" })
public class MappingTest4 extends HttpServlet {

	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("	<head><title>MappingTest4</title></head>");
		out.println("	<body>");
		out.println("		MappingTest4");
		out.println("	</body");
		out.println("/html>");
		
		out.close();
	}
}
