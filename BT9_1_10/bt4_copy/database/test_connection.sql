-- =============================================
-- Script Test kết nối Database
-- Chạy script này để kiểm tra database setup
-- =============================================

USE MyDatabase;
GO

PRINT '==============================================';
PRINT 'KIỂM TRA KẾT NỐI VÀ SETUP DATABASE';
PRINT '==============================================';

-- Test 1: Kiểm tra database tồn tại
IF DB_ID('MyDatabase') IS NOT NULL
BEGIN
    PRINT '✓ Database MyDatabase tồn tại';
END
ELSE
BEGIN
    PRINT '✗ Database MyDatabase KHÔNG tồn tại - Cần chạy create_database.sql';
    RETURN;
END

-- Test 2: Kiểm tra các bảng
DECLARE @tableCount INT = 0;

IF OBJECT_ID('Users', 'U') IS NOT NULL
BEGIN
    PRINT '✓ Bảng Users tồn tại';
    SET @tableCount = @tableCount + 1;
END
ELSE
    PRINT '✗ Bảng Users KHÔNG tồn tại';

IF OBJECT_ID('Roles', 'U') IS NOT NULL
BEGIN
    PRINT '✓ Bảng Roles tồn tại';
    SET @tableCount = @tableCount + 1;
END
ELSE
    PRINT '✗ Bảng Roles KHÔNG tồn tại';

IF OBJECT_ID('Categories', 'U') IS NOT NULL
BEGIN
    PRINT '✓ Bảng Categories tồn tại';
    SET @tableCount = @tableCount + 1;
END
ELSE
    PRINT '✗ Bảng Categories KHÔNG tồn tại';

IF OBJECT_ID('Products', 'U') IS NOT NULL
BEGIN
    PRINT '✓ Bảng Products tồn tại';
    SET @tableCount = @tableCount + 1;
END
ELSE
    PRINT '✗ Bảng Products KHÔNG tồn tại';

-- Test 3: Kiểm tra dữ liệu
DECLARE @userCount INT, @roleCount INT, @categoryCount INT, @productCount INT;

SELECT @userCount = COUNT(*) FROM Users WHERE @tableCount >= 1;
SELECT @roleCount = COUNT(*) FROM Roles WHERE @tableCount >= 2;
SELECT @categoryCount = COUNT(*) FROM Categories WHERE @tableCount >= 3;
SELECT @productCount = COUNT(*) FROM Products WHERE @tableCount >= 4;

PRINT '';
PRINT 'THỐNG KÊ DỮ LIỆU:';
PRINT '- Users: ' + CAST(ISNULL(@userCount, 0) AS VARCHAR(10)) + ' records';
PRINT '- Roles: ' + CAST(ISNULL(@roleCount, 0) AS VARCHAR(10)) + ' records';
PRINT '- Categories: ' + CAST(ISNULL(@categoryCount, 0) AS VARCHAR(10)) + ' records';
PRINT '- Products: ' + CAST(ISNULL(@productCount, 0) AS VARCHAR(10)) + ' records';

-- Test 4: Kiểm tra tài khoản admin
IF EXISTS (SELECT * FROM Users WHERE username = 'admin' AND roleid = 2)
BEGIN
    PRINT '✓ Tài khoản Admin tồn tại';
END
ELSE
BEGIN
    PRINT '✗ Tài khoản Admin KHÔNG tồn tại - Cần chạy insert_sample_data.sql';
END

-- Test 5: Test query cơ bản
BEGIN TRY
    DECLARE @testResult NVARCHAR(100);
    SELECT TOP 1 @testResult = fullname FROM Users WHERE roleid = 2;
    PRINT '✓ Test query thành công: ' + ISNULL(@testResult, 'NULL');
END TRY
BEGIN CATCH
    PRINT '✗ Lỗi khi test query: ' + ERROR_MESSAGE();
END CATCH

-- Test 6: Kiểm tra foreign key
IF EXISTS (
    SELECT * FROM sys.foreign_keys 
    WHERE name = 'FK_Users_Roles'
)
BEGIN
    PRINT '✓ Foreign Key Users -> Roles tồn tại';
END
ELSE
BEGIN
    PRINT '✗ Foreign Key Users -> Roles KHÔNG tồn tại';
END

-- Test 7: Kiểm tra index
DECLARE @indexCount INT;
SELECT @indexCount = COUNT(*) 
FROM sys.indexes 
WHERE name IN ('IX_Users_Username', 'IX_Users_Email', 'IX_Categories_Name');

PRINT '✓ Tìm thấy ' + CAST(@indexCount AS VARCHAR(10)) + '/3 indexes';

PRINT '';
PRINT '==============================================';
IF @tableCount = 4 AND @userCount > 0 AND @roleCount > 0
BEGIN
    PRINT 'KẾT QUẢ: DATABASE SETUP THÀNH CÔNG! ✓';
    PRINT 'Bạn có thể bắt đầu sử dụng ứng dụng.';
END
ELSE
BEGIN
    PRINT 'KẾT QUẢ: CẦN SETUP THÊM! ✗';
    PRINT 'Hãy chạy create_database.sql và insert_sample_data.sql';
END
PRINT '==============================================';

-- Hiển thị connection string để copy
PRINT '';
PRINT 'CONNECTION STRING INFO:';
PRINT 'Server: localhost:1433';
PRINT 'Database: MyDatabase';
PRINT 'User: sa';
PRINT 'Password: 1';
PRINT 'URL: jdbc:sqlserver://localhost:1433;databaseName=MyDatabase;encrypt=false;trustServerCertificate=true';