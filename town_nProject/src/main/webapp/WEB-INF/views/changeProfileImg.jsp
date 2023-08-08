<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 사진 변경</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<style>
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

* {font-family : 'GmarketSansMedium';}

html, body {
	margin: 0px;
	padding: 0px;
	background-color: #E3E2E0;
}

html {
	overflow-x:hidden; 
	overflow-y:hidden;
}

header {
	padding-left: 30px;
	height: 50px;
	line-height: 50px;
	background-color: #182434;
	color: white;
}

#form-wrap {
	height: 300px;
	display: flex;
	flex-direction: column;
	align-items: center;
	background-color: white; 
}

#profile_img {
	width: 100%;
	height: 150px;
	display: flex;
	justify-content: center;
	padding: 20px;
}

#profile_img img {
	width: 150px;
	height: 150px;
	border-radius: 75px;
}

#profile_img a {
	position: relative;
	width: 40px;
	height: 40px;
	top: 110px;	
	left: -40px;
	background-image: url("/img/camera-icon.png");
	background-size: 40px 40px;
	cursor: pointer;
}

button {
	color: #182434;
	border: 1px solid #DEDEDE;
	border-radius: 4px;
	width: 50px;
	height: 30px;
	cursor: pointer;
}

button:first-of-type {
	margin-right: 10px;
}

button:hover {
  background: #e1e1e1;
  border-color: #e1e1e1;
}
</style>
</head>
<body>
<header>프로필 사진 설정</header>
<div id="form-wrap">
	<div id="profile_img">
		<img src="/img/basic_profile.png"/>
		<a></a>
	</div>
	<p>설정하고 싶은 프로필 사진을 선택해주세요.</p>
	<div>
		<button>적용</button>
		<button>취소</button>
	</div>
</div>
</body>
<script>
// 부모창에서 이전 프로필 사진 정보 가져옴.
let prevImgSrc;
(function() {
	prevImgSrc = opener.document.querySelector("#my_profile_img img").src
	$("#profile_img img").attr("src", prevImgSrc);
})();

// 프로필 사진을 선택하는 함수
function selectLocalImage() {
	const fileInput = document.createElement('input');
	const maxSize = 5 * 1024 * 1024;
	fileInput.setAttribute('type', 'file');
	fileInput.setAttribute("max", maxSize);
	
	fileInput.click();
	
	fileInput.addEventListener("change", function () {  // change 이벤트로 input 값이 바뀌면 실행
		const formData = new FormData();
		const file = fileInput.files[0];
		const fileSize = file.size;
		  
		if (this.files && this.files[0]) {
			if(fileSize > maxSize){
				alert("첨부파일 사이즈는 5MB 이내로 등록 가능합니다.");
				$(this).val('');
				return false;
			}
		}
		formData.append('uploadFile', file);

    $.ajax({
			type: 'post',
			enctype: 'multipart/form-data',
			url: '/board/imageUpload',
			data: formData,
			processData: false,
			contentType: false,
			dataType: 'json',
			success: function (data) {
				data.uploadPath = data.uploadPath.replace(/\\/g, '/');
				$("#profile_img img").attr("src", "/display?fileName=" + data.uploadPath + "/" + data.uuid + "_" + data.fileName);
			},
				error: function(request,status,error) {
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}); //ajax
	}); //addEventListener
} //function

// 프로필 사진 변경 아이콘 클릭시
$("#profile_img a").on("click", function() {
	selectLocalImage();
}); //onclick

// 적용 버튼 클릭시
$("button:eq(0)").on("click", function() {
	const curImgSrc = $("#profile_img img").attr("src");
	if (prevImgSrc === curImgSrc) {
		self.close();
		return;
	}
	$.ajax({
		url: "/updateProfileImg",
		data: {
			imgSrc: curImgSrc,
		},
		dataType: "json",
		method: "post",
		success: function(response) {
			if (response.result === 1) {
				alert("프로필 변경이 완료되었습니다.");
				opener.document.querySelector("#my_profile_img img").src = curImgSrc;
				opener.document.querySelector(".oneboard_profileImg img").src = curImgSrc;
				self.close();
			} else if (response.result === 0) {
				alert("세션이 만료되었습니다. 다시 로그인 해주세요.");
				window.location.href = "/Signin";
			} else {
				console.log("알 수 없는 에러 발생");
				alert("알 수 없는 에러 발생");
			}
		},
		error: function(request,status,error) {
   		alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
   		console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    }
	}); //ajax
}); //onclick

// 취소 버튼 클릭시
$("button:eq(1)").on("click", function() {
	self.close();
}); //onclick
</script>
</html>