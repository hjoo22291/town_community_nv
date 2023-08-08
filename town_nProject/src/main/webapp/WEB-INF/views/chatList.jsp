<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
  <title>채팅방 목록창</title>
  <script src="/js/jquery-3.6.4.min.js"></script>
  <style>
    /* 전체 목록창 스타일 */
    
    @font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
* {
	font-family : 'GmarketSansMedium';
	box-sizing: border-box;
	}
    
        html, body {
      margin: 0;
      display: flex;
      justify-content: center;
    }
    
    .chat-container {
      width: 600px;
      height: 700px;
      border: 1px solid #ccc;
      overflow: hidden;
    }
    
    /* 헤더 스타일 */
    .header {
      background-color: #182434;
      color : white;
      padding: 10px;
      font-weight: bold;
      display: flex;
      justify-content: space-between;
    }
    
    /* 전체 목록창 내부 스타일 */
    .chat-list {
      height: 300px;
      overflow-y: scroll;
      padding: 10px;
      scrollbar-width: none; /* Firefox 용 */
	-ms-overflow-style: none; /* IE, Edge 용 */
    }
    
    .chat-list::-webkit-scrollbar {
	width: 0;
	height: 0;
	}
    
    /* 채팅방 아이템 스타일 */
    .chat-item {
      display: flex;
      align-items: center;
      padding: 10px;
      margin-bottom: 10px;
      border-radius: 5px;
      background-color: #dcd9d8;
      cursor: pointer;
    }
    
    /* 채팅방 아이템 썸네일 이미지 스타일 */
    .chat-item .thumbnail {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      object-fit: cover;
      margin-right: 10px;
    }
    
    /* 채팅방 아이템 정보 스타일 */
    .chat-item .info {
      flex: 1;
    }
    
    /* 채팅방 아이템 정보 제목 스타일 */
    .chat-item .info .title {
      font-weight: bold;
      font-size: 16px;
      line-height: 1.4;
    }
    
    /* 채팅방 아이템 정보 메시지 스타일 */
    .chat-item .info .message {
      font-size: 14px;
      line-height: 1.4;
      color: #666;
    }
    
    .chat-item .totalisread {
		display : flex;
		width: 25px;
		height: 25px;
		border-radius: 50%;
		background-color : red;
		color : white;
		justify-content : center;
  		align-items : center;
		margin-right : 10px;
    }

    /* 채팅방 아이템 스타일 */
    .chat-item2 {
      display: flex;
      align-items: center;
      padding: 10px;
      margin-bottom: 10px;
      border-radius: 5px;
      background-color: #dcd9d8;
      cursor: pointer;
    }
    
    /* 채팅방 아이템 썸네일 이미지 스타일 */
    .chat-item2 .thumbnail {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      object-fit: cover;
      margin-right: 10px;
    }
    
    /* 채팅방 아이템 정보 스타일 */
    .chat-item2 .info {
      flex: 1;
    }
    
    /* 채팅방 아이템 정보 제목 스타일 */
    .chat-item2 .info .title {
      font-weight: bold;
      font-size: 16px;
      line-height: 1.4;
    }
    
    /* 채팅방 아이템 정보 메시지 스타일 */
    .chat-item2 .info .message {
      font-size: 14px;
      line-height: 1.4;
      color: #666;
    }
    
    .chat-item2 .totalisread {
		display : flex;
		width: 25px;
		height: 25px;
		border-radius: 50%;
		background-color : red;
		color : white;
		justify-content : center;
  		align-items : center;
		margin-right : 10px;
    }
  </style>
<script>
  $(document).ready(function() {
    var chatList = $('.chat-list');
    
    chatList.mouseover(function() {
      chatList.css('overflow-y', 'hidden');
    });

    chatList.mouseout(function() {
      chatList.css('overflow-y', 'scroll');
    });
    
    $(".chat-item").on("click", function() {
    	var toId = $(this).data("to-id");
    	var memberId = $(this).data("member-id");
    	var loginId = '<%= (String)session.getAttribute("member_id") %>';
    	if (toId == loginId) {
    		window.location.href = '/chatstart?touser_id=' + encodeURIComponent(memberId);
    	}
    	else {
        	window.location.href = '/chatstart?touser_id=' + encodeURIComponent(toId);
    	}
    });
    
    $(".chat-item2").on("click", function() {
    	var boardId = $(this).data("board-id");
		window.location.href = '/entergchat?board_id=' + encodeURIComponent(boardId);		    	
    });
  });
</script>
</head>
<body>
  <div class="chat-container">
    <div class="header">
    	<div>1:1 채팅</div>
    	<button type="button" onclick="location.href='/main'">메인으로 돌아가기</button>
    </div>
    <div class="chat-list">
	  <c:forEach items="${list}" var="list">
	  	<div class="chat-item" data-to-id="${list.to_id}" data-member-id="${list.member_id}">
	  		<img class="thumbnail" src="img/기본프로필사진.png">
	  		<div class="info">
	  			<div class="title">${list.to_id}</div>
	  			<div class="message">${list.latest_content}</div>
	  		</div>
	  		<c:if test="${list.totalisread != 0}">
	  			<div class="totalisread">${list.totalisread}</div>
	  		</c:if>
	  	</div>
	  </c:forEach>
    </div>
    <div class="header">그룹 채팅</div>
    <div class="chat-list">
 	  <c:forEach items="${list2}" var="list2">
	  	<div class="chat-item2" data-board-id="${list2.board_id}">
	  		<img class="thumbnail" src="img/기본프로필사진.png">
	  		<div class="info">
	  			<div class="title">${list2.chatroom_name}</div>
	  			<div class="message">${list2.board_id}</div>
	  		</div>
	  	</div>
	  </c:forEach>   
    </div>
  </div>
</body>
</html>