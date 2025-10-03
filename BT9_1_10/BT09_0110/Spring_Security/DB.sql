
-- Tạo database nếu chưa tồn tại
CREATE DATABASE IF NOT EXISTS spring_security
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE spring_security;

-- Vô hiệu hóa ràng buộc khóa ngoại để dễ dàng xóa dữ liệu cũ
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS users_roles;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS user_info;
DROP TABLE IF EXISTS users;

SET FOREIGN_KEY_CHECKS = 1;

-- Tạo bảng Products (theo entity Product.java)
CREATE TABLE Products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    brand VARCHAR(255),
    madein VARCHAR(255),
    price DOUBLE NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Tạo bảng roles (theo entity Role.java)
CREATE TABLE roles (
    role_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Tạo bảng user_info (theo entity UserInfo.java)
CREATE TABLE user_info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255),
    name VARCHAR(255),
    password VARCHAR(255),
    roles VARCHAR(255),
    username VARCHAR(255)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Tạo bảng users (theo entity Users.java)
CREATE TABLE users (
    user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(50) NOT NULL,
    name VARCHAR(255),
    password VARCHAR(255),
    enabled TINYINT(1) NOT NULL DEFAULT 1
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Tạo bảng users_roles (many-to-many relationship)
CREATE TABLE users_roles (
    role_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    PRIMARY KEY (role_id, user_id),
    CONSTRAINT fk_users_roles_role FOREIGN KEY (role_id) REFERENCES roles(role_id),
    CONSTRAINT fk_users_roles_user FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Insert dữ liệu mẫu cho roles
INSERT INTO roles (role_name) VALUES
('ROLE_USER'),
('ROLE_ADMIN'),
('ROLE_EDITOR'),
('ROLE_CREATOR');

-- Insert dữ liệu mẫu cho user_info (password đã được mã hóa BCrypt)
INSERT INTO user_info (name, username, email, password, roles) VALUES
('admin', 'admin', 'admin@demo.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'ROLE_ADMIN'),
('user', 'user', 'user@demo.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'ROLE_USER'),
('demo', 'demo', 'demo@demo.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'ROLE_USER');

-- Insert dữ liệu mẫu cho Products
INSERT INTO Products (name, brand, madein, price) VALUES
('iPhone 15 Pro', 'Apple', 'USA', 29990000.0),
('Samsung Galaxy S24 Ultra', 'Samsung', 'South Korea', 27990000.0),
('MacBook Pro M3', 'Apple', 'USA', 45990000.0);

-- Kiểm tra dữ liệu
SELECT '=== KIỂM TRA DỮ LIỆU ===' AS message;
SELECT 'Roles' AS table_name;
SELECT * FROM roles;

SELECT 'User Info' AS table_name;
SELECT id, name, username, email, roles FROM user_info;

SELECT 'Products' AS table_name;
SELECT * FROM Products;

SELECT '=== HOÀN THÀNH SETUP DATABASE ===' AS message;
SELECT 'Database: spring_security' AS info;
SELECT 'Tài khoản ứng dụng:' AS info;
SELECT '  - Admin: admin@demo.com / admin123' AS info;
SELECT '  - User: user@demo.com / user123' AS info;
SELECT '  - Demo: demo@demo.com / demo123' AS info;

