<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - LTW Project</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        .navbar-brand {
            font-weight: bold;
            color: #0d6efd !important;
        }
        .footer {
            background-color: #f8f9fa;
            padding: 2rem 0;
            margin-top: auto;
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .content {
            flex: 1;
        }
        .user-avatar {
            width: 32px;
            height: 32px;
            object-fit: cover;
        }
        .alert {
            margin-bottom: 0;
        }
    </style>
    
    <sitemesh:write property='head'/>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-laptop-code me-2"></i>LTW Project
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-1"></i>Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/category/list">
                            <i class="fas fa-list me-1"></i>Danh mục
                        </a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <c:if test="${sessionScope.account != null}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                                <img src="${pageContext.request.contextPath}/uploads/${sessionScope.account.avatar}" 
                                     alt="Avatar" class="user-avatar rounded-circle me-2"
                                     onerror="this.src='${pageContext.request.contextPath}/uploads/default.png'">
                                ${sessionScope.account.fullName}
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                    <i class="fas fa-user me-2"></i>Thông tin cá nhân
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile/edit">
                                    <i class="fas fa-edit me-2"></i>Chỉnh sửa profile
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <c:if test="${sessionScope.account.roleid == 2}">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/home">
                                        <i class="fas fa-cog me-2"></i>Quản trị
                                    </a></li>
                                </c:if>
                                <c:if test="${sessionScope.account.roleid == 3}">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/manager/home">
                                        <i class="fas fa-tasks me-2"></i>Quản lý
                                    </a></li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                    <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                                </a></li>
                            </ul>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.account == null}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                <i class="fas fa-user-plus me-1"></i>Đăng ký
                            </a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Alert Messages -->
    <c:if test="${not empty alert}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>${alert}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-times-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Main Content -->
    <main class="content">
        <div class="container mt-4">
            <sitemesh:write property='body'/>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-laptop-code me-2"></i>LTW Project</h5>
                    <p class="text-muted">Dự án Lập trình Web - Java Servlet & JSP</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="text-muted mb-0">
                        © 2025 LTW Project. All rights reserved.
                    </p>
                    <small class="text-muted">
                        Powered by Java, Bootstrap & SiteMesh
                    </small>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Auto hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
        
        // Image upload preview
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const preview = document.getElementById('avatar-preview');
                    if (preview) {
                        preview.src = e.target.result;
                    }
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
    
    <sitemesh:write property='page.script'/>
</body>
</html>
