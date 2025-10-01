<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="${pageContext.request.contextPath}/home">
			<i class="fas fa-home"></i> LTW_0304
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ms-auto">
				<c:choose>
					<c:when test="${not empty sessionScope.account}">
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
								<i class="fas fa-user"></i> ${sessionScope.account.userName}
							</a>
							<ul class="dropdown-menu">
								<c:if test="${sessionScope.account.roleid == 2}">
									<li>
										<a class="dropdown-item" href="${pageContext.request.contextPath}/admin/home">
											<i class="fas fa-shield-alt"></i> Admin Dashboard
										</a>
									</li>
								</c:if>
								<c:if test="${sessionScope.account.roleid == 3}">
									<li>
										<a class="dropdown-item" href="${pageContext.request.contextPath}/manager/home">
											<i class="fas fa-briefcase"></i> Manager Dashboard
										</a>
									</li>
								</c:if>
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
									<i class="fas fa-id-card"></i> Thông tin cá nhân
								</a></li>
								<li><hr class="dropdown-divider"></li>
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
									<i class="fas fa-sign-out-alt"></i> Đăng xuất
								</a></li>
							</ul>
						</li>
					</c:when>
					<c:otherwise>
						<li class="nav-item">
							<a class="nav-link" href="${pageContext.request.contextPath}/login">
								<i class="fas fa-sign-in-alt"></i> Đăng nhập
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="${pageContext.request.contextPath}/register">
								<i class="fas fa-user-plus"></i> Đăng ký
							</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</nav>