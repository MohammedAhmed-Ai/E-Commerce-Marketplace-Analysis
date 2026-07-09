USE ECommerceAnalytics;
GO

IF OBJECT_ID('dbo.Sales', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Sales;
END
GO

CREATE TABLE dbo.Sales
(
    RowID INT PRIMARY KEY,

    OrderID VARCHAR(20) NOT NULL,
    OrderDate DATE NOT NULL,
    ShipDate DATE NOT NULL,
    ShipMode VARCHAR(30) NOT NULL,

    CustomerID VARCHAR(20) NOT NULL,
    CustomerName NVARCHAR(100) NOT NULL,
    Segment VARCHAR(30) NOT NULL,

    Country NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    State NVARCHAR(50) NOT NULL,
    PostalCode VARCHAR(20) NULL,
    Region VARCHAR(30) NOT NULL,

    ProductID VARCHAR(30) NOT NULL,
    Category VARCHAR(30) NOT NULL,
    SubCategory VARCHAR(50) NOT NULL,
    ProductName NVARCHAR(200) NOT NULL,

    Sales DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,
    Discount DECIMAL(4,2) NOT NULL,
    Profit DECIMAL(10,2) NOT NULL,

    OrderYear INT NOT NULL,
    OrderMonth INT NOT NULL,
    OrderMonthName VARCHAR(20) NOT NULL,
    OrderQuarter INT NOT NULL,
    OrderDay INT NOT NULL,
    OrderWeekday VARCHAR(20) NOT NULL,

    ShippingDays INT NOT NULL,

    ProfitMargin FLOAT NOT NULL,

    HasDiscount BIT NOT NULL,

    HighProfit BIT NOT NULL,

    OrderSize VARCHAR(20) NOT NULL
);
GO