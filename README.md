## NYC Taxi Data Pipeline on GCP ![Python](https://img.shields.io/badge/python-3.10-blue) ![GCP](https://img.shields.io/badge/GCP-cloud-green)

> End-to-end data pipeline built on GCP using PySpark for large-scale data processing and analytics.

## Table of Contents
1. [Problem Statement](#problem-statement)
2. [Architecture](#architecture)
3. [Tech Stack](#tech-stack)
4. [Pipeline Steps](#pipeline-steps)
5. [PySpark Script](#pyspark-script)
6. [Supporting Scripts](#supporting-scripts)
7. [Key Outcomes](#key-outcomes)
8. [Future Improvements](#future-improvements)
9. [Assets](#assets)
10. [How To Run](#how-to-run)

---

## Problem Statement
Process large-scale NYC Taxi trip data and transform it into analytics-ready datasets for business insights. This pipeline demonstrates cloud-native ETL, scalable processing with PySpark, and integration with GCP services.

---

## Architecture
```
Raw Data (GCS)
   ↓
Dataproc (PySpark) → Transformations
   ↓
Processed Data (GCS)
   ↓
BigQuery (Analytics & Dashboarding)
```

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
- Example transformation snippets (full logic available in `nyc_taxi_job.py`):

```python
from pyspark.sql.functions import col, to_date

# Load data from GCS
df = spark.read.parquet("gs://de-nyx-taxi-newton/raw_data/")

# Filter valid trips
df_clean = df.filter(
    (col("trip_distance") > 0) & 
    (col("fare_amount") > 0)
)

# Business logic example
df_clean = df_clean.withColumn(
    "trip_date",
    to_date(col("tpep_pickup_datetime"))
)

# Write processed data to BigQuery
df_agg.write \
      .format("bigquery") \
      .option("table", "de-way-forward.nyc_taxi.trips") \
      .option("temporaryGcsBucket", "de-nyx-taxi-newton") \
      .mode("overwrite") \
      .save()
```
---

## Supporting Scripts
- `dataproc_job_submission.sh` — CLI command to run PySpark job on Dataproc  
- `sample_queries.sql` — Example BigQuery queries for analysis

---

## Key Outcomes
- Processed ~1GB+ NYC Taxi dataset efficiently using PySpark
- Built scalable, analytics-ready datasets in BigQuery
- Demonstrated cloud-native ETL workflow using Dataproc and GCS
- Project ready for automation with Airflow or Cloud Functions

---

## Future Improvements
- Automate workflow using Apache Airflow or Cloud Functions
- Implement scheduled runs via Cloud Scheduler
- Add logging, monitoring, and retry mechanisms

---

## Assets
- NYC Taxi dataset source: https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page

---

## How to Run
1. Upload raw NYC Taxi dataset to GCS
2. Submit PySpark job using Dataproc
3. Processed data is written back to GCS
4. Load processed data into BigQuery
5. Run analytical queries in BigQuery