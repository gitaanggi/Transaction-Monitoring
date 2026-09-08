# Ringkasan Performa Sistem (Overall Health)
SELECT 
    COUNT(trx_id) AS total_transactions,
    ROUND((COUNT(CASE WHEN status = 'Success' THEN 1 END) * 100.0) / COUNT(trx_id), 2) AS success_rate_pct,
    ROUND((COUNT(CASE WHEN status = 'Failed' THEN 1 END) * 100.0) / COUNT(trx_id), 2) AS failure_rate_pct,
    SUM(CASE WHEN status = 'Failed' THEN amount_idr ELSE 0 END) AS potential_lost_amount
FROM `Sakumaya.trx`;

# Tren Jam Sibuk (Peak Hours Monitoring)
SELECT 
    trx_hour,
    COUNT(trx_id) AS total_volume,
    ROUND((COUNT(CASE WHEN status = 'Failed' THEN 1 END) * 100.0) / COUNT(trx_id), 2) AS failure_rate_pct
FROM `Sakumaya.trx`
GROUP BY trx_hour
ORDER BY trx_hour ASC;

# Kegagalan Berdasarkan Channel
SELECT 
    channel,
    merchant_category,
    COUNT(trx_id) AS total_volume,
    ROUND((COUNT(CASE WHEN status = 'Failed' THEN 1 END) * 100.0) / COUNT(trx_id), 2) AS failure_rate_pct
FROM `Sakumaya.trx`
GROUP BY channel, merchant_category
ORDER BY failure_rate_pct DESC
LIMIT 5;

# Uji Korelasi
WITH HourlyStats AS (
  SELECT 
    trx_date,
    trx_hour,
    COUNT(trx_id) AS total_volume,
    ROUND((COUNT(CASE WHEN status = 'Failed' THEN 1 END) * 100.0) / COUNT(trx_id), 2) AS failure_rate_pct
  FROM `Sakumaya.trx`
  GROUP BY trx_date, trx_hour
)
SELECT 
  -- CORR menghasilkan nilai korelasi antara -1 dan 1
  ROUND(CORR(total_volume, failure_rate_pct), 4) AS correlation_coefficient,
  COUNT(*) AS total_sample_hours
FROM HourlyStats;

