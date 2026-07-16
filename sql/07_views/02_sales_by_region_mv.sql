-- sql/07_views/02_sales_by_region_mv.sql (materialized view)
USE ROLE DE_ADMIN;
USE SCHEMA SALES_DB.PUBLIC;

CREATE OR REPLACE MATERIALIZED VIEW MV_SALES_BY_REGION AS
SELECT region, transaction_date, SUM(net_revenue) AS total_revenue, COUNT(*) AS txn_count
FROM SALES_DB.RAW.SALES
GROUP BY region, transaction_date;