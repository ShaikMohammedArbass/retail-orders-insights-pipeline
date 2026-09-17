## 📦 Retail Orders Data Pipeline: Python ETL & SQL Analytics

An end-to-end data pipeline that takes 9,994 raw retail order records through Python-based cleaning and feature engineering, loads them into a MySQL database, and answers five business questions using analytical SQL — CTEs, window functions, and conditional aggregation.

## Short Description

This project demonstrates a complete **Extract → Transform → Load → Analyze** workflow without relying on a BI tool: raw order-level data is cleaned and enriched entirely in Python (Pandas), pushed into a relational MySQL database via SQLAlchemy, and every business insight is derived directly from hand-written SQL — including window functions and multi-stage CTEs — rather than a drag-and-drop dashboard. It's intended to demonstrate data engineering fundamentals (cleaning, feature engineering, database loading) paired with analytical SQL skill.

## Tech Stack

- **🐍 Python (Pandas)** — Data cleaning, null handling, and feature engineering (`discount`, `sale_price`, `profit`).
- **🔗 SQLAlchemy + PyMySQL** — Loads the cleaned DataFrame into a MySQL database table.
- **🛢️ MySQL** — Relational database used as the analytical query layer.
- **🧮 SQL** — CTEs, `ROW_NUMBER()` window functions, `CASE WHEN` conditional aggregation, and `DATE_FORMAT`-based time grouping.
- **📓 Jupyter Notebook** — Development environment for the ETL stage, executed top to bottom.

## Data Source

*Source: Retail order-level transaction data (`Retail-Orders-Dataset.csv`).*

9,994 order line items spanning **January 2022 – December 2023**, covering order details (date, ship mode, segment), geography (country, state, city, region — 4 regions: South, West, Central, East), product hierarchy (category, sub-category, product ID), and pricing (cost price, list price, discount %, quantity). A data-quality check confirmed 0 duplicate rows; 6 rows have a missing `ship_mode` value, left as `NULL` rather than imputed.

## Features / Highlights

- **Business Problem**

  Raw transactional exports tell a business what was sold, but not which products, regions, or time periods are actually driving revenue and profit growth — or where performance is quietly declining. Answering that requires cleaning the data first, then querying it with the right analytical SQL, not just summing columns.

- **Goal of the Pipeline**

  To build a reusable, portable pipeline that:
  - Cleans and standardizes raw order data (column naming, null handling, type conversion).
  - Engineers the financial metrics (discount, sale price, profit) needed for downstream analysis.
  - Loads the result into a real relational database rather than staying in a flat file.
  - Answers concrete revenue/profit questions using SQL window functions and CTEs — the same techniques used in production analytics.

- **Pipeline Walkthrough**

  1. **Load & null handling:** Raw CSV loaded with `Not Available`/`unknown` placeholder strings mapped to true `NaN`.
  2. **Column standardization:** All column names lowercased and spaced replaced with underscores for SQL compatibility.
  3. **Data quality check:** Confirms 0 duplicate rows and surfaces exactly which columns carry nulls before any metric is trusted.
  4. **Feature engineering:** `discount = list_price × discount_percent`, `sale_price = list_price − discount`, `profit = sale_price − cost_price`.
  5. **Type conversion:** `order_date` cast from text to a proper datetime.
  6. **Column pruning:** Source columns already folded into the new metrics (`cost_price`, `list_price`, `discount_percent`) are dropped to keep the loaded table lean.
  7. **Load to MySQL:** Cleaned table pushed to a `df_orders` table via SQLAlchemy for SQL-side analysis.

- **SQL Analysis — Queries & Verified Results**

  | # | Question | Technique | Result |
  |---|---|---|---|
  | 1 | Top 10 highest-revenue products | `GROUP BY` + `ORDER BY ... LIMIT` | `TEC-CO-10004722` leads at **$59,514** — 2.2x the #2 product |
  | 2 | Top 5 products per region | CTE + `ROW_NUMBER()` window function | Ranks products independently within each of the 4 regions |
  | 3 | Month-over-month growth, 2022 vs. 2023 | CTE + `CASE WHEN` pivot | **Feb 2023 grew +42.2%** YoY; **Jun 2023 fell −26.8%** YoY |
  | 4 | Peak sales month per category | CTE + `DATE_FORMAT` + `ROW_NUMBER()` | Furniture peaked Oct 2022, Office Supplies Feb 2023, Technology Oct 2023 |
  | 5 | Sub-category with highest YoY profit growth | Multi-stage CTE + `CASE WHEN` | **Machines** grew **+$3,635**; **Copiers** declined **−$3,062** |

- **Business Impact & Insights**

  - **Product concentration risk:** The top product (`TEC-CO-10004722`, a Technology/Copier item) generates more than double the revenue of the next-highest product — a strong candidate for stock-out risk monitoring.
  - **Seasonality by category:** Each product category peaks in a different month (Furniture in October, Office Supplies in February, Technology in October), suggesting category-specific promotional and inventory timing rather than a single company-wide calendar.
  - **Profit growth is uneven at the sub-category level:** Machines (+$3,635) and Phones (+$2,319) drove profit growth in 2023, while Copiers (−$3,062), Appliances (−$2,481), and Tables (−$2,041) declined — a swing of over $6,600 between the best- and worst-performing sub-categories, pointing to where margin or pricing review is most needed.
  - **Volatile month-over-month growth** (from +42.2% in February to −26.8% in June) suggests revenue is not steadily trending but driven by specific campaigns or seasonal spikes worth investigating further.

## Repository Contents

| File | Description |
|---|---|
| `Retail-Orders-Insights-Pipeline.ipynb` | Jupyter notebook covering the full ETL pipeline, pre-executed with outputs |
| `Retail-Orders-Performance-Queries.sql` | Five annotated SQL queries (CTEs, window functions, conditional aggregation) with verified results |
| `Retail-Orders-Dataset.csv` | Source dataset (9,994 order line items) |

## How to Run

```bash
pip install pandas sqlalchemy pymysql jupyter
```

1. Start a local MySQL server and create a database (e.g. `orders_db`).
2. Set your connection details as environment variables rather than hardcoding them:
   ```bash
   export MYSQL_USER=root
   export MYSQL_PASSWORD=your_password
   export MYSQL_HOST=localhost
   export MYSQL_DB=orders_db
   ```
3. Run `Retail-Orders-Insights-Pipeline.ipynb` top to bottom to clean the data and load it into MySQL.
4. Run the queries in `Retail-Orders-Performance-Queries.sql` against the `df_orders` table to reproduce the results above.
