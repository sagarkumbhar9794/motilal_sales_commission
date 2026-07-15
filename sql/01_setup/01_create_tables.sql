USE ROLE DE_ADMIN;

CREATE SCHEMA IF NOT EXISTS SALES_DB.RAW;
USE SCHEMA SALES_DB.RAW;

-- Master data
CREATE OR REPLACE TABLE CLIENT_MASTER (
    client_id STRING,
    client_name STRING,
    client_activation_date DATE,
    client_segment STRING,
    account_status STRING,
    rm_id STRING,
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name STRING DEFAULT METADATA$FILENAME
);

CREATE OR REPLACE TABLE HR_MASTER (
    rm_id STRING,
    rm_name STRING,
    date_of_joining DATE,
    employment_status STRING,
    date_of_leaving DATE,
    ctc FLOAT,
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name STRING DEFAULT METADATA$FILENAME
);

-- Daily sales (wide revenue-by-channel table)
CREATE OR REPLACE TABLE SALES (
    rm_id STRING,
    region STRING,
    client_id STRING,
    client_segment STRING,
    transaction_id STRING,
    transaction_date DATE,
    delivery_equity_revenue_housecall FLOAT,
    delivery_equity_revenue_nonhousecall FLOAT,
    cash_intraday_revenue_housecall FLOAT,
    cash_intraday_revenue_nonhousecall FLOAT,
    fno_revenue_housecall FLOAT,
    fno_revenue_nonhousecall FLOAT,
    commodity_revenue_housecall FLOAT,
    commodity_revenue_nonhousecall FLOAT,
    other_revenue FLOAT,
    total_revenue_housecall FLOAT,
    total_revenue FLOAT,
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name STRING DEFAULT METADATA$FILENAME
);
-- IMPORTANT: verify these 17 column names/order against your actual sales_2026-06-20.csv
-- header row before loading — this is inferred, not confirmed against the real header.

-- Product-line feeds
CREATE OR REPLACE TABLE IAP (
    iap_id STRING,
    date DATE,
    rm_id STRING,
    client_id STRING,
    iap_amount FLOAT,
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name STRING DEFAULT METADATA$FILENAME
);

CREATE OR REPLACE TABLE INSURANCE (
    insurance_id STRING,
    date DATE,
    rm_id STRING,
    client_id STRING,
    insurance_amount FLOAT,
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name STRING DEFAULT METADATA$FILENAME
);

CREATE OR REPLACE TABLE TGS (
    tgs_id STRING,
    date STRING,      -- kept as STRING: source has DD-MM-YYYY format, cast properly later in staging, not here
    rm_id STRING,
    client_id STRING,
    tgs_amount FLOAT,
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name STRING DEFAULT METADATA$FILENAME
);

CREATE OR REPLACE TABLE SIP (
    sip_id STRING,
    date DATE,
    rm_id STRING,
    client_id STRING,
    sip_status STRING,
    sip_amount FLOAT,
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name STRING DEFAULT METADATA$FILENAME
);

-- Verify all 7 tables were created
SHOW TABLES IN SCHEMA SALES_DB.RAW;