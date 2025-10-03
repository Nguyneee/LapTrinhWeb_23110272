

-- 1. Tạo database (nếu chưa tồn tại)
CREATE DATABASE IF NOT EXISTS BT0110
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- 2. Sử dụng database BT0110
USE BT0110;

-- 3. Tạo bảng users
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    enabled TINYINT(1) NOT NULL DEFAULT 1,
    account_non_expired TINYINT(1) NOT NULL DEFAULT 1,
    account_non_locked TINYINT(1) NOT NULL DEFAULT 1,
    credentials_non_expired TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6)
);

-- 4. Thêm dữ liệu mẫu (optional)
INSERT INTO users (username, password, email, role, enabled)
VALUES
    ('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'admin@example.com', 'ADMIN', 1),
    ('test', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.', 'test@example.com', 'USER', 1)
ON DUPLICATE KEY UPDATE
    password = VALUES(password),
    role = VALUES(role),
    enabled = VALUES(enabled),
    updated_at = CURRENT_TIMESTAMP(6);

-- 5. Tạo trigger để tự động cập nhật updated_at (bổ sung cho các client cũ không khai thác ON UPDATE)
DELIMITER $$
DROP TRIGGER IF EXISTS tr_users_updated_at $$
CREATE TRIGGER tr_users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP(6);
END $$
DELIMITER ;

-- 6. Tạo stored procedure để tạo user mới
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_CreateUser $$
CREATE PROCEDURE sp_CreateUser(
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_email VARCHAR(100),
    IN p_role VARCHAR(20)
)
BEGIN
    DECLARE v_user_exists INT DEFAULT 0;
    DECLARE v_email_exists INT DEFAULT 0;
    DECLARE v_role VARCHAR(20);

    SELECT COUNT(*) INTO v_user_exists FROM users WHERE username = p_username;
    IF v_user_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Username already exists';
    END IF;

    SELECT COUNT(*) INTO v_email_exists FROM users WHERE email = p_email;
    IF v_email_exists > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already exists';
    END IF;

    SET v_role = COALESCE(p_role, 'USER');

    INSERT INTO users (username, password, email, role)
    VALUES (p_username, p_password, p_email, v_role);

    SELECT 'User created successfully' AS result;
END $$
DELIMITER ;

-- 7. Tạo stored procedure để tìm user theo username
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_FindUserByUsername $$
CREATE PROCEDURE sp_FindUserByUsername(IN p_username VARCHAR(50))
BEGIN
    SELECT 
        id,
        username,
        password,
        email,
        role,
        enabled,
        account_non_expired,
        account_non_locked,
        credentials_non_expired,
        created_at,
        updated_at
    FROM users
    WHERE username = p_username;
END $$
DELIMITER ;

-- 8. Tạo stored procedure để tìm user theo email
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_FindUserByEmail $$
CREATE PROCEDURE sp_FindUserByEmail(IN p_email VARCHAR(100))
BEGIN
    SELECT 
        id,
        username,
        password,
        email,
        role,
        enabled,
        account_non_expired,
        account_non_locked,
        credentials_non_expired,
        created_at,
        updated_at
    FROM users
    WHERE email = p_email;
END $$
DELIMITER ;

-- 9. Hiển thị thông tin database
SELECT 
    'Database setup completed successfully!' AS status,
    DATABASE() AS database_name,
    COUNT(*) AS user_count
FROM users;

SELECT '=============================================' AS info;
