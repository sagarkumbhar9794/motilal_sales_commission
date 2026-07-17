{{ config(
    materialized='incremental',
    unique_key=['transaction_id', 'product_line', 'channel'],
    incremental_strategy='merge'
) }}

SELECT
    t.transaction_id,
    t.product_line,
    t.channel,
    t.revenue,
    t.transaction_date,
    c.client_id,
    r.rm_id
FROM {{ ref('int_sales_unpivoted') }} t
LEFT JOIN {{ ref('dim_client') }} c
    ON t.client_id = c.client_id
    AND t.transaction_date BETWEEN c.dbt_valid_from AND COALESCE(c.dbt_valid_to, '9999-12-31')
LEFT JOIN {{ ref('dim_rm') }} r
    ON t.rm_id = r.rm_id
    AND t.transaction_date BETWEEN r.dbt_valid_from AND COALESCE(r.dbt_valid_to, '9999-12-31')
{% if is_incremental() %}
WHERE t.transaction_date > (SELECT MAX(transaction_date) FROM {{ this }})
{% endif %}