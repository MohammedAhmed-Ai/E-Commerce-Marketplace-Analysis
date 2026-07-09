CREATE VIEW vw_SalesSummary AS

SELECT Category, SUM(Sales) TotalSales, SUM(Profit) TotalProfit,AVG(Discount) AverageDiscount
FROM Sales
GROUP BY Category;


-- Viwe 2


CREATE VIEW vw_TopCustomers AS

SELECT CustomerName,SUM(Sales) TotalSales, SUM(Profit) TotalProfit 
FROM Sales
GROUP BY CustomerName;


SELECT *
FROM vw_SalesSummary;


SELECT *
FROM vw_TopCustomers;



