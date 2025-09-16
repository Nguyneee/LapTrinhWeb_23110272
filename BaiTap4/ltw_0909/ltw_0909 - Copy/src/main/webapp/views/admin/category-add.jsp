<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Thêm danh mục mới - Admin Panel</title>
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
        padding: 20px;
      }

      .container {
        max-width: 1200px;
        margin: 0 auto;
        background: white;
        border-radius: 15px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        overflow: hidden;
      }

      .header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 30px;
        text-align: center;
      }

      .header h1 {
        font-size: 2.5rem;
        margin-bottom: 10px;
      }

      .header p {
        font-size: 1.1rem;
        opacity: 0.9;
      }

      .content {
        padding: 40px;
      }

      .page-header {
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 3px solid #667eea;
      }

      .page-header h2 {
        color: #333;
        font-size: 2rem;
        margin-bottom: 10px;
      }

      .breadcrumb {
        color: #6c757d;
        font-size: 1rem;
      }

      .card {
        background: white;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        overflow: hidden;
      }

      .card-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 20px 30px;
      }

      .card-header h3 {
        font-size: 1.3rem;
        margin: 0;
      }

      .card-body {
        padding: 30px;
      }

      .form-group {
        margin-bottom: 25px;
      }

      .form-label {
        display: block;
        font-weight: 600;
        color: #333;
        margin-bottom: 8px;
        font-size: 1rem;
      }

      .form-control {
        width: 100%;
        padding: 12px 15px;
        border: 2px solid #e9ecef;
        border-radius: 8px;
        font-size: 1rem;
        transition: all 0.3s ease;
      }

      .form-control:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
      }

      .btn {
        display: inline-block;
        padding: 12px 25px;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 600;
        text-decoration: none;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-right: 10px;
      }

      .btn-success {
        background: linear-gradient(135deg, #28a745, #20c997);
        color: white;
      }

      .btn-success:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
      }

      .btn-default {
        background: #6c757d;
        color: white;
      }

      .btn-default:hover {
        background: #5a6268;
        transform: translateY(-2px);
      }

      .alert {
        padding: 15px 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        font-weight: 500;
      }

      .alert-danger {
        background-color: #f8d7da;
        border: 1px solid #f5c6cb;
        color: #721c24;
      }

      small {
        display: block;
        margin-top: 5px;
        color: #6c757d;
        font-size: 0.9rem;
      }

      #imagePreview img {
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
      }

      #noImagePreview {
        border: 2px dashed #dee2e6;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #6c757d;
        background: #f8f9fa;
      }

      .back-btn {
        position: fixed;
        top: 20px;
        left: 20px;
        background: rgba(255, 255, 255, 0.9);
        color: #667eea;
        padding: 10px 15px;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 600;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
      }

      .back-btn:hover {
        background: white;
        transform: translateY(-2px);
      }
    </style>
  </head>
  <body>
    <a
      href="${pageContext.request.contextPath}/admin/categories"
      class="back-btn"
    >
      <i class="fas fa-arrow-left"></i> Quay lại
    </a>

    <div class="container">
      <div class="header">
        <h1><i class="fas fa-plus-circle"></i> Thêm danh mục mới</h1>
        <p>Tạo danh mục sản phẩm mới cho hệ thống</p>
      </div>

      <div class="content">
        <!-- Page Header -->
        <div class="page-header">
          <h2><i class="fas fa-edit"></i> Thông tin danh mục</h2>
          <div class="breadcrumb">Điền thông tin để tạo danh mục mới</div>
        </div>

        <!-- Form Card -->
        <div class="card">
          <div class="card-header">
            <h3><i class="fas fa-plus"></i> Tạo danh mục</h3>
          </div>
          <div class="card-body">
            <c:if test="${not empty error}">
              <div class="alert alert-danger">
                <i class="fas fa-exclamation-triangle"></i> ${error}
              </div>
            </c:if>

            <form
              action="${pageContext.request.contextPath}/admin/category/add"
              method="post"
              enctype="multipart/form-data"
            >
              <div style="max-width: 600px">
                <div class="form-group">
                  <label class="form-label" for="categoryname">
                    <i class="fas fa-tag"></i> Tên danh mục
                    <span style="color: red">*</span>
                  </label>
                  <input
                    type="text"
                    class="form-control"
                    id="categoryname"
                    name="categoryname"
                    placeholder="Nhập tên danh mục..."
                    required
                  />
                  <small>Ví dụ: Điện thoại, Laptop, Thời trang...</small>
                </div>

                <div class="form-group">
                  <label class="form-label" for="images">
                    <i class="fas fa-image"></i> URL Hình ảnh
                  </label>
                  <input
                    type="url"
                    class="form-control"
                    id="images"
                    name="images"
                    placeholder="https://example.com/image.jpg"
                  />
                  <small
                    >Nhập đường dẫn URL của hình ảnh (không bắt buộc)</small
                  >
                </div>

                <div class="form-group">
                  <label class="form-label" for="imageFile">
                    <i class="fas fa-upload"></i> Hoặc Upload File
                  </label>
                  <input
                    type="file"
                    class="form-control"
                    id="imageFile"
                    name="imageFile"
                    accept="image/*"
                  />
                  <small
                    >Chọn file ảnh từ máy tính (jpg, png, gif... - không bắt
                    buộc)</small
                  >
                </div>

                <div class="form-group">
                  <label class="form-label">Xem trước hình ảnh</label>
                  <div id="imagePreview" style="display: none">
                    <img
                      id="previewImg"
                      src=""
                      alt="Preview"
                      style="width: 150px; height: 150px; object-fit: cover"
                    />
                  </div>
                  <div id="noImagePreview" style="width: 150px; height: 150px">
                    <i class="fas fa-image fa-2x"></i>
                  </div>
                </div>
              </div>

              <div
                style="
                  border-top: 1px solid #dee2e6;
                  padding-top: 20px;
                  margin-top: 30px;
                "
              >
                <button type="submit" class="btn btn-success">
                  <i class="fas fa-save"></i> Lưu danh mục
                </button>
                <a
                  href="${pageContext.request.contextPath}/admin/categories"
                  class="btn btn-default"
                >
                  <i class="fas fa-times"></i> Hủy bỏ
                </a>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <script>
      // Image preview functionality
      document.getElementById("images").addEventListener("input", function () {
        updatePreview(this.value);
      });

      document
        .getElementById("imageFile")
        .addEventListener("change", function () {
          const file = this.files[0];
          if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
              updatePreview(e.target.result);
            };
            reader.readAsDataURL(file);
            // Clear URL input when file is selected
            document.getElementById("images").value = "";
          }
        });

      function updatePreview(src) {
        const preview = document.getElementById("imagePreview");
        const previewImg = document.getElementById("previewImg");
        const noPreview = document.getElementById("noImagePreview");

        if (src && (isValidImageUrl(src) || src.startsWith("data:image"))) {
          previewImg.src = src;
          previewImg.onerror = function () {
            preview.style.display = "none";
            noPreview.style.display = "flex";
          };
          preview.style.display = "block";
          noPreview.style.display = "none";
        } else {
          preview.style.display = "none";
          noPreview.style.display = "flex";
        }
      }

      function isValidImageUrl(url) {
        return (
          /\.(jpg|jpeg|png|gif|bmp|webp)(\?.*)?$/i.test(url) ||
          url.includes("image")
        );
      }
    </script>
  </body>
</html>
