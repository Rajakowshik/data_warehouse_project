# data_warehouse_project

## 📌 Overview

This project demonstrates the design and implementation of a **modern data warehouse** using SQL Server. It follows the **Medallion Architecture (Bronze → Silver → Gold)** to transform raw data into analytical insights.

The goal is to build a structured pipeline that supports **data cleaning, transformation, and business reporting**.

---

## 🏗️ Data Architecture

The project is structured into three layers:

### 🥉 Bronze Layer

* Stores raw data from source systems (CRM & ERP)
* Data is ingested directly from CSV files
* No transformations applied

### 🥈 Silver Layer

* Cleans and standardizes data
* Handles:

  * Missing values
  * Invalid records
  * Data formatting issues
* Prepares data for modeling

### 🥇 Gold Layer

* Builds analytical data models (Star Schema)
* Includes:

  * Fact table: `fact_sales`
  * Dimension tables: `dim_customer`, `dim_products`
* Optimized for reporting and analytics

---

## 🔄 ETL Pipeline

1. Load raw data into Bronze layer
2. Clean and transform data in Silver layer
3. Create dimension and fact tables in Gold layer

---

## 📊 Data Model

The Gold layer follows a **Star Schema**:

* **Fact Table**

  * `fact_sales` → stores transactional data

* **Dimension Tables**

  * `dim_customer` → customer details
  * `dim_products` → product information

---

## 🧹 Data Cleaning Rules

* Removed invalid prefixes (e.g., 'NAS' from IDs)
* Standardized gender values (M/F → Male/Female)
* Replaced NULL values using `COALESCE`
* Removed future dates in birthdate columns
* Ensured consistency across joined datasets

---

## 🛠️ Tech Stack

* SQL Server
* SQL (T-SQL)
* CSV Data Sources
* Git & GitHub

---

## 📂 Project Structure

```
sql-datawarehouse-project/
│
├── data/
│   └── raw/                # Raw CSV datasets
│
├── scripts/
│   ├── bronze/             # Data ingestion scripts
│   ├── silver/             # Data cleaning scripts
│   └── gold/               # Data modeling scripts
│
├── docs/                   # Architecture diagrams and documentation
│
├── README.md
└── .gitignore
```

---

## ▶️ How to Run

1. Run Bronze scripts to load raw data
2. Run Silver scripts to clean data
3. Run Gold scripts to build analytical tables

---

## 🚀 Key Highlights

* Implemented Medallion Architecture
* Designed Star Schema for analytics
* Built end-to-end ETL pipeline using SQL
* Applied real-world data cleaning techniques

---

## 📌 Future Improvements

* Convert views to physical tables
* Add incremental data loading
* Implement indexing for performance
* Integrate with BI tools (Power BI / Tableau)

---

## 👨‍💻 Author

This project is developed as part of a data engineering learning journey.
