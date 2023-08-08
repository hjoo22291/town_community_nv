<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네일보 게시판</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/BoardCommon.css" />
<link rel="stylesheet" href="/css/BoardDetail.css" />
<style>
#oneboard_photo {
	width : 100%;
	margin : 10px;
}
#mapInfoBox {
	background-color : #E8E7E5;
	width : 300px;
	height : 300px;
	/* margin : 0 auto; */
	margin-top : 30px;
	padding : 5px;
	
}
#staticMap {
	width:300px; height:250px;
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
.groupChatBtn, #board_btns_open {
	height : 30px;
	font-size : 13px;
	border : none;
	background-color : transparent;	
	cursor: pointer;
}
.groupChatBtn:hover, #board_btns_open:hover {
	background-color : #6D829B;
	color : white;			
} 
</style>
<script>
$(document).ready(function(){
	
	//목록 버튼
	$("#backToList").on('click', function(){
		location.href = document.referrer; //이전페이지로 이동 + 새로고침
	});//목록 버튼
	
	//id 누르면 채팅하기 버튼 (보드 작성자 ver)
	//글 작성자 ver
 	$("#oneboard_writer").on('click', function(){
 		let yourInfoBoxStatus = $(this).next(".yourInfo_btnBox").css('display');
 		let myInfoBoxStatus = $(this).nextAll(".myInfo_btnBox").css('display');
 		let clickedId = $(this).text();
		//alert(clickedId);
		if(clickedId != "${member_id}") {	
			if(yourInfoBoxStatus == 'none')  {
				$(this).next(".yourInfo_btnBox").fadeIn(200);				
			}
			else {
				$(this).next(".yourInfo_btnBox").fadeOut(200);							
			}
		}	
	 	else {
			if(myInfoBoxStatus == 'none')  {
				$(this).nextAll(".myInfo_btnBox").fadeIn(200);				
			}
			else {
				$(this).nextAll(".myInfo_btnBox").fadeOut(200);				
			}
	 	}
	});	
	
	//아무데나 클릭시 show상태인 div 다시 hide로 - 글 수정,삭제,신고버튼
	$(function(){
		$(document).mousedown(function( e ){
			if( $(".yourInfo_btnBox").is(":visible") ) {
				$(".yourInfo_btnBox").each(function(){
					var l_position = $(this).offset();
					l_position.right = parseInt(l_position.left) + ($(this).width());
					l_position.bottom = parseInt(l_position.top) + parseInt($(this).height());

					if( ( l_position.left <= e.pageX && e.pageX <= l_position.right )
						&& ( l_position.top <= e.pageY && e.pageY <= l_position.bottom ) ) {
					} else {
						$(this).hide();
					}
				});
			}//if(outer)				
		});//mousedown
	});//이외영역 클릭 function
	
	//아무데나 클릭시 show상태인 div 다시 hide로 
	$(function(){
		$(document).mousedown(function( e ){
			if( $(".myInfo_btnBox").is(":visible") ) {
				$(".myInfo_btnBox").each(function(){
					var l_position = $(this).offset();
					l_position.right = parseInt(l_position.left) + ($(this).width());
					l_position.bottom = parseInt(l_position.top) + parseInt($(this).height());

					if( ( l_position.left <= e.pageX && e.pageX <= l_position.right )
						&& ( l_position.top <= e.pageY && e.pageY <= l_position.bottom ) ) {
					} else {
						$(this).hide();
					}
				});
			}//if(outer)				
		});//mousedown
	});//이외영역 클릭 function
		
	//채팅생성
	$(".chatTo_btn").on('click', function(){
		let memberId = $(this).prevAll(".memId").val();
		//alert("member Id = " + memberId);
		open("/chatstart?touser_id="+memberId , "일대일채팅", "width=400px, height=650px, top=200px, left=800px, scrollbars=no");	
	});
	
	
	
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
	<div id="board_onepage">
		<div id="top_btns">
			<input type=button id="backToList" value="목록">
			<div id="board_btnbox" >
				<%-- <input type="button" id="board_btns_open" value="···" />
				<div id="board_btns_parentDiv" >
					<form action="boardUpdateForm" id="boardUpdateForm" method="post">
					<input type="hidden" id="boardIdToUpdate" name="bi" value="${detaildto.board_id}">
					<input type="hidden" id="boardTi" name="town_id" value="${detaildto.town_id}">
					</form>
					<input type="button" id="board_update_btn" value="수정" />
					<hr style="margin:2px 0px;">
					<input type="button" id="board_delete_btn" value="삭제" />
				</div>
				<div id="board_blameBtn_parentDiv">
					<input type="button" id="board_blame_btn" value="신고" />
				</div> --%>
			</div>
		</div>
		<hr style="margin-bottom : 20px;">
		<div id="oneboard_title">${detaildto.board_title}</div>
		<div id="oneboard_info">
			<div id="oneboard_writerinfo">
				<div id="oneboard_profileImg"><img src="${writerDto.profile_image}"></div>
				<div id="oneboard_memberGrade"><img src="${boardWriterGradeImg }"></div>
				<div id="oneboard_writer">${detaildto.writer}</div>
				<div class="yourInfo_btnBox">						
					<input type="hidden" class="memId" value="${detaildto.writer}" />
					<input type="button" class="yourInfo_btn" value="회원정보" />
					<hr style="margin:2px 0px;">
					<input type="button" class="chatTo_btn" value="채팅하기" />
				</div>
				<div class="myInfo_btnBox">						
					<input type="button" class="myInfo_btn" value="내정보" />
				</div>
			</div>
			<div class="info" id="view_cnt">조회 ${detaildto.view_cnt}</div>
			<div class="info" id="writingtime">
				<!-- 오늘 날짜랑 같으면 시간만 출력, 날짜 다르면 년월일 출력 / 댓글 수정했으면 수정시간 표시 -->
				<jsp:useBean id="now" class="java.util.Date" />
				<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate" />
				<c:choose>
				 	<c:when test="${detaildto.update_time != null}">
						<fmt:parseDate value="${detaildto.update_time}" pattern="yyyy-MM-dd HH:mm:ss" var="reg" />
				 	</c:when>
				 	<c:otherwise>
						<fmt:parseDate value="${detaildto.writing_time}" pattern="yyyy-MM-dd HH:mm:ss" var="reg" />
				 	</c:otherwise>
				</c:choose> 
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
			<div class="info" id="comment_cnt"><%-- 댓글 ${commentCnt } --%></div>
		</div>
		<hr style="margin-bottom : 20px;">
		<div id="oneboard_contents"> 
			${detaildto.board_contents}
			
			<!-- 지도정보 있으면 출력 -->
			<c:if test="${detaildto.place_name != null}">
				<div id="mapInfoBox">
					<div id="staticMap"></div>
					<div id="placeName">${detaildto.place_name}</div>
					<div id="placeAddress">${detaildto.place_road_address}</div>
				</div>
				<input type="hidden" id="placeLat" value="${detaildto.place_lat}">
				<input type="hidden" id="placeLong" value="${detaildto.place_long}">
			</c:if>
		</div>
		
	<!-- 좋아요/싫어요 start -->
<%-- 		<div id="good_hate_area">
			<div id="good_hate_btnBox">
				<div id="good_info" class="good_hate_infoDiv">
					<label for="good_btn">
						<c:choose>
							 <c:when test="${gohresult == 'good'}">
								<img id='good_iconImg' src="/img/icon_good_on3.svg" style="width : 50px; height = 50px;" />
							 </c:when>
							 <c:otherwise>
								<img id='good_iconImg' src="/img/icon_good_off3.svg" style="width : 50px; height = 50px;" />
							 </c:otherwise>
						</c:choose> 
					</label> 
				  	<input type="button" id="good_btn" />
			  		<div id="good_cnt">${detaildto.good_cnt }</div>
			  	</div>	
				<div id="hate_info" class="good_hate_infoDiv">
					<label for="hate_btn"> 
					<c:choose>
						 <c:when test="${gohresult == 'hate'}">
							<img id='hate_iconImg' src="/img/icon_hate_on3.svg" style="width : 50px; height = 50px;" />
						 </c:when>
						 <c:otherwise>
							<img id='hate_iconImg' src="/img/icon_hate_off3.svg" style="width : 50px; height = 50px;" />
						 </c:otherwise>
					</c:choose> 
					</label> 
				  	<input type="button" id="hate_btn" />
			  		<div id="hate_cnt">${detaildto.hate_cnt }</div>
				</div>
			</div>
		</div> --%>
	<!-- 좋아요/싫어요 end -->	
	
		<hr style="margin-bottom : 20px; margin-top : 20px;">	
<!-- 		<div id="oneboard_commentarea">
			<div id="oneboard_comments">		
			</div>
		</div> -->
	


</div>
</div>

</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4f7e1f2c70926d22aa160d0a0685b14c&libraries=services"></script>
<script>
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

//댓글,대댓글에 사진 첨부한거 취소하기
function cancleImg(e){
	$(e).prev().attr('src',"");
	$(e).parent().hide();
};  


</script>
</html>