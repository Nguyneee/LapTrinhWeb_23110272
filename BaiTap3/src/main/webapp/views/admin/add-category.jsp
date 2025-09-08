<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h2>Thêm danh mục</h2>
<form action="${pageContext.request.contextPath}/admin/category/add" method="post">
  <label>Tên:</label>
  <input type="text" name="name" required /><br/>
  <label>Icon:</label>
  <input type="text" name="icon" /><br/>
  <button type="submit">Lưu</button>
  <a href="${pageContext.request.contextPath}/admin/category/list">Hủy</a>
</form>