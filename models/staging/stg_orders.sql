{{
    config(materialized='table')
}}

SELECT * FROM {{source('jaffle_shop', 'orders')}}