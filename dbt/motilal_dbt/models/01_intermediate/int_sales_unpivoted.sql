{{ config(materialized='ephemeral') }}

{% set revenue_columns = [
    {'product_line': 'Delivery_Equity', 'channel': 'HouseCall',    'column_name': 'delivery_equity_revenue_housecall'},
    {'product_line': 'Delivery_Equity', 'channel': 'NonHouseCall', 'column_name': 'delivery_equity_revenue_nonhousecall'},
    {'product_line': 'Cash_Intraday',   'channel': 'HouseCall',    'column_name': 'cash_intraday_revenue_housecall'},
    {'product_line': 'Cash_Intraday',   'channel': 'NonHouseCall', 'column_name': 'cash_intraday_revenue_nonhousecall'},
    {'product_line': 'FnO',             'channel': 'HouseCall',    'column_name': 'fno_revenue_housecall'},
    {'product_line': 'FnO',             'channel': 'NonHouseCall', 'column_name': 'fno_revenue_nonhousecall'},
    {'product_line': 'Commodity',       'channel': 'HouseCall',    'column_name': 'commodity_revenue_housecall'},
    {'product_line': 'Commodity',       'channel': 'NonHouseCall', 'column_name': 'commodity_revenue_nonhousecall'}
] %}

WITH unpivoted AS (
    {{ unpivot_revenue(ref('stg_sales'), revenue_columns) }}
)
SELECT * FROM unpivoted WHERE revenue > 0