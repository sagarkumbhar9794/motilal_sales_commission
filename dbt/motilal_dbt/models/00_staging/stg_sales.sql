SELECT
    rm_id, region, client_id, client_segment, transaction_id, transaction_date,
    delivery_equity_revenue_housecall, delivery_equity_revenue_nonhousecall,
    cash_intraday_revenue_housecall, cash_intraday_revenue_nonhousecall,
    fno_revenue_nonhousecall, fno_revenue_housecall,
    commodity_revenue_housecall, commodity_revenue_nonhousecall,
    offline_revenue, online_revenue, net_revenue
FROM {{ source('raw', 'sales') }}
QUALIFY ROW_NUMBER() OVER (PARTITION BY transaction_id ORDER BY _loaded_at DESC) = 1   -- dedup real duplicate TXNs