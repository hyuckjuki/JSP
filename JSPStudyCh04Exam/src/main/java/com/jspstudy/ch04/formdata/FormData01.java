package com.jspstudy.ch04.formdata;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 회원등록 폼 데이터를 처리하는 서블릿
@WebServlet("/formData01")
public class FormData01 extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		
		// 파라미터로 전송된 데이터를 저장할 변수 선언
		String name, id, pass, gender, nMail, aMail, iMail, job;
		
		/* GET 방식으로 전달되는 파라미터의 값을 읽어온다.
		 * 폼의 텍스트 필드에 입력된 값이 없으면 공백 문자열("")이 넘어온다.
		 * 나머지 폼 컴포넌트에서 넘어오는 데이터는 프린트 p40 참조
		 **/		
		name = request.getParameter("name");		
		id = request.getParameter("id");
		pass = request.getParameter("pass");
		gender = request.getParameter("gender");		
		nMail = request.getParameter("nMail");
		aMail = request.getParameter("aMail");
		iMail = request.getParameter("iMail");		
		job = request.getParameter("job");
		
		// view 페이지에 출력할 데이터를 request의 속성에 담고 있다. 
		request.setAttribute("name", name);
		request.setAttribute("id", id);
		request.setAttribute("pass", pass);
		request.setAttribute("gender", gender);
		request.setAttribute("nMail", receiveMail(nMail));
		request.setAttribute("aMail", receiveMail(aMail));
		request.setAttribute("iMail", receiveMail(iMail));
		request.setAttribute("job", job);
		
		/* view 페이지로 제어를 넘겨 요청에 대한 결과를 출력하기 위해
		 * HttpServletRequest 객체로 부터 RequestDispatcher 객체를
		 * 구하여 view/formDataView01.jsp로 포위딩을 하고 있다. 
		 **/
		RequestDispatcher rd = 
				request.getRequestDispatcher("view/formDataView01.jsp");
		rd.forward(request, response);
		
		/* 모델 데이터를 View 페이지로 전달해 View 페이지에서 HTML 문서 형식으로
		 * 응답 데이터를 만들기 때문에 아래와 같이 번거롭게 뷰를 직접 만들 필요는 없다. 
		 **/
		/*
		// 웹 브라우저에 출력될 응답문서의 형식과 문자 셋을 지정 
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		out.println("<html>");
		out.println("	<head>");
		out.println("		<title>회원 기본 정보</title>");
		out.println("	</head>");
		out.println("	<body>");
		out.println("		<h2>회원 기본 정보</h2>");
		out.printf("			이 름 : %s<br/>", (name.equals("")) ? "null" : name);
		out.printf("			아이디 : %s<br/>", id);
		out.printf("			비밀번호 : %s<br/>", pass);
		out.printf("			성 별 : %s<br/>", gender);
		out.printf("			공지메일 : %s<br/>", receiveMail(nMail));
		out.printf("			광고메일 : %s<br/>", receiveMail(aMail));
		out.printf("			정보메일 : %s<br/>", receiveMail(iMail));
		out.printf("			직 업 : %s<br/>", job);
		out.println("	</body>");
		out.println("<html>");
		
		// 작업이 끝나면 스트림을 닫는다.
		out.close();*/
	}
	
	// 체크박스의 선택 여부에 따라 문자열을 지정하는 메소드 
	private String receiveMail(String mail) {
		if(mail == null) {
			return "받지 않음";
		} else {
			return "받음";
		}
	}
}
