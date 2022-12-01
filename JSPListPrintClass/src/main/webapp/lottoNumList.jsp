<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스크립틀릿과 표현식을 이용해 로또 당첨 번호 리스트 출력</title>
<style>
	body { font-size: 12px; }
	#lotto_list {
		width: 810px;
		margin: 0 auto;		
	}
	h2 { 
		font-size: 2em;
		text-align: center; 
	}
	div#lottoWrap {
		width: 720px;
		margin: 30px auto;
		padding: 3px;
		background-color: #EAEAEA;
		border-radius: 10px;
	}		
	div.num_box {
		padding: 7px;
		margin: 7px;
		text-align: center;	
		background-color: #FFFFFF;
		border-radius: 5px;	
		border: 1px solid #AAAAFF;
	}
	span.lotto_num {
		display: inline-block;
		width: 45px;
		height: 45px;
		line-height: 45px;
		margin: 0px 7px;		
		vertical-align: middle;
	}
	span.bonus_txt {
		color: gray;
		font-size: 14px;
		font-weight: bold;
		width: 120px;
	}
	span.lotto_num:first-child {
		font-size: 20px;
		font-weight: bold;
		color: #3333FF;		
		width: 80px;	
	}
</style>
</head>
<body>
	<div id="lotto_list">
	</div>
</body>
</html>