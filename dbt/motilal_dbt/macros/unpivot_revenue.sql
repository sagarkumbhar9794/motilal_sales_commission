{% macro unpivot_revenue(source_ref, revenue_columns) %}
    {% for col in revenue_columns %}
    SELECT
        rm_id, region, client_id, client_segment, transaction_id, transaction_date,
        '{{ col.product_line }}' AS product_line,
        '{{ col.channel }}' AS channel,
        {{ col.column_name }} AS revenue
    FROM {{ source_ref }}
    {% if not loop.last %}UNION ALL{% endif %}
    {% endfor %}
{% endmacro %}