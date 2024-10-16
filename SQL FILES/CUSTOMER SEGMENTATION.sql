-- CUSTOMER SEGMENTATION
-- Top 10 Customers by Sales
SELECT customer_name, SUM(sales) AS total_sales
FROM sales
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 Customers by Profit
SELECT customer_name, SUM(profit) AS total_profit
FROM sales
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 10;

-- Customer Sales by Segment
SELECT segment, customer_name, SUM(sales) AS total_sales
FROM sales
GROUP BY segment, customer_name
ORDER BY total_sales DESC;

--  Total Quantity Purchased by Customer
SELECT customer_name, SUM(quantity) AS total_quantity
FROM sales
GROUP BY customer_name
ORDER BY total_quantity DESC;

--  Customers with the Most Orders
SELECT customer_name, COUNT(order_id) AS total_orders
FROM sales
GROUP BY customer_name
ORDER BY total_orders DESC;

-- Customers by Region
SELECT region, customer_name, SUM(sales) AS total_sales
FROM sales
GROUP BY region, customer_name
ORDER BY total_sales DESC;

-- Top 5 Products Purchased by Each Customer
SELECT customer_name, product_name, SUM(quantity) AS total_quantity
FROM sales
GROUP BY customer_name, product_name
ORDER BY customer_name, total_quantity DESC;

-- Average Discount per Customer
SELECT customer_name, AVG(discount) AS avg_discount
FROM sales
GROUP BY customer_name
ORDER BY avg_discount DESC;

-- Customer Sales by Shipping Mode
SELECT ship_mode, customer_name, SUM(sales) AS total_sales
FROM sales
GROUP BY ship_mode, customer_name
ORDER BY total_sales DESC;

-- Customer Order Priorities
SELECT order_priority, customer_name, COUNT(order_id) AS total_orders
FROM sales
GROUP BY order_priority, customer_name
ORDER BY total_orders DESC;

-- Total Shipping Cost per Customer
SELECT customer_name, SUM(shipping_cost) AS total_shipping_cost
FROM sales
GROUP BY customer_name
ORDER BY total_shipping_cost DESC;

-- Customer Sales by Year
SELECT customer_name, YEAR(order_date) AS year, SUM(sales) AS total_sales
FROM sales
GROUP BY customer_name, year
ORDER BY total_sales DESC;

-- Customer Lifetime Value (CLV)
SELECT customer_name, 
       COUNT(order_id) AS total_orders, 
       SUM(sales) AS total_sales, 
       SUM(profit) AS total_profit, 
       SUM(profit) / COUNT(order_id) AS avg_profit_per_order
FROM sales
GROUP BY customer_name
ORDER BY total_profit DESC;

-- Year-over-Year Sales Growth per Customer
SELECT customer_name, 
       YEAR(order_date) AS year, 
       SUM(sales) AS yearly_sales, 
       LAG(SUM(sales), 1) OVER (PARTITION BY customer_name ORDER BY YEAR(order_date)) AS prev_year_sales, 
       (SUM(sales) - LAG(SUM(sales), 1) OVER (PARTITION BY customer_name ORDER BY YEAR(order_date))) / LAG(SUM(sales), 1) OVER (PARTITION BY customer_name ORDER BY YEAR(order_date)) * 100 AS growth_rate
FROM sales
GROUP BY customer_name, year
ORDER BY customer_name, year;

-- Customer Segmentation by Profitability
SELECT customer_name, 
       SUM(profit) AS total_profit, 
       CASE 
           WHEN SUM(profit) > 1000 THEN 'High'
           WHEN SUM(profit) BETWEEN 500 AND 1000 THEN 'Medium'
           ELSE 'Low'
       END AS profit_segment
FROM sales
GROUP BY customer_name
ORDER BY total_profit DESC;

--  Discount Effect on Sales and Profit
SELECT customer_name, 
       SUM(sales) AS total_sales, 
       SUM(profit) AS total_profit, 
       AVG(discount) AS avg_discount, 
       SUM(CASE WHEN discount > 0 THEN sales ELSE 0 END) AS sales_with_discount, 
       SUM(CASE WHEN discount > 0 THEN profit ELSE 0 END) AS profit_with_discount
FROM sales
GROUP BY customer_name
ORDER BY avg_discount DESC;

