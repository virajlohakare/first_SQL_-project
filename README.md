-- Project: Retail Sales Data Analysis 📊
-- Created by: Viraj Lohakare 💼
-- This project covers retail sales data analysis, including data cleaning, exploration, and generating insights!

-- Step 1: Create Database for the Project 🏗️
CREATE DATABASE project;
USE project;

-- Step 2: Create the Retail Sales Table 🛒
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(5),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- Step 3: Check the Created Table 🔍
SELECT * FROM retail_sales;

-- Step 4: Count the Number of Transactions in the Dataset 🧮
SELECT COUNT(*) FROM retail_sales;

-- Data Cleaning Process 🧹

-- Step 5: Identify Null Values in the Dataset ⚠️
SELECT * FROM retail_sales  
WHERE 
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantity IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;

-- Step 6: Remove Null Data 🗑️
DELETE FROM retail_sales
WHERE 
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantity IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;

-- Data Exploration 🚀


-- Step 8: How Many Unique Customers? 👤
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales;

-- Step 9: Count of Unique Categories 🛍️
SELECT COUNT(DISTINCT category) AS category_count FROM retail_sales;

-- Step 10: Display All Unique Categories 🗂️
SELECT DISTINCT category FROM retail_sales;

-- Data Analysis & Business Problems 💼

-- 1️⃣ Retrieve All Sales Made on '2022-11-05' 📅
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

-- 2️⃣ Transactions in November 2022 with Category = 'Clothing' and Quantity > 10 👗👕
SELECT * FROM retail_sales  
WHERE category = 'clothing' 
AND DATE_FORMAT(sale_date, '%Y') = '2022'
AND quantity > 10;

-- 3️⃣ Total Sales for Each Category 💵
SELECT category, 
       SUM(total_sale) AS net_sale, 
       COUNT(*) AS total_order 
FROM retail_sales 
GROUP BY category;

-- 4️⃣ Average Age of Customers Who Purchased from the 'Beauty' Category 💅
SELECT ROUND(AVG(age), 2) AS avg_age FROM retail_sales WHERE category = 'beauty';

-- 5️⃣ Find All Transactions with Total Sales Greater Than 1000 💰
SELECT transactions_id, total_sale 
FROM retail_sales 
WHERE total_sale > 1000;

-- 6️⃣ Total Number of Transactions by Gender in Each Category 👨👩
SELECT category, gender, COUNT(*) AS total_transactions 
FROM retail_sales 
GROUP BY category, gender 
ORDER BY 1;


-- 8️⃣ Top 5 Customers by Highest Total Sales 🏆
SELECT customer_id, 
       SUM(total_sale) AS total_sales 
FROM retail_sales 
GROUP BY customer_id 
ORDER BY total_sales DESC
LIMIT 5;

-- 9️⃣ Unique Customers for Each Category 🛍️
SELECT category, 
       COUNT(DISTINCT customer_id) AS unique_customers 
FROM retail_sales 
GROUP BY category;

-- 🔟 Categorize Orders by Shift (Morning, Afternoon, Evening) 🌅🌞🌙
WITH hourly_sales AS (
    SELECT *,
        CASE 
            WHEN HOUR(sale_time) < 12 THEN 'morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
            ELSE 'evening'
        END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders 
FROM hourly_sales 
GROUP BY shift;
