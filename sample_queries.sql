SELECT 
  SUM(Total_trips) AS total_trips,
  SUM(Total_revenue) AS total_revenue,
  AVG(average_dist) AS avg_trip_distance
FROM `de-way-forward.nyc_taxi.trips`;



1. Daily Trips Trend
SELECT 
  trip_date,
  Total_trips
FROM `de-way-forward.nyc_taxi.trips`
ORDER BY trip_date;

2. Daily Revenue Trend
SELECT 
  trip_date,
  Total_revenue
FROM `de-way-forward.nyc_taxi.trips`
ORDER BY trip_date;

3. Top 5 Bussiest Days
SELECT 
  trip_date,
  Total_trips
FROM `de-way-forward.nyc_taxi.trips`
ORDER BY Total_trips DESC
LIMIT 5;

4. Top 5 Highest Revenue Days
SELECT 
  trip_date,
  Total_revenue
FROM `de-way-forward.nyc_taxi.trips`
ORDER BY Total_revenue DESC
LIMIT 5;

5. Weekly Aggregation
SELECT 
  EXTRACT(WEEK FROM trip_date) AS week,
  SUM(Total_trips) AS total_trips,
  SUM(Total_revenue) AS total_revenue
FROM `de-way-forward.nyc_taxi.trips`
GROUP BY week
ORDER BY week;

6. Low Demand Days
SELECT 
  trip_date,
  Total_trips
FROM `de-way-forward.nyc_taxi.trips`
WHERE Total_trips < (
  SELECT AVG(Total_trips) FROM `de-way-forward.nyc_taxi.trips`
)
ORDER BY Total_trips;

7.Busniness Insight Query
SELECT 
  trip_date,
  Total_trips,
  Total_revenue,
  Total_revenue / Total_trips AS revenue_per_trip,
  average_dist
FROM `de-way-forward.nyc_taxi.trips`
ORDER BY revenue_per_trip DESC;

