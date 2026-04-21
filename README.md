Fortress: SaaS Revenue & Customer Health Pipeline 
Project Overview
The Fortress Dashboard is an end-to-end analytics engineering project designed to transform raw, messy SaaS subscription logs into an executive-level command center. By architecting a Trailing 30-Day (T30) monitor, this pipeline moves beyond static reporting to provide proactive insights into churn risk and revenue protection.

Data Architecture & Structure
I implemented a modular Medallion Architecture using dbt to ensure data quality and maintainability.

models/staging/: Atomic cleaning layer. Transforms raw sources (raw_subscriptions, raw_usage_logs) into clean, casted, and structured tables.

models/intermediate/: The logic engine. Aggregates behavioral data (e.g., int_user_activity) to calculate recency and frequency metrics.

models/marts/: The Gold layer. Optimized for Tableau, featuring fct_customer_health—the single source of truth for the "Fortress" command center.

tests/: Data quality gateway. Contains schema tests (unique, not-null) and custom business logic tests (e.g., assert_healthy_users_have_recent_activity).

Technical Engineering Features
1. Trailing 30-Day (T30) Lookback
Real-time SaaS health requires current data. I engineered a dynamic lookback window using dbt CTEs that anchors the pipeline to the latest 30 days of activity (April 2026). This filters out historical "zombie" data, focusing exclusively on current active revenue.

2. Custom Health Score Logic
The pipeline calculates a multi-factor health score to categorize customers:

Healthy: Logged in within the last 14 days.

At Risk: Inactive for 15–30 days.

Critical Risk: Inactive for 30+ days or no login history.

Churned: Explicitly "cancelled" subscription status.

3. Data Integrity & Testing
I utilized dbt’s testing framework to ensure the "Fortress" remains unbreakable.

Automated Tests: Validates that all health scores fall within accepted values and that MRR fields are never null.

Custom SQL Test: A bespoke test to ensure no user is marked "Healthy" without a verified login within the 14-day window.

The Finite Summary
Fortress bridges the gap between raw database records and C-suite decision-making. By treating data as a product, I've built a scalable machine that surfaces $800k in Healthy MRR while immediately flagging $334k in Critical Risk revenue.
