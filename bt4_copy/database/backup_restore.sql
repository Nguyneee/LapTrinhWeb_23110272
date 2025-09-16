-- =============================================
-- Script Backup và Restore Database
-- =============================================

USE master;
GO

-- =============================================
-- BACKUP DATABASE
-- =============================================
DECLARE @BackupPath NVARCHAR(500);
DECLARE @FileName NVARCHAR(500);
DECLARE @Date NVARCHAR(20);

-- Tạo tên file backup với timestamp
SET @Date = REPLACE(REPLACE(REPLACE(CONVERT(NVARCHAR, GETDATE(), 120), '-', ''), ' ', '_'), ':', '');
SET @FileName = 'MyDatabase_Backup_' + @Date + '.bak';
SET @BackupPath = 'C:\Backup\' + @FileName;

-- Tạo thư mục backup nếu chưa có
EXEC xp_cmdshell 'if not exist "C:\Backup" mkdir "C:\Backup"', no_output;

PRINT 'Bắt đầu backup database MyDatabase...';
PRINT 'File backup: ' + @BackupPath;

BACKUP DATABASE MyDatabase 
TO DISK = @BackupPath
WITH INIT, 
     FORMAT,
     COMPRESSION,
     STATS = 10;

PRINT 'Backup hoàn thành thành công!';
PRINT 'File: ' + @BackupPath;
PRINT 'Dung lượng backup: ';

-- Kiểm tra thông tin backup
SELECT 
    database_name,
    backup_start_date,
    backup_finish_date,
    CAST(backup_size/1024/1024 AS VARCHAR(10)) + ' MB' as backup_size,
    physical_device_name
FROM msdb.dbo.backupset bs
INNER JOIN msdb.dbo.backupmediafamily bmf ON bs.media_set_id = bmf.media_set_id
WHERE database_name = 'MyDatabase'
  AND backup_start_date >= DATEADD(MINUTE, -5, GETDATE())
ORDER BY backup_start_date DESC;

GO

-- =============================================
-- SCRIPT RESTORE (Comment để tránh chạy nhầm)
-- =============================================

/*
-- ⚠️ CẢNH BÁO: Script restore sẽ xóa database hiện tại!
-- Chỉ uncomment và chạy khi cần restore

USE master;
GO

-- Ngắt kết nối tất cả user khỏi database
ALTER DATABASE MyDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- Restore database
RESTORE DATABASE MyDatabase 
FROM DISK = 'C:\Backup\MyDatabase_Backup_YYYYMMDD_HHMMSS.bak'
WITH REPLACE, STATS = 10;
GO

-- Cho phép kết nối trở lại
ALTER DATABASE MyDatabase SET MULTI_USER;
GO

PRINT 'Restore database hoàn thành!';
*/

-- =============================================
-- SCRIPT EXPORT DỮ LIỆU THÀNH INSERT STATEMENTS
-- =============================================

USE MyDatabase;
GO

PRINT '=============================================';
PRINT 'EXPORT DỮ LIỆU THÀNH INSERT STATEMENTS';
PRINT '=============================================';

-- Export Roles
PRINT '-- Export Roles Data';
SELECT 'INSERT INTO Roles (rolename, description) VALUES (''' + 
       rolename + ''', ''' + ISNULL(description, '') + ''');'
FROM Roles;

PRINT '';

-- Export Categories  
PRINT '-- Export Categories Data';
SELECT 'INSERT INTO Categories (cateName, icons) VALUES (''' + 
       cateName + ''', ''' + ISNULL(icons, '') + ''');'
FROM Categories;

PRINT '';

-- Export Users (without password for security)
PRINT '-- Export Users Data (passwords hidden)';
SELECT 'INSERT INTO Users (username, email, password, fullname, avatar, roleid, phone) VALUES (''' + 
       username + ''', ''' + email + ''', ''[HIDDEN]'', ''' + fullname + ''', ''' + 
       ISNULL(avatar, '') + ''', ' + CAST(roleid AS VARCHAR) + ', ''' + ISNULL(phone, '') + ''');'
FROM Users;

PRINT '';
PRINT 'Export hoàn thành! Copy các INSERT statements ở trên để backup dữ liệu.';