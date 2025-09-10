<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container mt-4">
    <h2>Cập nhật thông tin cá nhân</h2>

    <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label>Email</label>
            <input type="text" class="form-control" value="${user.email}" disabled/>
        </div>
        <div class="mb-3">
            <label>Họ tên</label>
            <input type="text" name="fullname" class="form-control" value="${user.fullName}" required/>
        </div>
        <div class="mb-3">
            <label>Số điện thoại</label>
            <input type="text" name="phone" class="form-control" value="${user.phone}" required/>
        </div>
        <div class="mb-3">
            <label>Ảnh đại diện</label><br/>
            <c:if test="${not empty user.avatar}">
                <img src="${pageContext.request.contextPath}/${user.avatar}" width="120" class="mb-2 rounded"/>
            </c:if>
            <input type="file" name="avatar" class="form-control"/>
        </div>
        <button type="submit" class="btn btn-success">Lưu thay đổi</button>
        <a href="${pageContext.request.contextPath}/profile" class="btn btn-secondary">Hủy</a>
    </form>
</div>
</body>
</html>
