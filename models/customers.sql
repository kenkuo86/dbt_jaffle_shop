{{
    config(materialized='table')
}}

WITH 
customers AS (
    SELECT * FROM `dbt-tutorial.jaffle_shop.customers`
),

orders AS (
    SELECT * FROM `dbt-tutorial.jaffle_shop.orders`
),

orders_grouped_by_customer_id AS (
    SELECT 
        user_id,
        COUNT(id) AS number_of_orders
    FROM 
        orders
    GROUP BY 
        user_id
),

customers_joined_with_orders AS (
    SELECT
        c.id AS customer_id,
        c.first_name,
        c.last_name,
        COALESCE(o.number_of_orders, 0) AS number_of_orders
    FROM
        customers AS c
    LEFT JOIN 
        orders_grouped_by_customer_id AS o
    ON c.id = o.user_id
)

SELECT
    *
FROM 
    customers_joined_with_orders
