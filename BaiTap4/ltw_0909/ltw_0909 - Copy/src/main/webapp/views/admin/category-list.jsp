<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục - Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .content {
            padding: 40px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 3px solid #667eea;
        }

        .page-header h2 {
            color: #333;
            font-size: 2rem;
        }

        .btn {
            display: inline-block;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-right: 10px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-warning {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
        }

        .search-box {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .search-box input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
        }

        .search-box input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        table {
            width: 100%;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        th {
            padding: 20px 15px;
            text-align: left;
            font-weight: 600;
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background: #f8f9fa;
            transform: translateX(5px);
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #dee2e6;
        }

        .category-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .no-image {
            width: 60px;
            height: 60px;
            background: #f8f9fa;
            border: 2px dashed #dee2e6;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: #dee2e6;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .alert-success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-list"></i> Quản lý danh mục</h1>
            <p>Danh sách tất cả các danh mục sản phẩm</p>
        </div>
        
        <div class="content">
            <!-- Page Header -->
            <div class="page-header">
                <h2>Danh sách danh mục</h2>
                <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Thêm danh mục mới
                </a>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${message}
                </div>
            </c:if>

            <!-- Search Box -->
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="Tìm kiếm danh mục..." onkeyup="searchCategories()">
            </div>

            <!-- Categories Table -->
            <c:choose>
                <c:when test="${not empty listcate}">
                    <table id="categoryTable">
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag"></i> ID</th>
                                <th><i class="fas fa-image"></i> Hình ảnh</th>
                                <th><i class="fas fa-tag"></i> Tên danh mục</th>
                                <th><i class="fas fa-cogs"></i> Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="category" items="${listcate}">
                                <tr>
                                    <td><strong>#${category.id}</strong></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty category.images}">
                                                <c:choose>
                                                    <c:when test="${category.images.startsWith('http')}">
                                                        <img src="${category.images}" alt="${category.name}" class="category-image">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/${category.images}" alt="${category.name}" class="category-image">
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="no-image">
                                                    <i class="fas fa-image"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <strong>${category.name}</strong>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/category/edit?id=${category.id}" 
                                           class="btn btn-warning">
                                            <i class="fas fa-edit"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/category/delete?id=${category.id}" 
                                           class="btn btn-danger"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục ${category.name}?')">
                                            <i class="fas fa-trash"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <h3>Chưa có danh mục nào</h3>
                        <p>Hãy tạo danh mục đầu tiên cho hệ thống của bạn</p>
                        <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-primary" style="margin-top: 20px;">
                            <i class="fas fa-plus"></i> Thêm danh mục đầu tiên
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        function searchCategories() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.getElementById('categoryTable');
            const rows = table.getElementsByTagName('tr');

            for (let i = 1; i < rows.length; i++) {
                const nameCell = rows[i].getElementsByTagName('td')[2];
                if (nameCell) {
                    const txtValue = nameCell.textContent || nameCell.innerText;
                    if (txtValue.toLowerCase().indexOf(filter) > -1) {
                        rows[i].style.display = '';
                    } else {
                        rows[i].style.display = 'none';
                    }
                }
            }
        }
    </script>
</body>
</html>

