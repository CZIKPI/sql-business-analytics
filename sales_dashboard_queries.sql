/* Question 1: How many orders were placed each year? */
-- Order placed meaning irrespective of the order status
-- Each order has unique order ID
-- Assume there are no duplicate order ids
SELECT COUNT(o.OrderID) AS No_of_Orders_Placed, YEAR(o.OrderDate) AS Order_Year
FROM `Order` o
GROUP BY Order_Year
ORDER BY Order_Year;

/* Question 2: What's the total revenue generated each Year? */
-- Revenue is when order status is completed
SELECT YEAR(o.OrderDate) AS OrderYear, SUM(o.TotalAmount) AS TotalRevenue
FROM `Order` o
WHERE o.OrderStatus = 'Completed'
GROUP BY OrderYear;

/* Question 3: Which month has the highest number of orders? */
-- Orders = total orders placed
-- Are there unique months for each Year? If Yes,
WITH RanKbyMonth AS (
    SELECT MONTH(o.OrderDate) AS OrderMonth,
           COUNT(o.OrderID) AS TotalOrder,
           DENSE_RANK() OVER (ORDER BY COUNT(o.OrderID) DESC) AS rank_highest
    FROM `Order` o
    GROUP BY MONTH(o.OrderDate)
)
SELECT * 
FROM RanKbyMonth
WHERE rank_highest = 1;

/* Question 4: What's the year-year growth from 2020 -2025 */
-- |Year , Sales|, previous_year, growth= (current -previous)/previous
-- Year-on-Year Growth Rate for Sales 
WITH SalesbyYear AS (
    SELECT YEAR(o.OrderDate) AS OrderYear, SUM(o.TotalAmount) AS TotalSales
    FROM `Order` o
    WHERE YEAR(o.OrderDate) BETWEEN 2020 AND 2025
    GROUP BY OrderYear
    ORDER BY OrderYear
)
SELECT OrderYear,
       TotalSales,
       LAG(TotalSales) OVER (ORDER BY OrderYear) AS PreviousYearSales,
       CONCAT(
           ROUND(
               (TotalSales - LAG(TotalSales) OVER (ORDER BY OrderYear)) / LAG(TotalSales) OVER (ORDER BY OrderYear) * 100,
               0
           ),
           '%'
       ) AS '%YoY'
FROM SalesbyYear;

/* Question 5: Which Year has the highest average orders amount */
-- Orders = total orders placed 
-- Year, total Order amount, Rank by order amount,
WITH AverageRevenueByYear AS (
    SELECT YEAR(o.OrderDate) AS OrderYear,
           AVG(o.TotalAmount) AS AverageAmountByYear,
           DENSE_RANK() OVER (ORDER BY AVG(o.TotalAmount) DESC) AS rankaverage
    FROM `Order` o
    WHERE o.OrderStatus != 'Cancelled'
    GROUP BY OrderYear
)
SELECT * 
FROM AverageRevenueByYear
WHERE rankaverage = 1;

/* Question 6: How does the total revenue of completed orders compare to pending orders for each year */
-- Year, total revenue(completed), total revenue(pending goods), ratio of pending/completed
SELECT YEAR(o.OrderDate) AS OrderYear,
       SUM(CASE WHEN o.OrderStatus = 'Completed' THEN o.TotalAmount ELSE 0 END) AS TotalCompleted_Sales,
       SUM(CASE WHEN o.OrderStatus = 'Pending' THEN o.TotalAmount ELSE 0 END) AS TotalPendingSales,
       (SUM(CASE WHEN o.OrderStatus = 'Pending' THEN o.TotalAmount ELSE 0 END) /
        NULLIF(SUM(CASE WHEN o.OrderStatus = 'Completed' THEN o.TotalAmount ELSE 0 END), 0)) * 100 AS PendingToCompletedRatio
FROM `Order` o
GROUP BY OrderYear
ORDER BY OrderYear;

/* Question 7: What is the Average Shipping time for completed orders */
-- How do we quantify time? month? day ? minutes? can use Datediff() for date and timestamp diff() for timestamps
SELECT AVG(o.DeliveryTime) AS Average_Shipping_Days 
FROM `Order` o
WHERE o.OrderStatus = 'Completed';

/* Question 8: Create a running total of sales by month for the entire period(2020 -2025) */
-- Year, Month, Total Sales, Running Total (order by unbounded preceding)
WITH SALESBYMONTH AS (
    SELECT YEAR(o.OrderDate) AS OrderYear,
           MONTH(o.OrderDate) AS OrderMonth,
           SUM(o.TotalAmount) AS TotalSales		
    FROM `Order` o
    WHERE YEAR(o.OrderDate) BETWEEN 2020 AND 2025
    GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate)
    ORDER BY YEAR(o.OrderDate), MONTH(o.OrderDate)
)
SELECT OrderYear,
       OrderMonth,
       TotalSales,
       SUM(TotalSales) OVER (ORDER BY OrderYear, OrderMonth
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotals
FROM SALESBYMONTH;

/* Question 9: Identify the Top 3 Customers who contributed the most to the revenue */
-- Revenue as completed
-- Customer, Total Revenue,
SELECT c.CustomerID, c.CustomerName,
       SUM(o.TotalAmount) AS TotalRevenue,
       DENSE_RANK() OVER (ORDER BY SUM(o.TotalAmount) DESC) AS RANKBYREV
FROM `Order` o
JOIN Customer c ON o.CustomerID = c.CustomerID
WHERE o.OrderStatus = 'Completed'
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalRevenue DESC
LIMIT 3;

/* Question 10: How many Orders were cancelled each year? */
-- YEAR, TOTAL CANCELLED
SELECT YEAR(o.OrderDate) AS OrderYear,
       COUNT(o.OrderID) AS Total_Orders_Cancelled
FROM `Order` o
WHERE o.OrderStatus = 'Cancelled'
GROUP BY OrderYear
ORDER BY Total_Orders_Cancelled DESC;

/* Question 11: What is the average order amount for orders placed in the first quarter (January-March) of each year */
SELECT YEAR(o.OrderDate) AS OrderYear,
       AVG(o.TotalAmount) AS '1st_QTR_Avg_Order_Amount'
FROM `Order` o
WHERE MONTH(o.OrderDate) BETWEEN 1 AND 3
GROUP BY YEAR(o.OrderDate)
ORDER BY YEAR(o.OrderDate);

/* Question 12: Which customers placed orders in multiple years, and what is their total revenue contribution */
-- Customer, count of Years, having years count more than 1 
SELECT c.CustomerID,
       COUNT(DISTINCT YEAR(o.OrderDate)) AS MultipleYears,
       SUM(o.TotalAmount) AS TheirTotalRevenue
FROM `Order` o
JOIN Customer c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID
HAVING MultipleYears > 1;
