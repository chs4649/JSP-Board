<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.chs.bbs.BbsDAO"%>
<%@ page import="com.chs.bbs.BbsBean"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@100..900&display=swap"
	rel="stylesheet">

<!-- Bootstrap CSS 파일 링크 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<!-- jQuery 스크립트 파일 링크 -->
<script src="https://code.jquery.com/jquery-3.7.1.slim.js"
	integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc="
	crossorigin="anonymous"></script>

<title>JSP掲示板ウェブサイト</title>
<style>
a {
	color: black;
	text-decoration: none;
}

body {
	font-family: 'Noto Sans JP', sans-serif;
}
</style>
</head>
<body style="padding-top: 100px;">
	<!-- 상단 네비게이션 바와 본문 사이의 여백 설정 -->

	<%
	// 세션에서 사용자 ID 가져오기
	String userID = null;

	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	// 요청 파라미터에서 페이지 번호 가져오기, 기본값은 1
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>

	<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
		<!-- 네비게이션 바 상단 고정 -->
		<div class="container-fluid">
			<a class="navbar-brand" href="main.jsp">JSP掲示板ウェブサイト</a>
			<div class="d-flex">
				<a class="nav-link me-3" href="main.jsp">メイン</a> <a class="nav-link"
					href="bbs.jsp">掲示板</a>
			</div>
			<!-- 로그인 상태에 따라 다른 드롭다운 메뉴 표시 -->
			<%
			if (userID == null) {
			%>
			<div class="ms-auto">
				<a class="nav-link dropdown-toggle" href="#"
					id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown"
					aria-expanded="false"> アクセス </a>
				<ul class="dropdown-menu dropdown-menu-end"
					aria-labelledby="navbarDropdownMenuLink">
					<!-- 로그인 및 회원가입 링크 포함된 드롭다운 메뉴 -->
					<li><a class="dropdown-item" href="login.jsp">ログイン</a></li>
					<li><a class="dropdown-item" href="join.jsp">ユーザー登録</a></li>
				</ul>
			</div>
			<%
			} else {
			%>
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

			<%
			}
			%>
		</div>
	</nav>

	<div class="container">
		<div class="row">
			<!-- 테이블의 각 행이 홀수와 짝수로 색이 다르게 표현되도록 설정 -->
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">番号</th>
						<th style="background-color: #eeeeee; text-align: center;">タイトル</th>
						<th style="background-color: #eeeeee; text-align: center;">作成者</th>
						<th style="background-color: #eeeeee; text-align: center;">作成日</th>
					</tr>
				</thead>

				<tbody>
					<%
					// 페이지 번호에 따라 게시글 목록 가져오기
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<BbsBean> list = bbsDAO.getList(pageNumber);
					for (BbsBean bbs : list) {
					%>
					<tr>
						<td><%=bbs.getBbsID()%></td>
						<td><a href="bbsView.jsp?bbsID=<%=bbs.getBbsID()%>"><%=bbs.getBbsTitle()%></a></td>
						<td><%=bbs.getUserID()%></td>
						<td><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "時 "
		+ bbs.getBbsDate().substring(14, 16) + "分"%></td>
					</tr>
					<%
					}
					%>
				</tbody>

			</table>
			<div style="display: flex; justify-content: space-between;">
				<div>
					<%
					if (pageNumber != 1) {
					%>
					<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>"
						class="btn btn-success btn-arrow-left" style="width: 50px;">次</a>
					<%
					}
					if (bbsDAO.nextPage(pageNumber + 1)) {
					%>
					<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>"
						class="btn btn-success btn-arrow-right"
						style="width: 50px; margin-left: 10px;">前</a>
					<%
					}
					%>
				</div>
				<!-- 글쓰기 버튼 -->
				<%
				if (userID != null) {
				%>
				<div>
					<a href="write.jsp" class="btn btn-primary" id="need-to-login">投稿</a>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS 번들 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>


