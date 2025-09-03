<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
    <form action="login" method="post">
        <c:if test="${alert !=null}">
            <h3 class="alert alert-danger">${alert}</h3>
        </c:if>
        
        <div class="container">
            <label for="username"><b>Username</b></label>
            <input type="text" placeholder="Enter Username" name="username" required>

            <label for="password"><b>Password</b></label>
            <input type="password" placeholder="Enter Password" name="password" required>

            <button type="submit">Login</button>
            <label>
                <input type="checkbox" checked="checked" name="remember"> Remember me
            </label>
        </div>

        <div class="container" style="background-color:#f1f1f1">
            <button type="button" class="cancelbtn">Cancel</button>
            <!-- Link Forgot password -->
            <span class="psw">Forgot <a href="${pageContext.request.contextPath}/forgot">password?</a></span>
            &nbsp;|&nbsp;
            <!-- Link Register -->
            <span class="register">New user? <a href="${pageContext.request.contextPath}/views/register.jsp">Register</a></span>
        </div>
        
        <c:if test="${not empty errorMessage}">
            <div style="color: red;">${errorMessage}</div>
        </c:if>
    </form>
</body>
</html>