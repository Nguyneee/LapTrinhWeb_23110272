<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty item ? 'Tạo User' : 'Sửa User'} - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>
                <i class="fas fa-users"></i> 
                ${empty item ? 'Tạo User Mới' : 'Sửa User'}
            </h1>
            <p>${empty item ? 'Thêm người dùng mới vào hệ thống' : 'Cập nhật thông tin người dùng'}</p>
        </div>

        <!-- Navigation Menu -->
        <div class="nav-menu">
            <strong><i class="fas fa-bars"></i> Navigation:</strong>
            <a href="${pageContext.request.contextPath}/admin/categories" class="nav-btn categories">
                <i class="fas fa-folder"></i> Categories
            </a>
            <a href="${pageContext.request.contextPath}/admin/videos" class="nav-btn videos">
                <i class="fas fa-video"></i> Videos
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-btn users">
                <i class="fas fa-users"></i> Users
            </a>
            <a href="${pageContext.request.contextPath}/profile" class="nav-btn profile">
                <i class="fas fa-user"></i> Profile
            </a>
            <a href="${pageContext.request.contextPath}/login" onclick="return confirm('Bạn có chắc muốn đăng xuất?')" class="nav-btn logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>

        <!-- Alert Messages -->
        <c:if test="${not empty error}">
            <div class="alert error">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert success">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>

        <!-- Form Container -->
        <div class="form-container">
            <form method="post" action="${pageContext.request.contextPath}/admin/users">
                <input type="hidden" name="id" value="${item.id}">
                
                <div class="form-group">
                    <label for="username">
                        <i class="fas fa-user"></i> Tên đăng nhập:
                    </label>
                    <input type="text" id="username" name="username" value="${item.username}" 
                           placeholder="Nhập tên đăng nhập (ví dụ: admin, user123...)" 
                           ${empty item ? "" : "readonly"} required>
                    <c:if test="${not empty item}">
                        <small style="color: #6c757d; margin-top: 5px;">
                            <i class="fas fa-lock"></i> Tên đăng nhập không thể thay đổi
                        </small>
                    </c:if>
                </div>
                
                <div class="form-group">
                    <label for="password">
                        <i class="fas fa-lock"></i> Mật khẩu:
                    </label>
                    <input type="password" id="password" name="password" 
                           placeholder="${empty item ? 'Nhập mật khẩu' : 'Nhập mật khẩu mới để thay đổi (để trống nếu không muốn đổi)'}"
                           ${empty item ? "required" : ""}>
                    <small style="color: #6c757d; margin-top: 5px;">
                        <i class="fas fa-info-circle"></i> 
                        ${empty item ? 'Mật khẩu phải có ít nhất 6 ký tự' : 'Để trống nếu không muốn thay đổi mật khẩu'}
                    </small>
                </div>
                
                <div class="form-group">
                    <label for="email">
                        <i class="fas fa-envelope"></i> Email:
                    </label>
                    <input type="email" id="email" name="email" value="${item.email}" 
                           placeholder="Nhập địa chỉ email (ví dụ: user@example.com)" required>
                </div>
                
                <div class="form-group">
                    <label for="role">
                        <i class="fas fa-shield-alt"></i> Vai trò:
                    </label>
                    <select id="role" name="role" required>
                        <option value="USER" ${item.role == 'USER' ? 'selected' : ''}>
                            <i class="fas fa-user"></i> USER - Người dùng thông thường
                        </option>
                        <option value="ADMIN" ${item.role == 'ADMIN' ? 'selected' : ''}>
                            <i class="fas fa-crown"></i> ADMIN - Quản trị viên
                        </option>
                    </select>
                    <small style="color: #6c757d; margin-top: 5px;">
                        <i class="fas fa-info-circle"></i> ADMIN có quyền quản lý toàn bộ hệ thống
                    </small>
                </div>
                
                <div class="form-group">
                    <label style="display: flex; align-items: center; cursor: pointer;">
                        <input type="checkbox" name="active" ${item.active ? 'checked' : ''} 
                               style="margin-right: 10px; transform: scale(1.2);">
                        <i class="fas fa-toggle-on"></i> Kích hoạt tài khoản
                    </label>
                    <small style="color: #6c757d; margin-top: 5px;">
                        <i class="fas fa-info-circle"></i> Tài khoản được kích hoạt mới có thể đăng nhập
                    </small>
                </div>
                
                <c:if test="${not empty item}">
                    <div class="form-group">
                        <div style="background: #e8f5e8; padding: 15px; border-radius: 8px; border-left: 4px solid #28a745;">
                            <h4 style="margin: 0 0 10px 0; color: #155724;">
                                <i class="fas fa-info-circle"></i> Thông tin bổ sung
                            </h4>
                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 10px;">
                                <div>
                                    <strong>ID:</strong> #${item.id}
                                </div>
                                <div>
                                    <strong>Trạng thái:</strong> 
                                    <c:choose>
                                        <c:when test="${item.active}">
                                            <span style="color: #28a745; font-weight: bold;">
                                                <i class="fas fa-check-circle"></i> Hoạt động
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #dc3545; font-weight: bold;">
                                                <i class="fas fa-times-circle"></i> Bị khóa
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <div style="display: flex; gap: 15px; margin-top: 30px;">
                    <button type="submit" class="submit-btn">
                        <i class="fas fa-save"></i> 
                        ${empty item ? 'Tạo User' : 'Cập nhật User'}
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/users" 
                       style="padding: 12px 25px; background: #6c757d; color: white; text-decoration: none; border-radius: 25px; font-weight: 500; transition: all 0.3s ease;">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Add some interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('input, textarea, select');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.style.transform = 'scale(1.02)';
                    this.style.transition = 'transform 0.2s ease';
                });
                input.addEventListener('blur', function() {
                    this.style.transform = 'scale(1)';
                });
            });

            // Password confirmation for new users
            const passwordInput = document.getElementById('password');
            if (passwordInput && passwordInput.placeholder.includes('Nhập mật khẩu')) {
                passwordInput.addEventListener('input', function() {
                    if (this.value.length > 0 && this.value.length < 6) {
                        this.style.borderColor = '#dc3545';
                        this.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
                    } else {
                        this.style.borderColor = '#28a745';
                        this.style.boxShadow = '0 0 0 3px rgba(40, 167, 69, 0.1)';
                    }
                });
            }
        });
    </script>
</body>
</html>
