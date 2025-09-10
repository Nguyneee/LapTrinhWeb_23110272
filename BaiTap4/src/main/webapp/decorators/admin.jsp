<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><sitemesh:write property="title"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
    <jsp:include page="/commons/web/header.jsp"/>
    <div class="container mt-4">
        <sitemesh:write property="body"/>
    </div>
    <jsp:include page="/commons/web/footer.jsp"/>
</body>
</html>
