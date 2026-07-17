-- Fails if 'any' (transaction_id, product_line, channel) combination appears more than once
-- Directly validates the staging dedup fix for the real duplicate rows found in sales_historical.csv
SELECT transaction_id, product_line, channel, COUNT(*) AS cnt
FROM {{ ref('fct_sales_revenue') }}
GROUP BY 1, 2, 3
HAVING COUNT(*) > 1