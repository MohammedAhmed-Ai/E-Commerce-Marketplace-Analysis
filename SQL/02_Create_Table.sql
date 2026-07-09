CREATE TABLE DimCustomer
(
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,

    CustomerID VARCHAR(20) NOT NULL UNIQUE,

    CustomerName NVARCHAR(100) NOT NULL,

    Segment VARCHAR(30) NOT NULL
);


CREATE TABLE DimProduct
(
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,

    ProductID VARCHAR(30) NOT NULL UNIQUE,

    ProductName NVARCHAR(200) NOT NULL,

    Category VARCHAR(50) NOT NULL,

    SubCategory VARCHAR(50) NOT NULL
);


CREATE TABLE DimLocation
(
    LocationKey INT IDENTITY(1,1) PRIMARY KEY,

    Country NVARCHAR(50),

    Region NVARCHAR(50),

    State NVARCHAR(50),

    City NVARCHAR(50),

    PostalCode VARCHAR(20)
);



CREATE TABLE DimShipMode
(
    ShipModeKey INT IDENTITY(1,1) PRIMARY KEY,

    ShipMode VARCHAR(30) UNIQUE
);



CREATE TABLE DimDate
(
    DateKey INT PRIMARY KEY,

    OrderDate DATE,

    OrderYear INT,

    OrderMonth INT,

    OrderMonthName VARCHAR(20),

    OrderQuarter INT,

    OrderDay INT,

    OrderWeekday VARCHAR(20)
);



CREATE TABLE FactSales
(
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,

    CustomerKey INT NOT NULL,

    ProductKey INT NOT NULL,

    LocationKey INT NOT NULL,

    ShipModeKey INT NOT NULL,

    DateKey INT NOT NULL,

    Sales DECIMAL(10,2),

    Quantity INT,

    Discount DECIMAL(4,2),

    Profit DECIMAL(10,2),

    ShippingDays INT,

    ProfitMargin FLOAT,

    HasDiscount BIT,

    HighProfit BIT,

    OrderSize VARCHAR(20),

    FOREIGN KEY (CustomerKey)
        REFERENCES DimCustomer(CustomerKey),

    FOREIGN KEY (ProductKey)
        REFERENCES DimProduct(ProductKey),

    FOREIGN KEY (LocationKey)
        REFERENCES DimLocation(LocationKey),

    FOREIGN KEY (ShipModeKey)
        REFERENCES DimShipMode(ShipModeKey),

    FOREIGN KEY (DateKey)
        REFERENCES DimDate(DateKey)
);


