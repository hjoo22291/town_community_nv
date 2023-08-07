<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/BoardCommon.css" />
<Style>
#top_btnBox{
	width : 97%;
	display : flex;
	justify-content:flex-end;
	margin-bottom : 5px;
}
#writeBtn {
	width:70px; height : 35px;
	font-size : 13px;
	border : 1px solid #8D98AA;
	border-radius : 3px;
	background-color : transparent;	
	cursor: pointer;
}
#writeBtn:hover {
	background-color : #6D829B;
	color : white;			
} 
.one_board {
	width : 210px; height : 250px;
	margin-right : 20px;
	margin-bottom : 25px;
	cursor: pointer;
	border-bottom: 1px solid gray;
}
.one_photo {
	width : 210px; height : 150px;
 	> img {border : 1px solid #E3E2E0; }
}
.one_reaction {
	width : 210px; height : 30px;
	display : flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
}
.reaction1 {
	display : flex; 
	align-items: center;
	width : auto; height : 25px;
}
.reaction2 {
	display : flex; 
	align-items: center;
	width : auto; height : 25px;
}
.one_contents {
	width : 210px; height : 50px;
}
.one_writingTime {
	width : 210px;
	text-align: right;
	font-size : 10px;
	color : gray;
}
#board_search_box {
	width : 100%;
	/* border : 1px solid black; */
	text-align: center;
	margin-top : 10px;
	
	#board_search_btn {
		font-size : 15px;
		margin : 0.5px;
		border : none;
		background-color: transparent;
		cursor: pointer;
	}
}

</Style>
<script>
$(document).ready(function(){
	//페이지 버튼 눌렀을때 해당페이지 보여주기
	$(".photoPageNumBtn").on('click', function(){
		let boardName = "${boardName}";
		let townId = "${town_id}";
		let pageNumber = $(this).val();
		 $.ajax({
			url : 'photoBoard2',
			type : 'post',
			data : {
				'ctgy' : boardName,
				'ti' : townId,
				'page' : pageNumber
			},
			success : function(response){ 
				location.href = "/photoBoard2?ctgy="+boardName+"&ti="+townId+"&page="+pageNumber;
			}, 
			error : function(request, status, e) {
				alert("메시지=" + request.responseText + "\n" + "error=" + e); 
			}
			
		});//ajax
	});//pageNumBtn클릭
	
	//글 누르면 해당 글 상세페이지로 이동
	$(".one_board").on('click', function(){
		const boardId = $(this).attr('id');
		location.href = "/photoboarddetail?board_id="+boardId;

	});//글 1개 조회
		
	
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
	<div id="top_btnBox"><input type="button" id="writeBtn" value="글쓰기"></div>
	
	<div id="board_page">
	
		<c:forEach items="${boardList}" var="dto" varStatus="status">
				<div class="one_board" id="${dto.board_id }">
					<div class="one_photo">
						<img class="one_photo" src="${dto.board_imgurl }">
					</div>
					<div class="one_reaction">
						<div class="reaction1">
							<img class="reaction1" src="/img/Love.svg">					
							<div class="reaction1" style="color : red;">${dto.good_cnt }</div>					
						</div>
						<div class="reaction2">
							<img class="reaction2" src="/img/Chat Bubble.svg">
							<div class="reaction2">120</div>
						</div>
					</div>
					<div class="one_contents">
						${dto.board_title }
					</div>
 					<div class="one_writingTime">
							<!-- 오늘 날짜랑 같으면 시간만 출력, 날짜 다르면 년월일 출력 -->
							<jsp:useBean id="now" class="java.util.Date" />
							<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate" />
							<fmt:parseDate value="${dto.writing_time}" pattern="yyyy-MM-dd HH:mm:ss" var="reg" />
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
				</div>
		</c:forEach>


	</div><!-- board_page end -->
	
	<div id="board_pagingNum"> <!--  버튼 임의로 생성. 버튼 class값은 이대로 주기(CSS class이름으로 적용) -->
		<input type="button" class="photoPageBtn" id="photoBoardPageBtnFirst" value="◁◁">
		<input type="button" class="photoPageBtn" id="photoBoardPageBtnPre" value="◁">
		<%
				int boardCnt = (Integer)request.getAttribute("boardCnt");
				int totalPage = 0;
				if(boardCnt % 30 == 0){
					totalPage = boardCnt/ 30;
				}
				else {
					totalPage = boardCnt / 30 + 1;
				}
				for(int i = 1; i <= totalPage; i++){
			%>
					<input type="button" class="photoPageNumBtn" id="<%=i %>photoBoardPage" value="<%=i %>">
			<%		
				}
			%>

		<input type="button" class="photoPageBtn" id="photoBoardPageBtnNext" value="▷">
		<input type="button" class="photoPageBtn" id="photoBoardPageBtnLast" value="▷▷">
	</div>
	
	<!-- 검색창 -->
	<div id="board_search_box">
		 <select name="board_search_from">
			<option value="board_all"> 전체 </option>
			<option value="board_title"> 제목 </option>
			<option value="board_contents"> 내용 </option>
			<option value="writer"> 작성자 </option>
          </select>
		<input type=text id="board_searchword" >
		<input type=hidden id="search_ctgy" value="${boardName}">
		<input type=hidden id="search_ti" value="${town_id}">
		<input type=button id="board_search_btn" value="검색">
	</div>

</div>
</div>
</body>
</html>