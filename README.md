# NBA Player Performance Pipeline

## Table of Contents

1. [Project Overview](#section-1-project-overview)
2. [Data Extraction](#section-2-data-extraction)
3. [Snowflake Storage](#section-3-snowflake-storage)
4. [DBT Transformation](#section-4-dbt-transformation)
5. [DBT Test Post-Transformation](#section-5-dbt-test-post-transformation)
6. [Visualization/Reporting](#section-6-visualizationreporting)


## Section 1: Project Overview

This project demonstrates an end-to-end analytics workflow, showcasing my skills in **data modeling**, **analytics**, and **visualization** using tools such as **Snowflake**, **dbt**, **Python**, and **Tableau**. The goal is to develop a comprehensive **NBA Player Performance Dashboard** that provides insights into player statistics and performance.

The workflow for this project includes the following steps:

1. **Data Extraction**:  
   - Used Python to extract data from the `Kaggle API` and `NBA API`.

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
- **Data Partitioning**: Spark for partitioning and optimizing data.
- **Data Warehouse**: Snowflake as a scalable, cloud-based data storage.
- **Data Transformation**: dbt for creating and managing data models, including dimension and fact tables.
- **Data Testing**: dbt tests to validate data quality.
- **Data Visualization**: Tableau for designing interactive dashboards for the NBA insights.

Below is the visual representation of the workflow for this project.


<img width="1062" alt="nba_performance_architecture" src="https://github.com/user-attachments/assets/8cec6884-c6e2-4196-af7d-cd98a4f29a9f">


### Tableau Link:

Access here : [(Tableau Page)](https://public.tableau.com/app/profile/yogi.sharo.sarumaha/viz/NBAPerformanceAnalysis/NBAPerformanceDashboard)


## Section 2: Data Extraction

I extract the data and convert to parquet using python notebook in 1. Data Ingestion to Snowflake,

Here is the dataset size and information:

![nba_performance_dataset_size](https://github.com/user-attachments/assets/c6ddb7a5-458b-4b85-9407-091dba90044e)

Here is the directory structure:

![nba_performance_project_structure](https://github.com/user-attachments/assets/599ede48-38bc-4e05-b367-7fbeed41b56c)

here's the preview of the parquet files before imported to snowflake:

![nba_performance_project_partition](https://github.com/user-attachments/assets/cbd5af07-7d7f-48eb-bdca-21afe644f8a6)


## Section 3: Snowflake storage

Creates NBA_GAMES Database containing RAW Tables for games, games_details, players, player_information, ranking, teams
<img width="306" alt="nba_performance_snowflake_storage" src="https://github.com/user-attachments/assets/f4211d18-c133-4953-9cec-33a654ef6e79">


## Section 4: DBT Transformation

The data is structured into three layers: **Raw Layer**, **Staging Layer**, and **Core Layer**.

### Raw Layer
**Purpose**: Contains unprocessed data from the Kaggle API and NBA API.

**Tables**:
- `raw_games`
- `raw_games_details`
- `raw_players`
- `raw_player_information`
- `raw_ranking`
- `raw_teams`

### Staging Layer
**Purpose**: Cleans and prepares raw data for transformation.

**Transformations**:
- `src_games`: Cleans `raw_games` by removing duplicates and standardizing dates.
- `src_games_details`: Cleanses `raw_games_details`.
- `src_players`: Processes player data from `raw_players`.
- `stg_player_information`: Combines attributes from `raw_player_information`.
- `src_ranking`: Aligns rankings and player IDs from `raw_ranking`.
- `src_teams`: Standardizes team data from `raw_teams`.

### Core Layer
**Purpose**: Provides optimized, consolidated data models for analysis and reporting.

**Models**:
- `dim_players_cleansed`: Deduplicates and standardizes player data from `src_players`.
- `dim_teams_cleansed`: Cleans and consolidates team data from `src_teams`.
- `dim_seasons`: Creates a game season dimension from `src_games`.
- `int_player_stats`: Integrates player stats from games, details, and player data.
- `int_season_stats`: Aggregates stats at the season level.
- `fct_player_performance`: Builds a fact table for analyzing player performance.
- `scd_raw_teams`: Applies SCD Type II to track historical changes in team data.
- `scd_raw_players`: Applies SCD Type II to track historical changes in player data.

Here is the output of the dbt run:
<img width="847" alt="nba_performance_dbt_run" src="https://github.com/user-attachments/assets/4933e7db-13cb-4a72-9be0-ec7d0db3b7b9">


Below is the lineage graph from dbt:

<img width="899" alt="nba_performance_full_lineage_graph" src="https://github.com/user-attachments/assets/bd0356ac-5bfd-490c-af84-d56b3d7c5fc6">


Note that not all of the tables in the dbt model are used for reporting; some data models are included to present data modeling techniques

## Section 5: DBT Test Post-Transformation

This section is important to ensure the accuracy and reliability of our data pipeline and to identify issues early.

### Generic Tests: To Test Common Data Issues

#### Table: `dim_players_cleansed`
- **Field**: `player_name`
  - **Test**: `not_null`
- **Field**: `team_id`
  - **Test**: `not_null`
- **Field**: `player_id`
  - **Test**: `not_null`

#### Table: `dim_seasons`
- **Field**: `season_id`
  - **Tests**: `not_null`, `unique`
- **Field**: `season_name`
  - **Tests**: `not_null`, `unique`
- **Field**: `start_date`
  - **Test**: `not_null`
- **Field**: `end_date`
  - **Test**: `not_null`

#### Table: `src_games`
- **Field**: `home_team_wins`
  - **Test**: `accepted_values`

### Singular Tests: To Cover Specific Tests in the Data Model

#### Table: `fct_player_performance`
- **Field**: `total_points`
  - **Test**: If `total_points` is less than 0, flag as fault.

#### Table: `int_season_stats`
- **Field**: `efficiency_rating`
  - **Test**: Using a macro, if `efficiency_rating` is greater than 100, flag as invalid.

### Output of the Tests

<img width="771" alt="nba_performance_dbt_test" src="https://github.com/user-attachments/assets/83539d31-390d-46d8-b8d2-35269655a21c">


## Section 6: Visualization/Reporting

Here are some questions to be answered in this dashboard: 

1. **How does a player's performance evolve over the seasons?**  
   - "Point Per Game by Season" and "Shot Accuracy by Season" charts allow users to track a player's scoring trends and efficiency over time. Users can filter by **Season Year** or type in **Player Name**.

2. **How is the relationship between scoring and assisting for players?**  
   - The "Scoring vs Assist" scatterplot visualizes how players balance scoring and assisting responsibilities, to look at their playmaking style. For example, we can check if high scorers would also contribute significantly with assists.

3. **Who are the top players in terms of points per game, and how do they compare?**  
   - The "Top 15 Players by Points Per Game" table ranks players based on their scoring averages.

4. **How does a player's defensive performance compare to others?**  
   - The "Defensive Performance" scatterplot shows defensive contributions like steals and blocks per game. This chart looks at which player that has an outstanding offensive play and also good in defense



Here is the snapshot of the dashboard : 
<img width="830" alt="nba_performance_tableau" src="https://github.com/user-attachments/assets/7f6b286c-a809-4c22-a7ee-7e16d4f1747d">



Access the tableau dashboard here : [(Tableau Page)](https://public.tableau.com/app/profile/yogi.sharo.sarumaha/viz/NBAPerformanceAnalysis/NBAPerformanceDashboard)


