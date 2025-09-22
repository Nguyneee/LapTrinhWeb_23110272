<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Video Test</title></head>
<body>
  <h2>Video Test Page</h2>
  
  <p>Pages: ${pages}</p>
  <p>Page: ${page}</p>
  <p>Items count: ${items != null ? items.size() : 0}</p>
  
  <c:if test="${pages != null && pages > 0}">
    <p>Pagination will be shown here</p>
    <c:forEach var="i" begin="0" end="${pages - 1}">
      <span>[${i+1}] </span>
    </c:forEach>
  </c:if>
  
  <c:if test="${pages == null || pages <= 0}">
    <p>No pagination needed</p>
  </c:if>
</body>
</html>
