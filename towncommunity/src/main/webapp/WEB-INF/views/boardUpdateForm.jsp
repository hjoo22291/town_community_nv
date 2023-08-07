<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정 페이지</title>
<!-- quill.js -->
<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
<script src="//cdn.quilljs.com/1.3.6/quill.js"></script>
<!-- jquery -->
<script src="/js/jquery-3.6.4.min.js"></script>
<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/writingForm.css"/>
<style>
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
		<div id="board_page" style="height: 700px;">			
			
			<div id="editor"></div>
			<input type="hidden" id="quill_html" name="content"/>
			
			<div id="content-footer">
				<button id="place-btn">장소추가</button>
				<button id="boardUpdateBtn">수정완료</button>
			</div>
			
			<script>
				// 게시판에서 글 작성 페이지로 이동시 자동으로 게시판 소분류 선택
				$(document).ready(function() {
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
					  ['blockquote', 'code-block'],
					  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
					  [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
					  [{ 'align': [] }],
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
						let board_name_inner = $("#board-name option:selected").val(); // 게시글 소분류
						let boardId = $("#boardId").val(); // 게시글 id
						let board_title = $("#write-title").val(); // 게시글 제목
						let board_contents = $("#quill_html").val(); // 게시글 내용
						let board_imgurl; // 업로드한 이미지가 저장된 경로
						
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
								"board_imgurl": board_imgurl
							},
							dataType: "json",
							method: "post",
							success: function(response) {
								if (response == 1) {
									alert("글 수정이 완료되었습니다.");
									if (board_name_inner === "오늘의 사진" || 
											board_name_inner === "역대 당선작" || 
											board_name_inner === "분실물센터") {
										location.href = "/photoboarddetail?bi=" + boardId;
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
						window.open('/kakaoMap', '_blank', 'width=500px, height=400px');
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
					
				}); //ready
			</script>
			
		</div>
	</div>
</div>
</body>
</html>