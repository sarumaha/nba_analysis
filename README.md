# NBA Player Performance Pipeline

## Section 1: Project Overview

This project demonstrates an end-to-end analytics workflow, showcasing my skills in **data modeling**, **analytics**, and **visualization** using tools such as **Snowflake**, **dbt**, **Python**, and **Tableau**. The goal is to develop a comprehensive **NBA Player Performance Dashboard** that provides insights into player statistics and performance while highlighting expertise in modern data tools and techniques.

The workflow for this project includes the following steps:

1. **Data Extraction**:  
   - Used Python to extract data from the Kaggle API and `nba_api`.

2. **Data Processing**:  
   - Used PySpark to clean and compress data for efficient storage and processing.

3. **Data Loading**:  
   - Import Parquet files into Snowflake using Python for cloud-based storage.

4. **Data Transformation**:  
   - Used dbt to create:
     - Dimension tables with SCD Type II for historical tracking.
     - Fact tables for performance metrics.
     - Intermediate and aggregated tables for reporting.

5. **Data Quality Assurance**:  
   - Applied dbt tests, including:
     - **Generic Tests**: Enforced constraints like uniqueness and non-nullability.
     - **Singular and Custom Tests**: Ensured data accuracy and eliminated anomalies.

6. **Data Reporting**:  
   - Visualize dashboards in Tableau to present insights.



## Tools

This project uses the following tools at various stages of the workflow:

- **Data Extraction**: Python for retrieving data from APIs and external sources.
- **Data Partitioning**: Spark for partitioning and optimizing data for efficient processing.
- **Data Warehouse**: Snowflake as a scalable, cloud-based data storage and querying solution.
- **Data Transformation**: dbt for creating and managing data models, including dimension and fact tables.
- **Data Testing **: dbt tests to validate data quality.
- **Data Visualization**: Tableau for designing interactive dashboards to present actionable insights.

Below is the visual representation of the workflow for this project.


<img width="1062" alt="nba_performance_architecture" src="https://github.com/user-attachments/assets/8cec6884-c6e2-4196-af7d-cd98a4f29a9f">


## Tableau Link:

Access here : [(Tableau Page)](https://public.tableau.com/app/profile/yogi.sharo.sarumaha/viz/NBAPerformanceAnalysis/NBAPerformanceDashboard)


## Section 2 Data Extraction

I extract the data and convert to parquet using python notebook in 1. Data Ingestion to Snowflake,

![nba_performance_project_structure](https://github.com/user-attachments/assets/599ede48-38bc-4e05-b367-7fbeed41b56c)

here's the output of all the data...
![nba_performance_project_partition](https://github.com/user-attachments/assets/cbd5af07-7d7f-48eb-bdca-21afe644f8a6)


## Section 3 Snowflake storage


## Section 4 DBT Transformation


## Section 5 DBT Test Post-Transformation

## Section 6 Visualization/Reporting


