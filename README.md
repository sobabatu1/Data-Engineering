Fortress Revenue and Financial Health Pipeline

## The Mission
Fortress is a fictional high-growth SaaS platform. As the business scaled to 10,000+ users, the leadership team needed a "Fortress-grade" data infrastructure to protect recurring revenue and identify churn risk in real-time.

Fortress: SaaS Revenue & Customer Health Pipeline 
This isn't just a dashboard; it’s a full-stack analytics engine. I built Fortress to solve the gap between raw subscription logs and executive-level strategy, turning "radioactive" data into a clean, Trailing 30-Day (T30) command center.

**The Stack**
Transformation: dbt (Core logic & Medallion Architecture)

Database: PostgreSQL

Visualization: Tableau Professional

Environment: VS Code / Git

The Architecture
I implemented a Medallion Architecture to move data from raw chaos to refined insights:

Staging (stg_): Atomic-level cleaning. Casting types, renaming columns, and handling initial deduplication.

Intermediate (int_): The heavy lifting. This is where I joined subscription data with usage logs and calculated the "Days Since Last Login" logic.

Marts (fct_): The reporting-ready layer. Optimized for Tableau with pre-calculated health scores to keep dashboard performance high.

**Engineering Highlights**
1. The T30 Lookback Engine
Real-time SaaS requires current data. I engineered a dynamic lookback window using dbt CTEs that anchors the entire pipeline to the latest 30 days of activity (April 2026). This filters out historical "zombie" data and focuses purely on active revenue and immediate churn risk.

2. Custom Health Score Logic
I didn't just pull a column; I engineered a status engine based on financial and behavioral triggers:

Healthy: User active within < 14 days.

At Risk: 15–30 days of inactivity.

Critical Risk: 30+ days of inactivity.

Churned: Explicitly cancelled status.

3. Data Integrity (The Safety Net)
I used dbt’s testing framework to ensure the "Fortress" remains unbreakable. Every run validates:

Uniqueness on customer_id.

Non-null checks on MRR (crucial for financial reporting).

Accepted values for the Health Score categories.

📊 The "Fortress" Command Center
The final Tableau output is built for cognitive clarity. It surfaces $800k in Healthy MRR while immediately flagging $334k in Critical Risk revenue. By focusing on the 30-day window, the business can intervene before the revenue disappears.
