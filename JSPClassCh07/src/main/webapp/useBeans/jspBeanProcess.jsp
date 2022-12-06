<%-- <jsp:useBean> 액션태그 - 요청 처리 페이지 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학생 등록 완료</title>
<style type="text/css">
	table {
		border: 1px solid blue;
		border-collapse: collapse; 
	}
	td { border: 1px solid blue; height: 30px; }
	.title {
		width: 100px;
		padding-left: 5px;
	}
	.content {
		width: 200px;
		padding-left: 5px;
	}
</style>	
</head>
<body style="font-size: 0.8em">
	<table>
		<tr>
			<td colspan="2" style="text-align: center; 
				height: 30px; line-height: 30px">
				<h3>학생 등록 완료</h3></td>
		</tr>
		<tr>
			<td  class="title">이 름</td>
			<td class="content"></td>
		</tr>
		<tr>
			<td class="title">성 별</td>
			<td class="content"></td>
		</tr>
		<tr>
			<td class="title">나 이</td>			
			<td class="content"></td>
		</tr>
		<tr>
			<td class="title">연락처</td>
			<td class="content"></td>
		</tr>
	</table>	
</body>
</html>