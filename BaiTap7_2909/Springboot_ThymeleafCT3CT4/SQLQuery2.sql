IF DB_ID('LTWEB012') IS NOT NULL
    DROP DATABASE LTWEB012;
GO

CREATE DATABASE LTWEB012;
GO

USE LTWEB012;
GO

-- Create Users table
IF OBJECT_ID('users', 'U') IS NOT NULL
    DROP TABLE users;
GO

CREATE TABLE users (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    email NVARCHAR(100) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    full_name NVARCHAR(100) NULL,
    phone_number NVARCHAR(15) NULL,
    avatar NVARCHAR(255) NULL,
    role NVARCHAR(20) NOT NULL DEFAULT 'USER',
    is_active BIT NOT NULL DEFAULT 1,
    is_verified BIT NOT NULL DEFAULT 0,
    created_date DATETIME2 NOT NULL DEFAULT GETDATE(),
    last_login DATETIME2 NULL
);
GO

-- Insert default admin user (password: admin123)
INSERT INTO users (username, email, password, full_name, role, is_active, is_verified) VALUES
(N'admin', N'admin@ecshop.com', N'$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', N'Administrator', N'ADMIN', 1, 1),
(N'manager', N'manager@ecshop.com', N'$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', N'Manager', N'MANAGER', 1, 1),
(N'user', N'user@ecshop.com', N'$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', N'Regular User', N'USER', 1, 1);
GO

-- Create Categories table
IF OBJECT_ID('categories', 'U') IS NOT NULL
    DROP TABLE categories;
GO

CREATE TABLE categories (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    image NVARCHAR(255) NULL,
    is_show BIT NOT NULL DEFAULT 1,
    is_sub_home BIT NOT NULL DEFAULT 0,
    sort_order INT NOT NULL DEFAULT 1
);
GO

-- Insert sample categories
INSERT INTO categories (name, image, is_show, is_sub_home, sort_order) VALUES
(N'Son môi', 'son.jpg', 1, 0, 1),
(N'Kem dưỡng da', 'kem.jpg', 1, 1, 2),
(N'Nước hoa', 'nuochoa.jpg', 1, 0, 3),
(N'Sữa rửa mặt', 'srm.jpg', 1, 1, 4),
(N'Toner', 'toner.jpg', 1, 0, 5),
(N'Mascara', 'mascara.jpg', 1, 0, 6),
(N'Foundation', 'foundation.jpg', 1, 1, 7),
(N'Serum', 'serum.jpg', 1, 0, 8);