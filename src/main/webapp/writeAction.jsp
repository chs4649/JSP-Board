<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.chs.bbs.BbsDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
// 요청된 문자 인코딩을 UTF-8로 설정
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="bbs" class="com.chs.bbs.BbsBean" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>JSP掲示板ウェブサイト</title>

</head>
<body>

	<%
	// 세션에서 사용자 ID 가져오기
	String userID = null;

	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	// 로그인하지 않은 사용자가 접근 시 로그인 페이지로 리다이렉트
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('ログインが必要です。')");
		script.println("location.href = 'login.jsp'"); //로그인 페이지로 리다이렉트
		script.println("</script>");

	} else {

		// 제목이나 내용이 입력되지 않았을 경우 이전 페이지로 리다이렉트
		if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('入力されていない項目があります。')");
			script.println("history.back()"); //이전 페이지로 리다이렉트
			script.println("</script>");
		} else {
			// BbsDAO를 사용하여 게시글 작성 시도
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			// 게시글 작성 실패 시 이전 페이지로 리다이렉트
			if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('投稿に失敗しました。')");
		script.println("history.back()"); //이전 페이지로 리다이렉트
		script.println("</script>");
			} else { // 게시글 작성 성공 시 게시판 페이지로 리다이렉트
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");

			}

		}

	}
	%>


</body>
</html>
