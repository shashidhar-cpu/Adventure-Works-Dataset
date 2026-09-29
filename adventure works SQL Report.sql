CREATE DATABASE adventureworks;
use adventureworks;

drop database adventureworks;
CREATE DATABASE adventureworks;
use adventureworks;
show tables;



-- (Q).0 UNION of FactInternetSales and Fact_Internet_Sales_New
SELECT * FROM factinternetsales;
SELECT * FROM fact_internet_sales_new;

CREATE TABLE sales AS
SELECT *
FROM factinternetsales

UNION ALL

SELECT *
FROM fact_internet_sales_new;

select * from sales;



-- (Q).1  Lookup Product Name
SELECT
    s.ProductKey,
    p.EnglishProductName
FROM sales s
JOIN dimproduct p
ON s.ProductKey = p.ProductKey
LIMIT 40;


-- (Q).2 Lookup Customer Full Name and Unit Price
SELECT
    s.CustomerKey,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerFullName,
    p.`Unit price` AS UnitPrice
FROM sales s
JOIN dimcustomer c
ON s.CustomerKey = c.CustomerKey
JOIN dimproduct p
ON s.ProductKey = p.ProductKey
LIMIT 10;



-- (Q).3  Date Calculations
SELECT
    OrderDateKey,
    STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d') AS OrderDate
FROM sales
LIMIT 10;

-- Year
SELECT
    OrderDateKey,
    YEAR(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS Year
FROM sales
LIMIT 10;

-- Month Number
SELECT
    OrderDateKey,
    MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS MonthNo
FROM sales
LIMIT 10;

-- Month Full Name
SELECT
    OrderDateKey,
    MONTHNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS MonthName
FROM sales
LIMIT 10;

-- Quarter
SELECT
    OrderDateKey,
    CONCAT('Q', QUARTER(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'))) AS Quarter
FROM sales
LIMIT 10;


-- YearMonth (YYYY-MMM)
SELECT
    OrderDateKey,
    DATE_FORMAT(
        STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d'),
        '%Y-%M'
    ) AS YearMonth
FROM sales
LIMIT 10;

-- Weekday Number
SELECT
    OrderDateKey,
    DAYOFWEEK(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS WeekdayNo
FROM sales
LIMIT 10;

-- Weekday Name
SELECT
    OrderDateKey,
    DAYNAME(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) AS WeekdayName
FROM sales
LIMIT 10;

-- Financial Month (April = Month 1)
SELECT
    OrderDateKey,
    CASE
        WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) >= 4
        THEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) - 3
        ELSE MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) + 9
    END AS FinancialMonth
FROM sales
LIMIT 10;

-- Financial Quarter
SELECT
    OrderDateKey,
    CASE
        WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) BETWEEN 4 AND 6 THEN 'Q1'
        WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) BETWEEN 7 AND 9 THEN 'Q2'
        WHEN MONTH(STR_TO_DATE(CAST(OrderDateKey AS CHAR), '%Y%m%d')) BETWEEN 10 AND 12 THEN 'Q3'
        ELSE 'Q4'
    END AS FinancialQuarter
FROM sales
LIMIT 40;


-- Question 4 : Sales Amount Calculation
SELECT
    UnitPrice,
    OrderQuantity,
    UnitPriceDiscountPct,
    (UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct)) AS CalcSalesAmount
FROM sales;


-- Question 5 : Production Cost Calculation
SELECT
    ProductStandardCost,
    OrderQuantity,
    (ProductStandardCost * OrderQuantity) AS ProductionCost
FROM sales;


-- Question 6 : Profit Calculation
SELECT
    SalesAmount,
    TotalProductCost,
    (SalesAmount - TotalProductCost) AS Profit
FROM sales;












 
