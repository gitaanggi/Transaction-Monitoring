# Pengecekan nilai null dan anomali
SELECT 
    -- Pengecekan NULL
    SUM(CASE WHEN trx_id IS NULL THEN 1 ELSE 0 END) AS null_trx_id,
    SUM(CASE WHEN account_id IS NULL THEN 1 ELSE 0 END) AS null_account_id,
    SUM(CASE WHEN amount_idr IS NULL THEN 1 ELSE 0 END) AS null_amount,
    SUM(CASE WHEN trx_date IS NULL THEN 1 ELSE 0 END) AS null_date,
    
    -- Pengecekan Anomali Logika Bisnis
    SUM(CASE WHEN amount_idr <= 0 THEN 1 ELSE 0 END) AS invalid_amount,
    SUM(CASE WHEN status NOT IN ('success', 'failed') THEN 1 ELSE 0 END) AS invalid_status,
    SUM(CASE WHEN trx_type NOT IN ('debit', 'credit', 'transfer_in', 'transfer_out', 'top_up') THEN 1 ELSE 0 END) AS invalid_trx_type
FROM Sakumaya.transactions;

# Pengecekan data duplikat
SELECT 
    trx_id, 
    COUNT(trx_id) AS jumlah_duplikasi
FROM Sakumaya.transactions
GROUP BY trx_id
HAVING COUNT(trx_id) > 1;