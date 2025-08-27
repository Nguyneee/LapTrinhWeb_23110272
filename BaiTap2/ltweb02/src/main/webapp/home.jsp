<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
</head>
<body>
<h2>Đăng nhập</h2>

<!-- Hiển thị thông báo -->
<% String alert = (String) request.getAttribute("alert");
   if (alert != null) { %>
    <p style="color:red"><%= alert %></p>
<% } %>

<form action="login" method="post">
    Tài khoản: <input type="text" name="username"><br><br>
    Mật khẩu: <input type="password" name="password"><br><br>
    <input type="checkbox" name="remember"> Nhớ tôi<br><br>
    <button type="submit">Đăng nhập</button>
</form>
</body>
</html>