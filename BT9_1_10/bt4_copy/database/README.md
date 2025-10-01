# Hướng dẫn Setup Database cho LTW Project

## Yêu cầu hệ thống
- SQL Server 2019 hoặc mới hơn
- SQL Server Management Studio (SSMS)
- Quyền sysadmin hoặc dbcreator

## Cấu hình Database hiện tại
```
Server: localhost
Port: 1433
Database: MyDatabase
Username: sa
Password: 1
```

## Các bước thực hiện

### Bước 1: Khởi động SQL Server
Đảm bảo SQL Server đang chạy trên máy tính của bạn.

### Bước 2: Kết nối SQL Server
Mở SQL Server Management Studio và kết nối với:
- Server name: `localhost` hoặc `localhost\SQLEXPRESS`
- Authentication: SQL Server Authentication
- Login: `sa`
- Password: `1`

### Bước 3: Tạo Database và Tables
1. Mở file `create_database.sql` trong SSMS
2. Chạy script này để tạo database và các bảng

```sql
-- Chạy file này trước
create_database.sql
```

### Bước 4: Insert dữ liệu mẫu
1. Mở file `insert_sample_data.sql` trong SSMS  
2. Chạy script này để thêm dữ liệu mẫu

```sql
-- Chạy file này sau
insert_sample_data.sql
```

## Cấu trúc Database

### Bảng Users
- `id` - Primary Key (Auto Increment)
- `username` - Tên đăng nhập (Unique)
- `email` - Email (Unique)
- `password` - Mật khẩu
- `fullname` - Họ và tên
- `avatar` - Ảnh đại diện
- `roleid` - ID vai trò (FK)
- `phone` - Số điện thoại
- `createDate` - Ngày tạo
- `isActive` - Trạng thái hoạt động

### Bảng Roles
- `roleid` - Primary Key (Auto Increment)
- `rolename` - Tên vai trò
- `description` - Mô tả vai trò

### Bảng Categories
- `cateId` - Primary Key (Auto Increment)
- `cateName` - Tên danh mục
- `icons` - Icon hiển thị
- `createdDate` - Ngày tạo
- `isActive` - Trạng thái hoạt động

### Bảng Products (Mở rộng)
- `productId` - Primary Key (Auto Increment)
- `productName` - Tên sản phẩm
- `description` - Mô tả sản phẩm
- `price` - Giá sản phẩm
- `image` - Hình ảnh sản phẩm
- `cateId` - ID danh mục (FK)
- `createdDate` - Ngày tạo
- `updatedDate` - Ngày cập nhật
- `isActive` - Trạng thái hoạt động

## Tài khoản mẫu

### Admin Account
- Username: `admin`
- Password: `123456`
- Email: `admin@example.com`
- Role: Admin

### Manager Account
- Username: `manager`
- Password: `123456`
- Email: `manager@example.com`
- Role: Manager

### User Account
- Username: `user1`
- Password: `123456`
- Email: `user1@example.com`
- Role: User

## Kiểm tra kết nối

Sau khi setup xong, bạn có thể test kết nối bằng cách:

1. Chạy ứng dụng web
2. Truy cập http://localhost:8080/login
3. Đăng nhập với tài khoản admin hoặc user ở trên

## Troubleshooting

### Lỗi kết nối database
1. Kiểm tra SQL Server có đang chạy không
2. Kiểm tra tên server và port
3. Kiểm tra username/password
4. Kiểm tra firewall và SQL Server Configuration

### Lỗi permission
1. Đảm bảo user `sa` được enable
2. Kiểm tra SQL Server Authentication mode
3. Grant quyền cần thiết cho user

### Lỗi database không tồn tại
1. Chạy lại script `create_database.sql`
2. Kiểm tra tên database trong connection string

## Backup và Restore

### Backup Database
```sql
BACKUP DATABASE MyDatabase 
TO DISK = 'C:\Backup\MyDatabase.bak'
```

### Restore Database  
```sql
RESTORE DATABASE MyDatabase 
FROM DISK = 'C:\Backup\MyDatabase.bak'
```

## Lưu ý quan trọng

⚠️ **Password mặc định**: Tất cả tài khoản mẫu đều sử dụng password `123456`. Trong production, hãy đổi password mạnh hơn.

⚠️ **Security**: Trong môi trường production, không nên sử dụng tài khoản `sa` và nên tạo user riêng với quyền hạn chế.

⚠️ **Encoding**: Database sử dụng NVARCHAR để hỗ trợ tiếng Việt.