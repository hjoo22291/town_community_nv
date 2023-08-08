<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/BoardCommon.css" />
<script>
$(document).ready(function(){	
	
	//메뉴 눌렀을때(사진게시판)
	let board = "/basicBoard"; // 글 or 사진 게시판
	let ctgy = "?ctgy=${boardName}"; // 게시판 카테고리
	let ti = "&ti=${ti}"; // 동네 아이디
	
	// 공지사항, HOT 게시판 카테고리 클릭시 이벤트
	$("li.outerMenu").on("click", function() {
		let outerctgy = $(this).html().split('<')[0].trim();
		if (outerctgy === "공지사항" || outerctgy === "HOT 게시판") {
			ctgy = "?ctgy=" + outerctgy;
		} else {
			return;
		}
		window.location.href = board + ctgy + ti;
	}); //onclick
	
	// 게시판 소분류 클릭시 동작
	$("li.innerMenu").on("click", function(e) {
		ctgy = "?ctgy=" + $(this).text().trim();
		if (ctgy === "?ctgy=오늘의 사진" || 
				ctgy === "?ctgy=역대 당선작" || 
				ctgy === "?ctgy=분실물센터") {
			board = "/photoBoard";
		} else {
			board = "/basicBoard";
		}
		window.location.href = board + ctgy + ti;
		e.stopPropagation();
	}); //onclick
	
	//글쓰기 버튼 클릭시 writingForm 페이지로 이동
	$("#writeBtn").on("click", function() {
		if ("${param.ti}" !== "${sessionScope.town_id}" && "${param.ti}" !== "") {
			alert("게시글 작성은 회원님의 동네 게시판에서만 가능합니다.");
		} else {
			window.location.href = "/writingForm?ctgy=${param.ctgy}&ti=${param.ti}";
		}
	}); //onclick
	
}); //ready
</script>
</head>
<body>
<div id="board_menu">
        <ul class="allMenu">
          <li class="outerMenu">공지사항</li>
          <li class="outerMenu">
            지금 우리 동네
            <ul class="innerMenu">
              <li class="innerMenu">나의 일상</li>
              <li class="innerMenu">사건, 사고 소식</li>
              <li class="innerMenu">분실물센터</li>
            </ul>
          </li>
          <li class="outerMenu">
            동네 사진전
            <ul class="innerMenu">
              <li class="innerMenu">오늘의 사진</li>
              <li class="innerMenu">역대 당선작</li>
            </ul>
          </li>
            <li class="outerMenu">
            만남의 광장
            <ul class="innerMenu">
              <li class="innerMenu">우리 지금 만나</li>
              <li class="innerMenu">같이해요 소모임</li>
            </ul>
          </li>
            <li class="outerMenu">
            알고 계신가요?
            <ul class="innerMenu">
              <li class="innerMenu">행사 소식</li>
              <li class="innerMenu">새로 오픈했어요</li>
              <li class="innerMenu">여기 추천!</li>
            </ul>
          </li>
        </ul>
    </div>
</body>
</html>