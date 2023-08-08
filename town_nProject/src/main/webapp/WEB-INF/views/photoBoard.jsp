<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<style>
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

* {font-family : 'GmarketSansMedium';}
html {
	width : 1900px; 
	background: #E3E2E0;
}
body {
	width : 80%; 
	margin : 50px auto; 
	padding : 0px 20px; 
	background : #F2F2F2; 
	padding-top : 10px;
	padding-bottom : 30px;
}
#board_layout {
	width : 100%; 
	display : inline-flex; 
	justify-content : space-between; 
	/* padding-top : 30px; */
	padding : 30px;
}
#board_menu {
	width : 20%; 
	border-right : 1px solid #182434;
	padding : 10px;
}
#board_main {
	width : 80%; 
	padding : 10px;
}

.outerMenu {
	line-height: 3;
	margin: 0 auto;
	padding-inline-start: 1.5em;
	list-style-type: none;
	font-size : 25px;
	font-weight : bold;
}
.innerMenu {
	line-height: 2;
	list-style-position: inside;
	list-style-type: "> ";
	font-size : 20px;
	font-weight : normal;
}
</style>
<script>
$(document).ready(function(){
	//구현
});
</script>
</head>
<body>
<jsp:include page="Header.jsp" />
<div id="board_layout">
	<div id="board_menu">
		<ul class="outerMenu">
		  <li>
		    지금 우리 동네
		    <ul class="innerMenu">
		      <li class="innerMenu">나의 일상</li>
		      <li class="innerMenu">사건, 사고 소식</li>
		    </ul>
		  </li>
		  <li>
		    동네 사진전
		    <ul class="innerMenu">
		      <li class="innerMenu">오늘의 사진</li>
		      <li class="innerMenu">역대 당선작</li>
		    </ul>
		  </li>
		    <li>
		    만남의 광장
		    <ul class="innerMenu">
		      <li class="innerMenu">같이 줄서요</li>
		      <li class="innerMenu">같이해요 소모임</li>
		    </ul>
		  </li>
		    <li>
		    도움이 필요해요
		    <ul class="innerMenu">
		      <li class="innerMenu">분실문센터</li>
		      <li class="innerMenu">심부름센터</li>
		    </ul>
		  </li>
		    <li>
		    알고 계신가요?
		    <ul class="innerMenu">
		      <li class="innerMenu">행사 소식</li>
		      <li class="innerMenu">새로 오픈했어요</li>
		    </ul>
		  </li>
		  <li>HOT 게시판</li>
		</ul>
	</div>
	<div id="board_main"></div>
</div>
</body>
</html>