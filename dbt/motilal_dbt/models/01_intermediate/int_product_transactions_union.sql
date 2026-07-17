{{ config(materialized='ephemeral') }}

SELECT sip_id AS product_txn_id, sip_date::DATE AS txn_date, rm_id, client_id,
       'SIP' AS product_type, sip_amount AS amount, sip_status AS status
FROM {{ ref('stg_sip') }}

UNION ALL

SELECT iap_id, date::DATE AS txn_date, rm_id, client_id, 'IAP', iap_amount, NULL
FROM {{ ref('stg_iap') }}

UNION ALL

SELECT insurance_id, date::DATE AS txn_date, rm_id, client_id, 'Insurance', insurance_amount, NULL
FROM {{ ref('stg_insurance') }}

UNION ALL

SELECT tgs_id, transaction_date::DATE AS txn_date, rm_id, client_id, 'TGS', tgs_amount, NULL
FROM {{ ref('stg_tgs') }}