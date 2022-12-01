<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.ch06.vo.*,com.jspstudy.ch06.dao.*"%>
<%
//post 방식 요청에 대한 문자 셋 처리
	request.setCharacterEncoding("utf-8");

	String pass = null;
	int no = 0;
	
	no = Integer.parseInt(request.getParameter("no"));
	pass = request.getParameter("pass");
	
	// 한번 더 비밀번호를 체크
	BoardDao dao = new BoardDao();
	boolean isPassCheck = dao.isPassCheck(no, pass);
	
	// 비밀번호가 틀린경우
	if(!isPassCheck){
		
		StringBuilder sb = new StringBuilder();
		sb.append("<script>");
		sb.append("	alert('비밀번호가 맞지 않습니다.');");
		sb.append("	history.back();");
		sb.append("</script>");
		
		out.println(sb.toString());
		return;
	}
	
	// 비밀번호가 맞는 경우	- BoardDao를 이용해서 테이블에서  no에 해당하는 게시 글을 삭제
	dao.deleteBoard(no);
	// 테이블이 수정않는 곳 이동  -
	response.sendRedirect("boardList.jsp");
%>