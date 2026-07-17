USE ROLE DE_ADMIN;
CREATE SCHEMA IF NOT EXISTS SALES_DB.SNAPSHOTS;

{% snapshot client_master_snapshot %}
{{
    config(
        target_schema='snapshots',
        unique_key='client_id',
        strategy='check',
        check_cols=['account_status', 'client_segment', 'rm_id']
    )
}}
SELECT * FROM {{ ref('stg_client_master') }}
{% endsnapshot %}