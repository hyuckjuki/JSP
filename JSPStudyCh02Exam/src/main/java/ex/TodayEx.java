package ex;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/TodayEx")
public class TodayEx extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TodayEx() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int result = 0;
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		for (int i = 0 ; i <= 100 ; i++) {
			if(i % 2 == 0) {
				result = result + i ;
			}
		}
		
		out.println("1부터 100까지 짝수의 합 : " + result);
	}

}
