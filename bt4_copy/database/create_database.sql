-- =============================================
-- Script tạo cơ sở dữ liệu cho LTW Project
-- Database: MyDatabase
-- Server: SQL Server
-- =============================================

-- Tạo database nếu chưa tồn tại
USE master;
GO

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'MyDatabase')
BEGIN
    CREATE DATABASE MyDatabase;
    PRINT 'Database MyDatabase đã được tạo thành công!';
END
ELSE
BEGIN
    PRINT 'Database MyDatabase đã tồn tại!';
END
GO

-- Sử dụng database MyDatabase
USE MyDatabase;
GO

-- =============================================
-- Tạo bảng Users (Bảng người dùng)
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Users' AND xtype='U')
BEGIN
    CREATE TABLE Users (
        id INT IDENTITY(1,1) PRIMARY KEY,
        username NVARCHAR(50) NOT NULL UNIQUE,
        email NVARCHAR(100) NOT NULL UNIQUE,
        password NVARCHAR(255) NOT NULL,
        fullname NVARCHAR(100) NOT NULL,
        avatar NVARCHAR(255) NULL DEFAULT 'default.png',
        roleid INT NOT NULL DEFAULT 1,
        phone NVARCHAR(15) NULL,
        createDate DATETIME NOT NULL DEFAULT GETDATE(),
        isActive BIT NOT NULL DEFAULT 1
    );
    PRINT 'Bảng Users đã được tạo thành công!';
END
ELSE
BEGIN
    PRINT 'Bảng Users đã tồn tại!';
END
GO

-- =============================================
-- Tạo bảng Roles (Bảng vai trò)
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Roles' AND xtype='U')
BEGIN
    CREATE TABLE Roles (
        roleid INT IDENTITY(1,1) PRIMARY KEY,
        rolename NVARCHAR(50) NOT NULL UNIQUE,
        description NVARCHAR(255) NULL
    );
    PRINT 'Bảng Roles đã được tạo thành công!';
END
ELSE
BEGIN
    PRINT 'Bảng Roles đã tồn tại!';
END
GO

-- =============================================
-- Tạo bảng Categories (Bảng danh mục)
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Categories' AND xtype='U')
BEGIN
    CREATE TABLE Categories (
        cateId INT IDENTITY(1,1) PRIMARY KEY,
        cateName NVARCHAR(100) NOT NULL,
        icons NVARCHAR(255) NULL,
        createdDate DATETIME NOT NULL DEFAULT GETDATE(),
        isActive BIT NOT NULL DEFAULT 1
    );
    PRINT 'Bảng Categories đã được tạo thành công!';
END
ELSE
BEGIN
    PRINT 'Bảng Categories đã tồn tại!';
END
GO

-- =============================================
-- Tạo bảng Products (Bảng sản phẩm - mở rộng)
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Products' AND xtype='U')
BEGIN
    CREATE TABLE Products (
        productId INT IDENTITY(1,1) PRIMARY KEY,
        productName NVARCHAR(255) NOT NULL,
        description NTEXT NULL,
        price DECIMAL(18,2) NOT NULL DEFAULT 0,
        image NVARCHAR(255) NULL,
        cateId INT NOT NULL,
        createdDate DATETIME NOT NULL DEFAULT GETDATE(),
        updatedDate DATETIME NULL,
        isActive BIT NOT NULL DEFAULT 1,
        FOREIGN KEY (cateId) REFERENCES Categories(cateId)
    );
    PRINT 'Bảng Products đã được tạo thành công!';
END
ELSE
BEGIN
    PRINT 'Bảng Products đã tồn tại!';
END
GO

-- =============================================
-- Thêm Foreign Key constraint cho Users và Roles
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Users_Roles')
BEGIN
    ALTER TABLE Users 
    ADD CONSTRAINT FK_Users_Roles 
    FOREIGN KEY (roleid) REFERENCES Roles(roleid);
    PRINT 'Foreign Key Users -> Roles đã được tạo!';
END
GO

-- =============================================
-- Tạo Index để tối ưu hóa truy vấn
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_Username')
BEGIN
    CREATE INDEX IX_Users_Username ON Users(username);
    PRINT 'Index IX_Users_Username đã được tạo!';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_Email')
BEGIN
    CREATE INDEX IX_Users_Email ON Users(email);
    PRINT 'Index IX_Users_Email đã được tạo!';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Categories_Name')
BEGIN
    CREATE INDEX IX_Categories_Name ON Categories(cateName);
    PRINT 'Index IX_Categories_Name đã được tạo!';
END
GO

-- =============================================
-- In thông báo hoàn thành
-- =============================================
PRINT '==============================================';
PRINT 'HOÀN THÀNH TẠO CƠ SỞ DỮ LIỆU!';
PRINT 'Database: MyDatabase';
PRINT 'Tables: Users, Roles, Categories, Products';
PRINT '==============================================';