$(document).ready(function(){	
	
	let board = "/myPage2"; // 글 or 사진 게시판
	let ctgy = "?ctgy="; // 게시판 카테고리
	
	// 게시판 소분류 클릭시 동작
	$("li.innerMenu").on("click", function(e) {
		
		ctgy = "?ctgy=" + $(this).text().trim();
		
		window.location.href = board + ctgy;
		e.stopPropagation();
	}); 
	
	$("#deleteclick").click(function(){
		
		var confirmmember=confirm("자신이 작성한 모든글이 다 삭제될예정입니다. 회원탈퇴하시겠습니까?");
		if(confirmmember){
			alert("회원탈퇴가 완료되었습니다.이용해주셔서 감사합니다.");
			location.href="/deletemember";
		}
	});
});
