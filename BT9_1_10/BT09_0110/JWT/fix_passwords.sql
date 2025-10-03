
USE springboot1001;

-- Cập nhật password hash đúng cho user 'test' (password: test123)
UPDATE users 
SET password = '$2a$10$eImiTXuWiQKVv7o3G1Lrmu4VNrchDJVGjVz9ToBgbrmxFgeJsMHxu'
WHERE username = 'test';
SELECT 'Updated password for user: test (password: test123)' AS info;

-- Cập nhật password hash đúng cho user 'admin' (password: admin123)
UPDATE users 
SET password = '$2a$10$VEjAiGztXXmkcmJ.fG9gTO5k.0L8CSvhgNz3auJi4T2GK9QzUWP9.'
WHERE username = 'admin';
SELECT 'Updated password for user: admin (password: admin123)' AS info;

-- Thêm user newuser123 với password: password123
INSERT INTO users (username, password, email, role, enabled)
VALUES (
    'newuser123',
    '$2a$10$YTqw1GX8TLWORdFxyNqEkOgcbcZazpRKWomUIwiJ7MF9/jUYI.hwy',
    'newuser123@example.com',
    'USER',
    1
)
ON DUPLICATE KEY UPDATE
    password = VALUES(password),
    email = VALUES(email),
    updated_at = CURRENT_TIMESTAMP(6);
SELECT 'Ensured user: newuser123 (password: password123)' AS info;

-- Thêm các user test khác với password: password123
INSERT INTO users (username, password, email, role, enabled)
VALUES 
    ('testuser4', '$2a$10$YTqw1GX8TLWORdFxyNqEkOgcbcZazpRKWomUIwiJ7MF9/jUYI.hwy', 'testuser4@example.com', 'USER', 1),
    ('testuser5', '$2a$10$YTqw1GX8TLWORdFxyNqEkOgcbcZazpRKWomUIwiJ7MF9/jUYI.hwy', 'testuser5@example.com', 'USER', 1),
    ('testuser6', '$2a$10$YTqw1GX8TLWORdFxyNqEkOgcbcZazpRKWomUIwiJ7MF9/jUYI.hwy', 'testuser6@example.com', 'USER', 1),
    ('testuser999', '$2a$10$YTqw1GX8TLWORdFxyNqEkOgcbcZazpRKWomUIwiJ7MF9/jUYI.hwy', 'testuser999@example.com', 'USER', 1),
    ('testuser2025', '$2a$10$YTqw1GX8TLWORdFxyNqEkOgcbcZazpRKWomUIwiJ7MF9/jUYI.hwy', 'testuser2025@example.com', 'USER', 1)
ON DUPLICATE KEY UPDATE
    password = VALUES(password),
    email = VALUES(email),
    updated_at = CURRENT_TIMESTAMP(6);
SELECT 'Ensured batch test users with password: password123' AS info;

-- Hiển thị tất cả users và thông tin của họ
SELECT 
    id,
    username,
    email,
    role,
    enabled,
    created_at
FROM users
ORDER BY id;

SELECT '=============================================' AS info;
SELECT 'Password hashes updated successfully!' AS info;
SELECT 'All users now have correct BCrypt password hashes' AS info;
SELECT 'Test accounts available:' AS info;
SELECT '  - admin / admin123' AS info;
SELECT '  - test / test123' AS info;
SELECT '  - newuser123 / password123' AS info;
SELECT '  - testuser4 / password123' AS info;
SELECT '  - testuser5 / password123' AS info;
SELECT '  - testuser6 / password123' AS info;
SELECT '  - testuser999 / password123' AS info;
SELECT '  - testuser2025 / password123' AS info;
SELECT '=============================================' AS info;
