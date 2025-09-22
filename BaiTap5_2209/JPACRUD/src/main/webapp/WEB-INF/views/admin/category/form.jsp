<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty item ? 'Tạo Category' : 'Sửa Category'} - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>
                <i class="fas fa-folder"></i> 
                ${empty item ? 'Tạo Category Mới' : 'Sửa Category'}
            </h1>
            <p>${empty item ? 'Thêm danh mục video mới vào hệ thống' : 'Cập nhật thông tin danh mục'}</p>
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
            <form method="post" action="${pageContext.request.contextPath}/admin/categories">
                <input type="hidden" name="id" value="${item.id}">
                
                <div class="form-group">
                    <label for="name">
                        <i class="fas fa-tag"></i> Tên danh mục:
                    </label>
                    <input type="text" id="name" name="name" value="${item.name}" 
                           placeholder="Nhập tên danh mục (ví dụ: Giải trí, Học tập...)" required>
                </div>
                
                <div class="form-group">
                    <label for="description">
                        <i class="fas fa-align-left"></i> Mô tả:
                    </label>
                    <textarea id="description" name="description" rows="4" 
                              placeholder="Nhập mô tả chi tiết về danh mục này...">${item.description}</textarea>
                </div>
                
                <div class="form-group">
                    <label style="display: flex; align-items: center; cursor: pointer;">
                        <input type="checkbox" name="active" ${item.active ? 'checked' : ''} 
                               style="margin-right: 10px; transform: scale(1.2);">
                        <i class="fas fa-toggle-on"></i> Kích hoạt danh mục
                    </label>
                    <small style="color: #6c757d; margin-top: 5px;">
                        <i class="fas fa-info-circle"></i> Danh mục được kích hoạt sẽ hiển thị cho người dùng
                    </small>
                </div>
                
                <div style="display: flex; gap: 15px; margin-top: 30px;">
                    <button type="submit" class="submit-btn">
                        <i class="fas fa-save"></i> 
                        ${empty item ? 'Tạo Category' : 'Cập nhật Category'}
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/categories" 
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
        });
    </script>
</body>
</html>
