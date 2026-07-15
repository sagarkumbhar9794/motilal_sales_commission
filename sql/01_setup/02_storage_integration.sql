use role accountadmin;

create storage integration sales_s3_integration
type = external_stage
storage_provider = "S3"
enabled = True
storage_aws_role_arn = 'arn:aws:iam::467138365505:role/snowflake-s3-access-role'
storage_allowed_locations = ('s3://mofslsales2026/sales-data-lake-sagar-2026/');