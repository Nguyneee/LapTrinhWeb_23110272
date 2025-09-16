<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản lý danh mục - LTW_0909</title>
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
        padding: 40px 30px;
        text-align: center;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        max-width: 400px;
        width: 100%;
        animation: fadeInUp 0.8s ease-out;
      }

      @keyframes fadeInUp {
        from {
          opacity: 0;
          transform: translateY(30px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      .logo {
        width: 70px;
        height: 70px;
        background: linear-gradient(135deg, #667eea, #764ba2);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 25px;
        box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
      }

      .logo i {
        font-size: 2rem;
        color: white;
      }

      h1 {
        color: #2c3e50;
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 10px;
      }

      .subtitle {
        color: #7f8c8d;
        font-size: 1rem;
        margin-bottom: 30px;
        line-height: 1.5;
      }

      .btn-admin {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        text-decoration: none;
        padding: 15px 25px;
        border-radius: 50px;
        font-weight: 600;
        font-size: 1rem;
        transition: all 0.3s ease;
        box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
      }

      .btn-admin:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 30px rgba(102, 126, 234, 0.4);
      }

      .version-info {
        margin-top: 25px;
        padding-top: 20px;
        border-top: 1px solid #eee;
        color: #95a5a6;
        font-size: 0.85rem;
      }

      @media (max-width: 480px) {
        .container {
          padding: 30px 20px;
          margin: 10px;
        }

        h1 {
          font-size: 1.8rem;
        }
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="logo">
        <i class="fas fa-list-alt"></i>
      </div>

      <h1>Quản lý danh mục</h1>
      <p class="subtitle">
        Hệ thống quản lý danh mục sản phẩm đơn giản và hiệu quả
      </p>

      <a
        href="${pageContext.request.contextPath}/admin/categories"
        class="btn-admin"
      >
        <i class="fas fa-cog"></i>
        Quản lý danh mục
      </a>

      <div class="version-info">
        <i class="fas fa-code"></i>
        LTW Project - Version 1.0
      </div>
    </div>
  </body>
</html>
