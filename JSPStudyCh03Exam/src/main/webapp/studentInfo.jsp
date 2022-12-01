<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jspstudy.ch03.vo.Student, java.util.*" %>
<%
	//학생 정보 저장할 ArrayList 객체 생성
	ArrayList<Student> studentInfo = new ArrayList<Student>();
		
	//ArrayList 에 저장
	Student stu = new Student("홍길동",23,"남성");
	studentInfo.add(stu);
	
	stu = new Student("어머나",21,"여성");
	studentInfo.add(stu);
	
	stu = new Student("왕호감",22,"남성");
	studentInfo.add(stu);
	
	stu = new Student("왕빛나",23,"여성");
	studentInfo.add(stu);
	
	stu = new Student("이나래",25,"여성");
	studentInfo.add(stu);
	
	// Request 이름 , ArrayList 저장
	request.setAttribute("studentInfo",studentInfo);
	
	// 두개 동시출력? 안되는듯..? 
	pageContext.forward("studentResult.jsp");
	

%>
