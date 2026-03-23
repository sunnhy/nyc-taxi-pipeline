gcloud dataproc jobs submit pyspark gs://de-nyx-taxi-newton/Scripts_used/nyc_taxi_pipeline.py \
    --cluster nyx-taxi-cluster \
    --region asia-south1 \
    --project de-way-forward