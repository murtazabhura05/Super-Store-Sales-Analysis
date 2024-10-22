-- PRODUCT ANALYSIS
-- Total Sales per Product
SELECT product_name, SUM(sales) AS total_sales
FROM sales
GROUP BY product_name
ORDER BY total_sales DESC;

-- Top 10 Most Profitable Products
SELECT product_name, SUM(profit) AS total_profit
FROM sales
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

-- Product Sales by Category
SELECT category, product_name, SUM(sales) AS total_sales
FROM sales
GROUP BY category, product_name
ORDER BY total_sales DESC;

-- Product Sales by Sub-Category
SELECT sub_category, product_name, SUM(sales) AS total_sales
FROM sales
GROUP BY sub_category, product_name
ORDER BY total_sales DESC;

-- Product Sales by Region
SELECT region, product_name, SUM(sales) AS total_sales
FROM sales
GROUP BY region, product_name
ORDER BY total_sales DESC;

-- Most Frequently Purchased Products
SELECT product_name, SUM(quantity) AS total_quantity
FROM sales
GROUP BY product_name
ORDER BY total_quantity DESC;

-- Products with Highest Discount
SELECT product_name, AVG(discount) AS avg_discount
FROM sales
GROUP BY product_name
ORDER BY avg_discount DESC
LIMIT 10;

-- Profit Margin per Product
SELECT product_name, 
       SUM(profit) AS total_profit, 
       SUM(sales) AS total_sales, 
       (SUM(profit) / SUM(sales)) * 100 AS profit_margin
FROM sales
GROUP BY product_name
ORDER BY profit_margin DESC;

-- Product Sales Over Time (Monthly)
SELECT product_name, 
       order_date,
       SUM(sales) AS monthly_sales
FROM sales
GROUP BY product_name, order_date
ORDER BY order_date;

-- Top 5 Products by Sales in Each Category
WITH ranked_products AS (
    SELECT category, product_name, SUM(sales) AS total_sales,
           RANK() OVER (PARTITION BY category ORDER BY SUM(sales) DESC) AS sales_rank
    FROM sales
    GROUP BY category, product_name
)
SELECT category, product_name, total_sales
FROM ranked_products
WHERE sales_rank <= 5
ORDER BY category, total_sales DESC;

-- Products with Most Orders
SELECT product_name, COUNT(DISTINCT order_id) AS order_count
FROM sales
GROUP BY product_name
ORDER BY order_count DESC;

-- Top Products by Customer Segment
SELECT segment, product_name, SUM(sales) AS total_sales
FROM sales
GROUP BY segment, product_name
ORDER BY segment, total_sales DESC;

-- Product Popularity by Market
SELECT market, product_name, SUM(sales) AS total_sales
FROM sales
GROUP BY market, product_name
ORDER BY total_sales DESC;

-- Most Profitable Products by Region
SELECT region, product_name, SUM(profit) AS total_profit
FROM sales
GROUP BY region, product_name
ORDER BY total_profit DESC;


SELECT product_name, 
       MONTH(order_date) AS month, 
       SUM(sales) AS total_sales
FROM sales
GROUP BY product_name, month
ORDER BY month, total_sales DESC;
