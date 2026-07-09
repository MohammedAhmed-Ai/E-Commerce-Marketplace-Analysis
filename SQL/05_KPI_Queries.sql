
-- KPI 01
-- Overall Business Performance


SELECT COUNT(*) AS TotalOrders, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit, SUM(Quantity) AS TotalQuantity,AVG(ProfitMargin) AS AvgProfitMargin
FROM FactSales;


-- KPI 02
-- Total Customers
SELECT COUNT(*) AS TotalCustomers
FROM DimCustomer;


-- KPI 03
-- Total Products

SELECT COUNT(*) AS TotalProducts
FROM DimProduct;

-- KPI 04
-- Geographic Coverage


SELECT COUNT(DISTINCT City) AS TotalCities, COUNT(DISTINCT State) AS TotalStates, COUNT(DISTINCT Region) AS TotalRegions
FROM DimLocation;



-- KPI 05
-- Sales by Category


SELECT p.Category, SUM(f.Sales) AS TotalSales, SUM(f.Profit) AS TotalProfit, SUM(f.Quantity) AS TotalQuantity
FROM FactSales f
INNER JOIN DimProduct p
ON f.ProductKey=p.ProductKey
GROUP BY p.Category
ORDER BY TotalSales DESC;


-- KPI 06 
-- Sales by SubCategor

SELECT p.SubCategory, SUM(f.Sales) AS TotalSales, SUM(f.Profit) AS TotalProfit FROM FactSales f
INNER JOIN DimProduct p
ON f.ProductKey=p.ProductKey
GROUP BY p.SubCategory
ORDER BY TotalSales DESC;


-- KPI 07
-- Orders by Discount
SELECT
CASE
WHEN HasDiscount=1 THEN 'Discounted'
ELSE 'No Discount' END AS DiscountStatus,
COUNT(*) OrdersCount, SUM(Sales) TotalSales, SUM(Profit) TotalProfit
FROM FactSales
GROUP BY
CASE WHEN HasDiscount=1 THEN 'Discounted'
ELSE 'No Discount'
END;



-- KPI 08
-- Top 10 Products by Sales


SELECT TOP 10
    p.ProductName,
    SUM(f.Sales) AS TotalSales,
    SUM(f.Profit) AS TotalProfit
FROM FactSales f
INNER JOIN DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY p.ProductName
ORDER BY TotalSales DESC;




-- KPI 09
-- Top 10 Products by Profit


SELECT TOP 10
    p.ProductName,
    SUM(f.Profit) AS TotalProfit
FROM FactSales f
INNER JOIN DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY p.ProductName
ORDER BY TotalProfit DESC;




-- KPI 10
-- Category Performance


SELECT p.Category, COUNT(*) AS Orders, SUM(f.Sales) AS TotalSales, SUM(f.Profit) AS TotalProfit, AVG(f.ProfitMargin) AS AvgProfitMargin
FROM FactSales f
INNER JOIN DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY p.Category
ORDER BY TotalSales DESC;



-- KPI 11
-- Top Customers


SELECT TOP 10
    c.CustomerName,
    c.Segment,
    SUM(f.Sales) AS TotalSales,
    SUM(f.Profit) AS TotalProfit
FROM FactSales f
INNER JOIN DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY
    c.CustomerName,
    c.Segment
ORDER BY TotalSales DESC;



-- KPI 12
-- Sales by Segment

SELECT c.Segment, COUNT(DISTINCT c.CustomerID) AS Customers,  SUM(f.Sales) AS TotalSales, SUM(f.Profit) AS TotalProfit
FROM FactSales f
INNER JOIN DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY c.Segment;


-- KPI 13
-- Sales by Region

SELECT
    l.Region,
    SUM(f.Sales) AS TotalSales,
    SUM(f.Profit) AS TotalProfit
FROM FactSales f
INNER JOIN DimLocation l
    ON f.LocationKey = l.LocationKey
GROUP BY l.Region
ORDER BY TotalSales DESC;



-- KPI 14
-- Top States


SELECT TOP 10
    l.State,
    SUM(f.Sales) AS TotalSales,
    SUM(f.Profit) AS TotalProfit
FROM FactSales f
INNER JOIN DimLocation l
    ON f.LocationKey = l.LocationKey
GROUP BY l.State
ORDER BY TotalSales DESC;





KPI 15
Monthly Sales Trend

SELECT d.OrderYear, d.OrderMonth, d.OrderMonthName, SUM(f.Sales) AS TotalSales,SUM(f.Profit) AS TotalProfit
FROM FactSales f
INNER JOIN DimDate d
    ON f.DateKey = d.DateKey
GROUP BY d.OrderYear, d.OrderMonth, d.OrderMonthName
ORDER BY d.OrderYear, d.OrderMonth;




-- KPI 16
-- Quarterly Performance


SELECT d.OrderYear, d.OrderQuarter, SUM(f.Sales) AS TotalSales, SUM(f.Profit) AS TotalProfit
FROM FactSales f
INNER JOIN DimDate d
    ON f.DateKey = d.DateKey
GROUP BY d.OrderYear, d.OrderQuarter
ORDER BY d.OrderYear, d.OrderQuarter;



-- KPI 17
-- -- Sales by Weekday


SELECT d.OrderWeekday, SUM(f.Sales) AS TotalSales, SUM(f.Profit) AS TotalProfit
FROM FactSales f
INNER JOIN DimDate d
    ON f.DateKey = d.DateKey
GROUP BY d.OrderWeekday;



-- KPI 18
-- Top 5 Products per Category


WITH RankedProducts AS
(
SELECT p.Category, p.ProductName, SUM(f.Sales) AS TotalSales,
ROW_NUMBER() OVER
(
PARTITION BY p.Category
ORDER BY SUM(f.Sales) DESC
) AS RankNo
FROM FactSales f
INNER JOIN DimProduct p
ON f.ProductKey = p.ProductKey
GROUP BY p.Category, p.ProductName
)
SELECT *
FROM RankedProducts
WHERE RankNo <= 5;



-- KPI 19
-- Product Sales Ranking


SELECT p.ProductName, SUM(f.Sales) AS TotalSales,
DENSE_RANK() OVER
(
ORDER BY SUM(f.Sales) DESC
) AS SalesRank
FROM FactSales f
INNER JOIN DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY p.ProductName;





-- KPI 20
-- Profit Classification

SELECT
CASE
WHEN Profit < 0 THEN 'Loss'
WHEN Profit BETWEEN 0 AND 100 THEN 'Low Profit'
WHEN Profit BETWEEN 100 AND 500 THEN 'Medium Profit'
ELSE 'High Profit' END AS ProfitCategory,COUNT(*) AS Orders,SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM FactSales
GROUP BY
CASE
WHEN Profit < 0 THEN 'Loss'
WHEN Profit BETWEEN 0 AND 100 THEN 'Low Profit'
WHEN Profit BETWEEN 100 AND 500 THEN 'Medium Profit'
ELSE 'High Profit'
END;