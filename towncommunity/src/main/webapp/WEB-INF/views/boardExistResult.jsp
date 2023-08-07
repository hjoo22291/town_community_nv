<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function(){
	if ("${boardCnt}" > 0) { //존재하는 글이면
		location.href = "/boarddetail?bi="+ "${bi}";
	}
	else {
		alert("존재하지 않는 글입니다.");
		location.href = "/main";
	}
	
});
</script>
</head>
<body>
</body>
</html>