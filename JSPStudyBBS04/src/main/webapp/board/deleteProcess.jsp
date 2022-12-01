<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.sql.*, java.io.*, java.net.*"  %>
<%@ page import="com.jspstudy.bbs.vo.*, com.jspstudy.bbs.dao.*"  %>
<%
	/* boardDetail.jsp에서 요청시 post로 넘어오기 때문에 
	 * request 영역의 문자 셋 처리가 필요하다.
	 **/
	request.setCharacterEncoding("utf-8");

	String sNo = request.getParameter("no");
	String pass = request.getParameter("pass");
	String pageNum = request.getParameter("pageNum");
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");	
	
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
	
	/* 요청 파라미터에서 type이나 keyword가 비어 있으면 일반 
	 * 게시 글 리스트에서 넘어온 요청으로 간주하여 false 값을 갖게 한다.
	 * 이 정보는 게시 글 리스트와 검색 리스트로 구분해 돌려보내기 위해 필요하다.
	 **/
	boolean searchOption = (type == null || type.equals("") 
			|| keyword == null || keyword.equals("")) ? false : true; 	
	
	/* 리다이렉트 할 때 게시 글 리스트의 페이지 번호를 파라미터로 넘겨 사용자가 
	 * 게시 글 수정을 요청한 페이지와 동일한 페이지로 리다이렉트 시킨다.
	 **/
	String url = "boardList.jsp?pageNum=" + pageNum;

	/* 검색 리스트 상태에서 게시 글 상세보기로 들어와 게시 글을 삭제하는 것이라면 
	 * 검색 옵션에 해당하는 검색한 결과에 대한 게시 글 리스트 페이지로 Redirect
	 * 시켜야 하므로 type과 keyword를 Redirect 주소에 추가한다.
	 * Redirect 기법은 요청한 결과가 이동했다고 브라우저에게 이동할 주소를 응답하는
	 * 것으로 브라우저는 주소 표시줄에 주소를 입력해 요청하게 되므로 GET 방식 요청이다. 
	 **/
	if(searchOption) {		

		/* 리다이렉트 할 때 파라미터에 한글이 포함되어 있으면 한글로 된 파라미터 값은
		 * 공백문자로 변경되어 리다이렉트 되기 때문에 한글 데이터는 깨지게 된다.
		 * 이런 경우에는 java.net 패키지의 URLEncoder 클래스를 이용해 아래와
		 * 같이 수동으로 URL 인코딩을 하면 이 문제를 해결할 수 있다.
		 **/	
		keyword = URLEncoder.encode(keyword, "utf-8");		
		url += "&type=" + type + "&keyword=" + keyword;
	}
	System.out.println("keyword : " + keyword);
	System.out.println("url : " + url);	
	
	/* DB에 게시 글을 삭제하고 브라우저에게 게시 글 리스트를 요청하라고 응답
	 * 게시 글 삭제가 완료된 후 Redirect 시키지 않으면 이 페이지를 새로 고침 하여
	 * 재요청 할 때 마다 이미 삭제된 게시 글을 계속해서 수정하려고 하는 문제가 발생한다.
	 * 이런 경우에는 Redirect 기법을 이용해 DB에 추가, 수정, 삭제하는 동작이 아닌
	 * 조회하는 곳으로 이동하도록 하면 문제를 해결 할 수 있다.
	 **/
	response.sendRedirect(url);
%>