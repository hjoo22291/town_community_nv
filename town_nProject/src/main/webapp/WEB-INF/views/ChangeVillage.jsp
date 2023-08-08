<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="css/Main.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>towncommunity</title>
</head>
<body>
<jsp:include page="Header.jsp" />
	<div class="btn"> 
		<svg width="22" height="133" viewBox="0 0 22 133" fill="none" xmlns="http://www.w3.org/2000/svg">
		<rect x="-8" width="30" height="133" rx="10" fill="#F2F2F2"/>
		<path d="M7.88 73.736C7.88 73.64 7.88 73.5653 7.88 73.512C7.88 73.4587 7.88533 73.4107 7.896 73.368C7.91733 73.3253 7.944 73.2827 7.976 73.24C8.01867 73.1973 8.072 73.144 8.136 73.08C8.552 72.664 8.984 72.2267 9.432 71.768C9.89067 71.3093 10.3493 70.8507 10.808 70.392C11.2667 69.9227 11.72 69.4587 12.168 69C12.6267 68.5413 13.064 68.104 13.48 67.688C13.576 67.5813 13.624 67.512 13.624 67.48C13.624 67.4373 13.5653 67.3573 13.448 67.24L8.168 61.896C8.09333 61.8213 8.03467 61.7627 7.992 61.72C7.96 61.6773 7.93333 61.6347 7.912 61.592C7.90133 61.5493 7.89067 61.496 7.88 61.432C7.88 61.368 7.88 61.2827 7.88 61.176V60.552C7.88 60.3067 7.89067 60.1787 7.912 60.168C7.944 60.1573 8.04 60.2373 8.2 60.408L14.36 66.648C14.424 66.712 14.472 66.7653 14.504 66.808C14.5467 66.8507 14.5733 66.8933 14.584 66.936C14.6053 66.968 14.616 67.0107 14.616 67.064C14.6267 67.1173 14.632 67.1867 14.632 67.272V67.688C14.632 67.7733 14.6267 67.8427 14.616 67.896C14.616 67.9493 14.6053 67.9973 14.584 68.04C14.5733 68.072 14.5467 68.1093 14.504 68.152C14.472 68.1947 14.424 68.248 14.36 68.312L8.152 74.552C8.01333 74.6907 7.93333 74.7547 7.912 74.744C7.89067 74.7333 7.88 74.6267 7.88 74.424V73.736Z" fill="#8C8C8C"/>
		</svg>	
	</div>
	<div id="menu"> 
		<div id="board_menu">
			<ul class="outerMenu">
			  <li class="innerMenu notice">
			    공지사항
			  </li>			
			  <li>
			    지금 우리 동네
			    <ul class="innerMenu">
			      <li class="innerMenu">나의 일상</li>
			      <li class="innerMenu">사건, 사고 소식</li>
			    </ul>
			  </li>
			  <li>
			    동네 사진전
			    <ul class="innerMenu">
			      <li class="innerMenu">오늘의 사진</li>
			      <li class="innerMenu">역대 당선작</li>
			    </ul>
			  </li>
			    <li>
			    만남의 광장
			    <ul class="innerMenu">
			      <li class="innerMenu">같이 줄서요</li>
			      <li class="innerMenu">같이해요 소모임</li>
			    </ul>
			  </li>
			    <li>
			    도움이 필요해요
			    <ul class="innerMenu">
			      <li class="innerMenu">분실물센터</li>
			      <li class="innerMenu">심부름센터</li>
			    </ul>
			  </li>
			    <li>
			    알고 계신가요?
			    <ul class="innerMenu">
			      <li class="innerMenu">행사 소식</li>
			      <li class="innerMenu">새로 오픈했어요</li>
			    </ul>
			  </li>
			</ul>
		</div>
	</div>
	<div onclick="history.back();" class="page_cover"></div>
	<div style="display: flex; margin:20px 0; flex-direction: column; width:100%;">
		<div style="display: flex; justify-content: space-between; align-items: center;">
			<div>
				<c:if test="${town_id == ti}">
					<button class="button" style="padding:5px 10px;" onclick="document.location.href='/main'">
				   		<img style="height: 15px;" color="black"src="img/홈버튼.png">
				   		홈으로
				   	</button>
				 </c:if>
				<c:if test="${town_id != ti}">
					<button class="button" style="padding:5px 10px;" onclick="document.location.href='/main?ti=${ti}'">
				   		<img style="height: 15px;" color="black"src="img/홈버튼.png">
				   		홈으로
				   	</button>
				   	<button class="button" style="margin: 10px 10px 0 0; padding: 5px 10px;" onclick='document.location.href="/main"'>우리 동네로 이동하기</button>	
				 </c:if>			
			</div>	 
		   	<div>
				<input class="textinput" type="text" placeholder="동네를 입력하세요" name="town_name" id="town_name">
				<button class="button" id="ajaxbtn" style="margin-top: 10px; padding: 5px 10px;">동네 검색하기</button>	
			</div>
		</div>
		<div id="result" style="margin-top: 15px;">	
		</div>
	</div>
<script>
$(".btn").click(function () {
    $("#menu,.page_cover,html").addClass("open"); // 메뉴 버튼을 눌렀을때 메뉴, 커버, html에 open 클래스를 추가해서 효과를 준다.
    window.location.hash = "#open"; // 페이지가 이동한것 처럼 URL 뒤에 #를 추가해 준다.
});

window.onhashchange = function () {
    if (location.hash != "#open") { // URL에 #가 있을 경우 아래 명령을 실행한다.
        $("#menu,.page_cover,html").removeClass("open"); // open 클래스를 지워 원래대로 돌린다.
    }
};
$("#ajaxbtn").on('click',function(){
	$("#result").empty();
	$.ajax({
		url:'ajaxResult',
		data:{'town_name':$("#town_name").val()},
		type:'get',
		dataType:'json',
		success:function(response){
			for(let i =0; i<response.length;i++){
				if(response[i].town_id == ${town_id}){
					$("#result").append("<button class='button' style='margin: 10px 10px 0 0; padding: 5px 10px; font-size: 20px;' onclick='document.location.href=\"/main\"'>"+response[i].address+"</button>");
				}else{
					$("#result").append("<button class='button' style='margin: 10px 10px 0 0; padding: 5px 10px; font-size: 20px;' onclick='document.location.href=\"/main?ti="+response[i].town_id+"\"'>"+response[i].address+"</button>");
				}
			}
		},
		error:function(){}
	});//ajax
});
$(document).ready(function() {
	// 전역 변수
    let board = "/basicBoard"; // 글 or 사진 게시판
    let ctgy = "?ctgy=${boardName}"; // 게시판 카테고리
    let ti = "&ti=${ti}"; // 동네 아이디

	// 게시판 소분류 클릭시
	$("li.innerMenu").on("click", function(e) {
        ctgy = "?ctgy=" + $(this).text().trim();
        if (ctgy === "?ctgy=오늘의 사진"||  
                ctgy === "?ctgy=역대 당선작"||  
                ctgy === "?ctgy=분실물센터") {
            board = "/photoBoard";
        } else {
            board = "/basicBoard";
        }
        window.location.href = board + ctgy + ti;
        e.stopPropagation();
	}); //onclick
});

</script>	
</body>
</html>