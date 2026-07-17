{{ config(
    materialized='incremental',
    unique_key='product_txn_id',
    incremental_strategy='append'
) }}

SELECT product_txn_id, txn_date, rm_id, client_id, product_type, amount, status
FROM {{ ref('int_product_transactions_union') }}
{% if is_incremental() %}
WHERE txn_date > (SELECT MAX(txn_date) FROM {{ this }})
{% endif %}