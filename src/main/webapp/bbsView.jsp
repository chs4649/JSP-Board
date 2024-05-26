<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.chs.bbs.BbsBean"%>
<%@ page import="com.chs.bbs.BbsDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@100..900&display=swap" rel="stylesheet">

<!-- css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<!-- 제이쿼리 -->
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

	// 게시글 ID를 요청 파라미터에서 가져오기
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	// 게시글 ID가 유효하지 않은 경우 경고 메시지 출력 후 게시판 페이지로 이동
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('有効ではありません。');");
		script.println("location.href='bbs.jsp';");
		script.println("</script>");
	}
	// 게시글 정보 가져오기
	BbsBean bbsBean = new BbsDAO().getBbs(bbsID);
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
					<!-- 로그인과 회원가입 링크를 포함한 드롭다운 메뉴 -->
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
					<!-- 로그아웃 링크를 포함한 드롭다운 메뉴 -->
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
		
			<%-- table-striped : 목록 홀수 짝수 색 다르게 표현 --%>
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd;">
				<thead>
					<tr>
					<th colspan="3" style="background-color: #eeeeee; text-align: center;">詳細</th>
					</tr>
				</thead>

				<tbody>
					<tr>
						<td style="width: 20%">タイトル</td>
						<td colspan="2"><%=bbsBean.getBbsTitle().replace(" ", "&nbsp;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>作成者</td>
						<td colspan="2"><%=bbsBean.getUserID() %></td>
					</tr>
					<tr>
						<td>作成日</td>
						<td colspan="2"><%=bbsBean.getBbsDate().substring(0, 11) + bbsBean.getBbsDate().substring(11, 13) + "時 "
								+ bbsBean.getBbsDate().substring(14, 16) + "分" %></td>
					</tr>
					<tr>
						<td>内容</td>
						<td colspan="2" style="height: 350px; overflow: auto;"><%=bbsBean.getBbsContent().replace(" ", "&nbsp;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			<div class="d-flex justify-content-left">
			<a href="bbs.jsp" class="btn btn-primary me-2">戻る</a>
			<%
			if (userID != null && userID.equals(bbsBean.getUserID())) {
			%>
			<a href="bbsUpdate.jsp?bbsID=<%=bbsID%>" class="btn btn-warning me-2">編集</a>
			<a href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-danger">削除</a>
			</div>
			<%
			}
			%>
	
		</div>
	</div>

	<!-- js -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
