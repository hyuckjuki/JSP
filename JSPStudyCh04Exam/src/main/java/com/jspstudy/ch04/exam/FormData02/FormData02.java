package com.jspstudy.ch04.exam.FormData02;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/formData02")
public class FormData02 extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		
		String name, gender, call, call1, call2 ;
		
		name = request.getParameter("name");		
		gender = request.getParameter("gender");
		call = request.getParameter("call");
		call1 = request.getParameter("call1");		
		call2 = request.getParameter("call2");
		ArrayList<String> jobs = new  ArrayList<String>(Arrays.asList(request.getParameterValues("job")));
		ArrayList<String> interests = new  ArrayList<String>(Arrays.asList(request.getParameterValues("interest")));
		String job = String.join(", ", jobs);
		String interest = String.join(", ", interests);
		
		request.setAttribute("name", name);
		request.setAttribute("gender", gender);
		request.setAttribute("call", call);
		request.setAttribute("call1", call1);
		request.setAttribute("call2", call2);
		request.setAttribute("job", job);
		request.setAttribute("interest", interest);
		
		RequestDispatcher rd = 
				request.getRequestDispatcher("view/formDataView02.jsp");
		rd.forward(request, response);
	}
	
}
