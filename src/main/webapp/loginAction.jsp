<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.chs.user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
// 요청된 문자 인코딩을 UTF-8로 설정
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="user" class="com.chs.user.UserBean" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPW" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>JSP게시판 웹 사이트</title>

</head>
<body>

	<%
	// 세션에서 사용자 ID 가져오기
	String userID = null;

	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	// 이미 로그인된 사용자가 접속 시도 시 메인 페이지로 리다이렉트
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('すでにログインされています。')");
		script.println("location.href = 'main.jsp'"); //메인 페이지로 리다이렉트
		script.println("</script>");
	}

	// UserDAO를 사용하여 로그인 시도
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPW());
	if (result == 1) {
		// 로그인 성공 시 세션에 userID 저장 후 메인 페이지로 리다이렉트
		session.setAttribute("userID", user.getUserID());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	} else if (result == 0) {
		// 비밀번호 오류 시 경고 메시지와 함께 이전 페이지로
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('パスワードが間違っています。')");
		script.println("history.back()"); //이전 페이지로 리다이렉트
		script.println("</script>");
	} else if (result == -1) {
		// ID가 존재하지 않을 때 경고 메시지와 함께 이전 페이지로
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('IDが存在しません。')");
		script.println("history.back()"); //이전 페이지로 리다이렉트
		script.println("</script>");
	} else if (result == -2) {
		// 데이터베이스 오류 발생 시 경고 메시지와 함께 이전 페이지로
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('DBエラー発生')");
		script.println("history.back()"); //이전 페이지로 리다이렉트
		script.println("</script>");
	}
	%>


</body>
</html>
