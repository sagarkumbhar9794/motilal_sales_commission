SELECT sip_id, date AS sip_date, rm_id, client_id, sip_status, sip_amount
FROM {{ source('raw', 'sip_current_status') }}