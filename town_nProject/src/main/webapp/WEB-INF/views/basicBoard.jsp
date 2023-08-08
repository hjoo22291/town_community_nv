<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>글 게시판 화면</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/basicBoard.css"> 
</head>
<body>
<jsp:include page="Header.jsp" />
<div id="board_layout">
	<jsp:include page="boardMenu.jsp" />
	<div id="board_main">
	
		<div id="board_name">
			<span>${boardName}</span>
		</div>
		
		<div id="top_btnBox">
			<div id="order_btnBox">
				<button>최신순</button>
				<button>좋아요</button>
				<button>조회수</button>
			</div>
			<div>
				<c:if test="${!(param.ctgy eq '공지사항')}">
					<input type="button" id="writeBtn" value="글쓰기">
				</c:if>
			</div>
		</div>
		
		<div id="board_page">
			<table id="board-table">
				<thead>
					<tr>
						<th style="width: 7%;">번호</th>
						<th style="width: 52%;">제목/내용</th>
						<th style="width: 15%;">작성자</th>
						<th style="width: 12%;">작성일</th>
						<th style="width: 7%;">좋아요</th>
						<th style="width: 7%;">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty param.ctgy || param.ctgy ==  '공지사항'}">
						<c:forEach var="boardlist" items="${boardlist}" varStatus="vs">
							<c:if test="${showNotice[vs.index]}">
								<tr>
									<td>
										${empty param.page || param.page == 1 
										? totalPostCnt - vs.index
										: totalPostCnt - (param.page - 1) * postCntPerPage - vs.index}
									</td>
									<td>
										<c:if test="${(param.sort eq 'board_preview') || (param.sort eq 'board_all')}">
											<c:if test='${searchPreview[vs.index] eq ""}'>
												<a href="/boarddetail?bi=${boardlist.board_id}" class="writing-title" id="${boardlist.board_id}">${boardlist.board_title}</a>
											</c:if>
											<c:if test='${!(searchPreview[vs.index] eq "")}'>
												<a href="/boarddetail?bi=${boardlist.board_id}" class="writing-title" id="${boardlist.board_id}">${boardlist.board_title} / ${searchPreview[vs.index]}</a>
											</c:if>
										</c:if>
										<c:if test="${!((param.sort eq 'board_preview') || (param.sort eq 'board_all'))}">
											<a href="/boarddetail?bi=${boardlist.board_id}" class="writing-title" id="${boardlist.board_id}">${boardlist.board_title}</a>
										</c:if>
										<c:if test="${includeImg[vs.index]}">
											<img class="include" src="/img/image_icon.png">
										</c:if>
										<c:if test="${includePlace[vs.index]}">
											<img class="include" src="/img/place_icon.png">
										</c:if>
									</td>
									<td>${boardlist.writer}</td>
									<td>${fn:split(boardlist.writing_time, " ")[0]}</td>
									<td>${boardlist.good_cnt}</td>
									<td>${boardlist.view_cnt}</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:if>
					<c:if test="${!(empty param.ctgy || param.ctgy ==  '공지사항')}">
						<c:forEach var="boardlist" items="${boardlist}" varStatus="vs">
							<tr>
								<td>
									${empty param.page || param.page == 1 
									? totalPostCnt - vs.index
									: totalPostCnt - (param.page - 1) * postCntPerPage - vs.index}
								</td>
								<td>
									<c:if test="${(param.sort eq 'board_preview') || (param.sort eq 'board_all')}">
										<c:if test='${searchPreview[vs.index] eq ""}'>
											<a href="/boarddetail?bi=${boardlist.board_id}" class="writing-title" id="${boardlist.board_id}">${boardlist.board_title}</a>
										</c:if>
										<c:if test='${!(searchPreview[vs.index] eq "")}'>
											<a href="/boarddetail?bi=${boardlist.board_id}" class="writing-title" id="${boardlist.board_id}">${boardlist.board_title} / ${searchPreview[vs.index]}</a>
										</c:if>
									</c:if>
									<c:if test="${!((param.sort eq 'board_preview') || (param.sort eq 'board_all'))}">
										<a href="/boarddetail?bi=${boardlist.board_id}" class="writing-title" id="${boardlist.board_id}">${boardlist.board_title}</a>
									</c:if>
									<c:if test="${includeImg[vs.index]}">
										<img class="include" src="/img/image_icon.png">
									</c:if>
									<c:if test="${includePlace[vs.index]}">
										<img class="include" src="/img/place_icon.png">
									</c:if>
								</td>
								<td>${boardlist.writer}</td>
								<td>${fn:split(boardlist.writing_time, " ")[0]}</td>
								<td>${boardlist.good_cnt}</td>
								<td>${boardlist.view_cnt}</td>
							</tr>
						</c:forEach>
					</c:if>
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
	      </select>
				<input type=text id="board_searchword" >
				<input type=hidden id="search_ctgy" value="${boardName}">
				<input type=hidden id="search_ti" value="${ti}">
				<input type=button id="board_search_btn" value="검색">
			</div> 
		</div>
		
		
	</div>
</div>
</body>
<script>
$(document).ready(function() {
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
	
	// 만약 url에 sort 속성값이 있으면 검색 기준 sort 값으로 변경
	if ("${param.sort}" !== "") {
		$("#selectBox").val("${param.sort}").prop("selected", true);
	}
	
	// 정렬 기준 컬럼 버튼 눌린 처리
	if ("${param.ordercol}" === "최신순") {
		$("#order_btnBox button").eq(0).addClass("activated");
	} else if ("${param.ordercol}" === "좋아요") {
		$("#order_btnBox button").eq(1).addClass("activated");
	} else if("${param.ordercol}" === "조회수") {
		$("#order_btnBox button").eq(2).addClass("activated");
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
		let ctgy = "${param.ctgy}";
		let sort = $("#selectBox option:selected").val();
		let keyword = $("#board_searchword").val();
		location.href = "/basicBoard?ctgy=" + ctgy + "&ti=${param.ti}" + "&sort=" + sort + "&keyword=" + keyword;
	}); //onclick
	
	// 게시글 검색 input태그에 focus인 상태에서 엔터 누르면 검색하기
	$("#board_searchword").on("keydown", function(e) {
		if (e.keyCode === 13) {
			$("#board_search_btn")[0].click();
		}
	});
	
	// 정렬 기준을 눌렀을 떄
	$("#order_btnBox button").on("click", function() {
		let url = document.location.href;
		if (url.indexOf("?") === -1) {
			url += "?";
		} else {
			url += "&";
		}
		let ordercolIndex = url.indexOf("ordercol=");
		if (ordercolIndex > -1) {
			url = url.substr(0, ordercolIndex);
		}
		let ordercol = $(this).text().trim();
		window.location.href = url + "ordercol=" + ordercol;
	});
	
}); //ready
</script>
</html>
