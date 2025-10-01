<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chỉnh sửa thông tin cá nhân</title>
    <!-- Decorator applied via sitemesh3.xml mapping -->
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-edit"></i> Chỉnh sửa thông tin cá nhân
                        </h4>
                    </div>
                    <div class="card-body">
                        <!-- Error message -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle"></i> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <!-- Success message -->
                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle"></i> ${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/profile/edit" method="post" enctype="multipart/form-data">
                            <div class="row">
                                <!-- Avatar Preview Column -->
                                <div class="col-md-4 text-center mb-4">
                                    <div class="mb-3">
                                        <label class="form-label fw-bold">Ảnh đại diện hiện tại:</label>
                                        <div id="currentAvatar">
                                            <c:choose>
                                                <c:when test="${not empty user.avatar}">
                                                    <img src="${pageContext.request.contextPath}/uploads/${user.avatar}" 
                                                         alt="Current Avatar" 
                                                         class="img-fluid rounded-circle border border-3 border-primary" 
                                                         style="width: 180px; height: 180px; object-fit: cover;">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="bg-secondary rounded-circle d-flex align-items-center justify-content-center" 
                                                         style="width: 180px; height: 180px; margin: 0 auto;">
                                                        <i class="fas fa-user text-white" style="font-size: 60px;"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    
                                    <!-- Avatar Upload -->
                                    <div class="mb-3">
                                        <label for="avatar" class="form-label fw-bold">
                                            <i class="fas fa-camera"></i> Thay đổi ảnh đại diện:
                                        </label>
                                        <input type="file" 
                                               class="form-control" 
                                               id="avatar" 
                                               name="avatar" 
                                               accept="image/*"
                                               onchange="previewImage(this)">
                                        <div class="form-text">
                                            Chỉ cho phép file ảnh (JPG, JPEG, PNG, GIF, BMP). Tối đa 10MB.
                                        </div>
                                    </div>
                                </div>

                                <!-- Form Fields Column -->
                                <div class="col-md-8">
                                    <!-- Email (readonly) -->
                                    <div class="mb-3">
                                        <label for="email" class="form-label fw-bold">
                                            <i class="fas fa-envelope"></i> Email:
                                        </label>
                                        <input type="email" 
                                               class="form-control" 
                                               id="email" 
                                               value="${user.email}" 
                                               readonly>
                                        <div class="form-text">Email không thể thay đổi.</div>
                                    </div>

                                    <!-- Username (readonly) -->
                                    <div class="mb-3">
                                        <label for="username" class="form-label fw-bold">
                                            <i class="fas fa-user-tag"></i> Tên đăng nhập:
                                        </label>
                                        <input type="text" 
                                               class="form-control" 
                                               id="username" 
                                               value="${user.userName}" 
                                               readonly>
                                        <div class="form-text">Tên đăng nhập không thể thay đổi.</div>
                                    </div>

                                    <!-- Full Name -->
                                    <div class="mb-3">
                                        <label for="fullname" class="form-label fw-bold">
                                            <i class="fas fa-id-card"></i> Họ và tên: <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" 
                                               class="form-control" 
                                               id="fullname" 
                                               name="fullname" 
                                               value="${user.fullName}" 
                                               required
                                               placeholder="Nhập họ và tên đầy đủ">
                                    </div>

                                    <!-- Phone -->
                                    <div class="mb-3">
                                        <label for="phone" class="form-label fw-bold">
                                            <i class="fas fa-phone"></i> Số điện thoại:
                                        </label>
                                        <input type="tel" 
                                               class="form-control" 
                                               id="phone" 
                                               name="phone" 
                                               value="${user.phone}" 
                                               pattern="[0-9]{10,11}"
                                               placeholder="Nhập số điện thoại (10-11 số)">
                                        <div class="form-text">Định dạng: 10-11 chữ số.</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="row mt-4">
                                <div class="col-12">
                                    <hr>
                                    <div class="d-flex justify-content-between">
                                        <a href="${pageContext.request.contextPath}/profile" 
                                           class="btn btn-secondary">
                                            <i class="fas fa-times"></i> Hủy bỏ
                                        </a>
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-save"></i> Lưu thay đổi
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript for image preview -->
    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    const currentAvatar = document.getElementById('currentAvatar');
                    currentAvatar.innerHTML = '<img src="' + e.target.result + '" alt="Preview" class="img-fluid rounded-circle border border-3 border-success" style="width: 180px; height: 180px; object-fit: cover;">';
                }
                
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>
