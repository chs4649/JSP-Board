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
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>JSP掲示板ウェブサイト</title>

</head>
<body>

	<%
	// 세션에서 사용자 ID를 가져옴
	String userID = null;

	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	// 이미 로그인된 사용자가 회원가입 시도 시 메인 페이지로 리다이렉트
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('すでにログインされています。')");
		script.println("location.href = 'main.jsp'"); //메인 페이지로 리다이렉트
		script.println("</script>");
	}

	// 필수 입력 항목이 비어있는 경우 경고 메시지와 함께 이전 페이지로
	if (user.getUserID() == null || user.getUserPW() == null || user.getUserName() == null
			|| user.getUserGender() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('入力されていない項目があります。')");
		script.println("history.back()"); //이전 페이지로 리다이렉트
		script.println("</script>");
	} else {
		// UserDAO를 사용하여 데이터베이스에 사용자 정보를 저장
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
		// ID 중복 등으로 인한 오류 처리
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('すでに存在するIDです。')");
			script.println("history.back()"); //이전 페이지로 리다이렉트
			script.println("</script>");
		} else { // 회원가입 성공 시 메인 페이지로 리다이렉트
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
	}
	%>


</body>
</html>
