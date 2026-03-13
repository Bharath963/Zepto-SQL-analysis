# Zepto Product Data Analysis – SQL Project

## Project Overview

This project focuses on **exploring, cleaning, and analyzing product data from the Zepto quick-commerce platform using SQL**. The goal was to transform raw product data into meaningful business insights by performing data cleaning, exploratory analysis, and business intelligence queries.

The dataset contains product information such as product name, category, price, discount percentage, inventory availability, product weight, and stock levels. Using SQL queries, the dataset was cleaned and analyzed to identify pricing patterns, discount trends, stock availability, and potential revenue opportunities.

The project demonstrates practical SQL skills including **data cleaning, aggregation, filtering, grouping, conditional logic, and business insight extraction**.

---

# Dataset Description

The dataset was stored in a PostgreSQL table called **zepto** containing the following fields:

| Column                   | Description                                |
| ------------------------ | ------------------------------------------ |
| sku_id                   | Unique identifier for each product         |
| category                 | Product category                           |
| name                     | Product name                               |
| mrp                      | Maximum retail price                       |
| discount_percent         | Discount offered                           |
| available_qty            | Quantity currently available               |
| discounted_selling_price | Price after discount                       |
| weightInGrams            | Product weight                             |
| outOfStock               | Stock availability status                  |
| quantity                 | Number of items sold or inventory quantity |

The table structure was created using SQL as shown in the dataset setup. 

---

# Data Cleaning Process

Real-world datasets often contain inconsistencies, incorrect values, or formatting issues. Several steps were taken to clean and standardize the data before performing analysis.

## 1. Column Correction

A typo existed in the dataset where the column **"quatity"** was incorrectly named. It was renamed to **"quantity"** for consistency and clarity.

Example SQL:

```
ALTER TABLE ZEPTO
RENAME COLUMN quatity TO quantity;
```

---

## 2. Identifying Missing Values

The dataset was checked for missing or NULL values across important columns such as:

* product name
* category
* price
* discount
* weight
* stock availability

Records containing missing critical values were identified to ensure data quality before analysis.

---

## 3. Removing Invalid Price Entries

Some products had a **price value of zero**, which indicates invalid or corrupted records.

These rows were removed to prevent inaccurate analysis.

Example:

```
DELETE FROM ZEPTO
WHERE mrp = 0;
```

---

## 4. Standardizing Price Units

Prices in the dataset were stored in **paise instead of rupees**.

To convert them into readable currency values, prices were divided by 100.

Example:

```
UPDATE ZEPTO
SET mrp = mrp/100.0,
    discounted_selling_price = discounted_selling_price/100.0;
```

This ensured price comparisons and revenue calculations were accurate.

---

## 5. Identifying Duplicate Products

Some product names appeared multiple times in the dataset. This analysis helped identify duplicates and variations of the same product across different SKUs.

Example query:

```
SELECT name, COUNT(sku_id)
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1;
```

---

# Exploratory Data Analysis

After cleaning, exploratory analysis was conducted to understand the structure of the dataset.

Key checks included:

* Total number of products in the dataset
* Distinct product categories
* Number of products currently out of stock
* Duplicate product entries

These steps provided a clear overview of the product catalog before extracting business insights.

---

# Business Insights Extracted

The dataset was analyzed using several SQL queries to extract useful insights.

---

# 1. Top 10 Products Offering the Highest Discounts

Identifying products with the highest discount percentages helps highlight promotional items and competitive pricing strategies.

Insight:

Products with the highest discounts can attract customers and increase sales volume.

---

# 2. High-Priced Products That Are Out of Stock

This analysis identified expensive products that are currently unavailable.

Insight:

Out-of-stock high-value products represent **missed revenue opportunities** and may require better inventory management.

---

# 3. Estimated Revenue by Product Category

Estimated revenue was calculated using:

```
discounted_price × quantity
```

Insight:

This helps identify which product categories contribute the most to overall revenue.

Categories with higher revenue potential may receive priority in marketing and inventory planning.

---

# 4. High-Priced Products With Low Discounts

Products priced above 500 with minimal discounts were identified.

Insight:

These products may have **lower price competitiveness** and could benefit from promotional pricing strategies.

---

# 5. Categories Offering the Highest Average Discounts

The average discount percentage was calculated for each category.

Insight:

Categories with higher discounts may indicate:

* strong market competition
* promotional strategies
* seasonal price reductions

---

# 6. Price Per Gram Analysis

To compare product value fairly across different package sizes, **price per gram** was calculated.

Formula used:

```
discounted_price / weight
```

Insight:

This allows identification of **best value products** and helps consumers or businesses compare products regardless of packaging size.

---

# 7. Product Weight Segmentation

Products were grouped into three weight categories:

| Category | Weight Range  |
| -------- | ------------- |
| Low      | < 1000g       |
| Medium   | 1000g – 5000g |
| Bulk     | > 5000g       |

Insight:

Weight segmentation helps understand product packaging strategies and customer purchasing behavior.

---

# 8. Total Inventory Weight by Category

Total inventory weight was calculated using:

```
weight × available quantity
```

Insight:

This helps identify which product categories dominate warehouse storage and logistics requirements.

---

# Skills Demonstrated

This project demonstrates proficiency in:

* SQL
* Data Cleaning
* Exploratory Data Analysis
* Aggregation Functions
* Data Transformation
* Business Intelligence Queries
* PostgreSQL

---

# Tools Used

* PostgreSQL
* SQL
* Data Exploration Queries
* Analytical SQL Functions

---

# Key Takeaways

Through this project:

* Raw product data was cleaned and standardized.
* SQL queries were used to uncover business insights.
* Pricing, discount trends, and inventory patterns were analyzed.
* Data-driven insights were generated that could support **inventory management, pricing strategies, and business decisions**.

---


