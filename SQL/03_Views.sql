CREATE OR ALTER VIEW vw_SalesSummary
AS
SELECT d.OrderYear, d.OrderMonth, p.Category, SUM(f.Sales) AS TotalSales, SUM(f.Profit) AS TotalProfit, SUM(f.Quantity) AS TotalQuantity, AVG(f.Discount) AS AvgDiscount
FROM FactSales f
INNER JOIN DimDate d
ON f.DateKey = d.DateKey
INNER JOIN DimProduct p
ON f.ProductKey = p.ProductKey
GROUP BY d.OrderYear, d.OrderMonth, p.Category;



-- View 2
-- Customer Performance

CREATE VIEW vw_CustomerPerformance AS
SELECT c.CustomerName, c.Segment, COUNT(*) AS OrdersCount, SUM(f.Sales) AS TotalSales, SUM(f.Profit) AS TotalProfit
FROM FactSales f
INNER JOIN DimCustomer c
ON f.CustomerKey=c.CustomerKey
GROUP BY c.CustomerName,c.Segment;



-- View 3
-- Product Performance


CREATE VIEW vw_ProductPerformance AS
SELECT  p.ProductName, p.Category, p.SubCategory, SUM(f.Sales) AS TotalSales, SUM(f.Profit) AS TotalProfit, SUM(f.Quantity) AS TotalQuantity
FROM FactSales f
INNER JOIN DimProduct p
ON f.ProductKey=p.ProductKey
GROUP BY p.ProductName, p.Category, p.SubCategory;



-- View 4
-- Location Performance


CREATE VIEW vw_LocationPerformance AS
SELECT l.Region, l.State, l.City, SUM(f.Sales) AS TotalSales, SUM(f.Profit) AS TotalProfit
FROM FactSales f
INNER JOIN DimLocation l
ON f.LocationKey=l.LocationKey
GROUP BY l.Region, l.State,l.City;


-- View 5
-- Monthly Trend


CREATE VIEW vw_MonthlyTrend AS
SELECT d.OrderYear, d.OrderMonth, d.OrderMonthName, SUM(f.Sales) AS TotalSales,SUM(f.Profit) AS TotalProfit
FROM FactSales f
INNER JOIN DimDate d
ON f.DateKey=d.DateKey
GROUP BY d.OrderYear, d.OrderMonth,d.OrderMonthName;