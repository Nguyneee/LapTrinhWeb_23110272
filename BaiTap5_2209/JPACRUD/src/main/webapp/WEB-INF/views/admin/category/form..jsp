<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Category Form</title></head>
<body>
  <h2>${empty item ? 'Tao Category' : 'Sua Category'}</h2>
  <form method="post" action="${pageContext.request.contextPath}/admin/categories">
    <input type="hidden" name="id" value="${item.id}">
    <div>
      <label>Name</label>
      <input name="name" value="${item.name}" required>
    </div>
    <div>
      <label>Description</label>
      <textarea name="description">${item.description}</textarea>
    </div>
    <div>
      <label>Active</label>
      <input type="checkbox" name="active" ${item.active ? 'checked' : ''}>
    </div>
    <button type="submit">Save</button>
    <a href="${pageContext.request.contextPath}/admin/categories">Back</a>
  </form>
</body>
</html>
