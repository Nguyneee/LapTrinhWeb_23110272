<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <title>Quên mật khẩu</title>
  <style>
    *{box-sizing:border-box} body{margin:0;font-family:Inter,system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif;background:#f5f6f8}
    .wrap{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:24px}
    .card{width:560px;max-width:100%;background:#fff;border-radius:16px;box-shadow:0 10px 30px rgba(0,0,0,.08);padding:36px 40px}
    h1{margin:0 0 24px;font-size:28px;text-align:center}
    .field{margin-bottom:16px}
    .field label{display:block;font-size:14px;color:#444;margin:0 0 6px}
    .input{width:100%;padding:12px 14px;border:1px solid #dfe3e8;border-radius:8px;font-size:15px;outline:none;background:#fff}
    .input:focus{border-color:#8ab4ff;box-shadow:0 0 0 3px rgba(138,180,255,.25)}
    .btn{width:100%;padding:12px 16px;border:0;border-radius:10px;background:#0d6efd;color:#fff;font-size:16px;cursor:pointer}
    .btn:hover{background:#0b5ed7}
    .muted{color:#6b7280;font-size:14px;text-align:center;margin-top:14px}
    a{color:#0d6efd;text-decoration:none} a:hover{text-decoration:underline}
    .alert{color:#e11d48;background:#fee2e2;border:1px solid #fecaca;padding:10px 12px;border-radius:8px;margin-bottom:14px;font-size:14px}
    .success{color:#065f46;background:#d1fae5;border:1px solid #a7f3d0}
  </style>
</head>
<body>
<div class="wrap">
  <div class="card">
    <h1>Quên mật khẩu</h1>

    <c:if test="${not empty error}">
      <div class="alert">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
      <div class="alert success">${message}</div>
    </c:if>

    <!-- Bước 1: Nhập email -->
    <c:if test="${empty foundEmail}">
      <form action="${pageContext.request.contextPath}/forgot" method="post" accept-charset="UTF-8">
        <div class="field">
          <label for="email">Email đã đăng ký</label>
          <input id="email" name="email" class="input" type="email" placeholder="you@example.com" required />
        </div>
        <input type="hidden" name="action" value="find"/>
        <button class="btn" type="submit">Xác nhận email</button>
      </form>

      <p class="muted" style="margin-top:16px">
        Nhớ mật khẩu rồi?
        <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
      </p>
    </c:if>

    <!-- Bước 2: Đặt lại mật khẩu -->
    <c:if test="${not empty foundEmail}">
      <form action="${pageContext.request.contextPath}/forgot" method="post" accept-charset="UTF-8">
        <div class="field">
          <label>Email</label>
          <input class="input" type="email" value="${foundEmail}" disabled />
          <input type="hidden" name="email" value="${foundEmail}" />
        </div>
        <div class="field">
          <label for="newPassword">Mật khẩu mới</label>
          <input id="newPassword" name="newPassword" class="input" type="password" placeholder="••••••••" required />
        </div>
        <div class="field">
          <label for="confirmPassword">Nhập lại mật khẩu</label>
          <input id="confirmPassword" name="confirmPassword" class="input" type="password" placeholder="••••••••" required />
        </div>
        <input type="hidden" name="action" value="reset"/>
        <button class="btn" type="submit">Đặt lại mật khẩu</button>
      </form>

      <p class="muted" style="margin-top:16px">
        Sai email?
        <a href="${pageContext.request.contextPath}/forgot">Thử lại</a>
      </p>
    </c:if>
  </div>
</div>
</body>
</html>
