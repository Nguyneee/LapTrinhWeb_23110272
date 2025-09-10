<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8" />
<title>Đăng nhập</title>
<style>
* {
	box-sizing: border-box
}

body {
	margin: 0;
	font-family: Inter, system-ui, -apple-system, Segoe UI, Roboto, Arial,
		sans-serif;
	background: #f5f6f8
}

.wrap {
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 24px
}

.card {
	width: 560px;
	max-width: 100%;
	background: #fff;
	border-radius: 16px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .08);
	padding: 36px 40px
}

h1 {
	margin: 0 0 24px;
	font-size: 28px;
	text-align: center
}

.field {
	margin-bottom: 16px
}

.field label {
	display: block;
	font-size: 14px;
	color: #444;
	margin: 0 0 6px
}

.input {
	width: 100%;
	padding: 12px 14px;
	border: 1px solid #dfe3e8;
	border-radius: 8px;
	font-size: 15px;
	outline: none;
	background: #fff
}

.input:focus {
	border-color: #8ab4ff;
	box-shadow: 0 0 0 3px rgba(138, 180, 255, .25)
}

.actions {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-top: 6px
}

.btn {
	width: 100%;
	padding: 12px 16px;
	border: 0;
	border-radius: 10px;
	background: #0d6efd;
	color: #fff;
	font-size: 16px;
	cursor: pointer
}

.btn:hover {
	background: #0b5ed7
}

.muted {
	color: #6b7280;
	font-size: 14px;
	text-align: center;
	margin-top: 14px
}

a {
	color: #0d6efd;
	text-decoration: none
}

a:hover {
	text-decoration: underline
}

.alert {
	color: #e11d48;
	background: #fee2e2;
	border: 1px solid #fecaca;
	padding: 10px 12px;
	border-radius: 8px;
	margin-bottom: 14px;
	font-size: 14px
}
</style>
</head>
<body>
	<div class="wrap">
		<div class="card">
			<h1>Đăng nhập</h1>

			<c:if test="${not empty alert}">
				<div class="alert">${alert}</div>
			</c:if>

			<form action="${pageContext.request.contextPath}/login" method="post"
				accept-charset="UTF-8">
				<div class="field">
					<label for="username">Tên đăng nhập hoặc Email</label> <input
						id="username" name="username" class="input" type="text"
						placeholder="vd: user01 hoặc user01@email.com" required />
				</div>

				<div class="field">
					<label for="password">Mật khẩu</label> <input id="password"
						name="password" class="input" type="password"
						placeholder="••••••••" required />
				</div>

				<div class="actions">
					<label
						style="display: flex; gap: 8px; align-items: center; font-size: 14px; color: #444">
						<input type="checkbox" name="remember" value="true" /> Ghi nhớ
						đăng nhập
					</label> <a href="${pageContext.request.contextPath}/forgot">Quên mật
						khẩu?</a>
				</div>

				<div style="margin-top: 18px">
					<button class="btn" type="submit">Đăng nhập</button>
				</div>
			</form>

			<p class="muted">
				Chưa có tài khoản? <a
					href="${pageContext.request.contextPath}/register">Đăng ký</a>
			</p>
		</div>
	</div>
</body>
</html>
