<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
<%-- 	let member_id = "<%=session.getAttribute("member_id")%>"; --%>
	let msg =  "<%=session.getAttribute("date")%>";
	let url =  "<%=session.getAttribute("url")%>";
	alert("회원님은 "+msg+" 까지 정지된 회원입니다");
	location.href = url;
    
    </script>
</head>
<body>


</body>
</html>