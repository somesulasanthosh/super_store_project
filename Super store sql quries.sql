-------phase 1:------
select * from [ Superstore_data]

-----PHASE 2: DATA CLEANING (SQL)----
------1)Check Nulls------
SELECT *
FROM [ Superstore_data]
WHERE sales IS NULL OR profit IS NULL;

----2. Remove Duplicates---
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY order_id, product_id ORDER BY order_id) AS rn
    FROM [ Superstore_data]
)
DELETE FROM CTE
WHERE rn > 1;


-----PHASE 3: BUSINESS SQL QUERIES----
---1. Total Sales--
SELECT SUM(sales) AS total_sales
FROM [ Superstore_data];

-----2. Total Profit----
SELECT SUM(profit) AS total_profit
FROM [ Superstore_data];

----3. Total Orders---
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM [ Superstore_data];

---- 4. Sales by Region---
SELECT region, SUM(sales) AS total_sales
FROM [ Superstore_data]
GROUP BY region;

----- 5. Sales by Category ----
SELECT category, SUM(sales) AS total_sales
FROM [ Superstore_data]
GROUP BY category;

----- 6. Top 10 Customers---
SELECT TOP 10
    customer_name,
    SUM(sales) AS total_sales
FROM [ Superstore_data]
GROUP BY customer_name
ORDER BY total_sales DESC;

------ 7. Top 10 Products---
SELECT TOP 10
    Product_Name,
    SUM(sales) AS total_sales
FROM [ Superstore_data]
GROUP BY Product_Name
ORDER BY total_sales DESC;

---- 8. Monthly Sales Trend---
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(sales) AS total_sales
FROM [ Superstore_data]
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

----- 9. Yearly Sales Trend---
SELECT 
    YEAR(order_date) AS year,
    SUM(sales) AS total_sales
FROM [ Superstore_data]
GROUP BY YEAR(order_date)
ORDER BY year;

---- 10. Discount vs Profit---
SELECT discount, SUM(profit) AS total_profit
FROM [ Superstore_data]
GROUP BY discount
ORDER BY discount;

----- 11. Loss Making Products--
SELECT product_name, SUM(profit) AS total_profit
FROM [ Superstore_data]
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;

---- 12. Average Order Value---
SELECT 
    SUM(sales) / COUNT(DISTINCT order_id) AS avg_order_value
FROM [ Superstore_data];


----- 13. Bottom 10 Products by Profit----
SELECT TOP 10
    product_name,
    SUM(profit) AS total_profit
FROM [ Superstore_data]
GROUP BY product_name
ORDER BY total_profit ASC;


--- 14 . Sales and Profit by Segment
SELECT
    segment,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM [ Superstore_data]
GROUP BY segment
ORDER BY total_sales asc;

--- 15. Sales by Ship Mode
SELECT
    ship_mode,
    SUM(sales) AS total_sales
FROM [ Superstore_data]
GROUP BY ship_mode
ORDER BY total_sales asc;

--- 16. Top 10 States by Profit
SELECT TOP 10
    state,
    SUM(profit) AS total_profit
FROM [ Superstore_data]
GROUP BY state
ORDER BY total_profit DESC;