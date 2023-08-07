<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminDashboard</title>
<link rel="stylesheet" href="/css/AdminDashboard.css" />
</head>
<body>
	<div class="Admin-dashboard1">
		<h2>관리자 대쉬보드</h2>
		<div class="dashboard-card" id="user-info">
			<i class="fas fa-users"></i>
			<h3>회원 정보 조회 및 검색</h3>
		</div>

		<div class="dashboard-card" id="account-control">
			<i class="fas fa-ban"></i>
			<h3>계정 정지 / 탈퇴 처리</h3>
		</div>

		<div class="dashboard-card" id="report-management">
			<i class="fas fa-flag"></i>
			<h3>신고 내역 관리</h3>
		</div>
	</div>

	<div class="Admin-dashboard2">
		<div class="dashboard-card2" id="statistics-report">
			<i class="fas fa-chart-bar"></i>
			<h3>통계 / 리포트</h3>
		</div>
		<div class="dashboard-card2" id="notice-management">
			<i class="fas fa-bullhorn"></i>
			<h3>공지사항 관리</h3>
		</div>
		<div class="dashboard-card2" id="feedback-management">
			<i class="fas fa-comments"></i>
			<h3>문의 / 피드백 관리</h3>
		</div>
	</div>

	<div id="modal" class="modal">
		<div class="modal-content">
			<h4 id="modal-header"></h4>
			<p id="modal-body">Modal content can go here.</p>
		</div>
	</div>

	<div class="Admin-main" id="main-content"></div>

	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script>
		$(document).ready(
				function() {
					$('.dashboard-card').click(
							function() {
								var targetModalId = $(this).data('target');
								$.ajax({
									type : 'POST',
									url : '/path/to/server/script',
									data : {
										'id' : targetModalId
									},
									success : function(data) {
										var response = JSON.parse(data);
										$('#' + targetModalId + 'Body').html(
												response.modalContent);
										$('#' + targetModalId).show();
									},
									error : function() {
										// 요청이 실패했을 때의 처리.
										alert('Error!');
									}
								});
							});
					$('#statistics-report').click(function() {
						$('#main-content').html('<p>통계와 리포트 정보를 조회합니다.</p>');
					});

					$('#notice-management').click(function() {
						$('#main-content').html('<p>공지사항을 관리합니다.</p>');
					});

					$('#feedback-management').click(function() {
						$('#main-content').html('<p>문의와 피드백을 관리합니다.</p>');
					});

					// 모달 외부 클릭시 닫힘 처리
					window.onclick = function(event) {
						if (event.target == modal) {
							modal.style.display = "none";
						}
					}
				});
	</script>
</body>
</html>
