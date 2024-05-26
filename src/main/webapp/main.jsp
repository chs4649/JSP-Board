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
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@100..900&display=swap"
	rel="stylesheet">

<!-- Bootstrap CSS를 위한 링크 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<!-- jQuery 스크립트 링크 -->
<script src="https://code.jquery.com/jquery-3.7.1.slim.js"
	integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc="
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<style>
.slider img {
	width: 100%; /* 이미지의 너비를 슬라이더 컨테이너에 맞춤 */
	height: 100%; /* 이미지의 높이를 고정 */
}

.slider {
	display: flex;
	justify-content: center; /* 슬라이더의 이미지를 가운데 정렬 */
	align-items: center; /* 세로 방향으로 가운데 정렬 */
	position: relative; /* 슬라이더의 위치를 상대적으로 설정 */
	transition: transform 0.5s ease-in-out; /* 슬라이드 전환 효과를 부드럽게 */
}

body {
	font-family: 'Noto Sans JP', sans-serif;
}
</style>

<script>
	$(document).ready(function() {
		var slider = $(".slider").bxSlider({
			auto : true,
			pause : 3000,
			infiniteLoop : true,
			speed : 500, /* 슬라이드 전환 속도를 500ms로 설정 */
			hideControlOnEnd : false, /* 첫 번째 및 마지막 슬라이드에서 컨트롤 숨김 비활성화 */
			onSliderLoad : function() {
				$(document).on('click', '.bx-prev, .bx-next', function() {
					slider.stopAuto();
					slider.startAuto();
				});
			}
		});
	});
</script>

<title>JSP掲示板ウェブサイト</title>

</head>
<body>

	<%
	// 사용자 ID를 세션에서 가져오기
	String userID = null;

	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>

	<!-- 네비게이션 바 설정 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
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

	<%-- メインコンテンツ --%>
	<div style="max-width: 1024px; margin: 0 auto;">
		<div class="container p-5 bg-light rounded-3 mt-5 mb-5">
			<h1>サイト紹介</h1>
			<p>
				これは、JSPを使用して作成された掲示板ウェブサイトです。<br>簡単な掲示板を作成してみました。<br>デザインテンプレートはBootstrapを使用しています。
			</p>
			<p>
				<a href="https://github.com/chs4649/JSP-Board.git"
					class="btn btn-primary" role="button">詳しく</a>
			</p>
		</div>
		<%-- 写真帳 --%>
		<div class="container mb-5">
			<div class="slider">
				<div>
					<img src="images/1.png">
				</div>
				<div>
					<img src="images/2.png">
				</div>
				<div>
					<img src="images/3.png">
				</div>
			</div>
		</div>
	</div>


	<!-- Bootstrap JS 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>


</html>
