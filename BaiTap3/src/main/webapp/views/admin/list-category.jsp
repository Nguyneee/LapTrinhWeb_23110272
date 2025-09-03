<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2>Danh sách danh mục</h2>
<a href="${pageContext.request.contextPath}/admin/category/add">+ Thêm danh mục</a>
<table border="1">
    <tr>
        <th>STT</th>
        <th>Tên</th>
        <th>Icon</th>
        <th>Hành động</th>
    </tr>
    <c:forEach var="cate" items="${cateList}" varStatus="st">
        <tr>
            <td>${st.index + 1}</td>
            <td>${cate.name}</td>
            <td>${cate.icon}</td>
            <td>
                <a href="edit?id=${cate.id}">Sửa</a> |
                <a href="delete?id=${cate.id}">Xoá</a>
            </td>
        </tr>
    </c:forEach>
</table>