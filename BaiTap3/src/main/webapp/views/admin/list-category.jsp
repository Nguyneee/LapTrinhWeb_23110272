<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách danh mục</title>
    <style>
        table {
            border-collapse: collapse;
            width: 70%;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }
        th {
            background: #f2f2f2;
        }
        a {
            text-decoration: none;
            color: blue;
        }
        a:hover {
            text-decoration: underline;
        }
        .actions a {
            margin: 0 5px;
        }
        .add-btn {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            background: #28a745;
            color: #fff;
            text-align: center;
            border-radius: 4px;
        }
        .add-btn:hover {
            background: #218838;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">Danh sách danh mục</h2>

<a href="${pageContext.request.contextPath}/admin/category/add" class="add-btn">+ Thêm danh mục</a>

<table>
    <tr>
        <th>ID</th>
        <th>Tên danh mục</th>
        <th>Icon</th>
        <th>Hành động</th>
    </tr>

    <c:forEach var="cate" items="${cateList}">
        <tr>
            <td>${cate.cateId}</td>
            <td>${cate.cateName}</td>
            <td>${cate.icons}</td>
            <td class="actions">
                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.cateId}">Sửa</a>
                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.cateId}">Xóa</a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>