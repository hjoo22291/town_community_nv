<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function() {
    $("#msgInput").click(function() {
        var message = $("#messageArea").val();

        $.ajax({
            type: "POST",
            url: "/sendChat",
            data: { message: message },
            dataType: "text",
            success: function(response) {
                console.log("Message sent successfully!");
                location.reload();
                $("#messageArea").val("");
            },
            error: function(xhr, status, error) {
                console.error("Error sending message:", error);
            }
        });
    });
});
</script>
</head>
<body>
<c:forEach items="${list}" var="list">
<h2>${list.message_content }</h2>
</c:forEach>
<button onclick="document.location.href='/chatstart?touser_id=abc123'">채팅하기</button>
<textarea id="messageArea" placeholder="메세지를 입력하세요"></textarea>
<button id="msgInput">메시지 보내기</button>

<button onclick="document.location.href='/gchatstart?board_id=1'">그룹채팅하기</button>
<button onclick="document.location.href='/entergchat?board_id=1'">그룹채팅입장</button>

</body>
</html>