drop table if exists
create table zepto(
	sku_id SERIAL PRIMARY KEY,
	category VARCHAR(120),
	name VARCHAR(150) NOT NULL,
	mrp NUMERIC(8,2),
	discount_percent NUMERIC(5,2),
	available_qty INTEGER,
	discounted_selling_price NUMERIC(8,2),
	weightInGrams INTEGER,
	outOfStock BOOLEAN,
	quatity INTEGER
);
ALTER TABLE ZEPTO
RENAME COLUMN quatity To quantity
--data exploration

--count of rows
SELECT COUNT(*) FROM ZEPTO

--SAMPLE DATA
SELECT * FROM ZEPTO LIMIT 10;

--NULL VALUES
SELECT * FROM ZEPTO
WHERE name IS NULL
OR
mrp IS NULL
OR
category IS NULL
OR
discount_percent IS NULL
OR
discounted_selling_price IS NULL
OR
weightInGrams IS NULL
OR
available_qty IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL

--different product category
SELECT DISTINCT category 
FROM zepto
ORDER BY category;

--STOCKS EXPLORATION
SELECT outOfStock, COUNT(sku_id)
FROM zepto
GROUP BY outOfStock;

--PRODUCT NAME PRESENT MULTIPLE TIMES
SELECT name, COUNT(sku_id)
FROM zepto
GROUP BY name
HAVING COUNT(sku_id)>1
ORDER BY Count(sku_id) DESC;

--DATA CLEANING
--PRODUCTS WITH PRIZE 0
SELECT * FROM ZEPTO 
WHERE mrp =0 OR discounted_selling_price = 0;

DELETE FROM ZEPTO WHERE mrp = 0;

--CONVERT PAISE TO RUPEES
UPDATE ZEPTO
SET mrp = mrp/100.0,discounted_selling_price = discounted_selling_price/100.0;

SELECT mrp,discounted_selling_price FROM ZEPTO;

--BUSIESS INSIGHTS

--Q1. Top 10 ebst value products based on the discount percent
SELECT DISTINCT name,mrp,discount_percent
FROM zepto
ORDER BY discount_percent DESC
LIMIT 10;

--Q2. PRODUCTS WITH HIGH MRP UT OUT OF STOCK
SELECT DISTINCT name,mrp,outOfStock
FROM zepto
WHERE outOfStock = True and mrp>300
order by mrp desc;

--Q3. CALCULATE THE STIMATED REVENUE FOR EACH CATEGORY
SELECT category,
SUM(discounted_selling_price * quantity) AS Total_revenue
from zepto
group by category
order by Total_revenue;

--Q4.Find all the products where MRP is greater than 500 and discount less than 10%
SELECT DISTINCT name,mrp,discount_percent
FROM zepto
WHERE mrp>500 and discount_percent < 10
order by mrp desc,discount_percent desc;

--Q5. Top 5 products offering highest average discount percent
SELECT category,
ROUND(AVG(discount_percent),2) as avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount desc
LIMIT 5;

--Q6. Find the price per gram for products above 100g and sort by values
SELECT DISTINCT name, weightInGrams,discounted_selling_price,
ROUND(discounted_selling_price/weightInGrams,2) as price_per_gram
FROM ZEPTO 
WHERE weightInGrams>=100
order by price_per_gram;

--Q7. Grouping of categories into low,medium and bulk
SELECT DISTINCT name, weightInGrams,
CASE WHEN weightInGrams < 1000 THEN 'low'
	 WHEN weightInGrams <5000 THEN 'medium'
	 ELSE 'bulk'
	 END as weight_category
From zepto;

--Q8.Total inventory weight per category
SELECT DISTINCT category,
sum(weightInGrams*available_qty) as total_weight
from zepto
group by category
order by total_weight desc;
