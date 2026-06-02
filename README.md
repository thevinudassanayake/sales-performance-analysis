# Sales Performance Analysis Project

An end-to-end sales performance analysis project utilizing **Excel (Power Query)**, **SQL**, and **Python (Pandas, Matplotlib)** to clean, normalize, analyze, and visualize retail sales data.

## 📂 Project Structure

```
sales-performance-analysis/
├── dataset/                     # Raw and cleaned dataset files (Git-ignored)
│   ├── Sample - Superstore.csv  # Original raw dataset
│   └── sales_analysis.csv       # Cleaned and processed dataset
├── sql/                         # Modular SQL scripts
│   ├── database_normalization.sql # SQL script for database schema normalization
│   └── business_analysis.sql    # SQL queries for key performance analysis
├── notebooks/                   # Jupyter Notebooks
│   └── sales_analysis.ipynb     # Python data analysis and visualization
├── README.md                    # Project documentation
└── insights.md                  # Executive summary and findings
```

## 🛠️ Tech Stack & Workflow

### 1. Data Cleaning & Transformation (Excel / Power Query)
*   **Action**: Cleaned raw retail sales data, handled missing entries, formatted date columns (`Order Date`, `Ship Date`), and set up the foundation for schema normalization.
*   **Tool**: **Excel & Power Query** was utilized for initial data ingestion and profiling.

### 2. Database Normalization & Schema Design (SQL)
*   **Action**: Normalized the flat CSV table into a star/snowflake schema containing separate tables: `customers`, `products`, `orders`, `shipping`, and `order_items` with appropriate primary and foreign key constraints.
*   **Tool**: **SQL** (MySQL/PostgreSQL compatible scripts).

### 3. Exploratory Data Analysis & Visualizations (Python)
*   **Action**: Analyzed overall sales trends, profit margins, regional performance, and discount impacts. Created plots for sales distribution, regional revenue contribution, and correlation analyses.
*   **Tool**: **Jupyter Notebook (Python, Pandas, Matplotlib, Seaborn)**.

---

## 📊 Database Schema Summary

The normalized database contains:
1.  **Customers Table**: customer ID, name, segment.
2.  **Products Table**: product ID, name, category, sub-category.
3.  **Orders Table**: order ID, customer ID, order date.
4.  **Shipping Table**: shipping mode, ship date, location (city, state, region).
5.  **Order Items Table**: row ID, order ID, product ID, quantity, sales, discount, profit.
