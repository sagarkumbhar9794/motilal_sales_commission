use role accountadmin;

CREATE STORAGE INTEGRATION SALES_S3_INTEGRATION
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::467138365505:role/snowflake-s3-access-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://mofslsales2026/sales-data-lake-sagar-2026/')