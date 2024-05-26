<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>JSP掲示板ウェブサイト</title>

</head>
<body>

	<%
	session.invalidate(); // 세션 종료
	response.sendRedirect("main.jsp"); // 메인 페이지로 리다이렉트
	%>

</body>
</html>
