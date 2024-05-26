<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@100..900&display=swap" rel="stylesheet">

<!-- Bootstrap CSS 파일 링크 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<!-- jQuery 스크립트 파일 링크 -->
<script src="https://code.jquery.com/jquery-3.7.1.slim.js" integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc=" crossorigin="anonymous"></script>

<style>
body {
		font-family: 'Noto Sans JP', sans-serif;
	}
</style>

<title>JSP掲示板ウェブサイト</title>

</head>
<body>

	<!-- 네비게이션 바 설정 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="main.jsp">JSP掲示板ウェブサイト</a>
			<div class="d-flex">
				<a class="nav-link me-3" href="main.jsp">メイン</a> <a class="nav-link"
					href="bbs.jsp">掲示板</a>
			</div>
			<!-- 드롭다운 메뉴 설정 -->
			<div class="ms-auto">
				<a class="nav-link dropdown-toggle" href="#"
					id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown"
					aria-expanded="false"> アクセス </a>
				<ul class="dropdown-menu dropdown-menu-end"
					aria-labelledby="navbarDropdownMenuLink">
					<!-- 드롭다운 메뉴 항목 -->
					<li><a class="dropdown-item" href="login.jsp">ログイン</a></li>
					<li><a class="dropdown-item" href="join.jsp">ユーザー登録</a></li>

				</ul>
			</div>
		</div>
	</nav>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="card shadow-lg p-4">
                    <!-- 로그인 양식 -->
                    <form action="loginAction.jsp" method="post">
                        <h3 class="text-center mb-4">ログイン画面</h3>
                        <div class="mb-3">
                            <input type="text" class="form-control" id="id" name="userID" placeholder="IDを入力">
                        </div>
                        <div class="mb-3">
                            <input type="password" class="form-control" id="pw" name="userPW" placeholder="パスワードを入力">
                        </div>
                        <button type="submit" class="btn btn-primary w-100">ログイン</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

	<!-- Bootstrap JS 파일 링크 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
