<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Video Form</title></head>
<body>
  <h2>${empty item ? 'Tạo Video' : 'Sửa Video'}</h2>
  <form method="post" action="${pageContext.request.contextPath}/admin/videos">
    <input type="hidden" name="id" value="${item.id}">

    <div>
      <label>Title:</label>
      <input name="title" value="${item.title}" required>
    </div>
    <div>
      <label>Description:</label>
      <textarea name="description">${item.description}</textarea>
    </div>
    <div>
      <label>URL:</label>
      <input name="url" value="${item.url}" required>
    </div>
    <div>
      <label>Thumbnail:</label>
      <input name="thumbnail" value="${item.thumbnail}">
    </div>
    <div>
      <label>Category:</label>
      <select name="categoryId" required>
        <c:forEach var="c" items="${categories}">
          <option value="${c.id}" ${item.category != null && item.category.id == c.id ? 'selected' : ''}>
            ${c.name}
          </option>
        </c:forEach>
      </select>
    </div>
    <div>
      <i>Uploader sẽ tự động lấy từ session khi thêm mới.</i>
      <c:if test="${not empty item.uploader}">
        <p>Uploader: ${item.uploader.username}</p>
      </c:if>
    </div>

    <button type="submit">Save</button>
    <a href="${pageContext.request.contextPath}/admin/videos">Back</a>
  </form>
</body>
</html>
