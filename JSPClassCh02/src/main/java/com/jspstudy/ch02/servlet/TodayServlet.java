package com.jspstudy.ch02.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/today.do")
public class TodayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(
			HttpServletRequest request, HttpServletResponse response)
					throws ServletException, IOException {
	
		Calendar today = Calendar.getInstance();
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.println("<html>");
		out.println("<head><title>오늘의 날짜</title></head>");
		out.println("<body>");
		out.println("<h2>오늘의 날짜</h2>");
		out.println(" 오늘은 " + (today.get(Calendar.YEAR) + "년 "));
		out.println("<p>중간 삽입</p>");
		out.println( (today.get(Calendar.MONTH) + 1) + "월 ");
		out.println( (today.get(Calendar.DAY_OF_MONTH)+1) + "일 ");
		out.println("</body>");
		out.println("</html>");
		
		out.close();
	}

}
