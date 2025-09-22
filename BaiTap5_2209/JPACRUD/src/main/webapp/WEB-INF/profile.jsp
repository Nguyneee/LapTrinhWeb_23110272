<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile Management - ${user.username}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-user"></i> Profile Management</h1>
            <p>Cập nhật thông tin cá nhân của bạn</p>
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

        <!-- User Info Card -->
        <div class="user-info">
            <h3><i class="fas fa-info-circle"></i> Thông tin tài khoản</h3>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-top: 15px;">
                <div>
                    <strong><i class="fas fa-user"></i> Username:</strong><br>
                    <span style="color: #007bff; font-weight: bold;">${user.username}</span>
                </div>
                <div>
                    <strong><i class="fas fa-envelope"></i> Email:</strong><br>
                    <span style="color: #6c757d;">${user.email}</span>
                </div>
                <div>
                    <strong><i class="fas fa-shield-alt"></i> Role:</strong><br>
                    <c:choose>
                        <c:when test="${user.role == 'ADMIN'}">
                            <span style="background: #dc3545; color: white; padding: 4px 8px; border-radius: 12px; font-size: 0.8rem;">
                                <i class="fas fa-crown"></i> ADMIN
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span style="background: #28a745; color: white; padding: 4px 8px; border-radius: 12px; font-size: 0.8rem;">
                                <i class="fas fa-user"></i> USER
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
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

        <!-- Profile Form -->
        <div class="form-container">
            <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/profile">
                
                <div class="form-group">
                    <label for="fullname">
                        <i class="fas fa-id-card"></i> Họ và tên:
                    </label>
                    <input type="text" id="fullname" name="fullname" value="${user.fullname}" 
                           placeholder="Nhập họ và tên đầy đủ của bạn" required>
                </div>
                
                <div class="form-group">
                    <label for="phone">
                        <i class="fas fa-phone"></i> Số điện thoại:
                    </label>
                    <input type="text" id="phone" name="phone" value="${user.phone}" 
                           placeholder="Nhập số điện thoại của bạn">
                </div>
                
                <div class="form-group">
                    <label for="image">
                        <i class="fas fa-image"></i> Ảnh đại diện:
                    </label>
                    <input type="file" id="image" name="image" accept="image/*">
                    <small style="color: #6c757d; display: block; margin-top: 5px;">
                        <i class="fas fa-info-circle"></i> Chọn file ảnh (JPG, PNG, GIF) - Tối đa 5MB
                    </small>
                    
                    <c:if test="${not empty user.image}">
                        <div class="image-preview" style="margin-top: 15px;">
                            <p><strong><i class="fas fa-eye"></i> Ảnh hiện tại:</strong></p>
                            <img src="${pageContext.request.contextPath}/${user.image}" width="120" height="120" 
                                 alt="Current profile image" style="border-radius: 50%; border: 3px solid #e9ecef; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
                        </div>
                    </c:if>
                </div>
                
                <div style="display: flex; gap: 15px; margin-top: 25px;">
                    <button type="submit" class="submit-btn">
                        <i class="fas fa-save"></i> Cập nhật Profile
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/categories" 
                       style="padding: 12px 25px; background: #6c757d; color: white; text-decoration: none; border-radius: 25px; font-weight: 500; transition: all 0.3s ease;">
                        <i class="fas fa-arrow-left"></i> Quay lại Admin
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Add file preview functionality
        document.getElementById('image').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const preview = document.querySelector('.image-preview');
                    if (preview) {
                        preview.innerHTML = '<p><strong><i class="fas fa-eye"></i> Ảnh mới:</strong></p><img src="' + e.target.result + '" width="120" height="120" alt="Preview" style="border-radius: 50%; border: 3px solid #e9ecef; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">';
                    } else {
                        const formGroup = document.querySelector('.form-group:last-of-type');
                        const newPreview = document.createElement('div');
                        newPreview.className = 'image-preview';
                        newPreview.style.marginTop = '15px';
                        newPreview.innerHTML = '<p><strong><i class="fas fa-eye"></i> Ảnh mới:</strong></p><img src="' + e.target.result + '" width="120" height="120" alt="Preview" style="border-radius: 50%; border: 3px solid #e9ecef; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">';
                        formGroup.appendChild(newPreview);
                    }
                };
                reader.readAsDataURL(file);
            }
        });
    </script>
</body>
</html>
