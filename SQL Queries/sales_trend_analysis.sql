-- =========================================================
-- TASK 6: Sales Trend Analysis Using Aggregations
-- Objective: Analyze Monthly Revenue and Order Volume
-- Dataset: online_sales
-- Tools: MySQL
-- =========================================================

-- Create a new database for the project
CREATE DATABASE sales_trend_analysis;

-- Select the database for use
USE sales_trend_analysis;

-- Remove the table if it already exists
DROP TABLE IF EXISTS online_sales;

-- Create the online_sales table
CREATE TABLE online_sales (
    order_id VARCHAR(50),
    order_date DATE,
    amount DECIMAL(10,2),
    product_id VARCHAR(50)
);

-- =========================================================
-- DATA VALIDATION QUERIES
-- =========================================================

-- Check the total number of records imported
SELECT COUNT(*) FROM online_sales;

-- View all records from the dataset
SELECT * FROM online_sales;

-- =========================================================
-- QUERY 1: Monthly Revenue and Order Volume Analysis
-- Purpose:
-- Analyze revenue and number of unique orders
-- for each month and year.
-- =========================================================

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    ROUND(SUM(amount),2) AS monthly_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM online_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

-- =========================================================
-- QUERY 2: Monthly Revenue Analysis
-- Purpose:
-- Calculate total revenue generated each month.
-- =========================================================

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    ROUND(SUM(amount), 2) AS monthly_revenue
FROM online_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

-- =========================================================
-- QUERY 3: Monthly Order Volume Analysis
-- Purpose:
-- Calculate the number of unique orders placed
-- each month.
-- =========================================================

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(DISTINCT order_id) AS order_volume
FROM online_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

-- =========================================================
-- QUERY 4: Monthly Revenue and Order Volume
-- For a Specific Year (2016)
-- Purpose:
-- Analyze monthly performance for the year 2016.
-- =========================================================

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    ROUND(SUM(amount), 2) AS monthly_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM online_sales
WHERE YEAR(order_date) = 2016
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_month;

-- =========================================================
-- QUERY 5: Top 10 Products by Revenue
-- Purpose:
-- Identify products generating the highest revenue.
-- =========================================================

SELECT
    product_id,
    ROUND(SUM(amount), 2) AS total_revenue
FROM online_sales
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;

-- =========================================================
-- QUERY 6: Top 3 Months by Revenue
-- Purpose:
-- Identify the three best-performing months
-- based on total sales revenue.
-- =========================================================

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    ROUND(SUM(amount),2) AS monthly_revenue
FROM online_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY monthly_revenue DESC
LIMIT 3;

-- =========================================================
-- QUERY 7: Yearly Revenue and Order Volume
-- Purpose:
-- Analyze sales performance at the yearly level.
-- =========================================================

SELECT
    YEAR(order_date) AS order_year,
    ROUND(SUM(amount),2) AS yearly_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM online_sales
GROUP BY YEAR(order_date)
ORDER BY order_year;

-- =========================================================
-- QUERY 8: Average Order Value by Month
-- Purpose:
-- Calculate the average revenue generated
-- per order for each month.
-- Formula:
-- Average Order Value = Total Revenue / Order Volume
-- =========================================================

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    ROUND(SUM(amount), 2) AS monthly_revenue,
    COUNT(DISTINCT order_id) AS order_volume,
    ROUND(SUM(amount) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM online_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

-- =========================================================
-- END OF PROJECT
-- =========================================================