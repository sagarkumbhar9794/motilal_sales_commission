-- sql/09_governance/01_time_travel_demo.sql
USE ROLE DE_ADMIN;
USE SCHEMA SALES_DB.RAW;

-- Break something on purpose to demo recovery
UPDATE SALES SET net_revenue = 0 WHERE transaction_id = 'TXN_0015001';

-- Recover using Time Travel (adjust offset to just before your UPDATE ran)
SELECT * FROM SALES AT(OFFSET => -60*2) WHERE transaction_id = 'TXN_0015001';

-- To actually restore the value:
UPDATE SALES tgt
SET net_revenue = src.net_revenue
FROM (SELECT transaction_id, net_revenue FROM SALES AT(OFFSET => -60*5) WHERE transaction_id = 'TXN_0015001') src
WHERE tgt.transaction_id = src.transaction_id;