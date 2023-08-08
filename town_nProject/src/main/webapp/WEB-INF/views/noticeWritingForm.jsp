<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성 폼</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<script src="//cdn.quilljs.com/1.3.6/quill.js"></script>
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
</head>
<body>
<jsp:include page="Header.jsp" />
<div id="myPage_layout">
	<jsp:include page="adminMenu.jsp" />
	<link rel="stylesheet" type="text/css" href="/css/noticeWritingForm.css"/>
	<div id="board_main">
		<div style="margin-bottom: 20px;">
			<span style="font-size: 37px; font-weight: bold;">공지사항 작성</span>
		</div>
		<div style="display: flex; flex-direction: row; justify-content: center; width: 100%;">
			<select id="board-name" multiple>
				<option value="0">전체 동네</option>
				<c:forEach items="${townNameList}" var="townName" varStatus="vs">
					<option value="${vs.count}">${townName}</option>
				</c:forEach>
			</select>
			<div id="notice_wrap">
				<div id="board_name">
					<input id="write-title" type="text" placeholder="공지사항 제목"/>
				</div>
				<div id="board_page">			
					
					<div id="editor"></div>
					<input type="hidden" id="quill_html" name="content">
					
					<div id="content-footer">
						<div id="place-and-write">
							<button id="write-btn">작성완료</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
<script src="/js/writingFormQuill.js"></script>
<script>
//작성완료 버튼 클릭 이벤트
$("#write-btn").on("click", function() {
	let board_name_inner = "공지사항";
	let board_title = $("#write-title").val(); // 게시글 제목
	let board_contents = $("#quill_html").val(); // 게시글 내용
	let board_imgurl; // 업로드한 이미지가 저장된 경로
	let board_fileurl; // 업로드한 파일이 저장된 경로
	let board_preview = $(".ql-editor").text(); // 게시글 미리보기 텍스트
	let writer = "${sessionScope.member_id}"; // 관리자 아이디
	let town_id = "${sessionScope.town_id}"; // 관리자 동네 아이디
	let town_ids = $("#board-name").val(); // ['0', '1', '2'] 이런식으로 문자열 배열로 저장됨
	if (town_ids.includes("0")) { // 전체 동네를 선택한 경우 town_ids 배열에 모든 동네 아이디 추가
		town_ids = [];
		let option = document.querySelectorAll("#board-name option");
		for (let i = 1; i < option.length; i++) {
			town_ids.push(option[i].value);
		}
	}
	
	// 이미지 폭 500px로 고정
	let imgSize = ' style="width: 500px; height: auto;"';
	let imgStr = '<img src="/display?fileName='
	let imgIdx = board_contents.indexOf(imgStr);
	while (true) {
		if(imgIdx === -1) break;
		board_contents = board_contents.slice(0, imgIdx + 4) + imgSize + board_contents.slice(imgIdx + 4);
		imgIdx = board_contents.indexOf(imgStr, imgIdx + 1);
	}
	
	// 만약 이미지가 하나 이상이면 첫번째 이미지 src 속성 board_imgurl에 저장 
	if ($(".ql-editor img").length > 0) {
		board_imgurl = $($(".ql-editor img")[0]).attr("src");
	}	
	
	// 이미지를 10장 이상 추가하면 alert 띄우기
	let imgTagIdx = $(".ql-editor img").length; // img 태그의 개수
	if (imgTagIdx > 10) {
		alert("사진은 최대 10개까지 업로드 가능합니다. 사진 개수를 조정해주세요.");
		return;
	}
	
	// .ql-editor img 태그 부모 p 태그에 style 속성이 없으면 #quill_html img에 style="width: 50%; height: auto; display: block;" 추가
	let imgStrIdx = 0;
	while(true) {
		imgStrIdx = board_contents.indexOf("<p><img ", imgStrIdx);
		if (imgStrIdx === -1) break;
		board_contents = board_contents.slice(0, imgStrIdx + 2) + ' style="width: 50%; height: auto; display: block;"' + board_contents.slice(imgStrIdx + 2);
		imgStrIdx++;
	} //while
	
	$.ajax({
		url: "/noticeWritingForm",
		data: {
			"board_name_inner": board_name_inner,
			"board_title": board_title,
			"board_contents": board_contents,
			"board_imgurl": board_imgurl,
			"board_fileurl": board_fileurl,
			"board_preview": board_preview,
			"writer": writer,
			"town_id": town_id,
			"town_ids": town_ids,
		},
		dataType: "json",
		method: "post",
		success: function(response) {
			if (response.insertResult === -1) {
				alert("공지사항 제목을 입력해주세요.");
			} else if (response.insertResult === -2) {
				alert("공지사항을 올릴 동네를 선택해주세요.");
			} else if (response.insertResult === 2) {
				alert("공지사항 작성이 완료되었습니다.");
				location.href = "/noticeBoardList";
			} else {
				alert("알 수 없는 오류 발생");
			}
		},
		error: function(request,status,error) {
    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    }
	}); //ajax
}) //onclick
</script>
</html>