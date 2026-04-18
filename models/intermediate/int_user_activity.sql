{{ config(materialized='ephemeral') }}

SELECT
    user_id,
    MAX(login_timestamp)::date AS last_login_date,
    -- PostgreSQL syntax for calculating day difference
    CURRENT_DATE - MAX(login_timestamp)::date AS days_since_last_login
FROM {{ source('raw_data', 'raw_usage_logs') }}
GROUP BY 1