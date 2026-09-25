USE quickfeed_db;

SELECT 
    table_name AS `Table`,
    ROUND(((data_length) / 1024), 2) AS `Data_Size_KB`,
    ROUND(((index_length) / 1024), 2) AS `Index_Size_KB`,
    ROUND(((data_length + index_length) / 1024), 2) AS `Total_Size_KB`
FROM information_schema.TABLES
WHERE table_schema = 'quickfeed_db' AND table_name = 'Posts';