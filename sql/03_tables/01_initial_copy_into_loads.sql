USE ROLE DE_ADMIN;
USE SCHEMA SALES_DB.RAW;

-- Master data
COPY INTO CLIENT_MASTER (client_id, client_name, client_activation_date, client_segment, account_status, rm_id, _file_name)
FROM (
    SELECT $1, $2, $3, $4, $5, $6, METADATA$FILENAME
    FROM @SALES_DB.PUBLIC.SALES_EXT_STAGE/raw/client_master/full_extract_date=2026-07-14/
)
FILE_FORMAT = (FORMAT_NAME = 'SALES_DB.PUBLIC.CSV_STANDARD')
ON_ERROR = 'CONTINUE';

COPY INTO HR_MASTER (rm_id, rm_name, date_of_joining, employment_status, date_of_leaving, ctc, _file_name)
FROM (
    SELECT $1, $2, $3, $4, $5, $6, METADATA$FILENAME
    FROM @SALES_DB.PUBLIC.SALES_EXT_STAGE/raw/hr_master/full_extract_date=2026-07-14/
)
FILE_FORMAT = (FORMAT_NAME = 'SALES_DB.PUBLIC.CSV_STANDARD')
ON_ERROR = 'CONTINUE';

-- Sales: historical backfill + the one daily file
COPY INTO SALES (rm_id, region, client_id, client_segment, transaction_id, transaction_date,
                 delivery_equity_revenue_housecall, delivery_equity_revenue_nonhousecall,
                 cash_intraday_revenue_housecall, cash_intraday_revenue_nonhousecall,
                 fno_revenue_nonhousecall, fno_revenue_housecall,
                 commodity_revenue_housecall, commodity_revenue_nonhousecall,
                 offline_revenue, online_revenue, net_revenue, _file_name)
FROM (
    SELECT $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17, METADATA$FILENAME
    FROM @SALES_DB.PUBLIC.SALES_EXT_STAGE/raw/sales_historical/one_time_backfill/
)
FILE_FORMAT = (FORMAT_NAME = 'SALES_DB.PUBLIC.CSV_STANDARD')
ON_ERROR = 'CONTINUE';

COPY INTO SALES (rm_id, region, client_id, client_segment, transaction_id, transaction_date,
                 delivery_equity_revenue_housecall, delivery_equity_revenue_nonhousecall,
                 cash_intraday_revenue_housecall, cash_intraday_revenue_nonhousecall,
                 fno_revenue_nonhousecall, fno_revenue_housecall,
                 commodity_revenue_housecall, commodity_revenue_nonhousecall,
                 offline_revenue, online_revenue, net_revenue, _file_name)
FROM (
    SELECT $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17, METADATA$FILENAME
    FROM @SALES_DB.PUBLIC.SALES_EXT_STAGE/raw/sales_daily/year=2026/month=06/day=20/
)
FILE_FORMAT = (FORMAT_NAME = 'SALES_DB.PUBLIC.CSV_STANDARD')
ON_ERROR = 'CONTINUE';

-- Product-line feeds
COPY INTO IAP (iap_id, date, rm_id, client_id, iap_amount, _file_name)
FROM (
    SELECT $1, $2, $3, $4, $5, METADATA$FILENAME
    FROM @SALES_DB.PUBLIC.SALES_EXT_STAGE/raw/iap/extract_date=2026-07-14/
)
FILE_FORMAT = (FORMAT_NAME = 'SALES_DB.PUBLIC.CSV_STANDARD')
ON_ERROR = 'CONTINUE';

COPY INTO INSURANCE (insurance_id, date, rm_id, client_id, insurance_amount, _file_name)
FROM (
    SELECT $1, $2, $3, $4, $5, METADATA$FILENAME
    FROM @SALES_DB.PUBLIC.SALES_EXT_STAGE/raw/insurance/extract_date=2026-07-14/
)
FILE_FORMAT = (FORMAT_NAME = 'SALES_DB.PUBLIC.CSV_STANDARD')
ON_ERROR = 'CONTINUE';

COPY INTO TGS (tgs_id, date, rm_id, client_id, tgs_amount, _file_name)
FROM (
    SELECT $1, $2, $3, $4, $5, METADATA$FILENAME
    FROM @SALES_DB.PUBLIC.SALES_EXT_STAGE/raw/tgs/extract_date=2026-07-14/
)
FILE_FORMAT = (FORMAT_NAME = 'SALES_DB.PUBLIC.CSV_STANDARD')
ON_ERROR = 'CONTINUE';

COPY INTO SIP (sip_id, date, rm_id, client_id, sip_status, sip_amount, _file_name)
FROM (
    SELECT $1, $2, $3, $4, $5, $6, METADATA$FILENAME
    FROM @SALES_DB.PUBLIC.SALES_EXT_STAGE/raw/sip/extract_date=2026-07-14/
)
FILE_FORMAT = (FORMAT_NAME = 'SALES_DB.PUBLIC.CSV_STANDARD')
ON_ERROR = 'CONTINUE';