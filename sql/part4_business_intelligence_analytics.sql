-- =====================================================
-- PART 4 — ADVANCED BUSINESS INTELLIGENCE ANALYTICS
-- =====================================================

-- PART OVERVIEW:
-- This section focuses on executive-level
-- business intelligence reporting using
-- customer retention, profitability,
-- refund analytics, and strategic KPI dashboards.

-- KEY BUSINESS AREAS COVERED:
-- • Customer Retention Intelligence
-- • Revenue Leakage Analysis
-- • Profitability Analytics
-- • Strategic KPI Reporting
-- • Executive Business Intelligence

-- SQL CONCEPTS USED:
-- • CTEs
-- • Window Functions
-- • CASE WHEN
-- • Aggregations
-- • CROSS JOIN
-- • KPI Dashboards
-- • Financial Analytics
-- • Strategic Reporting

-- =====================================================

-- =====================================================
-- QUERY 1 — CUSTOMER RETENTION INTELLIGENCE DASHBOARD
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need a centralized dashboard
-- to monitor customer retention,
-- repeat purchases, and churn behavior.

-- OBJECTIVE:
-- Analyze customer retention KPIs including
-- repeat customers, churn customers,
-- active customers, and retention percentage.

WITH customer_orders AS(
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    MAX(order_date) AS last_order_date

FROM orders
GROUP BY customer_id
),
retention_dashboard AS(
SELECT
    COUNT(customer_id) AS total_customers,

    COUNT(
        CASE
            WHEN total_orders > 1
            THEN customer_id
        END
    ) AS repeat_customers,
    COUNT(
        CASE
            WHEN DATEDIFF(CURDATE(),last_order_date) > 180
            THEN customer_id
        END
    ) AS churn_customers,
    COUNT(
        CASE
            WHEN DATEDIFF(CURDATE(),last_order_date) <= 60
            THEN customer_id
        END
    ) AS active_customers

FROM customer_orders
)
SELECT *,
ROUND(
(repeat_customers/NULLIF(total_customers,0))*100,2
) AS retention_rate
FROM retention_dashboard;
-- BUSINESS INTERPRETATION:
-- The dashboard provides a strategic overview
-- of customer retention performance including
-- repeat customers, churn behavior,
-- and active customer engagement.
--
-- Businesses can use this analysis
-- to improve retention campaigns,
-- loyalty programs,
-- and customer reactivation strategies.

-- =====================================================
-- QUERY 2 — REVENUE LEAKAGE & REFUND ANALYSIS
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify
-- revenue loss caused by refunds,
-- cancellations, and operational leakage.

-- OBJECTIVE:
-- Analyze refund impact,
-- revenue leakage percentage,
-- and net business revenue.

WITH refund_analysis AS(
SELECT
    SUM(revenue) AS gross_revenue,
    SUM(refund_amount) AS total_refunds,
    SUM(net_revenue) AS net_revenue,
    SUM(gross_margin) AS total_profit

FROM orders
)

SELECT *,

ROUND(
(total_refunds/NULLIF(gross_revenue,0))*100,2
) AS refund_percentage,

ROUND(
(total_profit/NULLIF(gross_revenue,0))*100,2
) AS profit_margin_percentage

FROM refund_analysis;

-- BUSINESS INTERPRETATION:
-- The report identifies the impact
-- of refunds and revenue leakage
-- on overall business profitability.
--
-- Businesses can use this analysis
-- to reduce refund losses,
-- improve operational efficiency,
-- and strengthen profit margins.

-- =====================================================
-- QUERY 3 — PROFITABILITY VS REVENUE ANALYSIS
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify whether
-- high-revenue product categories
-- are also generating strong profitability.

-- OBJECTIVE:
-- Compare revenue, profitability,
-- and margin contribution
-- across product categories.

WITH category_profitability AS(
SELECT
    product_category,

    SUM(revenue) AS total_revenue,
    SUM(gross_margin) AS total_profit,

    ROUND(
        (SUM(gross_margin)
/NULLIF(SUM(revenue),0))*100,2
    ) AS profit_margin_pct,

    COUNT(order_id) AS total_orders

FROM orders
GROUP BY product_category
)

SELECT *,

DENSE_RANK()
OVER(ORDER BY total_profit DESC)
AS profitability_rank

FROM category_profitability;

-- BUSINESS INTERPRETATION:
-- The report compares revenue generation
-- and profitability across product categories.
--
-- Businesses can identify categories
-- generating strong profit margins
-- instead of focusing only on revenue volume.
--
-- This helps improve pricing strategy,
-- inventory optimization,
-- and long-term business profitability.

-- =====================================================
-- PROJECT COMPLETED
-- =====================================================
