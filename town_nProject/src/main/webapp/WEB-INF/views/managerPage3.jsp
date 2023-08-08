<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네일보 관리자 페이지</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/BoardCommon.css" />
<link rel="stylesheet" href="/css/Mypage.css" />
<link rel="stylesheet" href="/css/Mypage2.css"> 
<style>
.admin_group {
	font-size : 21px;
	border : none;
	background-color : transparent;	
	cursor: pointer;
}
#board-table td{
	font-size : 15px;
}
</style>
<script>
$(document).ready(function() {

	// page 이동 버튼 클릭시 동작
	$("#pagination input:button").on("click", function(e) {
		let url = document.location.href;
		let pageIndex = url.indexOf("&page=");
		if (pageIndex > -1) {
			url = url.substr(0, pageIndex);
		}
		let pageval = $(this).val();
		let page = "$page=1";
		if (pageval === "◁◁") {
			page = "&page=1";
		} else if (pageval === "◁") {
			page = "&page=${startPageNum - 10}";
		} else if (pageval === "▷") {	
			page = "&page=${endPageNum + 1}";
		} else if (pageval === "▷▷") {
			page = "&page=${totalPageCnt}";
		} else if (pageval <= parseInt("${totalPageCnt}") && pageval >= 1) {
			page = "&page=" + pageval;
		}
		window.location.href = url + page;
	}); //onclick
}); //ready
</script>
</head>
<body>
<jsp:include page="Header.jsp" />
<div id="myPage_layout">
<jsp:include page="adminMenu.jsp" />
	
	<div id="myPage_main">
		<div id="myPage_name">
			관리자 페이지입니다.
		</div>
		<div id="board_page">
			원하는 메뉴를 선택해주세요.
		</div>
	</div>
</div>
</body>
</html>