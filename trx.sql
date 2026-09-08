CREATE OR REPLACE TABLE `Sakumaya.trx` AS
SELECT 
    trx_id,
    account_id,
    INITCAP(REPLACE(trx_type, '_', ' ')) AS trx_type,
    amount_idr,
    merchant_name,
    INITCAP(REPLACE(merchant_category, '_', ' ')) AS merchant_category,
    trx_date,
    trx_time,
    balance_after_idr,
    INITCAP(status) AS status,
    INITCAP(REPLACE(channel, '_', ' ')) AS channel,
    CAST(SUBSTR(CAST(trx_time AS STRING), 1, 2) AS INT64) AS trx_hour, 
    CAST(
        CONCAT(CAST(trx_date AS STRING), ' ', CAST(trx_time AS STRING))
        AS DATETIME
    ) AS trx_datetime
FROM 
    `Sakumaya.transactions`;