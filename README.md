# Retail Orders Data Pipeline: Python Data Cleaning & SQL Analytics

This project demonstrates an end-to-end data analytics workflow. Raw retail order data was processed, cleaned, and transformed using Python (Pandas), loaded into a MySQL database, and subsequently analyzed using SQL queries to extract key business insights.

---

## Project Architecture & Workflow
1. **Data Ingestion & Cleaning (Python)**: Extracted raw sales data from CSV, handled null values, standardized column schemas, and cast date fields.
2. **Feature Engineering (Python)**: Computed metric columns including `discount`, `sale_price`, and `profit`.
3. **Database Export (Python & SQLAlchemy)**: Loaded processed data into MySQL database tables.
4. **Business Analytics (SQL)**: Queried top-performing products, regional sales distributions, and Year-over-Year (YoY) revenue and profit trends.

---

## Key SQL Insights & Queries Covered
* **Top 10 Revenue Generating Products**: Aggregating sales by product ID to find primary drivers.
* **Top 5 Products per Region**: Using CTEs and `ROW_NUMBER()` window functions to rank performance per region.
* **Month-over-Month YoY Growth (2022 vs 2023)**: Aggregating sales with conditional `CASE WHEN` logic to pivot monthly revenue side-by-side.
* **Peak Category Performance**: Pinpointing highest sales months per product category.
* **Highest YoY Profit Growth by Sub-Category**: Calculating absolute profit delta between 2022 and 2023 to identify growth drivers.

---

## Technical Stack
* **Language**: Python 3.x, SQL
* **Libraries**: Pandas, SQLAlchemy, PyMySQL
* **Database**: MySQL Server
* **Environment**: Jupyter Notebook

---


