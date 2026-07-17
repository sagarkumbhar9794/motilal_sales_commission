SELECT
    client_id,
    client_name,
    client_activation_date,
    client_segment,
    account_status,
    rm_id,
    dbt_valid_from,
    dbt_valid_to
FROM {{ ref('client_master_snapshot') }}