<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot / Reset Password</title>
</head>
<body>
    <h2>Quên mật khẩu</h2>

    <!-- Bước 1: Nhập email -->
    <form action="${pageContext.request.contextPath}/forgot" method="post">
        <label>Email:</label>
        <input type="email" name="email" required>
        <button type="submit" name="action" value="find">Xác nhận</button>
    </form>

    <c:if test="${not empty foundEmail}">
        <hr/>
        <!-- Bước 2: Đặt lại mật khẩu -->
        <h3>Đặt lại mật khẩu cho ${foundEmail}</h3>
        <form action="${pageContext.request.contextPath}/forgot" method="post">
            <input type="hidden" name="email" value="${foundEmail}" />
            <label>Mật khẩu mới:</label>
            <input type="password" name="newPassword" required><br/>
            <label>Nhập lại mật khẩu:</label>
            <input type="password" name="confirmPassword" required><br/>
            <button type="submit" name="action" value="reset">Đặt lại mật khẩu</button>
        </form>
    </c:if>

    <c:if test="${not empty message}">
        <p style="color:green">${message}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p style="color:red">${error}</p>
    </c:if>

    <p><a href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a></p>
</body>
</html>