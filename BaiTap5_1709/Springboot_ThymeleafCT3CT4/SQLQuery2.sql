IF DB_ID('LTWEB012') IS NOT NULL
    DROP DATABASE LTWEB012;
GO

CREATE DATABASE LTWEB012;
GO

USE LTWEB012;
GO
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
INSERT INTO categories (name, image, is_show, is_sub_home, sort_order) VALUES
(N'Son môi', 'son.jpg', 1, 0, 1),
(N'Kem dưỡng da', 'kem.jpg', 1, 1, 2),
(N'Nước hoa', 'nuochoa.jpg', 1, 0, 3),
(N'Sữa rửa mặt', 'srm.jpg', 1, 1, 4),
(N'Toner', 'toner.jpg', 1, 0, 5);