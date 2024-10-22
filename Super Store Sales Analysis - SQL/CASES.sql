-- Flagging Orders with Delayed Shipping
SELECT order_id, customer_name, DATEDIFF(ship_date,order_date) AS shipping_duration,
       CASE 
           WHEN DATEDIFF(ship_date,order_date) >= 5 THEN 'Delayed'
           ELSE 'On Time'
       END AS shipping_status
FROM sales
ORDER BY shipping_duration DESC;

/*------------------------------------------------------------------------------------------------------------------------*/

-- Classifying Customers Based on Total Orders
SELECT customer_name, COUNT(order_id) AS total_orders,
       CASE 
           WHEN COUNT(order_id) <= 30 THEN 'Bronze'
           WHEN COUNT(order_id) BETWEEN 40 AND 60 THEN 'Silver'
           ELSE 'Gold'
       END AS customer_tier
FROM sales
GROUP BY customer_name
ORDER BY total_orders;

/*------------------------------------------------------------------------------------------------------------------------*/

-- Calculating Profit Margin with Conditional Discount Labeling
SELECT order_id, product_name, sales, profit,
       CASE 
           WHEN discount > 0 THEN 'Discounted'
           ELSE 'Full Price'
       END AS discount_status,
       (profit / sales) * 100 AS profit_margin
FROM sales;

/*------------------------------------------------------------------------------------------------------------------------*/

-- Assigning Priority Labels Based on Shipping Cost
SELECT order_id, customer_name, shipping_cost,
       CASE 
           WHEN shipping_cost < 20 THEN 'Low Cost'
           WHEN shipping_cost BETWEEN 20 AND 50 THEN 'Standard Cost'
           ELSE 'High Cost'
       END AS shipping_category
FROM sales;

/*------------------------------------------------------------------------------------------------------------------------*/

-- Assigning Priority Labels Based on Shipping Cost
SELECT order_id, product_name, sales, profit,
       CASE 
           WHEN profit > 0 THEN 'Profit'
           ELSE 'Loss'
       END AS profit_status
FROM sales;

