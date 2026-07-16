-- sql/09_governance/02_zero_copy_clone.sql
USE ROLE DE_ADMIN;

CREATE SCHEMA IF NOT EXISTS SALES_DB.DEV_SAGAR CLONE SALES_DB.RAW;

-- Prove it's independent: modify the clone, confirm prod is untouched
UPDATE SALES_DB.DEV_SAGAR.SALES SET net_revenue = 99999 WHERE transaction_id = 'TXN_0015002';
SELECT net_revenue FROM SALES_DB.RAW.SALES WHERE transaction_id = 'TXN_0015002';        -- unaffected
SELECT net_revenue FROM SALES_DB.DEV_SAGAR.SALES WHERE transaction_id = 'TXN_0015002';  -- changed