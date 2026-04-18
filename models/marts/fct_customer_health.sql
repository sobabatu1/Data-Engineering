{{ config(materialized='table') }}

WITH subs AS (
    SELECT * FROM {{ ref('stg_subscriptions') }}
),
activity AS (
    SELECT * FROM {{ ref('int_user_activity') }}
),
-- Step 1: Find the "Current Date" of the dataset (April 2026)
dataset_max AS (
    SELECT MAX(last_login_date) as max_date FROM activity
)

SELECT
    s.customer_id,
    s.plan_type,
    s.mrr,
    s.status,
    a.last_login_date,
    COALESCE(a.days_since_last_login, 999) AS days_inactive,
    -- Step 2: The Health Score Logic
    CASE 
        WHEN s.status = 'cancelled' THEN 'Churned'
        WHEN a.days_since_last_login > 30 OR a.last_login_date IS NULL THEN 'Critical Risk'
        WHEN a.days_since_last_login > 14 THEN 'At Risk'
        ELSE 'Healthy'
    END AS health_score
FROM subs s
LEFT JOIN activity a ON s.customer_id = a.user_id
-- Step 3: The 30-Day Filter
-- This ensures the dashboard only shows customers active in the last 30 days
-- or those who recently churned.
WHERE a.last_login_date >= (SELECT max_date FROM dataset_max) - INTERVAL '30 days'
   OR s.status = 'cancelled'