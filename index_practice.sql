USE classicmodels;

-- 1. Kiểm tra khi CHƯA tạo Index
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- 2. Tạo Index cho cột customerName
ALTER TABLE customers ADD INDEX idx_customerName(customerName);

-- 3. Kiểm tra lại SAU KHI đã tạo Index
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- 4. Tạo Index kết hợp (Composite Index)
ALTER TABLE customers ADD INDEX idx_full_name(contactFirstName, contactLastName);

-- 5. Kiểm tra Index kết hợp
EXPLAIN SELECT * FROM customers WHERE contactFirstName = 'Jean' OR contactFirstName = 'King';

-- 6. Xóa Index vừa tạo
ALTER TABLE customers DROP INDEX idx_full_name;