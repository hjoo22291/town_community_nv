<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<style>
@font-face {
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

* {
font-family : 'GmarketSansMedium';
font-size : 14px;
}

html, body {
	margin: 0px;
	padding: 0px;
	background-color: #E3E2E0;
	align-content: center;
}

header {
	height: 50px;
	line-height: 50px;
	background-color: #182434;
	color: white;
	text-align: center;
}
p {
font-size : 15px;
font-weight : bold;
}
textarea {
resize: none;
}
#form-wrap{
margin-left : 10px;

}
#btn-wrap{
width : 100%;
margin-left : 0px;
}
#report_submitBtn{
width : 520px; height : 40px;
margin-top : 10px;
}
#report_submitBtn:hover {
	background-color : #182434;
	color : white;			
}
</style>
<script>
$(document).ready(function(){
	$("#report_submitBtn").on('click', function(e){
		e.preventDefault();
 		let isChecked = $("input:radio[name=report_reason]").is(":checked");
  		if(isChecked){
  			let report_reason = $('input:radio[name="report_reason"]:checked').val();
  			let report_detail = $("#report_detail").val();

  			$.ajax({
 				url : 'reportBoard',
 				type : 'post',
 				data : {
 					'board_id' : "${dto.board_id }",
 					'reported_member_id' : "${dto.writer }",
 					'reported_contents' : "${dto.board_title }",
 					'reporter' : "${member_id }",
 					'report_reason' : report_reason,
 					'report_detail' : report_detail
 				},
 				success : function(response){ 
 					if(response > 0) {
 			  			alert("신고가 접수되었습니다.");
 			  			opener.location.reload();
 			  			window.close();
 					}
 				}, 
 				error : function(request, status, e) {
 					alert("코드=" + request.status + "\n" + "메시지=" + request.responseText + "\n" + "error=" + e); 
 				}
 			});//ajax
 		}
 		else {
 			alert("신고 사유를 선택해주세요.");
 		} 	 	
	});//신고하기 클릭
	
	
});
</script>
</head>
<body>
<header>신고하기</header>
<div id="form-wrap">
	<br>
	<div id="writer">작성자  | ${dto.writer}</div>
	<div id="contents"> 제목/내용  | ${dto.board_title }</div>
	<p>신고하시는 사유를 선택해주세요.</p>
	<form action="reportBoard" id="reportBoard" method="post">
		<div>
		<input type="radio" name="report_reason" value="스팸/홍보/도배">스팸/홍보/도배글입니다.<br>
		<input type="radio" name="report_reason" value="음란물">음란물입니다.<br>
		<input type="radio" name="report_reason" value="불법정보">불법정보를 포함하고 있습니다.<br>
		<input type="radio" name="report_reason" value="청소년유해">청소년에게 유해한 내용입니다.<br>
		<input type="radio" name="report_reason" value="욕설/생명경시/혐오/차별">욕설/생명경시/혐오/차별적 표현입니다.<br>
		<input type="radio" name="report_reason" value="개인정보노출">개인정보 노출 게시물입니다.<br>
		<input type="radio" name="report_reason" value="기타">기타<br>
		</div>
		<p>신고하시는 이유를 알려주세요.</p>
		<textarea id="report_detail" name="report_detail" rows="5" cols="55" placeholder="신고 사유를 구체적으로 작성해주세요.(선택사항)"></textarea>
		<br>
		<div id="btn-wrap"><input type="button" id="report_submitBtn" value="등록하기" /></div>
	</form>
</div>
</body>
</html>