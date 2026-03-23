# NYC Taxi Data Pipeline on GCP

## Problem Statement
Process large-scale NYC Taxi trip data and transform it into analytics-ready datasets for business insights.

## Architecture
Dataproc (PySpark)
↓
GCS (Storage)
↓
BigQuery (Analytics)

## Tech Stack
- Google Cloud Dataproc (PySpark)
- Google Cloud Storage (GCS)
- BigQuery
- Python (PySpark)

## Pipeline Steps
1. Upload raw data to GCS
2. Run PySpark job on Dataproc
3. Transform data (cleaning, filtering, aggregations)
4. Store processed data in GCS
5. Load into BigQuery

## PySpark Script
File: `nyc_taxi_pipeline.py`

- Includes data transformations, filtering, and aggregation
- Clean and well-commented for readability

## Supporting Scripts
- `dataproc_job_submission.sh` — CLI command to run PySpark job on Dataproc  
- `sample_queries.sql` — Example BigQuery queries for analysis

## Sample Queries / Results
```sql
SELECT passenger_count, COUNT(*) 
FROM nyc_dataset.taxi_data
GROUP BY passenger_count;



# NYC Taxi Data Pipeline on GCP ![Python](https://img.shields.io/badge/python-3.10-blue) ![GCP](https://img.shields.io/badge/GCP-cloud-green)

## Table of Contents
1. [Problem Statement](#problem-statement)
2. [Architecture](#architecture)
3. [Tech Stack](#tech-stack)
4. [Pipeline Steps](#pipeline-steps)
5. [PySpark Script](#pyspark-script)
6. [Supporting Scripts](#supporting-scripts)
7. [Sample Queries / Results](#sample-queries--results)
8. [Key Outcomes](#key-outcomes)
9. [Future Improvements](#future-improvements)
10.[Assets](#assets)
11.[How to Run](#how-to-run)

---

## Problem Statement
Process large-scale NYC Taxi trip data and transform it into analytics-ready datasets for business insights. This pipeline demonstrates cloud-native ETL, scalable processing with PySpark, and integration with GCP services.

---

## Architecture
Raw Data (GCS)
│
▼
Dataproc (PySpark) ──> Transformations (cleaning, filtering, aggregations)
│
▼
Processed Data (GCS)
│
▼
BigQuery (Analytics & Dashboarding)


---

## Tech Stack
- Google Cloud Dataproc (PySpark)
- Google Cloud Storage (GCS)
- BigQuery
- Python (PySpark)

---

## Pipeline Steps
1. Upload raw dataset to GCS
2. Run PySpark job on Dataproc
3. Transform data (cleaning, filtering, aggregations)
4. Store processed data in GCS
5. Load curated data into BigQuery

---

## PySpark Script
File: `nyc_taxi_job.py`  

- Includes all data transformations, filtering, and aggregation
- Clean, well-commented, and modular for readability
- Example snippet:

python
# Load CSV from GCS
df = spark.read.csv("gs://nyx-taxi-data/raw_data/*.csv", header=True, inferSchema=True)

# Filter trips with passenger_count > 0
df_filtered = df.filter(df.passenger_count > 0)

# Aggregate fare per day
df_agg = df_filtered.groupBy("pickup_date").sum("fare_amount")

# Save to GCS
df_agg.write.csv("gs://nyx-taxi-data/processed/")