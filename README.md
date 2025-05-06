# 🏋️‍♂️ ADLeisure&Fitness Cloud Data Platform (ELTL Pipeline with Azure)

## 🎯 Project Goal/Objective

The goal is to design, develop, and deploy a **cloud-based data system** that enables seamless **ingestion, transformation, storage**, and **analysis** of fitness centre data. The system aims to:

* 📦 **Centralize** member, booking, and facility usage data from various sources.
* ⚙️ **Automate** data workflows using Azure Data Factory for consistent and timely updates.
* 🧹 **Cleanse and transform** data to derive actionable business insights.
* 🗃️ **Store** curated datasets in Azure SQL Database for downstream use in dashboards and reports.
* 📊 **Enable stakeholders** to monitor member engagement, class attendance, and operational efficiency through real-time reporting.

## 🧩 Tech Stack

* **PostgreSQL** – for data modelling, relationship and constraint design
* **Azure Data Factory** – for data ingestion, transformation, and pipeline orchestration
* **Azure Blob Storage** – for storing raw CSV files
* **Azure SQL Database** – for storing transformed data
* **Azure Data Studio** – for querying and managing SQL DB

## ⚙️ Pipeline Architecture

An **ELTL** (Extract, Load, Transform, Load) data flow:

1. **Extract** – Raw data from CSVs in Azure Blob Storage
2. **Load** – Initial load into staging datasets using Azure Data Factory
3. **Transform** – Data Cleansing and Transformation via Data Flow in ADF
4. **Load** – Curated datasets written into Azure SQL Database

## 🔄 Key Data Transformations

* Extracted `booking_time` and normalized it to datetime format
* Parsed and split schedule strings into structured values (e.g., day/time)
* Calculated total bookings per member
* Categorized member activity (Low, Moderate, High)
* Flagged new members based on join year

## 🧱 Database Modeling

* Created tables for `members`, `bookings`, `classes`, `facilities`, and `usage_logs`
* Defined foreign key relationships and constraints for data integrity
* Indexed common query fields for performance

## 📊 Analytics & Use Cases

* Track member engagement and churn
* Analyze class popularity and instructor load
* Monitor peak usage periods per facility

## 🖥️ Monitoring and Scheduling

* Scheduled pipelines to refresh data on a regular cadence
* Monitored runs using ADF monitoring panel

## ✅ Deliverables

* ADF Pipeline JSON exports
* SQL scripts for database creation
* Project presentation slide deck
* Architecture diagrams

## 📁 Repository Structure

```bash
├── data/                   # Sample input datasets
├── pipelines/              # JSON exports from Azure Data Factory
├── sql/                    # SQL scripts (DDL, queries)
├── assets/                 # Architecture diagrams, screenshots
├── README.md               # Project overview and instructions
```

## 🚀 Outcome

* Built a fully functional cloud-based ELTL data system
* Automated ingestion and transformation pipelines
* Enabled stakeholders to make informed decisions via SQL queries and BI readiness
