--YOUR NAME HERE	ASSIGNMENT 5 JOINING TABLES
--Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...
--1 
-- A
SELECT sales.date, stock_items.item FROM stock_items JOIN sales ON stock_items.id = sales.item where stock_items.id = 1014;
-- B
SELECT sales.employee, stock_items.id, stock_items.category, stock_items.item FROM stock_items JOIN sales ON sales.item = stock_items.id WHERE stock_items.category = "feline";

--2
-- A
SELECT sales.date, sales.item, employees.first_name, employees.last_name FROM employees JOIN sales ON sales.employee = employees.id WHERE employees.id = 111;
-- B
SELECT CONCAT(employees.first_name," ",employees.last_name), employees.sin, employees.role, sales.item FROM employees RIGHT JOIN sales ON employees.id = sales.employee WHERE employees.sin LIKE "258%" OR employees.sin LIKE "456%" OR employees.sin LIKE"753%";

--3
-- A
SELECT sales.date, sales.item, employees.first_name FROM sales JOIN employees ON sales.employee = employees.id WHERE sales.date BETWEEN "2021-06-12" AND "2021-06-18";
-- B
SELECT CONCAT(employees.first_name," ",employees.last_name) as employ_name, count(*) AS sals_count FROM sales JOIN employees ON sales.employee = employees.id GROUP BY employ_name;
--4
-- A
SELECT s.date, si.category, si.price, si.item, e.first_name 
FROM sales s 
LEFT JOIN stock_items si ON s.item = si.id 
JOIN employees e ON s.employee = e.id 
WHERE CONCAT(e.first_name," ",e.last_name) = "Farud Said";
-- B
SELECT sales.item, stock_items.id, stock_items.item, stock_items.price, stock_items.category FROM stock_items LEFT JOIN sales ON stock_items.id = sales.item ORDER BY stock_items.id;