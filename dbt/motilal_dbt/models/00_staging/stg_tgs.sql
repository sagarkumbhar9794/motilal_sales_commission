SELECT
    tgs_id,
    COALESCE(
    TRY_TO_DATE(date,'YYYY-MM-DD'),
    TRY_TO_DATE(date,'DD-MM-YYYY')
    ) AS transaction_date,   -- real bug fix: source format mismatch
    rm_id, client_id, tgs_amount
FROM {{ source('raw', 'tgs') }}
QUALIFY ROW_NUMBER() OVER (PARTITION BY tgs_id ORDER BY _loaded_at DESC) = 1