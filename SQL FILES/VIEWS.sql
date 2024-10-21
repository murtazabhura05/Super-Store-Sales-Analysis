-- Total Sales and Profit by Region
CREATE VIEW TotalSalesAndProfitByRegion AS
SELECT region, SUM(sales) AS TotalSales, SUM(profit) AS TotalProfit
FROM sales
GROUP BY region;

SELECT  * FROM TotalSalesAndProfitByRegion;

/*------------------------------------------------------------------------------------------------------------------------*/

-- High-Priority Orders
CREATE VIEW HighPriorityOrders AS
SELECT order_id, order_date, customer_name, product_name, sales, profit, ship_mode
FROM sales
WHERE order_priority = 'High';

SELECT  * FROM HighPriorityOrders;

/*------------------------------------------------------------------------------------------------------------------------*/

-- Customer Sales Summary
CREATE VIEW CustomerSalesSummary AS
SELECT customer_name, COUNT(order_id) AS TotalOrders, SUM(sales) AS TotalSales,  SUM(profit) AS TotalProfit
FROM sales
GROUP BY customer_name;

SELECT  * FROM CustomerSalesSummary;

/*------------------------------------------------------------------------------------------------------------------------*/

-- Top Products by Sales
CREATE VIEW TopProductsBySales AS
SELECT product_name, SUM(sales) AS TotalSales
FROM sales
GROUP BY product_name
ORDER BY TotalSales DESC;

SELECT  * FROM TopProductsBySales LIMIT 3;

/*------------------------------------------------------------------------------------------------------------------------*/

-- Orders Shipped Late
CREATE VIEW LateShippedOrders AS
SELECT order_id, order_date, ship_date, DATEDIFF(ship_date, order_date) AS Difference, customer_name, product_name, ship_mode
FROM sales
WHERE DATEDIFF(ship_date, order_date) > 5;  -- Assuming shipping should take 5 days

SELECT * FROM LateShippedOrders;

/*------------------------------------------------------------------------------------------------------------------------*/

-- Sales by Category and Sub-Category
CREATE VIEW SalesByCategorySubCategory AS
SELECT category, sub_category, SUM(sales) AS TotalSales, SUM(profit) AS TotalProfit
FROM sales
GROUP BY category, sub_category
ORDER BY TotalSales DESC;

SELECT * FROM SalesByCategorySubCategory;

/*------------------------------------------------------------------------------------------------------------------------*/

--  State-Wise Sales and Profit
CREATE VIEW StateWiseSalesAndProfit AS
SELECT state, SUM(sales) AS TotalSales, SUM(profit) AS TotalProfit
FROM sales
GROUP BY state;

SELECT * FROM StateWiseSalesAndProfit;
