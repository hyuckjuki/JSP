<%-- request 내장 객체의 속성 사용하기 결과 페이지 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>request 내장 객체의 속성 사용하기</title>
<style type="text/css">
	table {
		border: 1px solid gray;
		border-collapse: collapse;
	}
	td {		
		height: 30px;
		line-height: 30px;
		border: 1px dashed gray;
	}
	.title {
		background: #EAEAEA;
		font-weight: bold;
		font-size: 14px;
		text-align: center;
		border: 1px solid gray;
	}
	.th { 
		width: 100px;
		text-align: center; 
	}
	.td {
		width: 200px;
		padding-left: 10px;
	}
</style>
</head>
<body style="font-size: 12px;">
	<table>
		<tr>
			<td colspan="2" class="title">상품정보 입력</td>
		</tr>
		<tr>
			<td class="th">상품명</td>
			<%-- 
				request 영역의 속성을 읽는다. 
				속성명이 존재하지 않으면 null이 출력된다. 
			--%>
			<td class="td"><%= request.getAttribute("pName") %></td>
		</tr>
		<tr>
			<td class="th">제조사</td>
			<td class="td"><%= request.getAttribute("manufacturer") %></td>
		</tr>
		<tr>
			<td class="th">할인율</td>
			<td class="td"><%= request.getAttribute("discount") %>%</td>
		</tr>
		<tr>
			<td class="th">정가(판매가)</td>
			<td class="td"><%= request.getAttribute("price") %>
				(<%= request.getAttribute("sPrice") %>)</td>
		</tr>		
	</table>
	<p><a href="requestAttributeForm.jsp" >상품 입력하기</a></p>	
</body>
</html>