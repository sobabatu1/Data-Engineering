{{ config(materialized='view') }}

SELECT
    id AS subscription_id,
    customer_id,
    plan_type,
    price::numeric(10,2) AS mrr,
    status,
    start_date::date AS start_date
FROM {{ source('raw_data', 'raw_subscriptions') }}