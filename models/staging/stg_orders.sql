{{
    config(materialized='table')
}}

WITH source AS (
    SELECT * FROM {{source('jaffle_shop', 'orders')}}
),

status_mapping AS (
    SELECT * FROM {{ref('seed_order_statuses')}}
),

transformed AS (
    SELECT
        s.id,
        s.user_id,
        s.order_date,
        s.status,
        s._etl_loaded_at,
        m.is_valid
    FROM
        source AS s
    LEFT JOIN 
        status_mapping AS m
    ON 
        s.status = m.status
)

SELECT
    *
FROM 
    transformed