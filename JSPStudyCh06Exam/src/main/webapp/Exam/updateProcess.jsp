<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Ch06ExamVo.*, Ch06ExamDao.*" %>
<%
	//post 방식 요청에 대한 문자 셋 처리
	request.setCharacterEncoding("utf-8");

	String pass = null, mname = null, writer = null, content = null; wdate = null;
	int no = 0;
	
	no = Integer.parseInt(request.getParameter("no"));
	pass = request.getParameter("pass");
	
	// 한번 더 비밀번호를 체크
	ExamDao dao = new ExamDao();
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
	
	mname = request.getParameter("mname");
	writer = request.getParameter("writer");
	content = request.getParameter("content");
	wdate = request.getParameter("wdate");
	
	// 사용자가 입력한 데이터를 Board 객체로 만듦
	ExamVo b = new ExamVo();
	b.setNo(no);
	b.setMname(mname);
	b.setWriter(writer);
	b.setPass(pass);
	b.setContent(content);
	b.setWdate(wdate);
	// BoardDao를 이용해서 DB에서 no에 해당하는 게시 글 정보를 수정
	dao.updateBoard(b);
	
// 	response.sendRedirect("boardList.jsp"); // 1방법
%>
<!-- 2 방법  -->
<script>
	alert("수정이 완료되었습니다.");
	location.href='boardList.jsp';
</script>