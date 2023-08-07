<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정 페이지</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4f7e1f2c70926d22aa160d0a0685b14c&libraries=services"></script>
<!-- quill.js -->
<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<script src="//cdn.quilljs.com/1.3.6/quill.js"></script>
<!-- jquery -->
<script src="/js/jquery-3.6.4.min.js"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/writingForm3.css"/>
<style>
#mapImg{
	width : 120px; height : 120px;
	margin : 5px;
}
</style>
</head>
<body>
<jsp:include page="Header.jsp" />
<div id="board_layout">
	<jsp:include page="boardMenu.jsp" />
	<div id="board_main">
		<div id="board_name">
			<select id="board-name">
				<option>나의 일상</option>
				<option>사건, 사고 소식</option>
				<option>오늘의 사진</option>
				<option>같이 줄서요</option>
				<option>같이 해요 소모임</option>
				<option>분실물센터</option>
				<option>심부름센터</option>
				<option>행사 소식</option>
				<option>새로 오픈했어요</option>
			</select>
			<input id="write-title" type="text" value="${dto.board_title }"/>
			<input type="hidden" id="boardId" value="${dto.board_id }" />
		</div>
		<div id="board_page">			
			
			<div id="editor"></div>
			<input type="hidden" id="quill_html" name="content">
			
			<div id="content-footer">

				 <c:choose>
				 	<c:when test="${dto.place_name != null}">
						<div id="place_center_align" style="display : flex;">
							<div id="place_con">
								<ul id="place_info_con">
									<li class="place_info">${dto.place_name}</li>
									<li class="place_info">${dto.place_road_address}</li>
									<li class="place_info">${dto.place_address}</li>
									<li class="place_info">${dto.place_tel}</li>
									<li class="place_info" style="display: none">${dto.place_lat}</li>
									<li class="place_info" style="display: none">${dto.place_long}</li>
								</ul>
								<div id="mapImg"></div>
							</div>
							<span id="place_delbtn">X</span>
						</div>
				 	</c:when>
				 	<c:otherwise>
						<div id="place_center_align">
							<div id="place_con">
								<ul id="place_info_con">
									<li class="place_info"></li>
									<li class="place_info"></li>
									<li class="place_info"></li>
									<li class="place_info"></li>
									<li class="place_info" style="display: none"></li>
									<li class="place_info" style="display: none"></li>
								</ul>
								<div id="mapImg"></div>
							</div>
							<span id="place_delbtn">X</span>
						</div>
				 	</c:otherwise>
				</c:choose>
				<div id="place-and-write">
					<button id="place-btn">장소추가</button>
					<button id="boardUpdateBtn">수정완료</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div id='addplace-result' style="display: none;"></div>
</body>
<script>
	$(document).ready(function() {
		//지도 이미지 넣기
		loadMapImg();
		
		// 게시판에서 글 작성 페이지로 이동시 자동으로 게시판 소분류 선택
		$("#board-name option").each(function(index, item) {
			if ($(item).text() === "${dto.board_name_inner}") {
				$(item).prop("selected", true);
			}
		});
		
		var toolbarOptions = [
		  [{ 'font': [] }],
		  [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
		  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
		  [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
		  ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
		  ['blockquote'],
		  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
		  ['clean'],   	                                    // remove formatting button
		  ['image'],
		];
		
		// quill.js 실행 코드
		function quilljsediterInit(){
		    var option = {
		        modules: {
		            toolbar: toolbarOptions,
		        },
		        placeholder: '자세한 내용을 입력해 주세요!',
		        theme: 'snow'
		    };

		    quill = new Quill('#editor', option);
		    
		    //기존 작성글 본문에 넣기----------------------------------
		    var html = '${dto.board_contents}';
		    var delta = quill.clipboard.convert(html);
	        quill.setContents(delta, 'silent');
	        document.getElementById("quill_html").value = quill.root.innerHTML;
	        //----------------------------------------------------
	        
		    quill.on('text-change', function() {
		        document.getElementById("quill_html").value = quill.root.innerHTML;
		    });

		    quill.getModule('toolbar').addHandler('image', function () {
		        selectLocalImage();
		    });
		}

		/* 이미지 콜백 함수 */
		function selectLocalImage() {
		    const fileInput = document.createElement('input');
		    fileInput.setAttribute('type', 'file');

		    fileInput.click();

		    fileInput.addEventListener("change", function () {  // change 이벤트로 input 값이 바뀌면 실행
		        const formData = new FormData();
		        const file = fileInput.files[0];
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
		                const range = quill.getSelection(); // 사용자가 선택한 에디터 범위
		                data.uploadPath = data.uploadPath.replace(/\\/g, '/');
		                quill.insertEmbed(range.index, 'image', "/display?fileName=" + data.uploadPath + "/" + data.uuid + "_" + data.fileName);
		            },
		            error: function(request,status,error) {
					      		alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					      		console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					      }
		        });

		    });
		}

		quilljsediterInit();

		// 작성완료 버튼 클릭 이벤트
		$("#boardUpdateBtn").on("click", function() {
			$(".ql editor").append("<p><br></p>")
			let board_name_inner = $("#board-name option:selected").val(); // 게시글 소분류
			let boardId = $("#boardId").val(); // 게시글 id
			let board_title = $("#write-title").val(); // 게시글 제목
			let board_contents = $("#quill_html").val(); // 게시글 내용
			let board_imgurl; // 업로드한 이미지가 저장된 경로
			let board_preview = $(".ql-editor").text(); // 게시글 미리보기 텍스트
			let place_name; // 게시글에 추가한 장소 이름
			let place_road_address; // 장소 도로명 주소
			let place_address; // 장소 지번 주소
			let place_tel; // 장소 전화번호
			let place_lat; // 장소 위도
			let place_long; // 장소 경도
			if ($("#place_center_align").css("display") !== "none") {
				place_name = $($(".place_info")[0]).text();
				place_road_address = $($(".place_info")[1]).text();
				place_address = $($(".place_info")[2]).text();
				place_tel = $($(".place_info")[3]).text();
				place_lat = $($(".place_info")[4]).text();
				place_long = $($(".place_info")[5]).text();
			}
			
			// 만약 이미지가 하나 이상이면 첫번째 이미지 src 속성 board_imgurl에 저장 
			if ($(".ql-editor img").length > 0) {
				board_imgurl = $($(".ql-editor img")[0]).attr("src");
			}	
			
			// board_contents에서 resize 속성 삭제
			let removeStr = "resize: both; ";
			let removeIdx = board_contents.indexOf(removeStr);
			while(removeIdx > -1) {
				board_contents = board_contents.replace(removeStr, "");
				removeIdx = board_contents.indexOf(removeStr);
			}
			
			$.ajax({
				url: "/boardupdate",
				data: {
					"board_id": boardId,
					"board_name_inner": board_name_inner,
					"board_title": board_title,
					"board_contents": board_contents,
					"board_imgurl": board_imgurl,
					"board_preview": board_preview,
					"place_name": place_name,
					"place_road_address": place_road_address,
					"place_address": place_address,
					"place_tel": place_tel,
					"place_lat": place_lat, 
					"place_long": place_long
				},
				dataType: "json",
				method: "post",
				success: function(response) {
					if (response == 1) {
						alert("글 수정이 완료되었습니다.");
						if (board_name_inner === "오늘의 사진" || 
								board_name_inner === "역대 당선작" || 
								board_name_inner === "분실물센터") {
							location.href = "/boarddetail?bi=" + boardId;
						} else {
							location.href = "/boarddetail?bi=" + boardId;
						}
						
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
		
		// 장소추가 버튼 클릭 이벤트
		$("#place-btn").on("click", function() {
			if ("${boardTi}" == "${sessionScope.town_id}") {
				window.name = "boardUpdateForm";
				window.open('/kakaoMap?ti=${boardTi}', 'kakaoMap', 'width=855px, height=602px, top=0px, left=0px');
			}
		}); //onclick
		
		
		// 에디터 내 이미지 클릭시 크기 조절 가능하게
		$(document).on("click", ".ql-editor img", function() {
			if ($(this).parent().css("resize") !== "both") {
				$(this).parent().css({
					"resize": "both",
					"width": "50%",
					"overflow": "hidden",
					"max-width": "1100px",
					"margin": "0px",
				});
				$(this).css("width", "100%");
				$(this).css("height", "100%");
			} else {
				$(this).parent().css("resize", "none");
			}
		}); //onclick
		
		// 에디터 작성 중 엔터 누를 때 동작
		$(".ql-editor").on("keydown", function(e) {
			if (e.keyCode === 13) {
				$(".ql-editor p").each(function(index, item) {
					if ($(item).find("img").length <= 0) {
						$(item).removeAttr("style");
					} //if
				}); //each
			}
		}); //onfocus
		
		$("#place_delbtn").on("click", function() {
			$("#place_center_align").css("display", "none");
		}); //onclick
		
		$("#place_con").on("click", function() {
			window.open("https://search.naver.com/search.naver?where=nexearch&sm=tab_jum&query=" + $($(".place_info")[0]).text());
		});
		
}); //document ready

//지도이미지 넣기
function loadMapImg(){ 
	//위도, 경도값
	let placeLat = $($(".place_info")[4]).text();
	let placeLong = $($(".place_info")[5]).text();
	
	// 이미지 지도에서 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(placeLat, placeLong); 
	
	// 이미지 지도에 표시할 마커입니다
	// 이미지 지도에 표시할 마커는 Object 형태입니다
	var marker = {
	    position: markerPosition
	};
	
	var staticMapContainer  = document.getElementById('mapImg'), // 이미지 지도를 표시할 div  
	    staticMapOption = { 
	        center: new kakao.maps.LatLng(placeLat, placeLong), // 이미지 지도의 중심좌표
	        level: 4, // 이미지 지도의 확대 레벨
	        marker: marker // 이미지 지도에 표시할 마커 
	    };    
	
	// 이미지 지도를 생성합니다
	var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
};

	// kakaoMap 창에서 장소추가했을 때 동작
	function addBoardPlace() {
		let place_html = $("#addplace-result");
		let place_data = $("#addplace-result").text().split("/n");
		
		$($(".place_info")[0]).text(place_data[0]); // 이름
		$($(".place_info")[1]).text(place_data[1]); // 도로명 주소
		$($(".place_info")[2]).text(place_data[2]); // 지번 주소
		$($(".place_info")[3]).text(place_data[3]); // 전화번호
		$($(".place_info")[4]).text(place_data[4]); // 위도
		$($(".place_info")[5]).text(place_data[5]); // 경도
		$("#place_center_align").css("display", "flex");
		$("#mapImg").html("");
		loadMapImg();
	}

</script>

</html>