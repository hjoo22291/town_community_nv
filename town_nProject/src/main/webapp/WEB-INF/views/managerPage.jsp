<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네일보 관리자 페이지</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="/css/BoardCommon.css" />
<link rel="stylesheet" href="/css/Mypage.css" />
<link rel="stylesheet" href="/css/Mypage2.css"> 

<script>
$(document).ready(function() {

	// page 이동 버튼 클릭시 동작
	$("#pagination input:button").on("click", function(e) {
		let url = document.location.href;
		let pageIndex = url.indexOf("&page=");
		if (pageIndex > -1) {
			url = url.substr(0, pageIndex);
		}
		let pageval = $(this).val();
		let page = "$page=1";
		if (pageval === "◁◁") {
			page = "&page=1";
		} else if (pageval === "◁") {
			page = "&page=${startPageNum - 10}";
		} else if (pageval === "▷") {	
			page = "&page=${endPageNum + 1}";
		} else if (pageval === "▷▷") {
			page = "&page=${totalPageCnt}";
		} else if (pageval <= parseInt("${totalPageCnt}") && pageval >= 1) {
			page = "&page=" + pageval;
		}
		window.location.href = url + page;
	}); //onclick
}); //ready
</script>

</head>
<body>
<jsp:include page="Header.jsp" />
<div id="myPage_layout">
	<div id="myPage_menu">
		<ul class="allMenu">
	      <li class="outerMenu">관리자 페이지</li>
			  <li class="outerMenu">
			    회원관리
			    <ul class="innerMenu">
			      <li class="innerMenu">회원정보</li>
			    </ul>
			  </li>
			  <li class="outerMenu">
			    신고관리
			    <ul class="innerMenu">
			      <li class="innerMenu">신고된 글</li>
			      <li class="innerMenu">신고된 댓글</li>
			      <li class="innerMenu">신고된 채팅</li>
			    </ul>
			  </li>		    

		</ul>
	</div>
	
	<div id="myPage_main">
		<div id="myPage_name">
			회원정보
		</div>
				<div id="board_page">
			<table id="board-table">
				<thead>
					<tr>
						<th style="width: 7%;">아이디</th>
						<th style="width: 14%;">이메일</th>
						<th style="width: 7%;">가입일</th>
						<th style="width: 14%;">정지일</th>
						<th style="width: 4%;">정지횟수</th>
						<th style="width: 5%;">정지해제</th>
						<th style="width: 6%;">정지일감소</th>
					</tr>
				</thead>
				<tbody>
						<tr>
							<td></td>
						</tr>
				</tbody>
			</table>
		</div>
		
		<div id="board_pagingNum">
			<div id="pagination">
				<c:if test="${prev}">
					<input type="button" class="pageNumBtn" value="◁◁">
					<input type="button" class="pageNumBtn" value="◁">
				</c:if>
				
				<c:forEach begin="${startPageNum}" end="${endPageNum}" var="i">
					<c:if test="${selectedPageNum != i}">
						<input type="button" class="pageNumBtn" value="${i}" style="font-weight: 300; color: #555">
					</c:if>
					<c:if test="${selectedPageNum == i}">
						<input type="button" class="pageNumBtn" value="${i}" style="font-weight: 900">
					</c:if>
				</c:forEach>
				<c:if test="${next}">
					<input type="button" class="pageNumBtn" value="▷">
					<input type="button" class="pageNumBtn" value="▷▷">
				</c:if>
			</div>
		</div>	
	</div>
</div>

<script>
var currentPage = 1;
var totalPageCnt = 1;

function formatDate(isoDateString, includeTime) {
    let date = new Date(isoDateString);
    let formattedDate = date.toISOString().split('T')[0];
    if (includeTime) {
        let time = date.toISOString().split('T')[1].slice(0, 8);
        formattedDate += '-' + time;
    }
    return formattedDate;
}


$(document).ready(function() {
    $("#myPage_name").click(function() {
        loadMembers(1);
        $("#board_page").show();  
    });
});
$(document).on("click", ".pageNumBtn", function() {
	var pageNum = $(this).val();
    if (pageNum === "◁◁") {
        pageNum = 1;
    } else if (pageNum === "◁") {
        pageNum = Math.max(1, currentPage - 1);
    } else if (pageNum === "▷") {
        pageNum = currentPage + 1;
    } else if (pageNum === "▷▷") {
        pageNum = totalPageCnt; 
    } 
    loadMembers(pageNum);
});

function loadMembers(pageNum) {
	
	var rowsPerPage = 20;
    currentPage = pageNum; //|| currentPage;
    $('#board-table tbody').empty();
    $.ajax({
        url: "/admin/members",
        type: 'POST',
        dataType: 'json',
        data: {
            'page': currentPage,
            'size': rowsPerPage
        },
        success: function(response) {
            // pagination 정보 처리
            currentPage = response.pagination.currentPage;
            totalPageCnt = response.pagination.totalPages;

            // members 정보 처리
            var members = response.members;
            if (Array.isArray(members)) {
                members.forEach(function(member) {
                    var row = $('<tr>');
                    row.append($('<td>').text(member.member_id));    // 아이디
                    row.append($('<td>').text(member.email));       // 이메일

                    // 가입일
                    var signupDate = formatDate(member.signup_date, false);
                    row.append($('<td>').text(signupDate));

                    // 정지일
                    var stopclearDate = formatDate(member.stopclear_date, true);
                    row.append($('<td>').text(stopclearDate));

                    row.append($('<td>').text(member.report_count));   // 정지횟수

                    var unbanButton = $('<button>').text('정지해제').click(function() {
                        unbanMember(member.member_id);
                    });
                    row.append($('<td>').append(unbanButton)); 
                    var adjustBanButton = $('<button>').text('정지일감소').click(function() {
                        adjustBanDate(member.member_id);
                    });
                    row.append($('<td>').append(adjustBanButton)); 
                    $('#board-table').append(row);
                });
            } 
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error("Error:", textStatus, errorThrown, jqXHR.responseText);
        }
        
    });
}
function unbanMember(memberId) {
    $.ajax({
        url: "/admin/unban/" + memberId,
        type: 'POST',
        success: function(response) {
            loadMembers();
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error(textStatus, errorThrown);
        }
    });
}
function adjustBanDate(memberId) {
    $.ajax({
        url: "/admin/adjustBanDate/" + memberId,
        type: 'POST',
        success: function(response) {
            loadMembers();
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.error(textStatus, errorThrown);
        }
    });
}
</script>
</body>
</html>