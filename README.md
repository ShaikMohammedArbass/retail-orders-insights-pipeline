# Retail Orders Data Pipeline: Python Data Cleaning & SQL Analytics

This project demonstrates an end-to-end data analytics workflow. Raw retail order data was processed, cleaned, and transformed using Python (Pandas), loaded into a MySQL database, and analyzed using complex SQL queries to extract actionable business insights.

---

## Data Pipeline Architecture

```text
  +------------------+
  |  Raw CSV Dataset |
  +--------+---------+
           |
           v
  +------------------+
  | Python / Pandas  |  --> Clean missing values, standardize schema,
  +--------+---------+      and calculate discount, sale price, & profit
           |
           v
  +------------------+
  | SQLAlchemy /     |  --> Export cleaned dataset to local MySQL database
  | PyMySQL Engine   |
  +--------+---------+
           |
           v
  +------------------+
  | MySQL Database   |  --> Run complex SQL queries using CTEs, Window 
  | (`orders_DB`)    |      Functions, and conditional aggregations```
  +------------------+

##  Key SQL Insights & Business Queries
The analysis focuses on essential performance metrics using advanced SQL techniques:

Top 10 Revenue Products: Aggregating sales by product ID to identify top grossing items.

Top 5 Products per Region: Using CTEs and ROW_NUMBER() window functions to rank performance per region.

Month-over-Month YoY Growth (2022 vs 2023): Aggregating sales with conditional CASE WHEN logic to compare monthly sales side-by-side.

Peak Category Performance: Pinpointing highest sales months per product category using ranking window functions.

Highest YoY Profit Growth by Sub-Category: Calculating absolute profit delta between 2022 and 2023 to identify growth drivers.
