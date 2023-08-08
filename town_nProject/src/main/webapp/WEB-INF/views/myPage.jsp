<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네일보 마이페이지</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/BoardCommon.css" />
<link rel="stylesheet" href="/css/Mypage.css" />
<link rel="stylesheet" href="/css/basicBoard.css"> 

</head>
<body style="background-image: url(/img/newspaper2.svg);">
<jsp:include page="Header.jsp" />
<div id="myPage_layout">
	<div id="myPage_menu">
		<ul class="allMenu">
      <li class="outerMenu">My page</li>
		  <li class="outerMenu">
		    내 글 목록
		    <ul class="innerMenu">
		      <li class="innerMenu">내가 쓴 글</li>
		      <li class="innerMenu">내가 쓴 댓글</li>
		      <li class="innerMenu">좋아요 한 글</li>
		    </ul>
		  </li>
	    <li class="outerMenu">내 채팅목록</li>
	  	<li class="outerMenu"><a href="/myinform">내 정보 수정</a></li>
	    <li class="outerMenu"><a href="#" onclick="return updatepasswordopen()">비밀번호 변경</a></li>
		  <div id="deleteclick"><li class="outerMenu"><a>회원 탈퇴</a></li></div>
		</ul>
	</div>
	
	<div id="myPage_main">
		<div id="myPage_name">
			My page
		</div>
		<div id="myPage_page">
			<div id="myinfo_box">
				<div id="my_profile_img">
					<img src="${my_info.profile_image}">
					<a></a>
				</div>
				<div id="my_profile_box">
					<div id="my_level" style="display: flex; font-size:15px; align-items: center">
						<span style="margin-right: 5px;">회원 등급 : </span>
						<img src="${gradeImage}" style="width: 15px; height: 15px; margin-right: 5px;">
						<span>${my_info.grade_name}</span>
					</div>
					<div id="my_id">${my_info.member_id}</div>
					<div id="my_email">${my_info.email}</div>
				</div> 
				<div id="my_grade_box">
					<progress value="${gradePercent}" max="100"></progress>
					<span>${gradeProgress}/${gradeRange}</span>
				</div>
			</div>
			<div id="myinfo_table">
				<table>
					<tr><th>보유포인트</th><th>가입일</th><th>방문횟수</th><th>내 동네</th></tr>
					<tr><td>${my_info.point}P</td><td>${Signup_date}</td><td>${my_info.invite_sum}</td><td>${my_info.address}</td>
					<tr><th>내가 쓴 글</th><th>내가 쓴 댓글</th><th>사진전 당선 글</th><th>좋아요 한 글</th></tr>
					<tr><td>${MyTotalArticleCount}개</td><td>${MycommentTotalArticleCount}개</td><td>0개</td><td>${getMygoodTotalArticleCount}개</td>
				</table>
			</div>
		</div>
	</div>
	
</div>
</body>
<script>
	// 프로필 수정 버튼 클릭시
	$("#my_profile_img a").on("click", function() {
		window.open("/changeProfileImg", "changeProvileImg", "width=500px, height=350px, top=300px, left=960px, scrollbars=no");
	}); //onclick
	//비밀번호 변경 클릭
	function updatepasswordopen() {
  	var win =window.open("/Updatepassword", "PopupWin", "width=980,height=500");
 	win;
}
</script>
<script src="/js/Mypage.js"></script>
</html>