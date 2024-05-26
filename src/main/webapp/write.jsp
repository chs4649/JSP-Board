<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
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
<body style="padding-top: 100px;"> <!-- body와 nav 사이의 간격을 조정 -->

	<%
	// 사용자 ID를 세션에서 가져오기
	String userID = null;

	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>

	<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top"> <!-- 네비게이션 바를 상단 고정 -->
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
		<form action="writeAction.jsp" method="post">
			<%-- table-striped : 목록 홀수 짝수 색 다르게 표현 --%>
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">掲示板 投稿</th>
					</tr>
				</thead>

				<tbody>
					<tr>
						<td><input type="text" name="bbsTitle" id="Title" class="form-control" placeholder="タイトルを入力してください。" maxlength="50"></td>
					</tr>
					<tr>
						<td><textarea name="bbsContent" id="Content" class="form-control" placeholder="内容を入力してください。" maxlength="2048"
						style="height: 350px;"></textarea></td>
					</tr>
				</tbody>
			</table>
			<div class="d-flex justify-content-between">
			<a href="bbs.jsp" class="btn btn-primary me-2" >戻る</a>
				<input type="submit" class="btn btn-primary" value="投稿">
			</div>
		</form>
		</div>
	</div>

	<!-- Bootstrap JS 파일 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
