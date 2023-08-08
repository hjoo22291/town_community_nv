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
	let msg =  "<%=session.getAttribute("msg")%>";
	let url =  "<%=session.getAttribute("url")%>";
	alert(msg);
	location.href = url;
    
    </script>
</head>
<body>


</body>
</html>