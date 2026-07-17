USE ROLE DE_ADMIN;
CREATE SCHEMA IF NOT EXISTS SALES_DB.SNAPSHOTS;

{% snapshot hr_master_snapshot %}
{{
    config(
        target_schema='snapshots',
        unique_key='rm_id',
        strategy='check',
        check_cols=['employment_status', 'date_of_leaving']
    )
}}
SELECT * FROM {{ ref('stg_hr_master') }}
{% endsnapshot %}