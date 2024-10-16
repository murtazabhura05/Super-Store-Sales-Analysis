-- SALES ANALYSIS
-- Total number of Sales over a period
SELECT concat("$",SUM(sales)) AS total_sales
FROM sales;

-- Total Sales by YEAR
SELECT YEAR(order_date) AS YEAR, SUM(sales) AS total_sales
FROM sales
GROUP BY YEAR
ORDER BY total_sales DESC;

-- Total Sales by MONTH
SELECT  DATE_FORMAT(order_date, '%M') AS MONTH, SUM(sales) AS total_sales
FROM sales
GROUP BY MONTH;

-- Total Sales by SHIP MODE
SELECT ship_mode, SUM(sales) AS total_sales
FROM sales
GROUP BY ship_mode
ORDER BY total_sales DESC;

-- Total Sales by CUSTOMERS
SELECT customer_name, SUM(sales) AS total_sales
FROM sales
GROUP BY customer_name
ORDER BY total_sales DESC;

-- Total Sales by SEGMENT
SELECT segment, SUM(sales) AS total_sales
FROM sales
GROUP BY segment
ORDER BY total_sales DESC;

-- Total Sales by STATE
SELECT state, SUM(sales) AS total_sales
FROM sales
GROUP BY state
ORDER BY total_sales DESC;

-- Total Sales by COUNTRY
SELECT country, SUM(sales) AS total_sales
FROM sales
GROUP BY country
ORDER BY total_sales DESC;

-- Total Sales by MARKET
SELECT market, SUM(sales) AS total_sales
FROM sales
GROUP BY market
ORDER BY total_sales DESC;

-- Total Sales by REGION
SELECT region, SUM(sales) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

-- Total Sales by PRODUCT
SELECT product_id, product_name, SUM(sales) AS total_sales
FROM sales
GROUP BY product_id, product_name
ORDER BY total_sales DESC;

-- Total Sales by ORDER PRIORITY
SELECT order_priority, SUM(sales) AS total_sales
FROM sales
GROUP BY order_priority
ORDER BY total_sales DESC;
