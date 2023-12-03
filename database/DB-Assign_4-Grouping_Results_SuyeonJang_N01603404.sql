--YOUR NAME HERE	ASSIGNMENT 4 GROUPING RESULTS
--Put your answers on the lines after each letter. E.g. your query for question 1A should go on line 5; your query for question 1B should go on line 7...
-- 1 
--A
SELECT MIN(price) FROM stock_items;
--B
SELECT MAX(inventory) FROM stock_items;

-- 2
--A
SELECT role, COUNT(role)FROM employees GROUP BY role;
--B
SELECT role, COUNT(role), COUNT(phone) FROM employees GROUP BY role;

-- 3
--A
SELECT category AS "Mammals", COUNT(item) FROM stock_items WHERE category NOT IN("Piscine") GROUP BY category;
--B
SELECT category AS "Animal", SUM(inventory) AS "In stock" FROM stock_items GROUP BY category ORDER BY SUM(inventory) ASC;
--C
SELECT category, MAX(price) AS "Highest price" FROM stock_items GROUP BY category ORDER BY Max(price) DESC;
--D
SELECT category, MAX(price) AS "Highest price" FROM stock_items GROUP BY category HAVING Max(price) > 50 ORDER BY Max(price) DESC;