<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="css/Main.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>towncommunity</title>
<script src="js/jquery-3.6.4.min.js" ></script>
<style type="text/css">
#mapInfoBox {
	background-color : #E8E7E5;
	width : 274px;
	height : 274px;
	/* margin : 0 auto; */
	padding : 5px;
	
}
#staticMap {
	width:274px; height:224px;
	margin-bottom:5px;
}
#placeName {
	width:300px; height:20px;
	font-weight : bold;
	margin-bottom:2px;
}
#placeAddress {
	width:300px; height:20px;
	font-size : 13px;
	color : gray;
	margin-bottom:2px;
}
</style>
</head>
<body>
	<jsp:include page="Header.jsp" />
	<div class="btn" id="menuBtn"> 
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
	<div style="width:100%; display: flex; justify-content: flex-end; padding:10px 0;">
	<button class="button" onclick="document.location.href='/changeVillage?ti=${ti}'" style="margin-top: 10px; padding: 5px 10px;">동네 변경하기</button>	
	</div>
	<div class="wrapper">
		<div class="firstBox">
			<div class="title">
				<c:if test="${town.town_name == '압구정동'}">
					<p class="vitro" style="font-size: 37px;">지금 ${town.town_name }은</p>
				</c:if>
				<c:if test="${town.town_name != '압구정동'}">
					<p class="vitro">지금 ${town.town_name }은</p>
				</c:if>
				<p>실시간 인기 게시글</p>
			</div>
			<c:if test="${popular.isEmpty()}">
				<div class="contentBox">
					아직 작성된 글이 없습니다.	
				</div>			
			</c:if>
			<c:forEach items="${popular }" var="popular">
			<div class="contentBox">
				<p class="contentTitle">${popular.board_title }</p>
				<div style="position: relative; width:274px; height:250px; overflow: hidden; background: white;">
					<img style="position: absolute; top:50%; left:50%; transform:translate(-50%,-50%);" src="${popular.board_imgurl }" width=274 />
				</div>
				<div class="content">
				${popular.board_contents }
				</div>
				<button type="submit"  id="${popular.board_id}" class="button one_board">게시물 전체보기</button>
			</div>
			</c:forEach>
		</div>
		<div class="secondBox">
			<div class="photoFrame" style="height:482px; position: relative; width:864px; overflow: hidden; background: white;">
				<c:if test="${photo.board_imgurl != null}">
					<img src="${photo.board_imgurl }" style="position: absolute; top:50%; left:50%; transform:translate(-50%,-50%);" height=481/>
				</c:if>
				<c:if test="${photo.board_imgurl == null}">
					<img src="img/displayimg.png" height=481/>
				</c:if>				
			</div>
			<div class="photoInformBox">
				<p class="vitro">"오늘, 우리동네" 사진전 당선작</p>
				<div class="contentBox" style="height:292px">
					<div class="content">
						<p class="contentTitle">${photo.board_title }</p>
						<p class="id">${photo.writer }</p>
						<div class="detail">
						${photo.board_contents }
						<c:if test="${photo == null}">
							아직 작성된 글이 없습니다.
						</c:if>							
						</div>
						<c:if test="${photo != null}">
							<button type="submit" id="${photo.board_id}" class="button one_board">게시물 전체보기</button>
						</c:if>	
						<c:if test="${photo == null && town_id == ti}">
							<button type="submit" onclick="document.location.href='/writingForm?ti=${ti}&ctgy=오늘의%20사진'" class="button">글 작성하기</button>
						</c:if>											
					</div>
					<div class="commentBox">
						<c:if test="${photo == null || photoComment.isEmpty()}">
							<div class="comment">
								등록된 댓글이 없습니다.
							</div>							
						</c:if>						
						<c:forEach items="${photoComment }" var="comment">
							<div class="comment">
								<div class="id" >${comment.comment_writer }</div>
								<div class="nowrap overflow ellipsis detail"> 
								${comment.comment_contents }
								</div>
							</div>
						</c:forEach>											
					</div>
				</div>
			</div>
			<div class="contentBox">
				<div class="townNews">
					<p class="newsTitle">
					#동네소식
					</p>
					<svg width="409" height="318" viewBox="0 0 409 318" fill="none" xmlns="http://www.w3.org/2000/svg">
						<rect x="0.5" y="0.5" width="408" height="317" stroke="#223A5C"/>
						<rect x="6.5" y="5.5" width="396" height="307" stroke="#223A5C"/>
						<rect width="409" height="72" fill="#182434"/>
						<ellipse cx="10.7552" cy="71.4431" rx="10.7552" ry="10.5064" fill="#182434"/>
						<ellipse cx="32.2657" cy="73.3534" rx="10.7552" ry="12.4166" fill="#182434"/>
						<ellipse cx="53.7757" cy="71.4431" rx="10.7552" ry="10.5064" fill="#182434"/>
						<ellipse cx="75.2869" cy="73.3534" rx="10.7552" ry="12.4166" fill="#182434"/>
						<ellipse cx="96.7967" cy="71.4431" rx="10.7552" ry="10.5064" fill="#182434"/>
						<ellipse cx="118.307" cy="73.3534" rx="10.7552" ry="12.4166" fill="#182434"/>
						<ellipse cx="139.817" cy="71.4431" rx="10.7552" ry="10.5064" fill="#182434"/>
						<ellipse cx="161.328" cy="73.3534" rx="10.7552" ry="12.4166" fill="#182434"/>
						<ellipse cx="182.838" cy="71.4431" rx="10.7552" ry="10.5064" fill="#182434"/>
						<ellipse cx="204.349" cy="73.3534" rx="10.7552" ry="12.4166" fill="#182434"/>
						<ellipse cx="225.859" cy="71.4431" rx="10.7552" ry="10.5064" fill="#182434"/>
						<ellipse cx="247.369" cy="73.3534" rx="10.7552" ry="12.4166" fill="#182434"/>
						<ellipse cx="268.88" cy="71.4431" rx="10.7552" ry="10.5064" fill="#182434"/>
						<ellipse cx="290.39" cy="73.3534" rx="10.7552" ry="12.4166" fill="#182434"/>
						<ellipse cx="311.901" cy="71.4431" rx="10.7552" ry="10.5064" fill="#182434"/>
						<ellipse cx="333.411" cy="73.3534" rx="10.7552" ry="12.4166" fill="#182434"/>
						<ellipse cx="354.922" cy="71.4431" rx="10.7552" ry="10.5064" fill="#182434"/>
						<ellipse cx="376.432" cy="73.3534" rx="10.7552" ry="12.4166" fill="#182434"/>
						<ellipse cx="397.942" cy="71.4431" rx="10.7552" ry="10.5064" fill="#182434"/>
					</svg>
					<div class="newsBox">
						<c:if test="${news.isEmpty()}">
								아직 작성된 글이 없습니다.			
						</c:if>					
						<c:forEach items="${news }" var="news">
							<div class="news one_board" id="${news.board_id}">
								<svg style="margin-left:10px;" width="13" height="14" viewBox="0 0 13 14" fill="none" xmlns="http://www.w3.org/2000/svg">
									<path d="M12.8762 7L0.59201 13.9282L0.59201 0.0717969L12.8762 7Z" fill="#182434"/>
								</svg>
								<div class="nowrap overflow ellipsis content">
								${news.board_title }
								</div>
								<svg style="margin-right:10px;" width="13" height="14" viewBox="0 0 13 14" fill="none" xmlns="http://www.w3.org/2000/svg">
									<path d="M0.123657 7L12.4079 0.0717964L12.4079 13.9282L0.123657 7Z" fill="#182434"/>
								</svg>
							</div>
						</c:forEach>																								
					</div>
				</div>
				<div class="placeofmeeting">
					<div class="nowrap overflow ellipsis title">
						만남의 광장
					</div>
						<c:if test="${placeOfMeeting.isEmpty()}">
							<div class="nowrap overflow ellipsis content">						
								아직 작성된 글이 없습니다.		
							</div>		
						</c:if>	
					<c:forEach items="${placeOfMeeting }" var="place">
						<div class="nowrap overflow ellipsis content one_board" id="${place.board_id}">
							${place.board_title }
						</div>
					</c:forEach>																	 
				</div>
			</div>
		</div>
		<div class="thirdBox">
			<div class="weatherBox">
				<p class="vitro title">오늘의 날씨</p>
				<p class="town">${town.getTown_name() }</p>
				<div class="weather">
					<div class="wt_icon">
						<i class="${iconVal}"></i>
					</div>	
					<p class="temperatue">${nowTempVal}</p>		
				</div>	
				<div class="compareTemp">
					<p>어제보다</p>	
					<p>${compDe}</p>	
					<p>${comp}</p>/
					<p>${weatherVal}</p>		
				</div>	
				<div class="etc">
					<p>체감</p>	
					<p>${bodyTempVal}</p>	
					<p>습도</p>	
					<p>${humidityVal}</p>	
					<p>${winddirecVal}</p>	
					<p>${windVal}</p>												
				</div>					
			</div>	
			<div class="titleBox">
				<p class="vitro title">Did you</p>
				<p class="vitro title">Know?</p>
			</div>
			<div class="knowBox">
				<p class="title">${youKnow.board_title }</p>
				<div class="content">
				<c:if test="${youKnow == null}">
					아직 작성된 글이 없습니다.			
				</c:if>					
				${youKnow.board_contents }
				</div>
				<c:if test="${youKnow != null}">
					<button type="submit" class="button class one_board" id="${youKnow.board_id}" style="">게시물 전체보기</button>
				</c:if>
				<c:if test="${youKnow.board_imgurl != null}">
					<p class="subtitle">카페 전경</p>
					<div style="position: relative; width:274px; height:274px; overflow: hidden; background: white">
						<img style="position: absolute; top:50%; left:50%; transform:translate(-50%,-50%); background: white;" src="${youKnow.board_imgurl }" width=274 />
					</div>
				</c:if>
				<c:if test="${youKnow.place_lat != null && youKnow.place_long != null}">
					<p class="subtitle">카페 위치</p>
					<div id="mapInfoBox">
					<div id="staticMap"></div>
					<div id="placeName">${youKnow.place_name}</div>
					<div id="placeAddress">${youKnow.place_road_address}</div>
				</div>
				<input type="hidden" id="placeLat" value="${youKnow.place_lat}">
				<input type="hidden" id="placeLong" value="${youKnow.place_long}">
				</c:if>
			</div>	
		</div>
	</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4f7e1f2c70926d22aa160d0a0685b14c&libraries=services"></script>
<script>
$("#menuBtn").click(function () {
    $("#menu,.page_cover,html").addClass("open"); // 메뉴 버튼을 눌렀을때 메뉴, 커버, html에 open 클래스를 추가해서 효과를 준다.
    window.location.hash = "#open"; // 페이지가 이동한것 처럼 URL 뒤에 #를 추가해 준다.
});

window.onhashchange = function () {
    if (location.hash != "#open") { // URL에 #가 있을 경우 아래 명령을 실행한다.
        $("#menu,.page_cover,html").removeClass("open"); // open 클래스를 지워 원래대로 돌린다.
    }
};
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

$(".one_board").on('click', function(){
    const boardId = $(this).attr('id');
    $.ajax({
        url : 'updateViewcnt',
        type : 'post',
        data : {'bi' : boardId},
        success : function(response){
            if(response > 0) {
                location.href = "/boarddetail?bi="+boardId;
            }
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

//위도, 경도값
let placeLat = $("#placeLat").val();
let placeLong = $("#placeLong").val();

// 이미지 지도에서 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(placeLat, placeLong); 

// 이미지 지도에 표시할 마커입니다
// 이미지 지도에 표시할 마커는 Object 형태입니다
var marker = {
    position: markerPosition
};

var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
    staticMapOption = { 
        center: new kakao.maps.LatLng(placeLat, placeLong), // 이미지 지도의 중심좌표
        level: 3, // 이미지 지도의 확대 레벨
        marker: marker // 이미지 지도에 표시할 마커 
    };    

// 이미지 지도를 생성합니다
var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
</script>
</body>
</html>