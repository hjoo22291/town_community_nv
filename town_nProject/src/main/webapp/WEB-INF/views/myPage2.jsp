<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네일보 마이페이지</title>
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
<body style="background-image: url(/img/newspaper2.svg);">
<jsp:include page="Header.jsp" />
<div id="myPage_layout">
	<div id="myPage_menu">
		<ul class="allMenu">
	      <a href="/myPage"><li class="outerMenu">My page</li></a>
		  <li class="outerMenu">
		    내 글 목록
		    <ul class="innerMenu">
		      <li class="innerMenu">내가 쓴 글</li>
		      <li class="innerMenu">내가 쓴 댓글</li>
		      <li class="innerMenu">좋아요 한 글</li>
		    </ul>
		  </li>
		    <li class="outerMenu">내 채팅목록</li>
		  	<li class="outerMenu"><a href="/myinform">내 정보 수정</a></li>
	   	 	<li class="outerMenu"><a href="#" onclick="return updatepasswordopen()">비밀번호 변경</a></li>
		  <li id="deleteclick"class="outerMenu">회원 탈퇴</li>
		</ul>
	</div>
	
	<div id="board_main">
		<div id="board_name">
			<span>${empty param.ctgy ? "My page" : param.ctgy}</span>
		</div>
		
		<div id="board_page">
			<table id="board-table">
				<thead>
					<tr>
						<c:if test="${param.ctgy eq '내가 쓴 글' || param.ctgy eq '좋아요 한 글'}">
							<th>번호</th>
							<th>게시글 분류</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</c:if>
						<c:if test="${!(param.ctgy eq '내가 쓴 글' || param.ctgy eq '좋아요 한 글')}">
							<th style="width: 7%;">번호</th>
							<th style="width: 13%;">게시글 분류</th>
							<th style="width: 35%;">댓글 내용</th>
							<th style="width: 20%;">게시글 제목</th>
							<th style="width: 13%;">작성자</th>
							<th style="width: 12%;">작성일</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="boardlist" items="${boardlist}" varStatus="vs">
						<tr>
							<c:if test="${param.ctgy eq '내가 쓴 글' || param.ctgy eq '좋아요 한 글'}">
								<td>
									${empty param.page || param.page == 1 
									? totalPostCnt - vs.index
									: totalPostCnt - (param.page - 1) * postCntPerPage - vs.index}
								</td>
								<td>${boardlist.board_name_inner}</td>
								<td><a href="/boarddetail?bi=${boardlist.board_id}" class="writing-title" id="${boardlist.board_id}">${boardlist.board_title}</a></td>
								<td>${boardlist.writer}</td>
								<td>${fn:split(boardlist.writing_time, " ")[0]}</td>
								<td>${boardlist.view_cnt}</td>
							</c:if>
							<c:if test="${!(param.ctgy eq '내가 쓴 글' || param.ctgy eq '좋아요 한 글')}">
								<td>
									${empty param.page || param.page == 1 
									? totalPostCnt - vs.index
									: totalPostCnt - (param.page - 1) * postCntPerPage - vs.index}
								</td>
								<td>${boardlist.board_name_inner}</td>
								<td><a href="/boarddetail?bi=${boardlist.board_id}" class="writing-title" id="${boardlist.board_id}">${boardlist.comment_contents}</a></td>
								<td>${boardlist.board_title}</td>
								<td>${boardlist.comment_writer}</td>
								<td>${fn:split(boardlist.comment_time, " ")[0]}</td>
							</c:if>
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
		
	
		
	</div>
	
</div>
</body>
<script>
	//글 누르면 조회수+1, 해당 글 상세페이지로 이동
	$(".writing-title").on('click', function(){
	    const boardId = $(this).attr('id');
	    $.ajax({
	        url : 'updateViewcnt',
	        type : 'post',
	        data : {'bi' : boardId},
	        success : function(response){
	            if(response > 0) {}
	            else {
	                alert("문제가 발생했습니다.");
	            }
	        },
	        error: function(request,status,error) {
	              alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	              console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	          }
	    });//ajax
	});//글 1개 조회

	//비밀번호 변경 클릭
	function updatepasswordopen() {
  	var win =window.open("/Updatepassword", "PopupWin", "width=980,height=500");
 	win;
	}
</script>
<script src="/js/Mypage.js"></script>
</html>