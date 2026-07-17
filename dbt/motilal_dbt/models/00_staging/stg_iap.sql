SELECT iap_id, date, rm_id, client_id, iap_amount
FROM {{ source('raw', 'iap') }}
QUALIFY ROW_NUMBER() OVER (PARTITION BY iap_id ORDER BY _loaded_at DESC) = 1