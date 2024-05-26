<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.chs.bbs.BbsDAO"%>
<%@ page import="com.chs.bbs.BbsBean"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@100..900&display=swap" rel="stylesheet">

<!-- Bootstrap CSS 파일 링크 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<!-- jQuery 스크립트 파일 링크 -->
<script src="https://code.jquery.com/jquery-3.7.1.slim.js"
	integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc="
	crossorigin="anonymous"></script>

	<style>
	body {
		font-family: 'Noto Sans JP', sans-serif;
	}
	</style>

<title>JSP掲示板ウェブサイト</title>

</head>
<body style="padding-top: 100px;">
	<!-- body와 nav 사이의 간격을 조정 -->

	<%
	// 세션에서 사용자 ID를 가져옵니다.
	String userID = null;

	// 세션에 "userID" 속성이 존재하면 userID 변수에 할당합니다.
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	// userID가 null이면 로그인이 되어있지 않은 상태입니다.
	if (userID == null) {
		// 로그인이 필요하다는 경고 메시지를 출력하고 로그인 페이지로 리다이렉트합니다.
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('ログインが必要です。');");
		script.println("location.href='login.jsp';");
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
	}
	%>

	<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
		<!-- 네비게이션 바를 상단 고정 -->
		<div class="container-fluid">
			<a class="navbar-brand" href="main.jsp">JSP掲示板ウェブサイト</a>
			<div class="d-flex">
				<a class="nav-link me-3" href="main.jsp">メイン</a> <a class="nav-link"
					href="bbs.jsp">掲示板</a>
			</div>

			<div class="ms-auto">
				<a class="nav-link dropdown-toggle" href="#"
					id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown"
					aria-expanded="false"> ユーザー管理 </a>
				<ul class="dropdown-menu dropdown-menu-end"
					aria-labelledby="navbarDropdownMenuLink">
					<!-- 로그아웃 링크 포함된 드롭다운 메뉴 -->
					<li><a class="dropdown-item" href="logoutAction.jsp">ログアウト</a></li>
				</ul>
			</div>

		</div>
	</nav>

	<div class="container">
		<div class="row">
			<form action="updateAction.jsp?bbsID=<%=bbsID%>" method="post">
				<%-- table-striped : 목록 홀수 짝수 색 다르게 표현 --%>
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd;">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">掲示板
								投稿修正</th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td><input type="text" name="bbsTitle" id="Title"
								class="form-control" placeholder="タイトルを入力してください。" maxlength="50" value="<%=bbsBean.getBbsTitle()%>"></td>
						</tr>
						<tr>
							<td><textarea name="bbsContent" id="Content"
									class="form-control" placeholder="内容を入力してください。"
									maxlength="2048" style="height: 350px;"><%=bbsBean.getBbsContent()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<div class="d-flex justify-content-between">
					<a href="bbs.jsp" class="btn btn-primary me-2" >戻る</a>
					<input type="submit" class="btn btn-primary" value="投稿修正">
				</div>
			</form>
		</div>
	</div>

	<!-- Bootstrap JS 파일 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
