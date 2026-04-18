-- dbt tests fail if the query returns any rows.
-- We are looking for "Healthy" users who haven't logged in for over 14 days.
SELECT
    customer_id,
    health_score,
    days_inactive
FROM {{ ref('fct_customer_health') }}
WHERE health_score = 'Healthy'
  AND days_inactive > 14