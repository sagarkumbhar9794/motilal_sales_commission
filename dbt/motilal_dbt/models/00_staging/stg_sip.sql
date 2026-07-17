SELECT
    sip_id,
    date AS sip_date,
    rm_id, client_id,
    NULLIF(TRIM(sip_status), '') AS sip_status,        -- real bug fix: blanks -> true NULL
    sip_amount
FROM {{ source('raw', 'sip') }}
QUALIFY ROW_NUMBER() OVER (PARTITION BY sip_id ORDER BY _loaded_at DESC) = 1