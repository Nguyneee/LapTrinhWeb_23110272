<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Video Management - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-video"></i> Video Management</h1>
            <p>Quản lý video và nội dung</p>
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

        <!-- Search Form -->
        <form method="get" class="search-form">
            <input type="text" name="q" value="${q}" placeholder="Tìm kiếm tiêu đề/mô tả..." class="search-input">
            <select name="categoryId" class="search-select">
                <option value="">-- Tất cả danh mục --</option>
                <c:forEach var="c" items="${categories}">
                    <option value="${c.id}" ${categoryId != null && categoryId == c.id ? 'selected' : ''}>${c.name}</option>
                </c:forEach>
            </select>
            <button type="submit" class="search-btn">
                <i class="fas fa-search"></i> Search
            </button>
            <a href="${pageContext.request.contextPath}/admin/videos?action=create" class="new-btn">
                <i class="fas fa-plus"></i> New Video
            </a>
        </form>

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

        <!-- Data Table -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th><i class="fas fa-hashtag"></i> ID</th>
                        <th><i class="fas fa-play"></i> Title</th>
                        <th><i class="fas fa-folder"></i> Category</th>
                        <th><i class="fas fa-user"></i> Uploader</th>
                        <th><i class="fas fa-cogs"></i> Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="v" items="${items}">
                        <tr>
                            <td><strong>#${v.id}</strong></td>
                            <td>
                                <div style="display: flex; align-items: center;">
                                    <i class="fas fa-video" style="color: #28a745; margin-right: 8px;"></i>
                                    <div>
                                        <strong>${v.title}</strong>
                                        <c:if test="${not empty v.description}">
                                            <br><small style="color: #6c757d;">${v.description}</small>
                                        </c:if>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${v.category != null}">
                                        <span style="background: #e3f2fd; color: #1976d2; padding: 4px 8px; border-radius: 12px; font-size: 0.8rem;">
                                            <i class="fas fa-tag"></i> ${v.category.name}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #6c757d; font-style: italic;">Chưa phân loại</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${v.uploader != null}">
                                        <div style="display: flex; align-items: center;">
                                            <i class="fas fa-user-circle" style="color: #007bff; margin-right: 5px;"></i>
                                            <span>${v.uploader.username}</span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #6c757d; font-style: italic;">Unknown</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/videos?action=edit&id=${v.id}" 
                                   class="action-btn edit">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/videos?action=delete&id=${v.id}" 
                                   onclick="return confirm('Bạn có chắc muốn xóa video này?')" 
                                   class="action-btn delete">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty items}">
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 40px; color: #6c757d;">
                                <i class="fas fa-video-slash" style="font-size: 3rem; margin-bottom: 15px; display: block;"></i>
                                <strong>Không có video nào</strong>
                                <br>
                                <small>Hãy tạo video đầu tiên của bạn!</small>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div class="pagination">
            <c:choose>
                <c:when test="${pages != null && pages > 0}">
                    <c:forEach var="i" begin="0" end="${pages - 1}">
                        <c:choose>
                            <c:when test="${i == page}">
                                <b>${i+1}</b>
                            </c:when>
                            <c:otherwise>
                                <a href="?q=${q}&categoryId=${categoryId}&page=${i}">${i+1}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <!-- No pagination needed -->
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        // Add some interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            // Add hover effects to table rows
            const rows = document.querySelectorAll('tbody tr');
            rows.forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateX(5px)';
                    this.style.transition = 'transform 0.2s ease';
                });
                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateX(0)';
                });
            });
        });
    </script>
</body>
</html>
