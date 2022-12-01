package com.jspstudy.ch04.servletbasic;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NowServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		
		/* 웹 브라우저에 출력될 응답문서의 형식과 문자 셋을 지정
		 * ContentType 설정은 Response 객체로 부터 PrintWriter 
		 * 객체를 얻기 전에 지정해야 한글이 깨지지 않고 제대로 동작한다.
		 **/
		response.setContentType("text/html; charset=UTF-8");
		
		// 응답 처리를 위해 Response 객체로부터 스트림 객체를 얻음
		PrintWriter out = response.getWriter();
		Calendar cal = Calendar.getInstance();		
		
		/* HTML 문서 형식에 맞게 웹 브라우저로 전송할 데이터를 작성한다.
		 * HTML 문서 형식에 맞게 html 태그부터 제대로 작성해야 하지만 out.println()으로
		 * 출력되는 내용은 브라우저에 출력되는 내용이 되므로 기본 태그들은 생략했다. 
		 **/
		out.println("<h2>현재 시간</h2>" 
				+ cal.get(Calendar.YEAR) + "년 "
				+ (cal.get(Calendar.MONTH) + 1) + "월 "
				+ cal.get(Calendar.DAY_OF_MONTH) + "일 "
				+ cal.get(Calendar.HOUR) + "시 " 
				+ cal.get(Calendar.MINUTE) + "분 "
				+ cal.get(Calendar.SECOND) +"초 입니다.");	
		
		// 작업이 끝나면 스트림을 닫는다.
		out.close();
	}
}