-- =============================================
-- BƯỚC 1 & 2: TẠO CSDL VÀ BẢNG PRODUCTS
-- =============================================
CREATE DATABASE IF NOT EXISTS demo;
USE demo;

DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(20) NOT NULL UNIQUE,
    productName VARCHAR(100) NOT NULL,
    productPrice DECIMAL(10, 2) NOT NULL,
    productAmount INT NOT NULL,
    productDescription TEXT,
    productStatus VARCHAR(20) DEFAULT 'Available'
);

-- Chèn dữ liệu mẫu
INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus) VALUES
('P001', 'iPhone 15', 999.99, 10, 'Smartphone Apple', 'Available'),
('P002', 'Samsung Galaxy S24', 899.99, 15, 'Smartphone Samsung', 'Available'),
('P003', 'MacBook Pro M3', 1999.99, 5, 'Laptop Apple', 'Available'),
('P004', 'Dell XPS 15', 1499.99, 8, 'Laptop Dell', 'Out of stock'),
('P005', 'iPad Air', 599.99, 12, 'Tablet Apple', 'Available');

-- =============================================
-- BƯỚC 3: TẠO INDEX VÀ KIỂM TRA HIỆU NĂNG
-- =============================================
-- Truy vấn trước khi tạo Index (để so sánh)
EXPLAIN SELECT * FROM Products WHERE productCode = 'P003';
EXPLAIN SELECT * FROM Products WHERE productName = 'iPhone 15' AND productPrice = 999.99;

-- 1. Tạo Unique Index trên cột productCode
ALTER TABLE Products ADD UNIQUE INDEX idx_productCode(productCode);

-- 2. Tạo Composite Index trên 2 cột productName và productPrice
ALTER TABLE Products ADD INDEX idx_name_price(productName, productPrice);

-- Truy vấn sau khi tạo Index (sử dụng EXPLAIN để kiểm tra)
EXPLAIN SELECT * FROM Products WHERE productCode = 'P003';
EXPLAIN SELECT * FROM Products WHERE productName = 'iPhone 15' AND productPrice = 999.99;

-- =============================================
-- BƯỚC 4: TẠO, SỬA VÀ XÓA VIEW
-- =============================================
-- 1. Tạo View
CREATE VIEW product_info_view AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;

-- Xem dữ liệu từ View
SELECT * FROM product_info_view;

-- 2. Sửa đổi View (CREATE OR REPLACE VIEW)
CREATE OR REPLACE VIEW product_info_view AS
SELECT productCode, productName, productPrice, productAmount, productStatus
FROM Products
WHERE productStatus = 'Available';

-- Xem lại View sau khi sửa
SELECT * FROM product_info_view;

-- 3. Xóa View
DROP VIEW product_info_view;

-- =============================================
-- BƯỚC 5: TẠO CÁC STORE PROCEDURE
-- =============================================

DELIMITER //

-- 1. Stored Procedure lấy tất cả thông tin sản phẩm
CREATE PROCEDURE sp_get_all_products()
BEGIN
    SELECT * FROM Products;
END //

-- 2. Stored Procedure thêm một sản phẩm mới
CREATE PROCEDURE sp_add_product(
    IN p_code VARCHAR(20),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10, 2),
    IN p_amount INT,
    IN p_des TEXT,
    IN p_status VARCHAR(20)
)
BEGIN
    INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (p_code, p_name, p_price, p_amount, p_des, p_status);
END //

-- 3. Stored Procedure sửa thông tin sản phẩm theo Id
CREATE PROCEDURE sp_update_product_by_id(
    IN p_id INT,
    IN p_code VARCHAR(20),
    IN p_name VARCHAR(100),
    IN p_price DECIMAL(10, 2),
    IN p_amount INT,
    IN p_des TEXT,
    IN p_status VARCHAR(20)
)
BEGIN
    UPDATE Products
    SET productCode = p_code,
        productName = p_name,
        productPrice = p_price,
        productAmount = p_amount,
        productDescription = p_des,
        productStatus = p_status
    WHERE Id = p_id;
END //

-- 4. Stored Procedure xóa sản phẩm theo Id
CREATE PROCEDURE sp_delete_product_by_id(
    IN p_id INT
)
BEGIN
    DELETE FROM Products WHERE Id = p_id;
END //

DELIMITER ;

-- Gọi thử nghiệm các Stored Procedure:
-- CALL sp_get_all_products();
-- CALL sp_add_product('P006', 'Sony Headphones', 299.99, 20, 'Noise cancelling', 'Available');
-- CALL sp_update_product_by_id(1, 'P001', 'iPhone 15 Pro', 1099.99, 10, 'Smartphone Apple Pro', 'Available');
-- CALL sp_delete_product_by_id(5);