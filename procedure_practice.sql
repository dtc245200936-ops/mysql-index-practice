USE classicmodels;

-- 1. Tạo Stored Procedure lấy toàn bộ danh sách khách hàng
DELIMITER //

CREATE PROCEDURE findAllCustomers()
BEGIN
  SELECT * FROM customers;
END //

DELIMITER ;

-- 2. Gọi Stored Procedure vừa tạo để kiểm tra
CALL findAllCustomers();

-- 3. Xóa và tạo lại Stored Procedure để lọc khách hàng có customerNumber = 175
DELIMITER //

DROP PROCEDURE IF EXISTS `findAllCustomers`//

CREATE PROCEDURE findAllCustomers()
BEGIN
  SELECT * FROM customers WHERE customerNumber = 175;
END //

DELIMITER ;

-- 4. Gọi lại Stored Procedure sau khi đã cập nhật
CALL findAllCustomers();