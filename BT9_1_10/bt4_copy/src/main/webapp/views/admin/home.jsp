<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Trang chủ Admin</title>
<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: Arial, sans-serif;
	background: #f5f6f8;
}

/* Sidebar */
.sidebar {
	width: 240px;
	height: 100vh;
	background: #1e293b;
	color: white;
	position: fixed;
	left: 0;
	top: 0;
	padding: 20px;
}

.sidebar h2 {
	text-align: center;
	margin-bottom: 20px;
	font-size: 18px;
}

.sidebar img {
	display: block;
	margin: 0 auto 10px;
	border-radius: 50%;
	width: 90px;
	height: 90px;
	object-fit: cover;
	border: 3px solid #fff;
}

.sidebar p {
	text-align: center;
	margin-bottom: 20px;
	font-size: 14px;
}

.sidebar ul {
	list-style: none;
}

.sidebar ul li {
	margin: 12px 0;
}

.sidebar ul li a {
	text-decoration: none;
	color: white;
	display: block;
	padding: 8px 12px;
	border-radius: 6px;
}

.sidebar ul li a:hover {
	background: #334155;
}

/* Header */
.header {
	margin-left: 240px;
	background: #0f172a;
	color: white;
	padding: 15px 25px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.header h1 {
	font-size: 20px;
}

/* Main content */
.content {
	margin-left: 240px;
	padding: 20px;
}

.card-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 20px;
}

.card {
	background: white;
	border-radius: 10px;
	padding: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.card h3 {
	margin-bottom: 8px;
}

.card p {
	color: #6b7280;
	font-size: 14px;
}

.logout-btn {
	background: #e11d48;
	border: none;
	color: white;
	padding: 8px 14px;
	border-radius: 6px;
	cursor: pointer;
}

.logout-btn:hover {
	background: #be123c;
}
</style>
</head>
<body>
	<!-- Sidebar -->
	<div class="sidebar">
		<img src="https://i.ibb.co/yF3rVHL/user.png" alt="avatar" />
		<h2>${sessionScope.username}</h2>
		<p>Quản trị viên</p>
		<ul>
			<li><a
				href="${pageContext.request.contextPath}/admin/category/list">Quản
					lý danh mục</a></li>
			<li><a
				href="${pageContext.request.contextPath}/admin/product/list">Quản
					lý sản phẩm</a></li>
			<li><a href="${pageContext.request.contextPath}/admin/user/list">Quản
					lý người dùng</a></li>
			<li><a href="#">Báo cáo & Thống kê</a></li>
		</ul>
	</div>

	<!-- Header -->
	<div class="header">
		<h1>Trang quản trị hệ thống</h1>
		<form action="${pageContext.request.contextPath}/logout" method="get">
			<button type="submit" class="logout-btn">Đăng xuất</button>
		</form>
	</div>

	<!-- Content -->
	<div class="content">
		<div class="card-grid">
			<div class="card">
				<h3>Người dùng</h3>