USE ECommerceAnalytics;
GO


SELECT COUNT(*) AS TotalOrders, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit,AVG(Discount) AS AverageDiscount
FROM Sales;
------------------
SELECT Category, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM Sales
GROUP BY Category
ORDER BY TotalSales DESC;

-------------------
SELECT TOP 10 ProductName, SUM(Sales) AS TotalSales
FROM Sales
GROUP BY ProductName
ORDER BY TotalSales DESC;

--------------------
SELECT Region, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM Sales
GROUP BY Region
ORDER BY TotalSales DESC;

-- ------------------ SECTION 2 : SALES ANALYSIS -------------------------------

SELECT OrderYear, OrderMonth, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM Sales
GROUP BY OrderYear, OrderMonth
ORDER BY OrderYear, OrderMonth;


SELECT Segment,COUNT(*) AS TotalOrders, SUM(Sales) AS TotalSales,AVG(Sales) AS AverageSales
FROM Sales
GROUP BY Segment
ORDER BY TotalSales DESC;

SELECT Category, AVG(ProfitMargin) AS AvgProfitMargin
FROM Sales
GROUP BY Category
ORDER BY AvgProfitMargin DESC;

SELECT HasDiscount, COUNT(*) AS OrdersCount,SUM(Sales) AS TotalSales,SUM(Profit) AS TotalProfit
FROM Sales
GROUP BY HasDiscount;


-- ------------------ SECTION 3 : PRODUCT ANALYSIS -------------------------------


SELECT TOP 10 ProductName, SUM(Profit) AS TotalProfit
FROM Sales
GROUP BY ProductName
ORDER BY TotalProfit DESC;



SELECT TOP 10 ProductName, SUM(Profit) AS TotalProfit
FROM Sales
GROUP BY ProductName
ORDER BY TotalProfit ASC;




SELECT ProductName, AVG(Sales) AS AverageSales
FROM Sales
GROUP BY ProductName
ORDER BY AverageSales DESC;
-- ------------------  SECTION 4 : CUSTOMER ANALYSIS -------------------------------



SELECT TOP 10 CustomerName, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM Sales
GROUP BY CustomerName
ORDER BY TotalSales DESC;



SELECT Segment, COUNT(DISTINCT CustomerID) AS TotalCustomers, SUM(Sales) AS TotalSales
FROM Sales
GROUP BY Segment;


SELECT Segment, AVG(Sales) AS AverageOrderValue
FROM Sales
GROUP BY Segment
ORDER BY AverageOrderValue DESC;


-- ------------------ SECTION 5 : GEOGRAPHIC ANALYSIS-------------------------------


SELECT State, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM Sales
GROUP BY State
ORDER BY TotalSales DESC;


SELECT TOP 10 City, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfit
FROM Sales
GROUP BY City
ORDER BY TotalSales DESC;



SELECT Region, SUM(Profit) AS TotalProfit
FROM Sales
GROUP BY Region
ORDER BY TotalProfit DESC;


-- ------------------ SECTION 7 : ADVANCED SQL ------------------------------

SELECT

DENSE_RANK() OVER(ORDER BY SUM(Sales) DESC) AS DenseRank,ProductName,SUM(Sales) AS TotalSales
FROM Sales

GROUP BY ProductName;



WITH ProductSales AS
(
    SELECT ProductName,SUM(Sales) AS TotalSales
    FROM Sales
    GROUP BY ProductName
)
SELECT TOP 10 *
FROM ProductSales
ORDER BY TotalSales DESC;



WITH RankedProducts AS
(
    SELECT ProductName, SUM(Sales) AS TotalSales,
    DENSE_RANK() OVER
    (
    ORDER BY SUM(Sales) DESC
    )AS ProductRank
    FROM Sales
    GROUP BY ProductName
)
SELECT * FROM RankedProducts
WHERE ProductRank <= 10;

