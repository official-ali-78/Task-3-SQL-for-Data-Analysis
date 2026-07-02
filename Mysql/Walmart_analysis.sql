/*=========================================================
        ELEVATE LABS DATA ANALYST INTERNSHIP
             TASK 3 : SQL FOR DATA ANALYSIS
               Dataset : Walmart Sales
==========================================================*/

----------------------------------------------------------
-- Create Database
----------------------------------------------------------

CREATE DATABASE walmart_db;

USE walmart_db;

----------------------------------------------------------
-- Create Table
----------------------------------------------------------

CREATE TABLE walmart_sales
(
invoice_id VARCHAR(30),
branch VARCHAR(50),
city VARCHAR(50),
category VARCHAR(50),
unit_price DECIMAL(10,2),
quantity INT,
date DATE,
time TIME,
payment_method VARCHAR(30),
rating DECIMAL(3,1),
profit_margin DECIMAL(10,2)
);


----------------------------------------------------------
-- Import Dataset
----------------------------------------------------------
/*
Import Walmart.csv using MySQL Workbench

Table Data Import Wizard

OR

LOAD DATA INFILE
*/

----------------------------------------------------------
-- View Dataset
----------------------------------------------------------

SELECT * FROM walmart_sales;

----------------------------------------------------------
-- Total Records
----------------------------------------------------------

SELECT COUNT(*) AS Total_Records
FROM walmart_sales;

----------------------------------------------------------
-- Display Required Columns
----------------------------------------------------------

SELECT
invoice_id,
city,
category,
quantity
FROM walmart_sales;

----------------------------------------------------------
-- Distinct Cities
----------------------------------------------------------

SELECT DISTINCT city
FROM walmart_sales;

----------------------------------------------------------
-- Distinct Categories
----------------------------------------------------------

SELECT DISTINCT category
FROM walmart_sales;

----------------------------------------------------------
-- Distinct Payment Methods
----------------------------------------------------------

SELECT DISTINCT payment_method
FROM walmart_sales;

----------------------------------------------------------
-- Filter Quantity Greater Than 5
----------------------------------------------------------

SELECT *
FROM walmart_sales
WHERE quantity > 5;

----------------------------------------------------------
-- Filter Rating Above 8
----------------------------------------------------------

SELECT *
FROM walmart_sales
WHERE rating > 8;

----------------------------------------------------------
-- Filter Branch A
----------------------------------------------------------

SELECT *
FROM walmart_sales
WHERE branch='A';

----------------------------------------------------------
-- Multiple Conditions
----------------------------------------------------------

SELECT *
FROM walmart_sales
WHERE branch='A'
AND quantity > 5;

----------------------------------------------------------
-- OR Condition
----------------------------------------------------------

SELECT *
FROM walmart_sales
WHERE city='Yangon'
OR city='Mandalay';

----------------------------------------------------------
-- BETWEEN
----------------------------------------------------------

SELECT *
FROM walmart_sales
WHERE rating BETWEEN 7 AND 10;

----------------------------------------------------------
-- IN Operator
----------------------------------------------------------

SELECT *
FROM walmart_sales
WHERE payment_method IN
('Cash','Ewallet');

----------------------------------------------------------
-- LIKE Operator
----------------------------------------------------------

SELECT *
FROM walmart_sales
WHERE city LIKE 'S%';

----------------------------------------------------------
-- ORDER BY Quantity
----------------------------------------------------------

SELECT *
FROM walmart_sales
ORDER BY quantity DESC;

----------------------------------------------------------
-- ORDER BY Rating
----------------------------------------------------------

SELECT *
FROM walmart_sales
ORDER BY rating DESC;

----------------------------------------------------------
-- Top 10 Records
----------------------------------------------------------

SELECT *
FROM walmart_sales
LIMIT 10;

----------------------------------------------------------
-- Total Quantity Sold
----------------------------------------------------------

SELECT
SUM(quantity) AS Total_Quantity
FROM walmart_sales;

----------------------------------------------------------
-- Average Quantity
----------------------------------------------------------

SELECT
AVG(quantity) AS Average_Quantity
FROM walmart_sales;

----------------------------------------------------------
-- Highest Rating
----------------------------------------------------------

SELECT
MAX(rating) AS Highest_Rating
FROM walmart_sales;

----------------------------------------------------------
-- Lowest Rating
----------------------------------------------------------

SELECT
MIN(rating) AS Lowest_Rating
FROM walmart_sales;

----------------------------------------------------------
-- Average Profit Margin
----------------------------------------------------------

SELECT
AVG(profit_margin) AS Average_Profit
FROM walmart_sales;


----------------------------------------------------------
-- Total Transactions by Branch
----------------------------------------------------------

SELECT
branch,
COUNT(*) AS Total_Transactions
FROM walmart_sales
GROUP BY branch;

----------------------------------------------------------
-- Total Quantity Sold by Branch
----------------------------------------------------------

SELECT
branch,
SUM(quantity) AS Total_Quantity
FROM walmart_sales
GROUP BY branch;

----------------------------------------------------------
-- Average Rating by Branch
----------------------------------------------------------

SELECT
branch,
ROUND(AVG(rating),2) AS Average_Rating
FROM walmart_sales
GROUP BY branch;

----------------------------------------------------------
-- Total Quantity by City
----------------------------------------------------------

SELECT
city,
SUM(quantity) AS Total_Quantity
FROM walmart_sales
GROUP BY city
ORDER BY Total_Quantity DESC;

----------------------------------------------------------
-- Average Rating by City
----------------------------------------------------------

SELECT
city,
ROUND(AVG(rating),2) AS Average_Rating
FROM walmart_sales
GROUP BY city
ORDER BY Average_Rating DESC;

----------------------------------------------------------
-- Transactions by Category
----------------------------------------------------------

SELECT
category,
COUNT(*) AS Total_Transactions
FROM walmart_sales
GROUP BY category
ORDER BY Total_Transactions DESC;

----------------------------------------------------------
-- Quantity Sold by Category
----------------------------------------------------------

SELECT
category,
SUM(quantity) AS Quantity_Sold
FROM walmart_sales
GROUP BY category
ORDER BY Quantity_Sold DESC;

----------------------------------------------------------
-- Average Profit Margin by Category
----------------------------------------------------------

SELECT
category,
ROUND(AVG(profit_margin),2) AS Avg_Profit_Margin
FROM walmart_sales
GROUP BY category
ORDER BY Avg_Profit_Margin DESC;

----------------------------------------------------------
-- Revenue by Category
----------------------------------------------------------

SELECT
category,
ROUND(SUM(unit_price * quantity),2) AS Revenue
FROM walmart_sales
GROUP BY category
ORDER BY Revenue DESC;

----------------------------------------------------------
-- Revenue by Branch
----------------------------------------------------------

SELECT
branch,
ROUND(SUM(unit_price * quantity),2) AS Revenue
FROM walmart_sales
GROUP BY branch
ORDER BY Revenue DESC;

----------------------------------------------------------
-- Revenue by City
----------------------------------------------------------

SELECT
city,
ROUND(SUM(unit_price * quantity),2) AS Revenue
FROM walmart_sales
GROUP BY city
ORDER BY Revenue DESC;

----------------------------------------------------------
-- Average Unit Price by Category
----------------------------------------------------------

SELECT
category,
ROUND(AVG(unit_price),2) AS Avg_Unit_Price
FROM walmart_sales
GROUP BY category;

----------------------------------------------------------
-- Highest Unit Price in Each Category
----------------------------------------------------------

SELECT
category,
MAX(unit_price) AS Highest_Price
FROM walmart_sales
GROUP BY category;

----------------------------------------------------------
-- Lowest Unit Price in Each Category
----------------------------------------------------------

SELECT
category,
MIN(unit_price) AS Lowest_Price
FROM walmart_sales
GROUP BY category;

----------------------------------------------------------
-- Payment Method Usage
----------------------------------------------------------

SELECT
payment_method,
COUNT(*) AS Total_Transactions
FROM walmart_sales
GROUP BY payment_method
ORDER BY Total_Transactions DESC;

----------------------------------------------------------
-- Average Rating by Payment Method
----------------------------------------------------------

SELECT
payment_method,
ROUND(AVG(rating),2) AS Avg_Rating
FROM walmart_sales
GROUP BY payment_method
ORDER BY Avg_Rating DESC;

----------------------------------------------------------
-- Revenue by Payment Method
----------------------------------------------------------

SELECT
payment_method,
ROUND(SUM(unit_price * quantity),2) AS Revenue
FROM walmart_sales
GROUP BY payment_method
ORDER BY Revenue DESC;

----------------------------------------------------------
-- HAVING Example
-- Categories with Revenue Greater Than 50000
----------------------------------------------------------

SELECT
category,
ROUND(SUM(unit_price * quantity),2) AS Revenue
FROM walmart_sales
GROUP BY category
HAVING Revenue > 50000;

----------------------------------------------------------
-- HAVING Example
-- Cities with More Than 20 Transactions
----------------------------------------------------------

SELECT
city,
COUNT(*) AS Transactions
FROM walmart_sales
GROUP BY city
HAVING Transactions > 20;

----------------------------------------------------------
-- CASE Statement
----------------------------------------------------------

SELECT
invoice_id,
rating,

CASE

WHEN rating >= 9 THEN 'Excellent'

WHEN rating >= 7 THEN 'Good'

WHEN rating >= 5 THEN 'Average'

ELSE 'Poor'

END AS Customer_Feedback

FROM walmart_sales;

----------------------------------------------------------
-- Revenue Classification
----------------------------------------------------------

SELECT
invoice_id,
(quantity * unit_price) AS Revenue,

CASE

WHEN (quantity * unit_price) >= 1000
THEN 'High Revenue'

WHEN (quantity * unit_price) >= 500
THEN 'Medium Revenue'

ELSE 'Low Revenue'

END AS Revenue_Category

FROM walmart_sales;

----------------------------------------------------------
-- Daily Revenue
----------------------------------------------------------

SELECT
date,
ROUND(SUM(quantity * unit_price),2) AS Daily_Revenue
FROM walmart_sales
GROUP BY date
ORDER BY date;

----------------------------------------------------------
-- Daily Transactions
----------------------------------------------------------

SELECT
date,
COUNT(*) AS Transactions
FROM walmart_sales
GROUP BY date
ORDER BY date;

----------------------------------------------------------
-- Top 10 Highest Revenue Transactions
----------------------------------------------------------

SELECT
invoice_id,
city,
category,
(quantity * unit_price) AS Revenue
FROM walmart_sales
ORDER BY Revenue DESC
LIMIT 10;

----------------------------------------------------------
-- Top Rated Transactions
----------------------------------------------------------

SELECT
invoice_id,
category,
rating
FROM walmart_sales
ORDER BY rating DESC
LIMIT 10;

----------------------------------------------------------
-- Category-wise Rating
----------------------------------------------------------

SELECT
category,
ROUND(AVG(rating),2) AS Avg_Rating
FROM walmart_sales
GROUP BY category
ORDER BY Avg_Rating DESC;


----------------------------------------------------------
-- Subquery 1
-- Transactions with Revenue Above Average
----------------------------------------------------------

SELECT *
FROM walmart_sales
WHERE (quantity * unit_price) >
(
    SELECT AVG(quantity * unit_price)
    FROM walmart_sales
);

----------------------------------------------------------
-- Subquery 2
-- Highest Rated Transaction
----------------------------------------------------------

SELECT *
FROM walmart_sales
WHERE rating =
(
    SELECT MAX(rating)
    FROM walmart_sales
);

----------------------------------------------------------
-- Subquery 3
-- Lowest Rated Transaction
----------------------------------------------------------

SELECT *
FROM walmart_sales
WHERE rating =
(
    SELECT MIN(rating)
    FROM walmart_sales
);

----------------------------------------------------------
-- Subquery 4
-- Products with Quantity Above Average
----------------------------------------------------------

SELECT *
FROM walmart_sales
WHERE quantity >
(
    SELECT AVG(quantity)
    FROM walmart_sales
);

----------------------------------------------------------
-- Subquery 5
-- Transactions Having Maximum Unit Price
----------------------------------------------------------

SELECT *
FROM walmart_sales
WHERE unit_price =
(
    SELECT MAX(unit_price)
    FROM walmart_sales
);

----------------------------------------------------------
-- View 1
-- Revenue Summary
----------------------------------------------------------

CREATE VIEW revenue_summary AS

SELECT
branch,
city,
category,
SUM(quantity*unit_price) AS revenue

FROM walmart_sales

GROUP BY
branch,
city,
category;

----------------------------------------------------------
-- Display Revenue Summary
----------------------------------------------------------

SELECT * FROM revenue_summary;

----------------------------------------------------------
-- View 2
-- Customer Satisfaction
----------------------------------------------------------

CREATE VIEW customer_feedback AS

SELECT
invoice_id,
city,
category,
rating,

CASE

WHEN rating>=9 THEN 'Excellent'

WHEN rating>=7 THEN 'Good'

WHEN rating>=5 THEN 'Average'

ELSE 'Poor'

END AS Feedback

FROM walmart_sales;

----------------------------------------------------------
-- Display Customer Feedback
----------------------------------------------------------

SELECT * FROM customer_feedback;

----------------------------------------------------------
-- View 3
-- Daily Sales Summary
----------------------------------------------------------

CREATE VIEW daily_sales AS

SELECT

date,

COUNT(*) AS Transactions,

SUM(quantity) AS Quantity,

SUM(quantity*unit_price) AS Revenue,

ROUND(AVG(rating),2) AS Avg_Rating

FROM walmart_sales

GROUP BY date;

----------------------------------------------------------
-- Display Daily Sales
----------------------------------------------------------

SELECT * FROM daily_sales;

----------------------------------------------------------
-- Create Index
----------------------------------------------------------

CREATE INDEX idx_city

ON walmart_sales(city);

----------------------------------------------------------
-- Create Index
----------------------------------------------------------

CREATE INDEX idx_category

ON walmart_sales(category);

----------------------------------------------------------
-- Create Index
----------------------------------------------------------

CREATE INDEX idx_branch

ON walmart_sales(branch);

----------------------------------------------------------
-- Top Revenue City
----------------------------------------------------------

SELECT

city,

SUM(quantity*unit_price) AS Revenue

FROM walmart_sales

GROUP BY city

ORDER BY Revenue DESC

LIMIT 1;

----------------------------------------------------------
-- Top Revenue Category
----------------------------------------------------------

SELECT

category,

SUM(quantity*unit_price) AS Revenue

FROM walmart_sales

GROUP BY category

ORDER BY Revenue DESC

LIMIT 1;

----------------------------------------------------------
-- Top Revenue Branch
----------------------------------------------------------

SELECT

branch,

SUM(quantity*unit_price) AS Revenue

FROM walmart_sales

GROUP BY branch

ORDER BY Revenue DESC

LIMIT 1;

----------------------------------------------------------
-- Highest Average Rating City
----------------------------------------------------------

SELECT

city,

ROUND(AVG(rating),2) AS Avg_Rating

FROM walmart_sales

GROUP BY city

ORDER BY Avg_Rating DESC;

----------------------------------------------------------
-- Branch Performance
----------------------------------------------------------

SELECT

branch,

COUNT(*) AS Transactions,

SUM(quantity*unit_price) AS Revenue,

ROUND(AVG(rating),2) AS Avg_Rating

FROM walmart_sales

GROUP BY branch

ORDER BY Revenue DESC;

----------------------------------------------------------
-- Payment Method Performance
----------------------------------------------------------

SELECT

payment_method,

COUNT(*) AS Transactions,

SUM(quantity*unit_price) AS Revenue,

ROUND(AVG(rating),2) AS Avg_Rating

FROM walmart_sales

GROUP BY payment_method

ORDER BY Revenue DESC;

----------------------------------------------------------
-- Category Performance
----------------------------------------------------------

SELECT

category,

COUNT(*) AS Transactions,

SUM(quantity) AS Quantity,

SUM(quantity*unit_price) AS Revenue,

ROUND(AVG(rating),2) AS Avg_Rating

FROM walmart_sales

GROUP BY category

ORDER BY Revenue DESC;

----------------------------------------------------------
-- Overall Business Summary
----------------------------------------------------------

SELECT

COUNT(*) AS Total_Transactions,

SUM(quantity) AS Total_Quantity,

ROUND(SUM(quantity*unit_price),2) AS Total_Revenue,

ROUND(AVG(rating),2) AS Average_Rating,

ROUND(AVG(profit_margin),2) AS Average_Profit

FROM walmart_sales;

----------------------------------------------------------
-- End of Task 3
----------------------------------------------------------