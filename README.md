# NBA Player Performance Pipeline

## Section 1 Project Overview

This project is an end-to-end analytics workflow showcasing my skills in **data modeling**, **analytics**, and **visualization** using tools like **Snowflake**, **dbt**, **Python**, and **Tableau**. The goal is to create a comprehensive **NBA Player Performance Dashboard** that provides insights into player statistics and performance while demonstrating expertise in modern data tools and techniques.

The workflow for this project is as follows:

1. Data Extraction: using python to take data from kaggle api and nba_api
2. Data Processing: Using pyspark to compress data
3. Data Loading : Import parquet file to Snowflake using Python
4. Data Transformation: using dbt to create dimension table with scd type II, fact tables, intermediate tables, Aggregated Tables
5. Data Quality Assurance: Using dbt test like generic test, singular test and custom test to keep unique values,  remove null values etc
6. Data Reporting : Using Tableau for the reporting


## Tools 

- Data Extraction: Python
- Data Partition: Spark
- Data Warehouse: Snowflake
- Data Transformation: dbt
- Data Testing post transformation: dbt test
- Data Visualization: Tableau

Below is the visualized workflow for this project

<img width="1062" alt="nba_performance_architecture" src="https://github.com/user-attachments/assets/8cec6884-c6e2-4196-af7d-cd98a4f29a9f">


## Tableau Link:

Access here : (here)


## Section 2 Data Extraction

I extract the data and convert to parquet using python notebook in 1. Data Ingestion to Snowflake,

![nba_performance_project_structure](https://github.com/user-attachments/assets/599ede48-38bc-4e05-b367-7fbeed41b56c)

here's the output of all the files...

## Section 3 Snowflake storage
