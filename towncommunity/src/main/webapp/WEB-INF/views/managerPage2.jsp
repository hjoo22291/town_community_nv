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
<div id="myPage_layout">
	<div id="myPage_menu">
		<ul class="allMenu">
	      <li class="outerMenu">관리자 페이지</li>
			  <li class="outerMenu">
			    회원관리
			    <ul class="innerMenu">
			      <li class="innerMenu">회원정보</li>
			    </ul>
			  </li>
			  <li class="outerMenu">
			    신고관리
			    <ul class="innerMenu">
			      <li class="innerMenu">신고된 글</li>
			      <li class="innerMenu">신고된 댓글</li>
			      <li class="innerMenu">신고된 채팅</li>
			    </ul>
			  </li>		    

		</ul>
	</div>
	
	<div id="myPage_main">
		<div id="myPage_name">
			회원정보
		</div>
				<div id="board_page">
			<table id="board-table">
				<thead>
					<tr>
						<th style="width: 7%;">번호</th>
						<th style="width: 13%;">게시글 분류</th>
						<th style="width: 35%;">댓글 내용</th>
						<th style="width: 20%;">게시글 제목</th>
						<th style="width: 13%;">작성자</th>
						<th style="width: 12%;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td></td>
						<td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="board_pagingNum">
			<div id="pagination">
				<c:if test="${prev}">
					<input type="button" class="pageNumBtn" value="◁◁">
					<input type="button" class="pageNumBtn" value="◁">
				</c:if>
				
				<c:forEach begin="${startPageNum}" end="${endPageNum}" var="i">
					<c:if test="${selectedPageNum != i}">
						<input type="button" class="pageNumBtn" value="${i}" style="font-weight: 300; color: #555">
					</c:if>
					<c:if test="${selectedPageNum == i}">
						<input type="button" class="pageNumBtn" value="${i}" style="font-weight: 900">
					</c:if>
				</c:forEach>
				<c:if test="${next}">
					<input type="button" class="pageNumBtn" value="▷">
					<input type="button" class="pageNumBtn" value="▷▷">
				</c:if>
			</div>
		</div>
	</div>
</div>
</body>
</html>