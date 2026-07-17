SELECT
    rm_id, rm_name, date_of_joining, employment_status, date_of_leaving, ctc
FROM {{ source('raw', 'hr_master') }}