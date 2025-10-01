@echo off
echo =============================================
echo        SETUP DATABASE CHO LTW PROJECT
echo =============================================
echo.

:: Kiểm tra SQL Server có chạy không
echo [1/4] Kiểm tra SQL Server...
sc query "MSSQLSERVER" >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ SQL Server không chạy! Hãy khởi động SQL Server trước.
    pause
    exit /b 1
)
echo ✅ SQL Server đang chạy

:: Kiểm tra sqlcmd có sẵn không
echo [2/4] Kiểm tra sqlcmd...
where sqlcmd >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ sqlcmd không tìm thấy! Hãy cài đặt SQL Server Command Line Tools.
    echo Tải từ: https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility
    pause
    exit /b 1
)
echo ✅ sqlcmd sẵn sàng

:: Tạo database và tables
echo [3/4] Tạo database và tables...
sqlcmd -S localhost -U sa -P 1 -i "create_database.sql"
if %errorlevel% neq 0 (
    echo ❌ Lỗi khi tạo database! Kiểm tra:
    echo    - SQL Server có đang chạy?
    echo    - Username/password có đúng?
    echo    - File create_database.sql có tồn tại?
    pause
    exit /b 1
)
echo ✅ Database và tables đã được tạo

:: Insert dữ liệu mẫu
echo [4/4] Insert dữ liệu mẫu...
sqlcmd -S localhost -U sa -P 1 -i "insert_sample_data.sql"
if %errorlevel% neq 0 (
    echo ❌ Lỗi khi insert dữ liệu!
    pause
    exit /b 1
)
echo ✅ Dữ liệu mẫu đã được thêm

echo.
echo =============================================
echo           SETUP HOÀN THÀNH! 🎉
echo =============================================
echo.
echo ✅ Database: MyDatabase
echo ✅ Server: localhost:1433
echo ✅ User: sa / Pass: 1
echo.
echo TÀI KHOẢN TEST:
echo 👤 Admin: admin / 123456
echo 👤 Manager: manager / 123456  
echo 👤 User: user1 / 123456
echo.
echo Bây giờ bạn có thể:
echo 1. Chạy ứng dụng web
echo 2. Truy cập http://localhost:8080/login
echo 3. Đăng nhập với tài khoản trên
echo.

:: Chạy test connection
echo Bạn có muốn test kết nối database không? (Y/N)
set /p choice=
if /i "%choice%"=="Y" (
    echo.
    echo Testing database connection...
    sqlcmd -S localhost -U sa -P 1 -i "test_connection.sql"
)

echo.
echo Nhấn Enter để thoát...
pause >nul