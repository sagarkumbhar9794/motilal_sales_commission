USE ROLE DE_ADMIN;
USE SCHEMA SALES_DB.RAW;

CREATE STREAM SIP_STREAM ON TABLE SIP;

CREATE TABLE IF NOT EXISTS SALES_DB.RAW.SIP_CURRENT_STATUS (
    sip_id STRING PRIMARY KEY, date DATE, rm_id STRING, client_id STRING,
    sip_status STRING, sip_amount FLOAT
);

CREATE TASK TASK_MERGE_SIP_CURRENT
  WAREHOUSE = COMPUTE_WH
  SCHEDULE = '5 MINUTE'
WHEN SYSTEM$STREAM_HAS_DATA('SIP_STREAM')
AS
MERGE INTO SIP_CURRENT_STATUS tgt
USING (
    SELECT sip_id, date, rm_id, client_id, sip_status, sip_amount
    FROM SIP_STREAM
    QUALIFY ROW_NUMBER() OVER (PARTITION BY sip_id ORDER BY date DESC) = 1
) src
ON tgt.sip_id = src.sip_id
WHEN MATCHED THEN UPDATE SET sip_status = src.sip_status, sip_amount = src.sip_amount, date = src.date
WHEN NOT MATCHED THEN INSERT (sip_id, date, rm_id, client_id, sip_status, sip_amount)
  VALUES (src.sip_id, src.date, src.rm_id, src.client_id, src.sip_status, src.sip_amount);

ALTER TASK TASK_MERGE_SIP_CURRENT RESUME;  -- tasks are suspended by default, don't forget