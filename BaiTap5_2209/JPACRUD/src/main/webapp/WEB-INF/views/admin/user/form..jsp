<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>User Form</title></head>
<body>
  <h2>${empty item ? 'Tạo User' : 'Sửa User'}</h2>
  <form method="post" action="${pageContext.request.contextPath}/admin/users">
    <input type="hidden" name="id" value="${item.id}">

    <div>
      <label>Username:</label>
      <input name="username" value="${item.username}" ${empty item ? "" : "readonly"}>
    </div>
    <div>
      <label>Password:</label>
      <input type="password" name="password" placeholder="${empty item ? '' : 'Nhập để đổi password'}">
    </div>
    <div>
      <label>Email:</label>
      <input type="email" name="email" value="${item.email}">
    </div>
    <div>
      <label>Role:</label>
      <select name="role">
        <option value="USER" ${item.role == 'USER' ? 'selected' : ''}>USER</option>
        <option value="ADMIN" ${item.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
      </select>
    </div>
    <div>
      <label>Active:</label>
      <input type="checkbox" name="active" ${item.active ? 'checked' : ''}>
    </div>

    <button type="submit">Save</button>
    <a href="${pageContext.request.contextPath}/admin/users">Back</a>
  </form>
</body>
</html>
