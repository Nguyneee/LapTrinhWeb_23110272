<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h2>Sửa danh mục</h2>
<form action="${pageContext.request.contextPath}/admin/category/edit"
	method="post">
	<input type="hidden" name="cateId" value="${cate.cateId}" /> <label>Tên:</label>
	<input type="text" name="cateName" value="${cate.cateName}" required /><br />

	<label>Icon:</label> <input type="text" name="icons"
		value="${cate.icons}" /><br />

	<button type="submit">Cập nhật</button>
	<a href="${pageContext.request.contextPath}/admin/category/list">Hủy</a>
</form>