SELECT insurance_id, date, rm_id, client_id, insurance_amount
FROM {{ source('raw', 'insurance') }}
QUALIFY ROW_NUMBER() OVER (PARTITION BY insurance_id ORDER BY _loaded_at DESC) = 1