create or replace stage sales_ext_stage
    url = 's3://mofslsales2026/sales-data-lake-sagar-2026/'
    storage_integration = sales_s3_integration
    file_format = csv_standard;