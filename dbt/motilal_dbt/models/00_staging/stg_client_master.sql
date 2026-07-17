SELECT
    client_id,
    client_name,
    client_activation_date,
    NULLIF(TRIM(client_segment), '') AS client_segment,   -- real bug fix: blanks -> true NULL
    account_status,
    rm_id
FROM {{ source('raw', 'client_master') }}