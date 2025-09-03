<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký tài khoản</title>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .register-form { width: 350px; margin: 60px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .register-form h2 { text-align: center; margin-bottom: 20px; }
        .register-form input[type=text],
        .register-form input[type=password],
        .register-form input[type=email] {
            width: 100%; padding: 10px; margin: 8px 0 16px 0; border: 1px solid #ccc; border-radius: 4px;
        }
        .register-form button { width: 100%; padding: 10px; background: #007bff; color: #fff; border: none; border-radius: 4px; font-size: 16px; }
        .register-form button:hover { background: #0056b3; }
        .alert { color: red; text-align: center; margin-bottom: 10px; }
        .login-link { text-align: center; margin-top: 10px; }
    </style>
</head>
<body>
<div class="register-form">
    <h2>Đăng ký tài khoản</h2>
    <form action="${pageContext.request.contextPath}/register" method="post">
        <input type="text" name="fullname" placeholder="Họ và tên" required />
        <input type="text" name="username" placeholder="Tên đăng nhập" required />
        <input type="email" name="email" placeholder="Email" required />
        <input type="password" name="password" placeholder="Mật khẩu" required />
        <input type="text" name="phone" placeholder="Số điện thoại" required />
        <button type="submit">Đăng ký</button>
        <div class="alert">${alert != null ? alert : ''}</div>
    </form>
    <div class="login-link">
        Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
    </div>
</div>
</body>
</html>