
--Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...
-- 1 
--A
CREATE VIEW stock_inventory
AS SELECT item, inventory, category
FROM stock_items
WHERE inventory <= 20;
--B
CREATE VIEW total_sale
AS SELECT e.id, e.first_name, e.last_name, SUM(si.price) AS 'total_amount'
FROM sales s
JOIN employees e ON s.employee = e.id
JOIN stock_items si ON s.item = si.id
WHERE e.role = "sales"
GROUP BY e.id,e.first_name, e.last_name
ORDER BY total_amount DESC;
-- 2
CREATE TABLE data_log(
    log_id INT(10) PRIMARY KEY AUTO_INCREMENT, 
    timestamp TIMESTAMP, 
    action VARCHAR(255), 
    first_name VARCHAR(255), 
    last_name VARCHAR(255),
    pay_per_hour DECIMAL(10,2));
--A
DELIMITER //
    CREATE TRIGGER log_update_trigger
    AFTER UPDATE ON employees
    FOR EACH ROW
    BEGIN
        INSERT INTO data_log (timestamp, action, first_name, last_name, pay_per_hour)
        VALUES (NOW(), 'update', NEW.first_name, NEW.last_name, NEW.pay_per_hour);
    END;

//

DELIMITER ;
--B
DELIMITER //
    CREATE TRIGGER log_delete_trigger
    AFTER DELETE ON employees
    FOR EACH ROW
    BEGIN
        INSERT INTO data_log (timestamp, action, first_name, last_name, pay_per_hour)
        VALUES (NOW(), 'delete', OLD.first_name, OLD.last_name, OLD.pay_per_hour);
    END;

//

DELIMITER ;


