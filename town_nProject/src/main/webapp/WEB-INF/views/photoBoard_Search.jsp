<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/BoardCommon.css" />
<Style>
#top_btnBox{
	width : 97%;
	display : flex;
	justify-content:flex-end;
	margin-bottom : 10px;
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
.one_searchBoard {
	width : 210px; height : 300px;
	margin-right : 20px;
	margin-bottom : 20px;
	cursor: pointer;
	border-bottom: 1px solid gray;
}
.one_photo {
	width : 210px; height : 150px;
 	> img {border : 1px solid #E3E2E0; }
}
.one_reaction {
	width : 210px; height : 30px;
	display : flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
}
.reaction1 {
	display : flex; 
	align-items: center;
	width : auto; height : 25px;
}
.reaction2 {
	display : flex; 
	align-items: center;
	width : auto; height : 25px;
}
.one_title {
	width : 210px; height : 40px;
  	margin: 5px 0px;
	overflow: hidden;
	text-overflow: ellipsis;
	/* white-space: normal; */
	line-height: 1.3;
	height: 2.6em;
	/* text-align: left; */
	word-wrap: break-word;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}
.one_contents {
	width : 210px; height : 60px;
  	margin: 5px 0px;
  	font-size : 13px;
	overflow: hidden;
	text-overflow: ellipsis;
	/* white-space: normal; */
	line-height: 1.3;
	height: 2.6em;
	/* text-align: left; */
	word-wrap: break-word;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}
.one_photoInfo {
	display : flex;
	justify-content: space-between;
	width : 210px;
}
.one_photoWriter {
	font-size : 10px;
	line-height: 10px;
	color : gray;
	width : 120px;, height : 10px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	word-break:break-all;
}
.one_writingTime {
	font-size : 10px;
	line-height: 10px;
	color : gray;
}
#photo_search_box {
	width : 100%;
	display : flex;
	justify-content : center;
	margin-top : 20px;
	
}
#photo_search_inputs{
	margin-left : 25px;
	width : 410px;
	display : flex;
	justify-content: space-between;
}
#photoSelectBox {
	width : 80px; height : 30px;
	text-align: center;
	font-size : 14px;
}
#photo_searchword {
	width : 230px; height : 25px;
}
#photo_search_btn {
	width:60px; height : 30px;
	font-size : 14px;
	border : 1px solid #8D98AA;
	border-radius : 3px;
	background-color : transparent;	
	cursor: pointer;
}
#photo_search_btn:hover {
	background-color : #6D829B;
	color : white;			
} 

</Style>
<script>
$(document).ready(function(){
	//페이지 버튼 눌렀을때 해당페이지 보여주기
 	$(".photoPageNumBtn").on('click', function(){
		const queryparamsPage = {
		   page: $(this).val(),
		   ctgy: "${searchdto.searchType1}",
		   ti: "${searchdto.searchType2}"
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});//pageNumBtn클릭
	
	//첫페이지
 	$("#photoBoardPageBtnFirst").on('click', function(){
		const queryparamsPage = {
		   page: 1,
		   ctgy: "${searchdto.searchType1}",
		   ti: "${searchdto.searchType2}"
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
 	//이전페이지
 	$("#photoBoardPageBtnPre").on('click', function(){
		const queryparamsPage = {
		   page: "${response.pagination.startPage-1}",
		   ctgy: "${searchdto.searchType1}",
		   ti: "${searchdto.searchType2}"
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
	//다음페이지
 	$("#photoBoardPageBtnNext").on('click', function(){
		const queryparamsPage = {
		   page: "${response.pagination.endPage+1}",
		   ctgy: "${searchdto.searchType1}",
		   ti: "${searchdto.searchType2}"
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
	
 	//마지막페이지
 	$("#photoBoardPageBtnLast").on('click', function(){
		const queryparamsPage = {
		   page: "${response.pagination.totalPageCount}",
		   ctgy: "${searchdto.searchType1}",
		   ti: "${searchdto.searchType2}"
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});//pageNumBtn클릭
	
	//글 누르면 해당 글 상세페이지로 이동
	$(".one_searchBoard").on('click', function(){
		const boardId = $(this).attr('id');
		location.href = "/photoboarddetail?bi="+boardId;

	});//글 1개 조회
	
	
});//ready
</script>
</head>
<body>
<jsp:include page="Header.jsp" />
<div id="board_layout">
<jsp:include page="boardMenu.jsp" />
<div id="board_main">
	 <div id="board_name">
			${boardName}
	</div>
	<!-- <div id="top_btnBox"><input type="button" id="writeBtn" value="글쓰기"></div> -->
	
	<div id="board_page">
		<c:if test="${fn:length(response.list) == 0 }">
			<div class="one_board">
				일치하는 검색 결과가 없습니다.
			</div>
		</c:if>
		
		<c:forEach items="${response.list}" var="dto" varStatus="status">
				<div class="one_searchBoard" id="${dto.board_id }">
					<div class="one_photo">
						<img class="one_photo" src="${dto.board_imgurl }">
					</div>
					<div class="one_reaction">
						<div class="reaction1">
							<img class="reaction1" src="/img/Love.svg">					
							<div class="reaction1" style="color : red;">${dto.good_cnt }</div>					
						</div>
						<div class="reaction2">
							<img class="reaction2" src="/img/Chat Bubble.svg">
							<div class="reaction2">${boardCommentCnt[dto.board_id] }</div>
						</div>
					</div>
					<div class="one_title">
						${dto.board_title }
					</div>
 					<div class="one_contents">
						${dto.board_preview}
					</div>
					<div class="one_photoInfo">
						<div class="one_photoWriter">작성자 : ${dto.writer }</div>
	 					<div class="one_writingTime">
								<!-- 오늘 날짜랑 같으면 시간만 출력, 날짜 다르면 년월일 출력 -->
								<jsp:useBean id="now" class="java.util.Date" />
								<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate" />
								<fmt:parseDate value="${dto.writing_time}" pattern="yyyy-MM-dd HH:mm:ss" var="reg" />
								<fmt:formatDate value="${reg}" pattern="yyyy-MM-dd" var="regDate" />
								<fmt:formatDate value="${reg}" pattern="HH:mm" var="regTime" />
								<c:choose>
								 	<c:when test="${nowDate == regDate}">
										${regTime}
								 	</c:when>
								 	<c:otherwise>
										${regDate}
								 	</c:otherwise>
								</c:choose> 										
						</div>
					</div>
				</div>
		</c:forEach>
	</div><!-- board_page end -->
	
  <!-- pagination -->
	<div id="board_pagingNum">
         <c:if test="${fn:length(response.list) != 0}">
            <div class="pagefirst"
               <c:if test="${!response.pagination.existPrevPage}"> style="visibility: hidden;" </c:if>>
               <input type="button" class="photoPageBtn" id="photoBoardPageBtnFirst" value="◁◁">
            </div>
            <div class="prev" id="${response.pagination.startPage-1}"
               <c:if test="${!response.pagination.existPrevPage}"> style="visibility: hidden;" </c:if>>
               <input type="button" class="photoPageBtn" id="photoBoardPageBtnPre" value="◁">
            </div>

            <c:forEach begin="${response.pagination.startPage}"
               end="${response.pagination.endPage}" varStatus="vs">
               <c:if test="${vs.index == searchdto.page}">
	               <input type="button" class="photoPageNumBtn" value="${vs.index}" style="font-weight: 900">
               </c:if>
               <c:if test="${vs.index != searchdto.page}">
	               <input type="button" class="photoPageNumBtn" value="${vs.index}" style="font-weight: 300; color: #555">
               </c:if>
            </c:forEach>

            <div class="next" id="${response.pagination.startPage+10}"
               <c:if test="${!response.pagination.existNextPage}"> style="visibility: hidden;" </c:if>>
               <input type="button" class="photoPageBtn" id="photoBoardPageBtnNext" value="▷">
            </div>
            <div class="pagelast" id="${response.pagination.totalPageCount}"
               <c:if test="${!response.pagination.existNextPage}"> style="visibility: hidden;" </c:if>>
               <input type="button" class="photoPageBtn" id="photoBoardPageBtnLast" value="▷▷">
            </div>
         </c:if>
      </div>
      <!-- pagination -->
	
	<!-- 검색창 -->
	<div id="photo_search_box">
	<form action="photoSearch" id="photoSearchForm" method="get">
		<div id="photo_search_inputs">
		 <select id="photoSelectBox" name="select">
			<option value="all"> 전체 </option>
			<option value="title"> 제목 </option>
			<option value="contents"> 내용 </option>
			<option value="writer"> 작성자 </option>
          </select>
		<input type=text id="photo_searchword" name="searchword" value="${searchdto.keyword }">
		<input type=hidden id="photo_search_ctgy" name="ctgy" value="${boardName}">
		<input type=hidden id="photo_search_ti" name="ti" value="${town_id}">
		<input type="submit" id="photo_search_btn" value="검색">
		</div>
	</form> 
	</div>
	<script>
    $("#photoSelectBox option").each(function(index, item) {
			if ($(item).val() == "${selected}") {
				$(item).prop("selected", true);
			}
		});
	</script>
</div>
</div>
</body>
</html>