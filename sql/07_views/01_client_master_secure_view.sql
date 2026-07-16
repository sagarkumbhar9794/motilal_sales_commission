-- sql/07_views/01_client_master_secure_view.sql
USE ROLE DE_ADMIN;
USE SCHEMA SALES_DB.PUBLIC;

CREATE OR REPLACE SECURE VIEW CLIENT_MASTER_SECURE AS
SELECT client_id, client_segment, account_status, rm_id
FROM SALES_DB.RAW.CLIENT_MASTER;
-- client_name intentionally omitted — PII masking

GRANT SELECT ON VIEW CLIENT_MASTER_SECURE TO ROLE DE_ADMIN;