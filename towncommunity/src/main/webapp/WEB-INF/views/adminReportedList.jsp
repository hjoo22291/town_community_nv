<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

//----------------------------------------- page 버튼 ----------------------------------------------------------------
 	//페이지 버튼 눌렀을때 해당페이지 보여주기
 	$(".photoPageNumBtn").on('click', function(){
		const queryparamsPage = {
		   page: $(this).val(),
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});//pageNumBtn클릭
	
	//첫페이지
 	$("#photoBoardPageBtnFirst").on('click', function(){
		const queryparamsPage = {
		   page: 1,
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
 	//이전페이지
 	$("#photoBoardPageBtnPre").on('click', function(){
		const queryparamsPage = {
		   page: "${response.pagination.startPage-1}",
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
	//다음페이지
 	$("#photoBoardPageBtnNext").on('click', function(){
		const queryparamsPage = {
		   page: "${response.pagination.endPage+1}",
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
	
 	//마지막페이지
 	$("#photoBoardPageBtnLast").on('click', function(){
		const queryparamsPage = {
		   page: "${response.pagination.totalPageCount}",
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});//pageNumBtn클릭
//----------------------------------------- page 버튼 -----------------------------------------------------------------
	
}); //ready
</script>
</head>
<body>
<jsp:include page="Header.jsp" />
<div id="myPage_layout">
	<div id="myPage_menu">
		<ul class="allMenu">
	      <li class="outerMenu">관리자 페이지</li>
			  <li class="outerMenu">
			    회원관리
			    <ul class="innerMenu">
			      	<li class="innerMenu">회원 조회
<!-- 			    	  <form id="admin_member" action="" method="post">			    	  	
			 			<input type="submit" value="회원 조회" id="admin_memberList_btn" class="admin_group">
					 </form> -->
			      </li>
			    </ul>
			  </li>
			  <li class="outerMenu">
			    신고관리
			    <ul class="innerMenu">
			      <li class="innerMenu">
			    	  <form id="admin_board" action="reportedList" method="post">			    	  	
			 			<input type="hidden" value="board_id" name="whatId">
			 			<input type="submit" value="신고된 글" id="admin_boardList_btn" class="admin_group">
					 </form>
			      </li>
			      <li class="innerMenu">
			    	  <form id="admin_comment" action="reportedList" method="post">			    	  	
			 			<input type="hidden" value="comment_id" name="whatId">
			 			<input type="submit" value="신고된 댓글" id="admin_commentList_btn" class="admin_group">
					 </form>
				  </li>
			      <li class="innerMenu">
			    	  <form id="admin_chat" action="reportedList" method="post">			    	  	
			 			<input type="hidden" value="message_id" name="whatId">
			 			<input type="submit" value="신고된 채팅(개인)" id="admin_chatList_btn" class="admin_group">
					 </form>
				  </li>
			      <li class="innerMenu">
			    	  <form id="admin_groupChat" action="reportedList" method="post">			    	  	
			 			<input type="hidden" value="gmessage_id" name="whatId">
			 			<input type="submit" value="신고된 채팅(그룹)" id="admin_groupChatList_btn" class="admin_group">
					 </form>
				  </li>
			    </ul>
			  </li>		    
		</ul>
	</div>
	
	<div id="myPage_main">
		<div id="myPage_name">
			${adminMenu}
		</div>
				<div id="board_page">
			<table id="board-table">
				<thead>
					<tr>
						<th style="width: 4%;">번호</th>
						<th style="width: 8%;">작성자</th>
						<th style="width: 16%;">제목/내용</th>
						<th style="width: 7%;">신고자</th>
						<th style="width: 8%;">신고사유</th>
						<th style="width: 14%;">신고상세사유</th>
						<th style="width: 10%;">신고날짜</th>
						<th style="width: 17%;">신고처리</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${response.list }" var="dto">
					<tr>
						<td>${dto.report_id}</td><td>${dto.reported_member_id}</td>
						
						 	<c:choose>
							 	<c:when test="${whatId == 'board_id'}">
									<td><a href="/boarddetail?bi=${dto.board_id}" target='_blank' class="writing-title">${dto.reported_contents }</a></td>
							 	</c:when>
							 	<c:when test="${whatId == 'comment_id'}">
									<td>${dto.reported_contents }</td>
							 	</c:when>
							 	<c:when test="${whatId == 'message_id'}">
									<td>${dto.reported_contents }</td>
							 	</c:when>
							 	<c:otherwise>
									<td>${dto.reported_contents }</td>
							 	</c:otherwise>
							</c:choose> 
						
						<td>${dto.reporter }</td>
						<td>${dto.report_reason }</td><td>${dto.report_detail }</td>
						<td>
							<jsp:useBean id="now" class="java.util.Date" />
							<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate" />
							<fmt:parseDate value="${dto.report_time }" pattern="yyyy-MM-dd HH:mm:ss" var="reg" />
							<fmt:formatDate value="${reg}" pattern="yyyy-MM-dd" var="regDate" />
							${regDate}
						</td>
						 <td>
						 	<c:choose>
							 	<c:when test="${whatId == 'board_id'}">
									 <button class="deleteBoard" id="${dto.board_id}">글삭제</button>
							 	</c:when>
							 	<c:when test="${whatId == 'comment_id'}">
									 <button class="deleteComment" id="${dto.comment_id}">댓글삭제</button>
							 	</c:when>
							 	<c:when test="${whatId == 'message_id'}">
									 <button class="deleteChat" id="${dto.message_id}">채팅삭제</button>
							 	</c:when>
							 	<c:otherwise>
									 <button class="deleteGroupChat" id="${dto.gmessage_id}">채팅삭제</button>
							 	</c:otherwise>
							</c:choose> 
							 <button class="deleteMember" id="${dto.reported_member_id}_delete">회원삭제</button>
							 <button class="stopMember" id="${dto.reported_member_id}_stop">회원정지</button>
						 </td>
					</tr>
				</c:forEach>   
				</tbody>
			</table>
		</div>
		
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
	</div>
</div>
</body>
</html>