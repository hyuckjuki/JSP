<%-- JSP 페이지에서 스크립틀릿과 표현식을 이용해 도서 리스트 출력하기 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	body { font-size: 12px; }
	#book_list {
		width: 600px;
		margin: 0 auto;		
	}
	h2 { 
		font-size: 2em;
		text-align: center; 
	}
	table {
		border-top: 2px solid #3A96D6;		
		margin: 0px auto;		
	}
	#image {
		padding-right: 20px;
	}
	#bookTitle {
		font-size: 14px;
		font-weight: bold;
		width: 350px;
	}
	#tdBottom {
		border-bottom: 1px dotted gray;
	}
	#lastBottom {
		border-bottom: 2px dotted #3A96D6;
	}
	.empty_cell { font-size: 6px; }
</style>
<title>스크립틀릿과 표현식을 이용해 도서 리스트 출력</title>
</head>
<body>
	<div id="book_list">
	</div>
</body>
</html>