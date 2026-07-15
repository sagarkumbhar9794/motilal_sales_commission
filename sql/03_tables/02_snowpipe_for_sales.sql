USE ROLE DE_ADMIN;
USE SCHEMA SALES_DB.RAW;

CREATE OR REPLACE PIPE PIPE_SALES_DAILY
  AUTO_INGEST = TRUE
AS
COPY INTO SALES (rm_id, region, client_id, client_segment, transaction_id, transaction_date,
                 delivery_equity_revenue_housecall, delivery_equity_revenue_nonhousecall,
                 cash_intraday_revenue_housecall, cash_intraday_revenue_nonhousecall,
                 fno_revenue_nonhousecall, fno_revenue_housecall,
                 commodity_revenue_housecall, commodity_revenue_nonhousecall,
                 offline_revenue, online_revenue, net_revenue, _file_name)
FROM (
    SELECT $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17, METADATA$FILENAME
    FROM @SALES_DB.PUBLIC.SALES_EXT_STAGE/raw/sales_daily/
)
FILE_FORMAT = (FORMAT_NAME = 'SALES_DB.PUBLIC.CSV_STANDARD');