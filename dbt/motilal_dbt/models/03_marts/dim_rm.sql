SELECT
    rm_id, rm_name, date_of_joining, employment_status, date_of_leaving, ctc,
    dbt_valid_from, dbt_valid_to
FROM {{ ref('hr_master_snapshot') }}