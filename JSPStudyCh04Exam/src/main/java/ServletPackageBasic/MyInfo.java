package ServletPackageBasic;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/MyInfo")
public class MyInfo extends HttpServlet {
    public MyInfo() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out =response.getWriter();
		
		out.println("<h1>My Info</h1></br>");
		out.println("이름 : 기혁주</br>");
		out.println("나이 : 25</br>");
		out.println("주소 : 경기도 부천시</br>");
		
		out.close();
	}

}
