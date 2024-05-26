<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.chs.bbs.BbsDAO"%>
<%@ page import="com.chs.bbs.BbsBean"%>
<%@ page import="java.io.PrintWriter"%>
<%
// 요청된 문자 인코딩을 UTF-8로 설정합니다.
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>JSP掲示板ウェブサイト</title>

</head>
<body>

	<%
	// 세션에서 사용자 ID를 가져옵니다.
	String userID = null;

	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	// 로그인하지 않은 사용자가 접근 시 로그인 페이지로 리다이렉트합니다.
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('ログインが必要です。')");
		script.println("location.href = 'login.jsp'"); //로그인 페이지로 리다이렉트
		script.println("</script>");
	}
	// 요청 파라미터에서 게시글 ID를 가져옵니다.
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	// 게시글 ID가 0이면 유효하지 않은 ID입니다.
	if (bbsID == 0) {
		// 유효하지 않은 게시글 ID라는 경고 메시지를 출력하고 게시판 페이지로 리다이렉트합니다.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('有効ではありません。');");
		script.println("location.href='bbs.jsp';");
		script.println("</script>");
	}
	// 게시글 ID를 사용하여 게시글 정보를 가져옵니다.
	BbsBean bbsBean = new BbsDAO().getBbs(bbsID);
	// 현재 로그인한 사용자 ID와 게시글 작성자 ID가 다르면 권한이 없다는 메시지를 출력합니다.
	if (!userID.equals(bbsBean.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('権限がありません。');");
		script.println("location.href='bbs.jsp';");
		script.println("</script>");
	} else {

		// 제목이나 내용이 입력되지 않았을 경우 이전 페이지로 리다이렉트합니다.
		if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
		|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('入力されていない項目があります。')");
			script.println("history.back()"); //이전 페이지로 리다이렉트
			script.println("</script>");
		} else {

			// BbsDAO를 사용하여 게시글 수정 시도합니다.
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));

			// 게시글 작성 실패 시 이전 페이지로 리다이렉트합니다.
			if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('修正に失敗しました。')");
		script.println("history.back()"); //이전 페이지로 리다이렉트
		script.println("</script>");

			} else { // 게시글 작성 성공 시 게시판 페이지로 리다이렉트합니다.
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
