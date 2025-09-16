<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Upload File - Test</title>
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

      .form-group {
        margin-bottom: 20px;
        text-align: left;
      }

      .form-label {
        display: block;
        font-weight: 600;
        margin-bottom: 8px;
        color: #333;
      }

      .form-control {
        width: 100%;
        padding: 12px 15px;
        border: 2px solid #e9ecef;
        border-radius: 8px;
        font-size: 1rem;
      }

      .btn {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        padding: 12px 25px;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
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
      <h1><i class="fas fa-upload"></i> Upload File Test</h1>
      <br />

      <form
        method="post"
        action="${pageContext.request.contextPath}/uploadfile"
        enctype="multipart/form-data"
      >
        <div class="form-group">
          <label class="form-label">Select file to upload:</label>
          <input type="file" name="uploadFile" class="form-control" required />
        </div>

        <div class="form-group">
          <label class="form-label">Name:</label>
          <input
            type="text"
            name="name"
            class="form-control"
            size="100"
            placeholder="Enter your name"
          />
        </div>

        <button type="submit" class="btn">
          <i class="fas fa-upload"></i> Upload
        </button>
      </form>

      <br /><br />
      <a href="${pageContext.request.contextPath}/" style="color: #667eea">
        <i class="fas fa-home"></i> Back to Home
      </a>
    </div>
  </body>
</html>
