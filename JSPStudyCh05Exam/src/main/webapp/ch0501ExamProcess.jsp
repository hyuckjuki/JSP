<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.io.*"%> 
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	ArrayList<String> colors = new ArrayList<String>(Arrays.asList(request.getParameterValues("color")));
	ArrayList<String> foods = new ArrayList<String>(Arrays.asList(request.getParameterValues("food")));
	ArrayList<String> animals = new ArrayList<String>(Arrays.asList(request.getParameterValues("animal")));
	ArrayList<String> hobbys = new ArrayList<String>(Arrays.asList(request.getParameterValues("hobby")));
	String color = String.join(", ",colors);
	String food = String.join(", ",foods);
	String animal = String.join(", ",animals);
	String hobby = String.join(", ",hobbys);
	
	request.setAttribute("name", name);
	request.setAttribute("color", color);
	request.setAttribute("food", food);
	request.setAttribute("animal", animal);
	request.setAttribute("hobby", hobby);
	
	pageContext.forward("ch0501ExamResult.jsp");
%>