<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Trang chủ User</title>
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
	background: #0d47a1;
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
	display: flex;
	align-items: center;
	gap: 8px;
	padding: 8px 12px;
	border-radius: 6px;
}

.sidebar ul li a:hover {
	background: #1565c0;
}

/* Header */
.header {
	margin-left: 240px;
	background: #1565c0;
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

.card {
	background: white;
	border-radius: 10px;
	padding: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

.card h3 {
	margin-bottom: 10px;
}

.card table {
	width: 100%;
	border-collapse: collapse;
}

.card table th, .card table td {
	padding: 10px;
	border-bottom: 1px solid #ddd;
	text-align: left;
}

.logout-btn {
	background: #e53935;
	border: none;
	color: white;
	padding: 8px 14px;
	border-radius: 6px;
	cursor: pointer;
}

.logout-btn:hover {
	background: #c62828;
}
</style>
</head>
<body>
	<!-- Sidebar -->
	<div class="sidebar">
		<img src="https://i.ibb.co/yF3rVHL/user.png" alt="avatar" />
		<h2>${sessionScope.username}</h2>
		<p>SV/HV/NCS - 23110272</p>
		<ul>
			<li><a href="#">Thông tin cá nhân</a></li>
			<li><a href="#">Trang của bạn</a></li>
			<li><a href="#">Chương trình đào tạo</a></li>
			<li><a href="#">Thời khóa biểu</a></li>
			<li><a href="#">Lịch thi</a></li>
		</ul>
	</div>

	<!-- Header -->
	<div class="header">
		<h1>TRƯỜNG ĐẠI HỌC SƯ PHẠM KỸ THUẬT TP.HCM</h1>
		<form action="${pageContext.request.contextPath}/logout" method="get">
			<button type="submit" class="logout-btn">Đăng xuất</button>
		</form>
	</div>

	<!-- Content -->
	<div class="content">
		<div class="card">
			<h3>Thông báo</h3>
			<table>
				<thead>
					<tr>
						<th>Tiêu đề</th>
						<th>Người gửi</th>
						<th>Thời gian gửi</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Thông báo v/v rút học phần qua mạng học kỳ 1 năm học 2025
							- 2026</td>
						<td>hanhptt</td>
						<td>08/09/2025 15:29:23</td>
					</tr>
					<tr>
						<td>Thông báo các vấn đề sinh viên khóa 2025 cần chú ý</td>
						<td>hanhptt</td>
						<td>08/09/2025 07:19:58</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>