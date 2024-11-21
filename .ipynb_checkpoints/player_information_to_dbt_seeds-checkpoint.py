import pandas as pd
import snowflake.connector
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()

# Connect to Snowflake
ctx = snowflake.connector.connect(
    user=os.getenv('SNOWFLAKE_USER'),
    password=os.getenv('SNOWFLAKE_PASSWORD'),
    account=os.getenv('SNOWFLAKE_ACCOUNT'),
    warehouse=os.getenv('SNOWFLAKE_WAREHOUSE'),
    database=os.getenv('SNOWFLAKE_DATABASE'),
    schema=os.getenv('SNOWFLAKE_SCHEMA'),
    role=os.getenv('SNOWFLAKE_ROLE')
)

# Query to fetch player information
query = """SELECT player as player_name, MAX(weight) AS weight, MAX(height) AS height, MAX(position) AS position FROM player_information GROUP BY player_name"""

# Load data into a pandas DataFrame
df = pd.read_sql(query, ctx)

# Save DataFrame to a CSV file for dbt seeds
csv_path = 'seeds/seeds_player_information.csv'  # Renamed the file
df.to_csv(csv_path, index=False)

print(f"Exported player information to {csv_path}.")

# Close the connection
ctx.close()
