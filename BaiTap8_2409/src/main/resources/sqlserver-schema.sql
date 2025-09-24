-- Schema SQL cho SQL Server - GraphQL Spring Boot Project

-- Tạo database nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'GraphQL_DB')
BEGIN
    CREATE DATABASE GraphQL_DB;
END
GO

USE GraphQL_DB;
GO

-- Xóa bảng nếu tồn tại (theo thứ tự ngược lại để tránh lỗi foreign key)
IF OBJECT_ID('products', 'U') IS NOT NULL DROP TABLE products;
IF OBJECT_ID('user_categories', 'U') IS NOT NULL DROP TABLE user_categories;
IF OBJECT_ID('users', 'U') IS NOT NULL DROP TABLE users;
IF OBJECT_ID('categories', 'U') IS NOT NULL DROP TABLE categories;

-- Tạo bảng Categories
CREATE TABLE categories (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    images NVARCHAR(500)
);

-- Tạo bảng Users
CREATE TABLE users (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    fullname NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    phone NVARCHAR(20)
);

-- Tạo bảng Products
CREATE TABLE products (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    quantity INT NOT NULL,
    description NTEXT,
    price DECIMAL(18,2) NOT NULL,
    user_id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Tạo bảng trung gian cho mối quan hệ many-to-many giữa User và Category
CREATE TABLE user_categories (
    user_id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, category_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- Tạo index để tối ưu hiệu suất
CREATE INDEX idx_products_user_id ON products(user_id);
CREATE INDEX idx_products_category_id ON products(category_id);
CREATE INDEX idx_products_price ON products(price);
CREATE INDEX idx_users_email ON users(email);
