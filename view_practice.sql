USE classicmodels;

-- 1. TẠO VIEW
CREATE VIEW customer_views AS
SELECT customerNumber, customerName, phone
FROM customers;

-- Xem kết quả bảng ảo vừa tạo
SELECT * FROM customer_views;


-- 2. CẬP NHẬT VIEW
CREATE OR REPLACE VIEW customer_views AS
SELECT customerNumber, customerName, contactFirstName, contactLastName, phone
FROM customers
WHERE city = 'Nantes';

-- Xem kết quả sau khi cập nhật
SELECT * FROM customer_views;


-- 3. XÓA VIEW
DROP VIEW customer_views;