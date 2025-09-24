-- Dữ liệu mẫu cho SQL Server - GraphQL Spring Boot Project

USE GraphQL_DB;
GO

-- Xóa dữ liệu cũ (nếu có)
DELETE FROM products;
DELETE FROM user_categories;
DELETE FROM users;
DELETE FROM categories;

-- Reset identity columns
DBCC CHECKIDENT ('categories', RESEED, 0);
DBCC CHECKIDENT ('users', RESEED, 0);
DBCC CHECKIDENT ('products', RESEED, 0);

-- Thêm dữ liệu mẫu cho Categories
INSERT INTO categories (name, images) VALUES 
(N'Điện tử', 'https://via.placeholder.com/300x200?text=Electronics'),
(N'Thời trang', 'https://via.placeholder.com/300x200?text=Clothing'),
(N'Sách', 'https://via.placeholder.com/300x200?text=Books'),
(N'Thể thao', 'https://via.placeholder.com/300x200?text=Sports'),
(N'Gia dụng', 'https://via.placeholder.com/300x200?text=Home');

-- Thêm dữ liệu mẫu cho Users
INSERT INTO users (fullname, email, password, phone) VALUES 
(N'Nguyễn Văn An', 'an.nguyen@example.com', 'password123', '0123456789'),
(N'Trần Thị Bình', 'binh.tran@example.com', 'password123', '0987654321'),
(N'Lê Văn Cường', 'cuong.le@example.com', 'password123', '0369258147'),
(N'Phạm Thị Dung', 'dung.pham@example.com', 'password123', '0555123456'),
(N'Hoàng Văn Em', 'em.hoang@example.com', 'password123', '0777123456');

-- Thêm mối quan hệ User-Category (many-to-many)
INSERT INTO user_categories (user_id, category_id) VALUES 
(1, 1), -- Nguyễn Văn An quan tâm Điện tử
(1, 3), -- Nguyễn Văn An quan tâm Sách
(2, 2), -- Trần Thị Bình quan tâm Thời trang
(2, 1), -- Trần Thị Bình quan tâm Điện tử
(3, 3), -- Lê Văn Cường quan tâm Sách
(3, 4), -- Lê Văn Cường quan tâm Thể thao
(4, 2), -- Phạm Thị Dung quan tâm Thời trang
(4, 5), -- Phạm Thị Dung quan tâm Gia dụng
(5, 1), -- Hoàng Văn Em quan tâm Điện tử
(5, 4); -- Hoàng Văn Em quan tâm Thể thao

-- Thêm dữ liệu mẫu cho Products
INSERT INTO products (title, quantity, description, price, user_id, category_id) VALUES 
-- Sản phẩm điện tử
(N'iPhone 15 Pro', 10, N'Điện thoại iPhone 15 Pro mới nhất với chip A17 Pro', 29990000.00, 1, 1),
(N'Samsung Galaxy S24', 15, N'Điện thoại Samsung Galaxy S24 với camera AI', 24990000.00, 1, 1),
(N'MacBook Air M2', 5, N'Laptop MacBook Air với chip M2 mạnh mẽ', 25990000.00, 1, 1),
(N'iPad Pro 12.9', 8, N'Máy tính bảng iPad Pro 12.9 inch với chip M2', 22990000.00, 5, 1),
(N'AirPods Pro 2', 20, N'Tai nghe không dây AirPods Pro thế hệ 2', 5990000.00, 5, 1),

-- Sản phẩm thời trang
(N'Áo thun nam', 50, N'Áo thun nam chất liệu cotton 100%', 150000.00, 2, 2),
(N'Quần jean nữ', 30, N'Quần jean nữ kiểu dáng slim fit', 350000.00, 2, 2),
(N'Váy đầm nữ', 40, N'Váy đầm nữ kiểu dáng thanh lịch', 450000.00, 4, 2),
(N'Áo khoác nam', 25, N'Áo khoác nam phong cách casual', 650000.00, 2, 2),
(N'Giày sneaker', 35, N'Giày sneaker thể thao thoải mái', 800000.00, 4, 2),

-- Sản phẩm sách
(N'Sách Java Programming', 20, N'Sách học lập trình Java từ cơ bản đến nâng cao', 250000.00, 3, 3),
(N'Sách Spring Boot', 25, N'Sách hướng dẫn phát triển ứng dụng với Spring Boot', 300000.00, 3, 3),
(N'Sách GraphQL', 15, N'Sách tìm hiểu về GraphQL API', 280000.00, 1, 3),
(N'Sách React.js', 18, N'Sách học React.js cho người mới bắt đầu', 320000.00, 3, 3),
(N'Sách Node.js', 22, N'Sách phát triển backend với Node.js', 290000.00, 1, 3),

-- Sản phẩm thể thao
(N'Bóng đá', 12, N'Bóng đá chính hãng FIFA', 450000.00, 3, 4),
(N'Vợt cầu lông', 8, N'Vợt cầu lông chuyên nghiệp', 350000.00, 5, 4),
(N'Giày chạy bộ', 15, N'Giày chạy bộ thoải mái', 1200000.00, 3, 4),
(N'Quần áo thể thao', 30, N'Bộ quần áo thể thao nam nữ', 280000.00, 5, 4),

-- Sản phẩm gia dụng
(N'Máy xay sinh tố', 10, N'Máy xay sinh tố đa năng', 850000.00, 4, 5),
(N'Nồi cơm điện', 12, N'Nồi cơm điện tử cao cấp', 1200000.00, 4, 5),
(N'Bàn ủi hơi nước', 8, N'Bàn ủi hơi nước tự động', 650000.00, 4, 5),
(N'Máy lọc nước', 6, N'Máy lọc nước RO 9 cấp', 3500000.00, 4, 5);
