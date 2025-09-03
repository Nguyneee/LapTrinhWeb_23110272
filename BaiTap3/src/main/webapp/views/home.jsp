<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>
    <h1>Trang chủ User</h1>

    <p>Xin chào, ${sessionScope.username}</p>

    <!-- Nút logout -->
    <form action="${pageContext.request.contextPath}/logout" method="get">
        <button type="submit">Logout</button>
    </form>
</body>
</html>