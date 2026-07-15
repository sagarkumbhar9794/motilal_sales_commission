use role de_admin;
use database sales_db;
use schema public;

-- One reusable File Format object for all your CSV sources.
-- SKIP_HEADER=1 skips the column-name row every one of your files has.
-- FIELD_OPTIONALLY_ENCLOSED_BY handles any text fields wrapped in quotes (e.g. client names with commas).

create or replace file format csv_standard
    type = 'CSV'
    skip_header = 1
    field_optionally_enclosed_by = '"'
    null_if = ('','NULL','null')
    EMPTY_FIELD_AS_NULL = TRUE
    ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;