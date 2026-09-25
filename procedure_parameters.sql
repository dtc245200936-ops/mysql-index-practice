USE classicmodels;

-- =============================================
-- 1. THAM SỐ LOẠI IN
-- =============================================
DROP PROCEDURE IF EXISTS getCusById;

DELIMITER //
CREATE PROCEDURE getCusById(IN cusNum INT(11))
BEGIN
  SELECT * FROM customers WHERE customerNumber = cusNum;
END //
DELIMITER ;

-- Gọi Stored Procedure loại IN:
CALL getCusById(175);


-- =============================================
-- 2. THAM SỐ LOẠI OUT
-- =============================================
DROP PROCEDURE IF EXISTS GetCustomersCountByCity;

DELIMITER //
CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //
DELIMITER ;

-- Gọi Stored Procedure loại OUT:
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total;


-- =============================================
-- 3. THAM SỐ LOẠI INOUT
-- =============================================
DROP PROCEDURE IF EXISTS SetCounter;

DELIMITER //
CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //
DELIMITER ;

-- Gọi Stored Procedure loại INOUT:
SET @counter = 1;
CALL SetCounter(@counter, 1); -- counter thành 2
CALL SetCounter(@counter, 1); -- counter thành 3
CALL SetCounter(@counter, 5); -- counter thành 8
SELECT @counter; -- Kết quả xuất ra: 8