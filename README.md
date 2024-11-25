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

The data is organized into three layers: Raw Layer, Staging Layer, and Core Layer, each serving a purpose in processing and transforming data.

<img width="958" alt="nba_performance_project_data-flow" src="https://github.com/user-attachments/assets/5062d61b-6904-47ef-8efd-b4ac2e0daa75">

## Raw Layer
**Purpose**: This layer contains the unprocessed, raw data from kaggle API and NBA API.
**Tables**:
- `raw_games`
- `raw_games_details`
- `raw_players`
- `raw_player_information`
- `raw_ranking`
- `raw_teams`

## Staging Layer
**Purpose**: The staging layer serves as an intermediary step where raw data is cleaned and prepared for further transformation.
**Transformations**:
- `src_games`: Loads data from `raw_games`, removes duplicates, and standardizes date formats.
- `src_games_details`: Imports and cleanses data from `raw_games_details`.
- `src_players`: Processes player data from `raw_players`.
- `stg_player_information`: Compiles detailed player information from `raw_player_information` for additional attributes.
- `src_ranking`: Gets ranking data from `raw_ranking`, aligning player IDs and rankings.
- `src_teams`: Gets team information from `raw_teams`

## Core Layer
**Purpose**: The core layer is designed for optimized query performance and supports complex analytical queries by providing cleansed, consolidated, and dimensionally modeled data.
**Models**:
- `dim_players_cleansed`: Consolidates player data from `src_players` to remove redundancies and ensure uniform formats.
- `dim_teams_cleansed`: Cleanses and deduplicates team data from `src_teams`.
- `dim_seasons`: Constructs a dimension table for game seasons from `src_games`, enabling analysis by season.
- `int_player_stats`: Integrates player statistics from multiple staging tables to provide a comprehensive view of player performance.
- `int_season_stats`: Aggregates season statistics to offer insights at the season level.
- `fct_player_performance`: A fact table that compiles player performance metrics, enabling detailed analysis and reporting.
- `scd_raw_teams`: Transformed from `raw_teams` using DBT and apply SCD type II logic to capture historical changes in team data.
- `scd_raw_players`: Transformed from `raw_players` using DBT and apply SCD type II logic to capture historical changes in player data.





## Section 5 DBT Test Post-Transformation

## Section 6 Visualization/Reporting


