<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Upload Result</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
      }

      .container {
        background: white;
        border-radius: 20px;
        padding: 40px;
        text-align: center;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        max-width: 500px;
        width: 100%;
      }

      .message {
        background: #d4edda;
        color: #155724;
        padding: 15px;
        border-radius: 8px;
        margin: 20px 0;
        border: 1px solid #c3e6cb;
      }

      .btn {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        padding: 12px 25px;
        border: none;
        border-radius: 8px;
        text-decoration: none;
        display: inline-block;
        font-size: 1rem;
        font-weight: 600;
        margin: 10px;
        transition: all 0.3s ease;
      }

      .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>
        <i class="fas fa-check-circle" style="color: #28a745"></i> Upload Result
      </h1>

      <c:if test="${not empty message}">
        <div class="message"><i class="fas fa-info-circle"></i> ${message}</div>
      </c:if>

      <a href="${pageContext.request.contextPath}/uploadfile" class="btn">
        <i class="fas fa-upload"></i> Upload Another File
      </a>

      <a href="${pageContext.request.contextPath}/" class="btn">
        <i class="fas fa-home"></i> Back to Home
      </a>
    </div>
  </body>
</html>
