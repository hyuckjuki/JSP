<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.jspstudy.ch03.vo.*" %>
<%
	ArrayList<LottoNum> lottoList = new ArrayList<LottoNum>();

	LottoNum lotto = new LottoNum("968회", 2, 5, 12, 14, 24, 39, 33);
	lottoList.add(lotto);
	
	lotto = new LottoNum("969회", 3, 9, 10, 29, 40, 45, 7);
	lottoList.add(lotto);
	
	lotto = new LottoNum("970회", 9, 11, 16, 21, 28, 36, 5);
	lottoList.add(lotto);
	
	lotto = new LottoNum("971회", 2, 6, 17, 18, 21, 26, 7);
	lottoList.add(lotto);
	
	lotto = new LottoNum("972회", 3, 6, 17, 23, 37, 39, 26);
	lottoList.add(lotto);
	
	// request 내장객체의 속성에 저장
	request.setAttribute("lottoList",lottoList);
	
	pageContext.forward("lottoNumResult.jsp");
	
	
%>