<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	//댓글 페이지 버튼 눌렀을때 해당페이지 보여주기 + 댓글 부분만 로드되도록
/* 	$(".pageNumBtn").on('click', function(){
		$('#oneboard_comments').load('/boarddetail?board_id=1&page='+$(this).val()+' #oneboard_comments');
	});//pageNumBtn클릭 */
	
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

 		 if(comment.value.trim() !== "" && $('#comment_writer').val() != "" ){
  			$.ajax({
 				url : 'commentwrite',
 				type : 'post',
 				data : {
 					'comment_writer' : $('#comment_writer').val(),
 					'board_id' : $('#board_id').val(),
 					'comment_contents' : $('#writing_area').val(),
 					'comment_secret' : $("#comment_secret").is(":checked")
 				},
 				success : function(response){ 
 					if(response > 0) {
 						comment.value =''; //입력칸 초기화
 						$("#comment_secret").prop('checked', false); //체크박스 초기화
 						$("#comment_img_preview").attr("src", ""); //첨부된사진 미리보기 없애기
 			 	      	$("#comment_img_preview").css("display","none"); //첨부된사진 미리보기 없애기
 						$('#oneboard_comments').load('/boarddetail?board_id=1 #oneboard_comments');//댓글div부분만 새로고침
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


	//댓글마다 ... 버튼 누르면 수정,삭제 / 신고버튼 나오게
 	$(".comment_btns_open").on('click', function(){
 		const commentWriter = $(this).parent(".comment_btnbox").attr('id');	
 		let status1 = $(this).next(".comment_btns_parentDiv").css('display');
		let status2 = $(this).nextAll(".comment_blameBtn_parentDiv").css('display');					 		
		if("${member_id}" == commentWriter) { //로그인 id와 댓글작성자가 같을때만 버튼 출력
			if(status1 == 'none')  {
				$(this).next(".comment_btns_parentDiv").css('display','block');				
			}
		 	else {
				$(this).next(".comment_btns_parentDiv").css('display','none');	
		 	}
 		}
 		else {
 			if(status2 == 'none') {
				$(this).nextAll(".comment_blameBtn_parentDiv").css('display','block');					 		 				
 			}
 			else { 				
				$(this).nextAll(".comment_blameBtn_parentDiv").css('display','none');					 		
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
			$(this).parents().siblings(".recomment_writing").css('display','block');
		} else {
			$(this).parents().siblings(".recomment_writing").css('display','none');			
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
				$(this).next("#board_btns_parentDiv").css('display','block');				
			}
		 	else {
				$(this).next("#board_btns_parentDiv").css('display','none');	
		 	}
 		}
 		else { //로그인 id가 글 작성자와 다를때 신고 버튼 출력
 			if(Bstatus2 == 'none') {
				$(this).nextAll("#board_blameBtn_parentDiv").css('display','block');					 		 				
 			}
 			else { 				
				$(this).nextAll("#board_blameBtn_parentDiv").css('display','none');					 		
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
	 					location.href = document.referrer;
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
					<hr>
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
					<div id="oneboard_writer">${detaildto.writer}</div>
			</div>
			<div class="info" id="view_cnt">조회 ${detaildto.view_cnt}</div>
			<div class="info" id="writingtime">${detaildto.writing_time}</div>
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
			
			<c:forEach items="${commentList}" var="dto" varStatus="status">
				<c:if test="${dto.parent_id == 0}">
					<div class="one_comment">
					
						<div class="comment_upper">
							<div class="comment_profile">
								<div class="comment_profileImg"><img src="${commentWriterProfileMap[dto.comment_writer] }"></div>
								<div class="comment_info">
									<div class="comment_writer">${dto.comment_writer}</div>
									<div class="comment_writingtime">${dto.comment_time}</div>
								</div>	
							</div>
						
 						<div class="comment_btnbox" id="${dto.comment_writer}"> 							
							<input type="button" class="writeRecommentBtn" value="답글" />
							<input type="button" class="comment_btns_open" id="${dto.comment_id}" value="···" />
							<div class="comment_btns_parentDiv" >
								<input type="button" class="comment_update_btn" value="수정" />
								<hr>
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

		
 				<div class="recomment_writing">
					<input type="hidden" class="recomment_writer" name="comment_writer" value="${member_id}">
					<input type="hidden" class="board_id" name="board_id" value="${detaildto.board_id}">
					<input type="hidden" class="parent_id" name="parent_id" value="${dto.comment_id}">
		
					<textarea class="recomment_writing_area" name="comment_contents"></textarea><br>
					<img class="recomment_img_preview" src="" />
					<div class="recomment_bottom_btns">
						<div class="recomment_img_upload">
							 <label> 
								 <img class='recomment_fileimg' src="/img/gallery_icon.png" alt="이미지아이콘" style="width : 20px; height = 20px;" />
							 </label> 
			  				 <input type="file" class="recomment_file" />
		  				 </div>
						<div class="recomment_bottom_right">					
							<div style="font-size:15px; margin-right : 5px;"><input type="checkbox" class="recomment_secret" name="comment_secret" value="secret">비밀</div>
							<input type="submit" class="recomment_submit_btn" value="등록">
						</div>
					</div>
				</div>
	
				</div><!-- one_comment end -->
					
				<!-- 대댓글 출력 시작 -->
				</c:if>
				<c:forEach items="${commentList}" var="dto_re" varStatus="status">
					<c:if test="${dto_re.parent_id != 0 && dto_re.parent_id == dto.comment_id}">
						<div class="one_recomment">	
						
						<div class="recomment_upper">
											
							<div class="recomment_profile">
								&nbsp;&nbsp;└&nbsp;&nbsp;&nbsp; 
								<div class="recomment_profileImg"><img src="${commentWriterProfileMap[dto_re.comment_writer] }"></div>
								<div class="recomment_info">
									<div class="recomment_writer">${dto_re.comment_writer}</div>
									<div class="recomment_writingtime">${dto_re.comment_time}</div>
								</div>
							</div>
							
							<div class="comment_btnbox" id="${dto_re.comment_writer}"> 							
								<input type="button" class="writeRecommentBtn" value="답글" />
								<input type="button" class="comment_btns_open" id="${dto_re.comment_id}" value="···" />
								<div class="comment_btns_parentDiv" >
									<input type="button" class="comment_update_btn" value="수정" />
									<hr>
									<input type="button" class="comment_delete_btn" value="삭제" />
								</div>
								<div class="comment_blameBtn_parentDiv">
									<input type="button" class="comment_blame_btn" value="신고" />
								</div>
							</div>

						</div>	<!-- Recomment_upper -->
						
							<div class="recomment_content">${dto_re.comment_contents}
								<c:if test="${dto_re.comment_imgurl != null}">
									<br><img class="comment_img" src="${dto_re.comment_imgurl}">
								</c:if>
							</div>
						</div>
					</c:if>				
				</c:forEach>
			</c:forEach>
				
			</div>
		</div>
	<div id="board_pagingNum">
		<input type="button" class="pageBtn" id="pageBtnFirst" value="◁◁">
		<input type="button" class="pageBtn" id="pageBtnPre" value="◁">
		<%
				int commentCnt = (Integer)request.getAttribute("commentCnt");
				int totalPage = 0;
				if(commentCnt % 20 == 0){
					totalPage = commentCnt/ 20;
				}
				else {
					totalPage = commentCnt / 20 + 1;
				}
				for(int i = 1; i <= totalPage; i++){
			%>
					<input type="button" class="pageNumBtn" id="<%=i %>page" value="<%=i %>">
			<%		
				}
			%>

		<input type="button" class="pageBtn" id="pageBtnNext" value="▷">
		<input type="button" class="pageBtn" id="pageBtnLast" value="▷▷">
	</div>
	
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
					<div style="font-size:15px; margin-right : 5px;"><input type="checkbox" id="comment_secret" name="comment_secret" value="secret">비밀</div>
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