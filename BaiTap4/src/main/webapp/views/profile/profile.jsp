<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container mt-4">
    <h2>Thông tin cá nhân</h2>

    <div class="mb-3">
        <label>Email:</label>
        <p>${user.email}</p>
    </div>
    <div class="mb-3">
        <label>Họ tên:</label>
        <p>${user.fullName}</p>
    </div>
    <div class="mb-3">
        <label>Số điện thoại:</label>
        <p>${user.phone}</p>
    </div>
    <div class="mb-3">
        <label>Avatar:</label><br/>
        <c:if test="${not empty user.avatar}">
            <img src="${pageContext.request.contextPath}/${user.avatar}" width="150" class="rounded"/>
        </c:if>
    </div>

    <a href="${pageContext.request.contextPath}/profile/edit" class="btn btn-primary">Chỉnh sửa</a>
</div>
</body>
</html>
