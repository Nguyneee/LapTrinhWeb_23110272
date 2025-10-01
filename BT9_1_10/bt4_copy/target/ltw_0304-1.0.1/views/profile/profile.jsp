<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thông tin cá nhân</title>
    <!-- Decorator applied via sitemesh3.xml mapping -->
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-user"></i> Thông tin cá nhân
                        </h4>
                    </div>
                    <div class="card-body">
                        <!-- Success message -->
                        <c:if test="${param.success == '1'}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle"></i> Cập nhật thông tin thành công!
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <div class="row">
                            <!-- Avatar Column -->
                            <div class="col-md-4 text-center">
                                <div class="profile-avatar mb-3">
                                    <c:choose>
                                        <c:when test="${not empty user.avatar}">
                                            <img src="${pageContext.request.contextPath}/uploads/${user.avatar}" 
                                                 alt="Avatar" 
                                                 class="img-fluid rounded-circle border border-3 border-primary" 
                                                 style="width: 200px; height: 200px; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="bg-secondary rounded-circle d-flex align-items-center justify-content-center" 
                                                 style="width: 200px; height: 200px; margin: 0 auto;">
                                                <i class="fas fa-user text-white" style="font-size: 80px;"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <!-- Action Buttons -->
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/profile/edit" 
                                       class="btn btn-outline-primary">
                                        <i class="fas fa-edit"></i> Chỉnh sửa thông tin
                                    </a>
                                </div>
                            </div>

                            <!-- User Information Column -->
                            <div class="col-md-8">
                                <table class="table table-borderless">
                                    <tbody>
                                        <tr>
                                            <td class="fw-bold text-muted" style="width: 30%;">
                                                <i class="fas fa-user-tag"></i> Tên đăng nhập:
                                            </td>
                                            <td>${user.userName}</td>
                                        </tr>
                                        <tr>
                                            <td class="fw-bold text-muted">
                                                <i class="fas fa-envelope"></i> Email:
                                            </td>
                                            <td>${user.email}</td>
                                        </tr>
                                        <tr>
                                            <td class="fw-bold text-muted">
                                                <i class="fas fa-id-card"></i> Họ và tên:
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty user.fullName}">
                                                        ${user.fullName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Chưa cập nhật</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="fw-bold text-muted">
                                                <i class="fas fa-phone"></i> Số điện thoại:
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty user.phone}">
                                                        ${user.phone}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Chưa cập nhật</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="fw-bold text-muted">
                                                <i class="fas fa-calendar-alt"></i> Ngày tạo:
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty user.createdDate}">
                                                        ${user.createdDate}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Không xác định</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="fw-bold text-muted">
                                                <i class="fas fa-user-shield"></i> Vai trò:
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.roleid == 2}">
                                                        <span class="badge bg-danger">Admin</span>
                                                    </c:when>
                                                    <c:when test="${user.roleid == 3}">
                                                        <span class="badge bg-warning text-dark">Manager</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-success">User</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Navigation Links -->
                <div class="mt-3 text-center">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary">
                        <i class="fas fa-home"></i> Về trang chủ
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
