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
				<c:forEach items="${members}" var="member">
    <tr>
        <td>${member.member_id}</td>
        <td>${member.email}</td>
        <td>${member.signup_date_str}</td>
        <td>${member.stopclear_date_str}</td>
        <td>${member.report_count}</td>
        <!-- member_id를 데이터 속성으로 추가 -->
        <td><button class="unban_btn" data-member_id="${member.member_id}">정지해제</button></td>
        <td><button class="adjust_btn" data-member_id="${member.member_id}">정지일감소</button></td>
    </tr>
</c:forEach>
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



$("#pagination input:button").on("click", function(e) {
	let url = document.location.href;
	if (url.indexOf("?") === -1) {
		url += "?";
	} else {
		url += "&";
	}
	let pageIndex = url.indexOf("page=");
	if (pageIndex > -1) {
		url = url.substr(0, pageIndex);
	}
	let pageval = $(this).val();
	let page = "page=1";
	if (pageval === "◁◁") {
		page = "page=1";
	} else if (pageval === "◁") {
		page = "page=${startPageNum - 10}";
	} else if (pageval === "▷") {	
		page = "page=${endPageNum + 1}";
	} else if (pageval === "▷▷") {
		page = "page=${totalPageCnt}";
	} else if (pageval <= parseInt("${totalPageCnt}") && pageval >= 1) {
		page = "page=" + pageval;
	}
	window.location.href = url + page;
});

function loadMembers(pageNum) {
	
	var rowsPerPage = 20;
    currentPage = pageNum; 
    $('#board-table tbody').empty();
    $.ajax({
        url: "/members",
        type: 'POST',
        dataType: 'json',
        data: {
            
        },
        success: function(response) {
            
            // members 정보 처리
            var members = response.members;
            if (Array.isArray(members)) {
                members.forEach(function(member) {
                    var row = $('<tr>');
                    row.append($('<td>').text(member.member_id));    // 아이디
                    row.append($('<td>').text(member.email));       // 이메일

                    
                    row.append($('<td>').text(member.signup_date_str));
                   

                    
                    row.append($('<td>').text(member.stopclear_date_str));

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


$(document).on('click', '.unban_btn', function() {
    var memberId = $(this).attr('data-member_id');
    unbanMember(memberId);
    
});

$(document).on('click', '.adjust_btn', function() {
    var memberId = $(this).attr('data-member_id');
    adjustBanDate(memberId);
    
});
function unbanMember(memberId) {
    $.ajax({
        url: "/unban/" + memberId,
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
        url: "/adjustBanDate/" + memberId,
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