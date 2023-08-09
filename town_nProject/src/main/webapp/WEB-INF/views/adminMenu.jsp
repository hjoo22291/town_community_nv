<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/BoardCommon.css" />
<style>
a {
	color: black;
	text-decoration: none;
}
.admin_group {
	font-size : 21px;
	border : none;
	background-color : transparent;	
	cursor: pointer;
}
</style>
<script>
$(document).ready(function(){	

}); //ready
</script>
</head>
<body>
	<div id="myPage_menu">
		<ul class="allMenu">
	      <li class="outerMenu"><a href="/adminManager">관리자 페이지</a></li>	      
			  <li class="outerMenu">
				<a href="/noticeBoardList">공지사항</a>
			  </li>
			  <li class="outerMenu">
			    회원관리
			    <ul class="innerMenu">
			      	<li class="innerMenu">
 			    	  <form id="admin_member" action="adminMemberList" method="get">			    	  	
			 			<input type="submit" value="회원 조회" id="manager_btn" class="admin_group">
					 </form>
			      </li>
			    </ul>
			  </li>
			  <li class="outerMenu">
			    신고관리
			    <ul class="innerMenu">
			      <li class="innerMenu">
			    	  <form id="admin_board" action="reportedBoardList" method="post">
			    	  	<input type="hidden" name="search" value="notYet" />			    	  	
			 			<input type="submit" value="신고된 글" id="admin_boardList_btn" class="admin_group">
					 </form>
			      </li>
			      <li class="innerMenu">
			    	  <form id="admin_comment" action="reportedCommentList" method="post">			    	  	
			    	  	<input type="hidden" name="search" value="notYet" />			    	  	
			 			<input type="submit" value="신고된 댓글" id="admin_commentList_btn" class="admin_group">
					 </form>
				  </li>
			      <li class="innerMenu">
			    	  <form id="admin_chat" action="reportedChatList" method="post">			    	  	
			    	  	<input type="hidden" name="search" value="notYet" />			    	  	
			 			<input type="submit" value="신고된 채팅(개인)" id="admin_chatList_btn" class="admin_group">
					 </form>
				  </li>
			      <li class="innerMenu">
			    	  <form id="admin_groupChat" action="reportedGChatList" method="post"> <!-- action값 주기 -->  	  	
			    	  	<input type="hidden" name="search" value="notYet" />			    	  	
			 			<input type="submit" value="신고된 채팅(그룹)" id="admin_groupChatList_btn" class="admin_group">
					 </form>
				  </li>
			    </ul>
			  </li>		    
		</ul>
	</div>
</body>
</html>