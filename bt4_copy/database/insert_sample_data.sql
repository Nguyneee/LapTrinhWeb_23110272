-- =============================================
-- Script Insert dữ liệu mẫu cho LTW Project
-- Database: MyDatabase
-- =============================================

USE MyDatabase;
GO

-- =============================================
-- Insert dữ liệu vào bảng Roles
-- =============================================
PRINT 'Đang insert dữ liệu vào bảng Roles...';

IF NOT EXISTS (SELECT * FROM Roles WHERE rolename = 'User')
BEGIN
    INSERT INTO Roles (rolename, description) VALUES 
    ('User', N'Người dùng thông thường'),
    ('Admin', N'Quản trị viên hệ thống'),
    ('Manager', N'Quản lý');
    PRINT 'Đã insert roles thành công!';
END
ELSE
BEGIN
    PRINT 'Dữ liệu Roles đã tồn tại!';
END
GO

-- =============================================
-- Insert dữ liệu vào bảng Categories
-- =============================================
PRINT 'Đang insert dữ liệu vào bảng Categories...';

IF NOT EXISTS (SELECT * FROM Categories WHERE cateName = N'Điện tử')
BEGIN
    INSERT INTO Categories (cateName, icons) VALUES 
    (N'Điện tử', 'fa-laptop'),
    (N'Thời trang', 'fa-tshirt'),
    (N'Sách', 'fa-book'),
    (N'Thể thao', 'fa-football-ball'),
    (N'Gia dụng', 'fa-home'),
    (N'Mỹ phẩm', 'fa-spa'),
    (N'Xe cộ', 'fa-car'),
    (N'Du lịch', 'fa-plane');
    PRINT 'Đã insert categories thành công!';
END
ELSE
BEGIN
    PRINT 'Dữ liệu Categories đã tồn tại!';
END
GO

-- =============================================
-- Insert dữ liệu vào bảng Users
-- =============================================
PRINT 'Đang insert dữ liệu vào bảng Users...';

IF NOT EXISTS (SELECT * FROM Users WHERE username = 'admin')
BEGIN
    INSERT INTO Users (username, email, password, fullname, avatar, roleid, phone) VALUES 
    ('admin', 'admin@example.com', '123456', N'Quản trị viên', 'admin.png', 2, '0123456789'),
    ('manager', 'manager@example.com', '123456', N'Người quản lý', 'manager.png', 3, '0987654321'),
    ('user1', 'user1@example.com', '123456', N'Nguyễn Văn A', 'user1.png', 1, '0111222333'),
    ('user2', 'user2@example.com', '123456', N'Trần Thị B', 'user2.png', 1, '0444555666'),
    ('test', 'test@example.com', '123456', N'Test User', 'default.png', 1, '0777888999');
    PRINT 'Đã insert users thành công!';
END
ELSE
BEGIN
    PRINT 'Dữ liệu Users đã tồn tại!';
END
GO

-- =============================================
-- Insert dữ liệu mẫu vào bảng Products
-- =============================================
PRINT 'Đang insert dữ liệu vào bảng Products...';

IF NOT EXISTS (SELECT * FROM Products WHERE productName = N'iPhone 15')
BEGIN
    INSERT INTO Products (productName, description, price, image, cateId) VALUES 
    (N'iPhone 15', N'Điện thoại iPhone 15 mới nhất từ Apple', 25000000, 'iphone15.jpg', 1),
    (N'Samsung Galaxy S24', N'Smartphone Samsung Galaxy S24 cao cấp', 22000000, 'galaxys24.jpg', 1),
    (N'MacBook Air M2', N'Laptop MacBook Air với chip M2', 30000000, 'macbook_air.jpg', 1),
    (N'Dell XPS 13', N'Laptop Dell XPS 13 siêu mỏng', 28000000, 'dell_xps.jpg', 1),
    (N'Áo thun nam', N'Áo thun nam chất cotton cao cấp', 299000, 'ao_thun_nam.jpg', 2),
    (N'Quần jean nữ', N'Quần jean nữ form slim fit', 599000, 'quan_jean_nu.jpg', 2),
    (N'Lập trình Java', N'Sách học lập trình Java từ cơ bản đến nâng cao', 250000, 'java_book.jpg', 3),
    (N'Clean Code', N'Sách Clean Code - Nghệ thuật viết code sạch', 180000, 'clean_code.jpg', 3),
    (N'Giày thể thao Nike', N'Giày thể thao Nike Air Max', 2500000, 'nike_shoes.jpg', 4),
    (N'Bóng đá FIFA', N'Quả bóng đá FIFA chính hãng', 450000, 'fifa_ball.jpg', 4);
    PRINT 'Đã insert products thành công!';
END
ELSE
BEGIN
    PRINT 'Dữ liệu Products đã tồn tại!';
END
GO

-- =============================================
-- Hiển thị thống kê dữ liệu
-- =============================================
PRINT '==============================================';
PRINT 'THỐNG KÊ DỮ LIỆU TRONG DATABASE:';
PRINT '==============================================';

DECLARE @UserCount INT, @RoleCount INT, @CategoryCount INT, @ProductCount INT;

SELECT @UserCount = COUNT(*) FROM Users;
SELECT @RoleCount = COUNT(*) FROM Roles;
SELECT @CategoryCount = COUNT(*) FROM Categories;
SELECT @ProductCount = COUNT(*) FROM Products;

PRINT 'Số lượng Users: ' + CAST(@UserCount AS VARCHAR(10));
PRINT 'Số lượng Roles: ' + CAST(@RoleCount AS VARCHAR(10));
PRINT 'Số lượng Categories: ' + CAST(@CategoryCount AS VARCHAR(10));
PRINT 'Số lượng Products: ' + CAST(@ProductCount AS VARCHAR(10));

PRINT '==============================================';
PRINT 'HOÀN THÀNH INSERT DỮ LIỆU MẪU!';
PRINT '==============================================';

-- =============================================
-- Hiển thị một số dữ liệu mẫu
-- =============================================
PRINT 'DANH SÁCH USER ACCOUNTS:';
SELECT username, email, fullname, 
       CASE roleid 
           WHEN 1 THEN 'User'
           WHEN 2 THEN 'Admin' 
           WHEN 3 THEN 'Manager'
           ELSE 'Unknown'
       END as role
FROM Users;

PRINT '';
PRINT 'DANH SÁCH CATEGORIES:';
SELECT cateId, cateName, icons FROM Categories;