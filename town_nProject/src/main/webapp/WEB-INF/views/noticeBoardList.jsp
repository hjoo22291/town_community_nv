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
/* 검색창 */
#board_search_box {
	width : 100%;
	display : flex;
	justify-content : center;
	margin-top : 20px;
	
}
#board_search_inputs{
	margin-left : 25px;
	width : 410px;
	display : flex;
	justify-content: space-between;
}
#selectBox {
	width : 80px; height : 30px;
	text-align: center;
	font-size : 14px;
}
#board_searchword {
	width : 230px; height : 25px;
}
#board_search_btn {
	width:60px; height : 30px;
	font-size : 14px;
	border : 1px solid #8D98AA;
	border-radius : 3px;
	background-color : transparent;	
	cursor: pointer;
}
#board_search_btn:hover {
	background-color : #6D829B;
	color : white;			
} 
/* 글쓰기 버튼 */
#top_btnBox{
	width : 97%;
	display : flex;
	justify-content: flex-end;
	margin-bottom : 5px;
	padding-left: 50px;
	padding-right: 30px;
}
#writeBtn {
	width:70px; height : 35px;
	font-size : 13px;
	border : 1px solid #8D98AA;
	border-radius : 3px;
	background-color : transparent;	
	cursor: pointer;
}
#writeBtn:hover {
	background-color : #6D829B;
	color : white;			
}
</style>
</head>
<body>
<jsp:include page="Header.jsp" />
<div id="myPage_layout">
	<div id="myPage_menu">
		<ul class="allMenu">
	      <li class="outerMenu">
	      	관리자 페이지
	      	<ul class="innerMenu">
			      <li class="innerMenu"><a href="/noticeBoardList">공지사항</a></li>
			    </ul>
      	</li>
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
			공지사항
		</div>
		<div id="top_btnBox">
			<div>
				<input type="button" id="writeBtn" value="글쓰기">
			</div>
		</div>
		<div id="board_page">
			<table id="board-table">
				<thead>
					<tr>
						<th style="width: 7%;">번호</th>
						<th style="width: 40%;">공지사항 제목</th>
						<th style="width: 26%;">동네</th>
						<th style="width: 15%;">작성자</th>
						<th style="width: 12%;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="boardlist" items="${boardlist}" varStatus="vs">
						<tr>
							<td>
								${empty param.page || param.page == 1 
								? totalPostCnt - vs.index
								: totalPostCnt - (param.page - 1) * postCntPerPage - vs.index}
							</td>
							<td><a href="/boarddetail?bi=${boardlist.board_id}" class="writing-title">${boardlist.board_title}</a></td>
							<td>${town_ids[vs.index]}</td>
							<td>${boardlist.writer}</td>
							<td>${fn:split(boardlist.writing_time, " ")[0]}</td>
						</tr>
					</c:forEach>
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
		
		<!-- 검색창 -->
		<div id="board_search_box">
			<div id="board_search_inputs">
			  <select id="selectBox" name="board_search_from">
					<option value="board_all" selected> 전체 </option>
					<option value="board_title"> 제목 </option>
					<option value="board_preview"> 내용 </option>
					<option value="writer"> 작성자 </option>
					<option value="town_id"> 동네 아이디 </option>
					<option value="town_name"> 동네 이름 </option>
	      </select>
				<input type=text id="board_searchword" >
				<input type=button id="board_search_btn" value="검색">
			</div> 
		</div>
		
	</div>
</div>
</body>
<script>
$(document).ready(function() {
	// 공지사항 목록의 글쓰기 버튼을 클릭하면 공지사항 작성 페이지로 이동
	$("#writeBtn").on("click", function() {
		location.href = "/noticeWritingForm";
	}); //onclick
	
	// 만약 url에 sort 속성값이 있으면 검색 기준 sort 값으로 변경
	if ("${param.sort}" !== "") {
		$("#selectBox").val("${param.sort}").prop("selected", true);
	}
	
	// page 이동 버튼 클릭시 동작
	$("#pagination input:button").on("click", function(e) {
		let url = document.location.href;
		if (url.indexOf("?") === -1) {
			url += "?";
		} else {
			url += "&";
		}
		let pageIndex = url.indexOf("page=");
		if (pageIndex > -1) {
			url = url.substr(0, pageIndex);
		}
		let pageval = $(this).val();
		let page = "page=1";
		if (pageval === "◁◁") {
			page = "page=1";
		} else if (pageval === "◁") {
			page = "page=${startPageNum - 10}";
		} else if (pageval === "▷") {	
			page = "page=${endPageNum + 1}";
		} else if (pageval === "▷▷") {
			page = "page=${totalPageCnt}";
		} else if (pageval <= parseInt("${totalPageCnt}") && pageval >= 1) {
			page = "page=" + pageval;
		}
		window.location.href = url + page;
	}); //onclick
	
	// 게시글 검색 버튼 클릭
	$("#board_search_btn").on("click", function() {
		if ($("#board_searchword").val() === "") {
			alert("검색할 내용을 입력해주세요.");
			return;
		}
		let sort = $("#selectBox option:selected").val();
		let keyword = $("#board_searchword").val();
		location.href = "/noticeBoardList?&sort=" + sort + "&keyword=" + keyword;
	}); //onclick
	
	// 게시글 검색 input태그에 focus인 상태에서 엔터 누르면 검색하기
	$("#board_searchword").on("keydown", function(e) {
		if (e.keyCode === 13) {
			$("#board_search_btn")[0].click();
		}
	}); 
	
}); //ready
</script>
</html>