<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty item ? 'Tạo Video' : 'Sửa Video'} - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>
                <i class="fas fa-video"></i> 
                ${empty item ? 'Tạo Video Mới' : 'Sửa Video'}
            </h1>
            <p>${empty item ? 'Thêm video mới vào hệ thống' : 'Cập nhật thông tin video'}</p>
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
            <form method="post" action="${pageContext.request.contextPath}/admin/videos">
                <input type="hidden" name="id" value="${item.id}">
                
                <div class="form-group">
                    <label for="title">
                        <i class="fas fa-play"></i> Tiêu đề video:
                    </label>
                    <input type="text" id="title" name="title" value="${item.title}" 
                           placeholder="Nhập tiêu đề video (ví dụ: Hướng dẫn lập trình Java...)" required>
                </div>
                
                <div class="form-group">
                    <label for="description">
                        <i class="fas fa-align-left"></i> Mô tả:
                    </label>
                    <textarea id="description" name="description" rows="4" 
                              placeholder="Nhập mô tả chi tiết về video...">${item.description}</textarea>
                </div>
                
                <div class="form-group">
                    <label for="url">
                        <i class="fas fa-link"></i> URL Video:
                    </label>
                    <input type="url" id="url" name="url" value="${item.url}" 
                           placeholder="https://www.youtube.com/watch?v=..." required>
                    <small style="color: #6c757d; margin-top: 5px;">
                        <i class="fas fa-info-circle"></i> Nhập link YouTube hoặc video khác
                    </small>
                </div>
                
                <div class="form-group">
                    <label for="thumbnail">
                        <i class="fas fa-image"></i> Thumbnail URL:
                    </label>
                    <input type="url" id="thumbnail" name="thumbnail" value="${item.thumbnail}" 
                           placeholder="https://img.youtube.com/vi/VIDEO_ID/maxresdefault.jpg">
                    <small style="color: #6c757d; margin-top: 5px;">
                        <i class="fas fa-info-circle"></i> Link ảnh thumbnail (tùy chọn)
                    </small>
                </div>
                
                <div class="form-group">
                    <label for="categoryId">
                        <i class="fas fa-folder"></i> Danh mục:
                    </label>
                    <select id="categoryId" name="categoryId" required>
                        <option value="">-- Chọn danh mục --</option>
                        <c:forEach var="c" items="${categories}">
                            <option value="${c.id}" ${item.category != null && item.category.id == c.id ? 'selected' : ''}>
                                ${c.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <div style="background: #e3f2fd; padding: 15px; border-radius: 8px; border-left: 4px solid #2196f3;">
                        <h4 style="margin: 0 0 10px 0; color: #1976d2;">
                            <i class="fas fa-info-circle"></i> Thông tin Uploader
                        </h4>
                        <c:choose>
                            <c:when test="${empty item}">
                                <p style="margin: 0; color: #666;">
                                    <i class="fas fa-user-plus"></i> Uploader sẽ tự động lấy từ tài khoản đăng nhập hiện tại
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p style="margin: 0; color: #666;">
                                    <i class="fas fa-user"></i> Uploader: <strong>${item.uploader.username}</strong>
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <div style="display: flex; gap: 15px; margin-top: 30px;">
                    <button type="submit" class="submit-btn">
                        <i class="fas fa-save"></i> 
                        ${empty item ? 'Tạo Video' : 'Cập nhật Video'}
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/videos" 
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

            // Auto-generate thumbnail from YouTube URL
            const urlInput = document.getElementById('url');
            const thumbnailInput = document.getElementById('thumbnail');
            
            urlInput.addEventListener('blur', function() {
                const url = this.value;
                if (url.includes('youtube.com/watch?v=')) {
                    const videoId = url.split('v=')[1].split('&')[0];
                    thumbnailInput.value = `https://img.youtube.com/vi/${videoId}/maxresdefault.jpg`;
                }
            });
        });
    </script>
</body>
</html>
