-- Retrieve Top N Customers by Sales
DELIMITER $$
CREATE PROCEDURE GetTopCustomers (
    IN regionName VARCHAR(255),
    IN limitN INT
)
BEGIN
    SELECT customer_name, region, SUM(sales) AS total_sales, SUM(profit) AS total_profit
    FROM sales
    WHERE region = regionName OR regionName IS NULL
    GROUP BY customer_name, region
    ORDER BY total_sales DESC
    LIMIT limitN;
END$$
DELIMITER ;

CALL GetTopCustomers('Oceania', 5); -- Get op 5 customers in Oceania
CALL GetTopCustomers('Central', 10); -- Get top 10 customers in Central

/*------------------------------------------------------------------------------------------------------------------------*/

-- Calculate Total Sales by yearly and monthly
DELIMITER $$
CREATE PROCEDURE GetSalesByYearOrMonth (
    IN regionName VARCHAR(255),
    IN categoryName VARCHAR(255),
    IN periodType VARCHAR(10)
)
BEGIN
	IF periodType = 'YEARLY' THEN
        SELECT 
            region, category,
            YEAR(order_date) AS sales_year,
            SUM(sales) AS total_sales,
            SUM(profit) AS total_profit
        FROM sales
        WHERE
            (region = regionName OR regionName IS NULL)
            AND (category = categoryName OR categoryName IS NULL)
        GROUP BY region, category, sales_year
        ORDER BY sales_year;
	ELSE
		SELECT 
            region, category,
            MONTHNAME(order_date) AS sales_month,
            SUM(sales) AS total_sales,
            SUM(profit) AS total_profit
        FROM sales
        WHERE
            (region = regionName OR regionName IS NULL)
            AND (category = categoryName OR categoryName IS NULL)
        GROUP BY region, category, sales_month;        
	END IF;
END$$
DELIMITER ;

CALL GetSalesByYearOrMonth('Central', 'Furniture','Yearly'); -- Yearly
CALL GetSalesByYearOrMonth('Central', NULL,NULL);-- Yearly

/*------------------------------------------------------------------------------------------------------------------------*/

-- Retrieves all orders placed by a specific customer.
DELIMITER $$
CREATE PROCEDURE GetOrdersByCustomer(IN customerName VARCHAR(255))
BEGIN
    SELECT customer_name, order_date, product_name, sales, profit, ship_mode
    FROM sales
    WHERE customer_name = customerName;
END $$
DELIMITER ;

CALL GetOrdersByCustomer('Toby Ritter');

/*------------------------------------------------------------------------------------------------------------------------*/

-- Calculates the total sales and profit for a given region.
DELIMITER $$
CREATE PROCEDURE GetSalesProfitByRegion(IN regionName VARCHAR(255))
BEGIN
    SELECT region, SUM(sales) AS TotalSales, SUM(profit) AS TotalProfit
    FROM sales
    WHERE region = regionName
    GROUP BY region;
END $$
DELIMITER ;

CALL GetSalesProfitByRegion('Africa');

/*------------------------------------------------------------------------------------------------------------------------*/

-- Retrieves the top N products based on sales.
DELIMITER $$
CREATE PROCEDURE GetTopProducts(IN topN INT)
BEGIN
    SELECT product_name, SUM(sales) AS TotalSales
    FROM sales
    GROUP BY product_name
    ORDER BY TotalSales DESC
    LIMIT topN;
END $$
DELIMITER ;

CALL GetTopProducts(10);

/*------------------------------------------------------------------------------------------------------------------------*/

-- Analyzes how discounts are impacting profit margins.
DELIMITER $$
CREATE PROCEDURE GetDiscountImpact()
BEGIN
    SELECT discount, SUM(profit) AS TotalProfit
    FROM sales
    GROUP BY discount
    ORDER BY discount ASC;
END $$
DELIMITER ;

CALL GetDiscountImpact();

/*------------------------------------------------------------------------------------------------------------------------*/

-- Lists orders filtered by priority (e.g., High, Medium, Low).
DELIMITER $$
CREATE PROCEDURE GetOrdersByPriority(IN orderPriority VARCHAR(50))
BEGIN
    SELECT order_id, order_date, product_name, sales, shipping_cost
    FROM sales
    WHERE order_priority = orderPriority;
END $$
DELIMITER ;

CALL GetOrdersByPriority('Medium');

/*------------------------------------------------------------------------------------------------------------------------*/

-- Takes a start and end date as inputs and returns the total sales within that date range.
DELIMITER $$
CREATE PROCEDURE GetTotalSalesBetweenDates(
    IN startDate DATE,
    IN endDate DATE,
    OUT totalSales DOUBLE
)
BEGIN
    SELECT SUM(sales) INTO totalSales
    FROM sales
    WHERE order_date BETWEEN startDate AND endDate;
END $$
DELIMITER ;

CALL GetTotalSalesBetweenDates('2011-01-01', '2011-12-31', @totalSales);
SELECT @totalSales as TotalSales;
