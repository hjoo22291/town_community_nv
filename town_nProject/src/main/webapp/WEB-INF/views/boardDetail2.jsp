<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/BoardCommon.css" />
<link rel="stylesheet" href="/css/BoardDetail.css" />
<script>
$(document).ready(function(){
//----------------------------------------- page 버튼 ----------------------------------------------------------------
	//페이지 버튼 눌렀을때 해당페이지 보여주기
 	$(".photoPageNumBtn").on('click', function(){
		const queryparamsPage = {
		   page: $(this).val(),
		   bi: "${searchdto.searchType1}"
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});//pageNumBtn클릭
	
	//첫페이지
 	$("#photoBoardPageBtnFirst").on('click', function(){
		const queryparamsPage = {
		   page: 1,
		   bi: "${searchdto.searchType1}"
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
 	//이전페이지
 	$("#photoBoardPageBtnPre").on('click', function(){
		const queryparamsPage = {
		   page: "${response.pagination.startPage-1}",
		   bi: "${searchdto.searchType1}"
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
	//다음페이지
 	$("#photoBoardPageBtnNext").on('click', function(){
		const queryparamsPage = {
		   page: "${response.pagination.endPage+1}",
		   bi: "${searchdto.searchType1}"
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});
	
 	//마지막페이지
 	$("#photoBoardPageBtnLast").on('click', function(){
		const queryparamsPage = {
		   page: "${response.pagination.totalPageCount}",
		   bi: "${searchdto.searchType1}"
		}
		location.href = location.pathname + '?' + new URLSearchParams(queryparamsPage).toString();
	});//pageNumBtn클릭
//----------------------------------------- page 버튼 -----------------------------------------------------------------
	
	//댓글에 사진올릴때 미리보기
	$("#comment_file").change(function() {
	   if (this.files && this.files[0]) {
	      var reader = new FileReader;
	      reader.onload = function(data) {
 	    	$("#comment_img_preview").attr("src", data.target.result);
 	      	$("#comment_img_preview").css("display","block");
	  	 }
	      reader.readAsDataURL(this.files[0]);
	   }
	});
	
	//댓글쓰기
	const comment = document.getElementById("writing_area");
	
 	 $("#comment_submit_btn").on('click', function(e){
		e.preventDefault();
		
		//enter => <br>
		let text = $('#writing_area').val();
		text = text.replace(/(?:\r\n|\r|\n)/g, '<br>');
		
 		 if(comment.value.trim() !== "" && $('#comment_writer').val() != "" ){
  			$.ajax({
 				url : 'commentwrite',
 				type : 'post',
 				data : {
 					'comment_writer' : $('#comment_writer').val(),
 					'board_id' : $('#board_id').val(),
 					'comment_contents' : text,
 					'comment_secret' : $("#comment_secret").is(":checked")
 				},
 				success : function(response){ 
 					if(response > 0) {
 						comment.value =''; //입력칸 초기화
 						$("#comment_secret").prop('checked', false); //체크박스 초기화
 						$("#comment_img_preview").attr("src", ""); //첨부된사진 미리보기 없애기
 			 	      	$("#comment_img_preview").css("display","none"); //첨부된사진 미리보기 없애기
 						location.reload(); //현재 페이지 새로고침
 					}
 				}, 
 				error : function(request, status, e) {
 					alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
 				}
 			});//ajax
 		}
  		else { 
  			alert("댓글을 입력하세요.");
  		}

	});//댓글쓰기

	//댓글마다 ... 버튼 누르면 수정,삭제버튼 나오게
 	$(".comment_btns_open").on('click', function(){
 		const commentWriter = $(this).parent(".comment_btnbox").attr('id');	
 		let status1 = $(this).next(".comment_btns_parentDiv").css('display');
		let status2 = $(this).nextAll(".comment_blameBtn_parentDiv").css('display');
		if("${member_id}" == commentWriter) { //로그인 id와 댓글작성자가 같을때만 버튼 출력
			if(status1 == 'none')  {
		 		$("#board_btns_parentDiv").hide();
		 		$("#board_blameBtn_parentDiv").hide();
		 		$(".comment_btns_parentDiv").hide();
		 		$(".comment_blameBtn_parentDiv").hide();
		 		$(".chatTo_btnBox").hide();
		 		$(".chatToCom_btnBox").hide();
				$(this).next(".comment_btns_parentDiv").fadeIn(200);		
			}
		 	else {
				$(this).next(".comment_btns_parentDiv").fadeOut(200);	
		 	}
 		}
 		else {
 			if(status2 == 'none') {
		 		$("#board_btns_parentDiv").hide();
		 		$("#board_blameBtn_parentDiv").hide();
		 		$(".comment_btns_parentDiv").hide();
		 		$(".comment_blameBtn_parentDiv").hide();
		 		$(".chatTo_btnBox").hide();
		 		$(".chatToCom_btnBox").hide();
				$(this).nextAll(".comment_blameBtn_parentDiv").fadeIn(200);					 		 				
 			}
 			else { 				
				$(this).nextAll(".comment_blameBtn_parentDiv").fadeOut(200);					 		
 			}
 		}
	});//수정,삭제버튼 나오게
	
	//댓글 삭제
	$(".comment_delete_btn").on('click', function(){
		 const commentId = $(this).parent().siblings(".comment_btns_open").attr('id');
		 if(confirm("정말 삭제하시겠습니까?") == true){
			 $.ajax({
	 				url : 'deletecomment',
	 				type : 'post',
	 				data : {'comment_id' : commentId },
	 				success : function(response){
	 					alert("댓글이 삭제되었습니다.");
	 					location.reload();
	 				}, 
	 				error : function(request, status, e) {
	 					alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
	 				}
	 			});//ajax 
	    }
	    else{
	        return ;
	    }
	}); //댓글 삭제
	
	//댓글 신고
	$(".comment_blame_btn").on('click', function(){
		 const commentId = $(this).parent().siblings(".comment_btns_open").attr('id');
		 alert(commentId);		 
	});//댓글 신고
	
	//답글 누르면 댓글form 열리게
	$(".writeRecommentBtn").on("click", function(){
		let status = $(this).parents().siblings(".recomment_writing").css('display');
		if(status == 'none')  {
			$("#board_btns_parentDiv").hide();
	 		$("#board_blameBtn_parentDiv").hide();
	 		$(".comment_btns_parentDiv").hide();
	 		$(".comment_blameBtn_parentDiv").hide();
	 		$(".chatTo_btnBox").hide();
	 		$(".chatToCom_btnBox").hide();
	 		$(".recomment_writing").hide();
	 		$(".recomment_writing_area").val("");
	 		$(".comment_updateWritingDiv").hide();
			$(this).parents().siblings(".recomment_writing").show();
			
		} else {
			$(this).parents().siblings(".recomment_writing").hide();
			$(this).parents().siblings(".recomment_writing").children(".recomment_writing_area").val("");
			
		}
	});//댓글폼열기
	
	//좋아요 버튼 누를때
	$("#good_info").on('click', "#good_iconImg", function(){			
 	 		 $.ajax({
					url : 'likethisboard',
					type : 'post',
					data : {
						'board_id' : "${detaildto.board_id}",
						'member_id' : "${member_id}"	
					},
					success : function(response){
						if(response.result == "cancle") {
							$("#good_iconImg").attr("src","/img/icon_good_off3.svg");						
						}
						else if(response.result == "onandoff"){
							$("#good_iconImg").attr("src","/img/icon_good_on3.svg");
							$("#hate_iconImg").attr("src","/img/icon_hate_off3.svg");						
						}
						else {
							$("#good_iconImg").attr("src","/img/icon_good_on3.svg");					
						}
						$('#good_info').load(location.href + ' #good_info');						
						$('#hate_info').load(location.href + ' #hate_info');						
					}, 
					error : function(request, status, e) {
						alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
					}
				});//ajax
			
	});//좋아요
	
	//싫어요 버튼 누를때
	$("#hate_info").on('click', "#hate_iconImg", function(){			
 	 		 $.ajax({
					url : 'hatethisboard',
					type : 'post',
					data : {
						'board_id' : "${detaildto.board_id}",
						'member_id' : "${member_id}"	
					},
					success : function(response){
						if(response.result == "cancle") {
							$("#hate_iconImg").attr("src","/img/icon_hate_off3.svg");					
						}
						else if(response.result == "onandoff"){
							$("#hate_iconImg").attr("src","/img/icon_hate_on3.svg");
							$("#good_iconImg").attr("src","/img/icon_good_off3.svg");					
						}
						else {
							$("#hate_iconImg").attr("src","/img/icon_hate_on3.svg");
						}
						$('#good_info').load(location.href + ' #good_info');						
						$('#hate_info').load(location.href + ' #hate_info');						
					}, 
					error : function(request, status, e) {
						alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
					}
				});//ajax
			
	});//싫어요

	//글 상단 ... 버튼 누르면 수정,삭제 / 신고버튼 나오게
 	$("#board_btns_open").on('click', function(){
 		const boardWriter = "${detaildto.writer}";	
 		let Bstatus1 = $(this).next("#board_btns_parentDiv").css('display');
		let Bstatus2 = $(this).nextAll("#board_blameBtn_parentDiv").css('display');					 		
		if("${member_id}" == boardWriter) { //로그인 id와 글작성자가 같을때 수정,삭제버튼 출력
			if(Bstatus1 == 'none')  {
		 		$("#board_btns_parentDiv").hide();
		 		$("#board_blameBtn_parentDiv").hide();
		 		$(".comment_btns_parentDiv").hide();
		 		$(".comment_blameBtn_parentDiv").hide();
		 		$(".chatTo_btnBox").hide();
		 		$(".chatToCom_btnBox").hide();
				$(this).next("#board_btns_parentDiv").fadeIn(200);				
			}
		 	else {
				$(this).next("#board_btns_parentDiv").fadeOut(200);
		 	}
 		}
 		else { //로그인 id가 글 작성자와 다를때 신고 버튼 출력
 			if(Bstatus2 == 'none') {
		 		$("#board_btns_parentDiv").hide();
		 		$("#board_blameBtn_parentDiv").hide();
		 		$(".comment_btns_parentDiv").hide();
		 		$(".comment_blameBtn_parentDiv").hide();
		 		$(".chatTo_btnBox").hide();
		 		$(".chatToCom_btnBox").hide();
				$(this).nextAll("#board_blameBtn_parentDiv").fadeIn(200);				 		 				
 			}
 			else { 				
				$(this).nextAll("#board_blameBtn_parentDiv").fadeOut(200);				 		
 			}
 		}
	});//수정,삭제버튼 나오게
	
	//글 삭제
	$("#board_delete_btn").on('click', function(){
		if(confirm("정말 삭제하시겠습니까?") == true){
			 $.ajax({
	 				url : 'deleteboard',
	 				type : 'post',
	 				data : {'board_id' : "${detaildto.board_id}"},
	 				success : function(response){
	 					alert("글이 삭제되었습니다.");
	 					location.href = document.referrer; //이전페이지로 이동 + 새로고침
	 				}, 
	 				error : function(request, status, e) {
	 					alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
	 				}
	 			});//ajax 
	    }
	    else{
	        return ;
	    }	 
	}); //글 삭제
	
	//글 신고
	$("#board_blame_btn").on('click', function(){
		 alert("${detaildto.board_id}");		 
	});//글 신고
	
	//목록 버튼
	$("#backToList").on('click', function(){
		location.href = document.referrer; //이전페이지로 이동 + 새로고침
	});//목록 버튼
	
	//id 누르면 채팅하기 버튼 (보드 작성자 ver)
	//글 작성자 ver
 	$("#oneboard_writer").on('click', function(){
 		let chatToBoxStatus = $(this).next(".chatTo_btnBox").css('display');
 		$(".chatTo_btnBox").hide();
 		$(".chatToCom_btnBox").hide();
		if(chatToBoxStatus == 'none')  {
	 		$("#board_btns_parentDiv").hide();
	 		$("#board_blameBtn_parentDiv").hide();
	 		$(".comment_btns_parentDiv").hide();
	 		$(".comment_blameBtn_parentDiv").hide();
	 		$(".chatTo_btnBox").hide();
	 		$(".chatToCom_btnBox").hide();			
			$(this).next(".chatTo_btnBox").fadeIn(200);			
		}
	 	else {
	 		$(this).next(".chatTo_btnBox").fadeOut(200);			
	 	}
	});	
	//댓글작성자 ver
	$(".comment_writer").on('click', function(){
 		let chatToBoxStatus = $(this).next(".chatToCom_btnBox").css('display');
 		$(".chatTo_btnBox").hide();
 		$(".chatToCom_btnBox").hide();
		if(chatToBoxStatus == 'none')  {
	 		$("#board_btns_parentDiv").hide();
	 		$("#board_blameBtn_parentDiv").hide();
	 		$(".comment_btns_parentDiv").hide();
	 		$(".comment_blameBtn_parentDiv").hide();
	 		$(".chatTo_btnBox").hide();
	 		$(".chatToCom_btnBox").hide();
			$(this).next(".chatToCom_btnBox").fadeIn(200);			
		}
	 	else {
	 		$(this).next(".chatToCom_btnBox").fadeOut(200);			
	 	}
	});
	//대댓글작성자 ver
	$(".recomment_writer").on('click', function(){
 		let chatToBoxStatus = $(this).next(".chatToCom_btnBox").css('display');
 		$(".chatTo_btnBox").hide();
 		$(".chatToCom_btnBox").hide();
		if(chatToBoxStatus == 'none')  {
	 		$("#board_btns_parentDiv").hide();
	 		$(".comment_btns_parentDiv").hide();
	 		$(".comment_blameBtn_parentDiv").hide();
	 		$(".chatTo_btnBox").hide();
	 		$(".chatToCom_btnBox").hide();
			$(this).next(".chatToCom_btnBox").fadeIn(200);			
		}
	 	else {
	 		$(this).next(".chatToCom_btnBox").fadeOut(200);			
	 	}
	});
	

	//대댓글쓰기
 	 $(".recomment_submit_btn").on('click', function(e){
		e.preventDefault();
		let recmt_contents = $(this).parents().siblings(".recomment_writing_area").val();
		const recmt_writer = $(this).parents().siblings(".recomment_writer").val();
		const recmt_boardId = $(this).parents().siblings(".recomment_board_id").val();
		const recmt_parentId = $(this).parents().siblings(".recomment_parent_id").val();
		const recmt_secretVal = $(this).prev().children(".recomment_secret").is(":checked");
		//alert(recmt_contents +" / "+ recmt_writer +" / "+ recmt_boardId +" / "+ recmt_parentId +" / "+ recmt_secretVal);
		
		//enter => <br>
		recmt_contents = recmt_contents.replace(/(?:\r\n|\r|\n)/g, '<br>');
		
 		if(recmt_contents.trim() !== "" && recmt_writer != "" ){
  			$.ajax({
 				url : 'recommentwrite',
 				type : 'post',
 				data : {
 					'comment_writer' : recmt_writer,
 					'board_id' : recmt_boardId,
 					'parent_id' : recmt_parentId,
 					'comment_contents' : recmt_contents,
 					'comment_secret' : recmt_secretVal
 				},
 				success : function(response){ 
 					if(response > 0) {
 						$(".recomment_writing_area").val(""); //입력칸 초기화
 						$(".recomment_secret").prop('checked', false); //체크박스 초기화
 						$(".recomment_img_preview").attr("src", ""); //첨부된사진 미리보기 없애기
 			 	      	$(".recomment_img_preview").css("display","none"); //첨부된사진 미리보기 없애기
 						location.reload(); //현재 페이지 새로고침
 					}
 				}, 
 				error : function(request, status, e) {
 					alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
 				}
 			});//ajax
 		}
  		else { 
  			alert("댓글을 입력하세요.");
  		}

	});//대댓글쓰기
	
	//댓글의 수정버튼 누르면 수정form 열리게
	$(".comment_update_btn").on("click", function(){
		let status = $(this).parents().siblings(".comment_updateWritingDiv").css('display');
		if(status == 'none')  {
			$("#board_btns_parentDiv").hide();
	 		$("#board_blameBtn_parentDiv").hide();
	 		$(".comment_btns_parentDiv").hide();
	 		$(".comment_blameBtn_parentDiv").hide();
	 		$(".chatTo_btnBox").hide();
	 		$(".chatToCom_btnBox").hide();
	 		$(".recomment_writing").hide();
	 		$(".recomment_writing_area").val("");
	 		$(".comment_updateWritingDiv").hide();
	 		//<br> -> enter로 다시 변경
			let text = $(this).parents().siblings(".comment_updateWritingDiv").children(".comment_update_writing_area").val();
			text = text.split('<br>').join("\r\n");
			$(this).parents().siblings(".comment_updateWritingDiv").children(".comment_update_writing_area").val(text);
			//수정폼 보이기
			$(this).parents().siblings(".comment_updateWritingDiv").show();
			
		} else {
			$(this).parents().siblings(".comment_updateWritingDiv").hide();
			$(this).parents().siblings(".comment_updateWritingDiv").children(".comment_update_writing_area").val("");
			
		}
	});//댓글수정폼열기
	
	//댓글수정
	$(".comment_update_submit_btn").on("click", function(e){
		e.preventDefault();
		let cmt_update_contents = $(this).parents().siblings(".comment_update_writing_area").val();
		const cmt_update_commentId = $(this).parents().siblings(".comment_update_comment_id").val();
		const cmt_update_writer = $(this).parents().siblings(".comment_update_writer").val();
		//const cmt_update_boardId = $(this).parents().siblings(".comment_update_board_id").val();
		const cmt_update_secretVal = $(this).prev().children(".comment_update_secret").is(":checked");
		//alert(cmt_update_contents +" / "+ cmt_update_writer +" / "+ cmt_update_boardId +" / "+ cmt_update_commentId +" / "+ cmt_update_secretVal);
		
		//enter => <br>
		cmt_update_contents = cmt_update_contents.replace(/(?:\r\n|\r|\n)/g, '<br>');
		
 		 if(cmt_update_contents.trim() !== "" && cmt_update_writer == "${member_id}" ){
  			$.ajax({
 				url : 'updatecomment',
 				type : 'post',
 				data : {
 					'comment_id' : cmt_update_commentId,
 					'comment_contents' : cmt_update_contents,
 					'comment_secret' : cmt_update_secretVal
 				},
 				success : function(response){ 
 					if(response > 0) {
 						alert("댓글이 수정되었습니다.");
 						location.reload(); //현재 페이지 새로고침
 					}
 				}, 
 				error : function(request, status, e) {
 					alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
 				}
 			});//ajax
 		}
  		else { 
  			alert("댓글을 입력하세요.");
  		}
		
		
	});//댓글수정
	
	
	//신고하기(글)
	$("#board_blame_btn").on('click', function(){
		
		
	});//글 신고
	
});
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
				<input type="button" id="board_btns_open" value="···" />
				<div id="board_btns_parentDiv" >
					<input type="button" id="board_update_btn" value="수정" />
					<hr style="margin:2px 0px;">
					<input type="button" id="board_delete_btn" value="삭제" />
				</div>
				<div id="board_blameBtn_parentDiv">
					<input type="button" id="board_blame_btn" value="신고" />
				</div>
			</div>
		</div>
		<hr style="margin-bottom : 20px;">
		<div id="oneboard_title">${detaildto.board_title}</div>
		<div id="oneboard_info">
			<div id="oneboard_writerinfo">
				<div id="oneboard_profileImg"><img src="${writerDto.profile_image}"></div>
				<div id="oneboard_writer" onclick="chatToBoxOpen()">${detaildto.writer}</div>
				<div class="chatTo_btnBox">						
					<input type="hidden" class="memId" value="${detaildto.writer}" />
					<input type="button" class="chatTo_btn" value="채팅하기" />
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
			<div class="info" id="comment_cnt">댓글 ${commentCnt }</div>
		</div>
		<hr style="margin-bottom : 20px;">
		<div id="oneboard_contents"> 
			${detaildto.board_contents}
		</div>
		
	<!-- 좋아요/싫어요 start -->
		<div id="good_hate_area">
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
		</div>
	<!-- 좋아요/싫어요 end -->	
	
		<hr style="margin-bottom : 20px; margin-top : 20px;">	
		<div id="oneboard_commentarea">
			<div id="oneboard_comments">
			
		<!-- 댓글 출력 -->			
			<c:forEach items="${response.list}" var="dto" varStatus="status">
				<c:if test="${dto.parent_id == 0}">
					<div class="one_comment">
					
						<div class="comment_upper">
							<div class="comment_profile">
								<div class="comment_profileImg">
								<c:if test="${dto.comment_writer != null }">
									<img src="${commentWriterProfileMap[dto.comment_writer] }">
								</c:if>
								</div>
								<div class="comment_info">
									<div class="comment_writer">${dto.comment_writer}</div>
									<div class="chatToCom_btnBox">				
										<input type="hidden" class="memId" value="${dto.comment_writer}" />
										<input type="button" class="chatTo_btn" value="채팅하기" />
									</div>
									<div class="comment_writingtime">	
										<!-- 오늘 날짜랑 같으면 시간만 출력, 날짜 다르면 년월일 출력 / 댓글 수정했으면 수정시간 표시 -->
										<c:choose>
										 	<c:when test="${dto.comment_updateTime != null}">
												<fmt:parseDate value="${dto.comment_updateTime}" pattern="yyyy-MM-dd HH:mm:ss" var="com_reg" />
										 	</c:when>
										 	<c:otherwise>
												<fmt:parseDate value="${dto.comment_time}" pattern="yyyy-MM-dd HH:mm:ss" var="com_reg" />
										 	</c:otherwise>
										</c:choose> 
										<fmt:formatDate value="${com_reg}" pattern="yyyy-MM-dd" var="com_regDate" />
										<fmt:formatDate value="${com_reg}" pattern="HH:mm" var="com_regTime" />
										<c:choose>
										 	<c:when test="${nowDate == com_regDate}">
												${com_regTime}
										 	</c:when>
										 	<c:otherwise>
												${com_regDate}
										 	</c:otherwise>
										</c:choose> 
									
									</div>
								</div>	
							</div>
						
 						<div class="comment_btnbox" id="${dto.comment_writer}"> 							
							<input type="button" class="writeRecommentBtn" value="답글" />
							<input type="button" class="comment_btns_open" id="${dto.comment_id}" value="···" />
							<div class="comment_btns_parentDiv" >
								<input type="button" class="comment_update_btn" value="수정" />
								<hr style="margin:2px 0px;">
								<input type="button" class="comment_delete_btn" value="삭제" />
							</div>
							<div class="comment_blameBtn_parentDiv">
								<input type="button" class="comment_blame_btn" value="신고" />
							</div>
						</div>
						
					</div><!-- comment_upper -->
						
						<div class="comment_content">${dto.comment_contents} 					
							<c:if test="${dto.comment_imgurl != null}">
								<br><img class="comment_img" src="${dto.comment_imgurl}">
							</c:if>
						</div>
						
			<!-- 대댓글쓰기 textarea 시작 -->
 				<div class="recomment_writing">
					<input type="hidden" class="recomment_writer" value="${member_id}">
					<input type="hidden" class="recomment_board_id" value="${detaildto.board_id}">
					<input type="hidden" class="recomment_parent_id" value="${dto.comment_id}">
					<textarea class="recomment_writing_area" ></textarea><br>
					<img class="recomment_img_preview" src="" />
					<div class="recomment_bottom_btns">
						<div class="recomment_img_upload">
							 <label> 
								 <img class='recomment_fileimg' src="/img/gallery_icon.png" alt="이미지아이콘" style="width : 20px; height = 20px;" />
							 </label> 
			  				 <input type="file" class="recomment_file" />
		  				 </div>
						<div class="recomment_bottom_right">					
							<div class="recomment_secret_checkDiv">
								<!-- <input type="checkbox" class="recomment_secret" value="secret">비밀 -->
							</div>
							<input type="submit" class="recomment_submit_btn" value="등록">
						</div>
					</div>
				</div><!-- 대댓글쓰기 textarea 끝 -->
				
			<!-- 댓글 수정 textarea 시작 -->
 				<div class="comment_updateWritingDiv">
					<input type="hidden" class="comment_update_comment_id" value="${dto.comment_id}">
					<input type="hidden" class="comment_update_writer" value="${dto.comment_writer}">
					<input type="hidden" class="comment_update_board_id" value="${dto.board_id}">
					<textarea class="comment_update_writing_area" >${dto.comment_contents}</textarea><br>
					<c:choose>
					 	<c:when test="${dto.comment_imgurl != null}">
							<img class="comment_update_img_preview" src="${dto.comment_imgurl }" style="display : block;" />
					 	</c:when>
					 	<c:otherwise>
							<img class="comment_update_img_preview" src="" />
					 	</c:otherwise>
					</c:choose> 
					<div class="comment_update_bottom_btns">
						<div class="comment_update_img_upload">
							 <label> 
								 <img class='comment_update_fileimg' src="/img/gallery_icon.png" alt="이미지아이콘" style="width : 20px; height = 20px;" />
							 </label> 
			  				 <input type="file" class="comment_update_file" />
		  				 </div>
						<div class="comment_update_bottom_right">					
							<div class="comment_update_secret_checkDiv">
								<%-- <c:choose>
								 	<c:when test="${dto.comment_secret}">
										<input type="checkbox" class="comment_update_secret" value="secret" checked="checked">비밀
								 	</c:when>
								 	<c:otherwise>
										<input type="checkbox" class="comment_update_secret" value="secret">비밀
								 	</c:otherwise>
								</c:choose>  --%>
							</div>
							<input type="submit" class="comment_update_submit_btn" value="수정">
						</div>
					</div>
				</div><!-- 댓글 수정 textarea 끝 -->
	
			</div><!-- one_comment end -->		
			</c:if>
				<!-- 대댓글 출력 시작 -->
					<c:if test="${dto.parent_id != 0}">
						<div class="one_recomment">	
						
						<div class="recomment_upper">
											
							<div class="recomment_profile">
								&nbsp;&nbsp;└&nbsp;&nbsp;&nbsp; 
								<div class="recomment_profileImg">
								<c:if test="${dto.comment_writer != null || dto.comment_writer != '' }">
									<img src="${commentWriterProfileMap[dto.comment_writer] }">
								</c:if>								
								</div>
								<div class="recomment_info">
									<div class="recomment_writer">${dto.comment_writer}</div>
									<div class="chatToCom_btnBox">				
										<input type="hidden" class="memId" value="${dto.comment_writer}" />
										<input type="button" class="chatTo_btn" value="채팅하기" />
									</div>
									<div class="recomment_writingtime">							
										<!-- 오늘 날짜랑 같으면 시간만 출력, 날짜 다르면 년월일 출력 / 댓글 수정했으면 수정시간 표시 -->
										<c:choose>
										 	<c:when test="${dto.comment_updateTime != null}">
												<fmt:parseDate value="${dto.comment_updateTime}" pattern="yyyy-MM-dd HH:mm:ss" var="recom_reg" />
										 	</c:when>
										 	<c:otherwise>
												<fmt:parseDate value="${dto.comment_time}" pattern="yyyy-MM-dd HH:mm:ss" var="recom_reg" />
										 	</c:otherwise>
										</c:choose> 
										<fmt:formatDate value="${recom_reg}" pattern="yyyy-MM-dd" var="recom_regDate" />
										<fmt:formatDate value="${recom_reg}" pattern="HH:mm" var="recom_regTime" />
										<c:choose>
										 	<c:when test="${nowDate == recom_regDate}">
												${recom_regTime}
										 	</c:when>
										 	<c:otherwise>
												${recom_regDate}
										 	</c:otherwise>
										</c:choose> 
										
									</div>
								</div>
							</div>
							
							<div class="comment_btnbox" id="${dto.comment_writer}"> 							
								<input type="button" class="writeRecommentBtn" value="답글" />
								<input type="button" class="comment_btns_open" id="${dto.comment_id}" value="···" />
								<div class="comment_btns_parentDiv" >
									<input type="button" class="comment_update_btn" value="수정" />
									<hr style="margin:2px 0px;">
									<input type="button" class="comment_delete_btn" value="삭제" />
								</div>
								<div class="comment_blameBtn_parentDiv">
									<input type="button" class="comment_blame_btn" value="신고" />
								</div>
							</div>

						</div>	<!-- Recomment_upper -->
						
							<div class="recomment_content">${dto.comment_contents}
								<c:if test="${dto.comment_imgurl != null}">
									<br><img class="comment_img" src="${dto.comment_imgurl}">
								</c:if>
							</div>
							
			<!-- ------------대댓글에 답글-------------------------- -->
					<!-- 대댓글쓰기 textarea 시작 -->
 				<div class="recomment_writing">
					<input type="hidden" class="recomment_writer" value="${member_id}">
					<input type="hidden" class="recomment_board_id" value="${detaildto.board_id}">
					<input type="hidden" class="recomment_parent_id" value="${dto.comment_id}">
					<textarea class="recomment_writing_area" ></textarea><br>
					<img class="recomment_img_preview" src="" />
					<div class="recomment_bottom_btns">
						<div class="recomment_img_upload">
							 <label> 
								 <img class='recomment_fileimg' src="/img/gallery_icon.png" alt="이미지아이콘" style="width : 20px; height = 20px;" />
							 </label> 
			  				 <input type="file" class="recomment_file" />
		  				 </div>
						<div class="recomment_bottom_right">					
							<div class="recomment_secret_checkDiv">
								<!-- <input type="checkbox" class="recomment_secret" value="secret">비밀 -->
							</div>
							<input type="submit" class="recomment_submit_btn" value="등록">
						</div>
					</div>
				</div><!-- 대댓글쓰기 textarea 끝 -->
				
			<!-- 대댓글 수정 textarea 시작 -->
 				<div class="comment_updateWritingDiv">
					<input type="hidden" class="comment_update_comment_id" value="${dto.comment_id}">
					<input type="hidden" class="comment_update_writer" value="${dto.comment_writer}">
					<input type="hidden" class="comment_update_board_id" value="${dto.board_id}">
					<textarea class="comment_update_writing_area" >${dto.comment_contents}</textarea><br>
					<c:choose>
					 	<c:when test="${dto.comment_imgurl != null}">
							<img class="comment_update_img_preview" src="${dto.comment_imgurl }" style="display : block;" />
					 	</c:when>
					 	<c:otherwise>
							<img class="comment_update_img_preview" src="" />
					 	</c:otherwise>
					</c:choose> 
					<div class="comment_update_bottom_btns">
						<div class="comment_update_img_upload">
							 <label> 
								 <img class='comment_update_fileimg' src="/img/gallery_icon.png" alt="이미지아이콘" style="width : 20px; height = 20px;" />
							 </label> 
			  				 <input type="file" class="comment_update_file" />
		  				 </div>
						<div class="comment_update_bottom_right">					
							<div class="comment_update_secret_checkDiv">
								<%-- <c:choose>
								 	<c:when test="${dto.comment_secret}">
										<input type="checkbox" class="comment_update_secret" value="secret" checked="checked">비밀
								 	</c:when>
								 	<c:otherwise>
										<input type="checkbox" class="comment_update_secret" value="secret">비밀
								 	</c:otherwise>
								</c:choose>  --%>
							</div>
							<input type="submit" class="comment_update_submit_btn" value="수정">
						</div>
					</div>
				</div><!-- 댓글 수정 textarea 끝 -->
							
					</div><!-- one_recomment end -->
					</c:if>				
				</c:forEach>
				
			</div>
		</div>
	
	<!-- pagination -->
	<div id="board_pagingNum">
         <c:if test="${fn:length(response.list) != 0}">
            <div class="pagefirst"
               <c:if test="${!response.pagination.existPrevPage}"> style="visibility: hidden;" </c:if>>
               <input type="button" class="photoPageBtn" id="photoBoardPageBtnFirst" value="◁◁">
            </div>
            <div class="prev" id="${response.pagination.startPage-1}"
               <c:if test="${!response.pagination.existPrevPage}"> style="visibility: hidden;" </c:if>>
               <input type="button" class="photoPageBtn" id="photoBoardPageBtnPre" value="◁">
            </div>

            <c:forEach begin="${response.pagination.startPage}"
               end="${response.pagination.endPage}" varStatus="vs">
               <c:if test="${vs.index == searchdto.page}">
	               <input type="button" class="photoPageNumBtn" value="${vs.index}" style="font-weight: 900">
               </c:if>
               <c:if test="${vs.index != searchdto.page}">
	               <input type="button" class="photoPageNumBtn" value="${vs.index}" style="font-weight: 300; color: #555">
               </c:if>
            </c:forEach>

            <div class="next" id="${response.pagination.startPage+10}"
               <c:if test="${!response.pagination.existNextPage}"> style="visibility: hidden;" </c:if>>
               <input type="button" class="photoPageBtn" id="photoBoardPageBtnNext" value="▷">
            </div>
            <div class="pagelast" id="${response.pagination.totalPageCount}"
               <c:if test="${!response.pagination.existNextPage}"> style="visibility: hidden;" </c:if>>
               <input type="button" class="photoPageBtn" id="photoBoardPageBtnLast" value="▷▷">
            </div>
         </c:if>
      </div>
      <!-- pagination -->
	
	<form action="commentwrite" method="get" id="comment_form">
		<div id="comment_writing">
			<input type="hidden" id="comment_writer" name="comment_writer" value="${member_id}">
			<input type="hidden" id="board_id" name="board_id" value="${detaildto.board_id}">
			<textarea id="writing_area" name="comment_contents"></textarea><br>
			<img id="comment_img_preview" src="" />
			<div id="bottom_btns">
				<div id="comment_img_upload">
					 <label for="comment_file"> 
						 <img id='fileimg' src="/img/gallery_icon.png" alt="이미지아이콘" style="width : 20px; height = 20px;" />
					 </label> 
	  				 <input type="file" id="comment_file" />
  				 </div>
				<div id="bottom_right">					
					<div id="secret_checkDiv"><!-- <input type="checkbox" id="comment_secret" name="comment_secret" value="secret">비밀 --></div>
					<input type="submit" id="comment_submit_btn" value="등록">
				</div>
			</div>
		</div>
	</form>
	
	</div><!-- board_page end -->

</div>
</div>

</body>
</html>