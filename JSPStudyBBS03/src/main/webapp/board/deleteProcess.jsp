<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.sql.*, java.io.*"  %>
<%@ page import="com.jspstudy.bbs.vo.*, com.jspstudy.bbs.dao.*"  %>
<%	
	String sNo = request.getParameter("no");
	String pass = request.getParameter("pass");
	String pageNum = request.getParameter("pageNum");
	
	// no와 pass 그리고 pageNum이 비어 있으면 비정상 요청임
	if(sNo == null || sNo.equals("") || pass == null || pass.equals("")
		|| pageNum == null || pageNum.equals("")) {
		out.println("<script>");
		out.println("	alert('잘못된 접근입니다.');");
		out.println("	history.back();");
		out.println("</script>");
		return;
	}	
	
	// BoardDao 객체 생성
	BoardDao dao = new BoardDao();
	int no = Integer.parseInt(sNo);
	
	// 게시 글의 비밀번호를 체크해 맞지 않으면 이전으로 돌려보낸다.
	boolean isPassCheck = dao.isPassCheck(no, pass);	
	if(! isPassCheck) {
		System.out.println("비밀번호 맞지 않음");
		StringBuilder sb = new StringBuilder();
		sb.append("<script>");
		sb.append("	alert('비밀번호가 맞지 않습니다.');");
		sb.append("	history.back();");
		sb.append("</script>");
		out.println(sb.toString());			
		return;
	}
	
	// BoardDao 객체를 이용해 게시 글을 삭제한다.
	dao.deleteBoard(no);	

	/* DB에 게시 글을 삭제하고 브라우저에게 게시 글 리스트를 요청하라고 응답
	 * 게시 글 삭제가 완료된 후 Redirect 시키지 않으면 이 페이지를 새로 고침 하여
	 * 재요청 할 때 마다 이미 삭제된 게시 글을 계속해서 수정하려고 하는 문제가 발생한다.
	 * 
	 *	리다이렉트 할 때 게시 글 리스트의 페이지 번호를 파라미터로 넘기고 있다. 
	 **/		
	response.sendRedirect("boardList.jsp?pageNum=" + pageNum);
%>