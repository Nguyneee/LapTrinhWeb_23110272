-- Insert default users (password: admin123)
INSERT INTO users (username, email, password, full_name, role, is_active, is_verified, created_date) VALUES
('admin', 'admin@ecshop.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Administrator', 'ADMIN', true, true, CURRENT_TIMESTAMP),
('manager', 'manager@ecshop.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Manager User', 'MANAGER', true, true, CURRENT_TIMESTAMP),
('user1', 'user1@ecshop.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Regular User 1', 'USER', true, true, CURRENT_TIMESTAMP),
('user2', 'user2@ecshop.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Regular User 2', 'USER', true, false, CURRENT_TIMESTAMP),
('testuser', 'test@ecshop.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Test User', 'USER', false, true, CURRENT_TIMESTAMP);

-- Insert sample categories
INSERT INTO categories (name, image, is_show, is_sub_home, sort_order) VALUES
('Son môi', 'son.jpg', true, false, 1),
('Kem dưỡng da', 'kem.jpg', true, true, 2),
('Nước hoa', 'nuochoa.jpg', true, false, 3),
('Sữa rửa mặt', 'srm.jpg', true, true, 4),
('Toner', 'toner.jpg', true, false, 5),
('Mascara', 'mascara.jpg', true, false, 6),
('Foundation', 'foundation.jpg', true, true, 7),
('Serum', 'serum.jpg', true, false, 8),
('Phấn phủ', 'phanphu.jpg', false, false, 9),
('Kem chống nắng', 'kemchongnang.jpg', true, true, 10);

-- Insert sample products
INSERT INTO products (product_name, quantity, unit_price, images, description, discount, create_date, status, category_id) VALUES
('Son môi MAC Ruby Woo', 50, 450000, 'mac_ruby_woo.jpg', 'Son môi màu đỏ cổ điển, bền màu 8 giờ', 0.1, CURRENT_TIMESTAMP, 1, 1),
('Kem dưỡng ẩm Neutrogena', 30, 320000, 'neutrogena_moisturizer.jpg', 'Kem dưỡng ẩm cho da khô, không gây mụn', 0.05, CURRENT_TIMESTAMP, 1, 2),
('Nước hoa Chanel No.5', 15, 2500000, 'chanel_no5.jpg', 'Nước hoa huyền thoại, hương thơm sang trọng', 0.15, CURRENT_TIMESTAMP, 1, 3),
('Sữa rửa mặt Cetaphil', 40, 180000, 'cetaphil_cleanser.jpg', 'Sữa rửa mặt dịu nhẹ cho da nhạy cảm', 0.0, CURRENT_TIMESTAMP, 1, 4),
('Toner Thayers Witch Hazel', 25, 280000, 'thayers_toner.jpg', 'Toner cân bằng độ pH, se khít lỗ chân lông', 0.1, CURRENT_TIMESTAMP, 1, 5),
('Mascara Maybelline Lash Sensational', 35, 220000, 'maybelline_mascara.jpg', 'Mascara tạo độ cong và dài cho lông mi', 0.0, CURRENT_TIMESTAMP, 1, 6),
('Foundation Estee Lauder Double Wear', 20, 1200000, 'estee_lauder_foundation.jpg', 'Foundation che phủ hoàn hảo, bền 24 giờ', 0.2, CURRENT_TIMESTAMP, 1, 7),
('Serum Vitamin C The Ordinary', 28, 350000, 'ordinary_vitamin_c.jpg', 'Serum vitamin C sáng da, chống lão hóa', 0.1, CURRENT_TIMESTAMP, 1, 8),
('Phấn phủ Laura Mercier', 18, 800000, 'laura_mercier_powder.jpg', 'Phấn phủ mịn màng, kiểm soát dầu', 0.05, CURRENT_TIMESTAMP, 0, 9),
('Kem chống nắng Anessa', 45, 420000, 'anessa_sunscreen.jpg', 'Kem chống nắng chống nước, SPF 50+', 0.0, CURRENT_TIMESTAMP, 1, 10);