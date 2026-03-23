from pyspark.sql import SparkSession
from pyspark.sql.functions import col, unix_timestamp, to_date, count, sum as _sum, avg

# Start Spark session
spark = SparkSession.builder.appName("NYX Taxi Pipeline").getOrCreate()

# Read Parquet file from Google Cloud Storage (GCS)
df = spark.read.parquet("gs://de-nyx-taxi-newton/raw_data/")
                        
                        
#--------------------
# Data Cleaning 
#--------------------

df_clean = df.filter(
    (col("trip_distance") > 0) & 
    (col("fare_amount") > 0)
)

#--------------------
# Feature Engineering 
#--------------------

df_clean = df_clean.withColumn(
    "trip_duration_min",
    (unix_timestamp(col("tpep_dropoff_datetime")) - unix_timestamp(col("tpep_pickup_datetime"))) / 60
)

df_clean = df_clean.withColumn(
    "trip_date",
    to_date(col("tpep_pickup_datetime"))
)

#--------------------
# Aggregation
#--------------------

df_agg = df_clean.groupBy("trip_date").agg(
    count("*").alias("Total_trips"),
    _sum("fare_amount").alias("Total_revenue"),
    avg("trip_distance").alias("average_dist")
)

#--------------------
# WRITE to Bigquery
#--------------------

df_agg.write \
    .format("bigquery") \
    .option("table", "de-way-forward.nyc_taxi.trips") \
    .option("temporaryGcsBucket", "de-nyx-taxi-newton") \
    .mode("overwrite") \
    .save()

spark.stop()