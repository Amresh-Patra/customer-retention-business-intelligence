-- =====================================================
-- PART 2 — ADVANCED SQL ANALYTICS
-- =====================================================

-- PART OVERVIEW:
-- This section focuses on advanced SQL analytics
-- using customer and order datasets to analyze
-- customer behavior, revenue performance,
-- retention patterns, product analytics,
-- and business growth trends.

-- KEY BUSINESS AREAS COVERED:
-- • Customer Revenue Analysis
-- • Customer Segmentation
-- • Product Performance Analytics
-- • Revenue Growth Analysis
-- • Customer Retention & Churn
-- • Customer Lifetime Value (CLV)
-- • RFM Analysis
-- • Ranking & Window Function Analytics
-- • Business Growth Reporting

-- SQL CONCEPTS USED:
-- • INNER JOIN
-- • LEFT JOIN
-- • CTEs
-- • Window Functions
-- • ROW_NUMBER()
-- • DENSE_RANK()
-- • LAG()
-- • CASE WHEN
-- • Aggregations
-- • GROUP BY
-- • NULLIF()
-- • KPI Analytics
-- • CRM Analytics

-- =====================================================

-- =====================================================
-- CONCEPT OVERVIEW:
-- Analyze customer revenue contribution,
-- order behavior, and business performance
-- using JOIN operations and aggregations.

-- BUSINESS GOALS:
-- • Identify high-value customers
-- • Analyze customer purchase behavior
-- • Monitor revenue contribution
-- • Understand customer activity patterns

-- SQL CONCEPTS USED:
-- • INNER JOIN
-- • LEFT JOIN
-- • Aggregations
-- • GROUP BY
-- • HAVING
-- • KPI Analytics
-- =====================================================

-- =====================================================
-- QUERY 1 — TOP REVENUE GENERATING CUSTOMERS
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify customers
-- generating the highest revenue contribution.

-- OBJECTIVE:
-- Analyze top customers based on
-- total revenue and order activity.

WITH temp AS(
SELECT
    customer_id,
    SUM(revenue) AS total_revenue,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY SUM(revenue) DESC
LIMIT 10
)
SELECT
    c.customer_id,
    c.region,
    c.customer_status,
    t.total_revenue,
    t.total_orders
FROM customers c
INNER JOIN temp t
ON c.customer_id = t.customer_id;

-- BUSINESS INTERPRETATION:
-- The report identifies high-value customers
-- generating the strongest revenue contribution.
-- Businesses can target these customers using
-- loyalty programs, premium offers,
-- and personalized retention strategies.

-- =====================================================
-- QUERY 2 — CUSTOMERS WITH NO ORDERS
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify inactive customers
-- who have not placed any orders.

-- OBJECTIVE:
-- Detect customers with zero order activity
-- using LEFT JOIN analysis.
WITH temp AS(
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.region,
    c.customer_status,
    c.signup_date,
    t.total_orders
FROM customers c
LEFT JOIN temp t
ON t.customer_id = c.customer_id
WHERE total_orders IS NULL;

-- BUSINESS INTERPRETATION:
-- The report identifies inactive customers
-- with no purchase activity. Businesses can
-- target these customers using onboarding campaigns,
-- promotional offers, and reactivation strategies.

-- =====================================================
-- CONCEPT 2 — CUSTOMER SEGMENTATION & VALUE ANALYSIS
-- =====================================================

-- CONCEPT OVERVIEW:
-- Analyze customer segments based on
-- revenue contribution, order frequency,
-- and customer value.

-- BUSINESS GOALS:
-- • Identify high-value customers
-- • Classify customer segments
-- • Improve customer retention
-- • Optimize CRM strategies

-- SQL CONCEPTS USED:
-- • CASE WHEN
-- • Aggregations
-- • GROUP BY
-- • HAVING
-- • KPI Analytics
-- • Customer Segmentation
-- =====================================================

-- =====================================================
-- QUERY 1 — HIGH VALUE CUSTOMER DETECTION
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify customers
-- generating strong revenue contribution.

-- OBJECTIVE:
-- Detect high-value customers based on
-- total revenue and order activity.

WITH temp AS(
SELECT
    customer_id,
    SUM(revenue) AS total_revenue,
    COUNT(order_id) AS total_orders,
    AVG(revenue) AS avg_revenue
FROM orders
GROUP BY customer_id
HAVING SUM(revenue) > 5000
)
SELECT
    t.*,
    c.region,
    c.customer_status

FROM temp t
INNER JOIN customers c
ON t.customer_id = c.customer_id;

-- BUSINESS INTERPRETATION:
-- The report identifies customers generating
-- high revenue and strong purchase activity.
-- Businesses can target these customers
-- using loyalty rewards and premium services.

-- =====================================================
-- QUERY 2 — CUSTOMER VALUE SEGMENTATION
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to classify customers
-- based on revenue contribution and business value.

-- OBJECTIVE:
-- Segment customers into different value groups
-- using total revenue analysis.
WITH temp AS(
SELECT
    customer_id,
    SUM(revenue) AS total_revenue,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
)
SELECT *,
CASE
    WHEN total_revenue > 100000
    THEN 'VIP Customer'
    WHEN total_revenue >= 50000
    THEN 'High Value'
    WHEN total_revenue >= 10000
    THEN 'Medium Value'
    ELSE 'Low Value'
END AS cust_segment

FROM temp
ORDER BY total_revenue DESC;

-- BUSINESS INTERPRETATION:
-- The report segments customers based on
-- revenue contribution and business value.
-- Businesses can create targeted retention
-- and marketing strategies for each segment.

-- =====================================================
-- CONCEPT 3 — REVENUE & REGIONAL PERFORMANCE ANALYSIS
-- =====================================================

-- CONCEPT OVERVIEW:
-- Analyze revenue generation and customer activity
-- across different regions and customer groups.

-- BUSINESS GOALS:
-- • Identify high-performing regions
-- • Measure customer revenue contribution
-- • Analyze regional business growth
-- • Improve regional marketing strategy

-- SQL CONCEPTS USED:
-- • INNER JOIN
-- • Aggregations
-- • GROUP BY
-- • ORDER BY
-- • KPI Analytics
-- • Revenue Analysis
-- =====================================================

-- =====================================================
-- QUERY 1 — CUSTOMER STATUS REVENUE ANALYSIS
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to understand how different
-- customer groups contribute to overall revenue.

-- OBJECTIVE:
-- Analyze revenue and order contribution
-- across customer status categories.

SELECT
    c.customer_status,
    SUM(o.revenue) AS total_revenue,
    COUNT(o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_id) AS total_customers,

    SUM(o.revenue)/COUNT(DISTINCT c.customer_id)
    AS per_customer_revenue

FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id

GROUP BY c.customer_status;

-- BUSINESS INTERPRETATION:
-- The report identifies customer groups
-- generating stronger revenue contribution
-- and customer activity for CRM optimization.

-- =====================================================
-- QUERY 2 — REGIONAL REVENUE PERFORMANCE
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify regions
-- generating higher revenue and customer activity.

-- OBJECTIVE:
-- Analyze regional revenue contribution
-- and customer performance.

SELECT
    c.region,
    SUM(o.revenue) AS total_revenue,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(o.order_id) AS total_orders,

    SUM(o.revenue)/COUNT(DISTINCT c.customer_id)
    AS avg_customer_revenue

FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id

GROUP BY region
ORDER BY SUM(o.revenue) DESC;

-- BUSINESS INTERPRETATION:
-- The report identifies high-performing regions
-- generating strong revenue and customer engagement.
-- Businesses can optimize regional campaigns
-- and allocate resources more effectively.

-- =====================================================
-- CONCEPT 4 — WINDOW FUNCTION & CUSTOMER RANKING ANALYSIS
-- =====================================================

-- CONCEPT OVERVIEW:
-- Analyze customer rankings, revenue contribution,
-- and cumulative business performance using
-- advanced window functions.

-- BUSINESS GOALS:
-- • Identify top-performing customers
-- • Analyze customer purchase frequency
-- • Measure cumulative revenue contribution
-- • Improve customer retention strategies

-- SQL CONCEPTS USED:
-- • DENSE_RANK()
-- • Window Functions
-- • OVER()
-- • PARTITION BY
-- • Aggregations
-- • Revenue Analytics
-- =====================================================

-- =====================================================
-- QUERY 1 — CUSTOMER REVENUE RANKING
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify customers
-- generating the highest revenue contribution.

-- OBJECTIVE:
-- Rank customers based on total revenue
-- and order activity.

WITH temp AS(
SELECT
    c.customer_id,
    c.region,
    COUNT(o.order_id) AS total_orders,
    SUM(o.revenue) AS total_revenue

FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id

GROUP BY c.customer_id,c.region
)

SELECT *,

DENSE_RANK()
OVER(ORDER BY total_revenue DESC)
AS customer_rank

FROM temp;

-- BUSINESS INTERPRETATION:
-- The report ranks customers based on
-- revenue contribution and identifies
-- high-value customers for loyalty
-- and retention programs.

-- =====================================================
-- QUERY 2 — REGION-WISE CUSTOMER RANKING
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify top customers
-- within each region.

-- OBJECTIVE:
-- Rank customers region-wise based on
-- revenue contribution.

WITH temp AS(
SELECT
    c.region,
    c.customer_id,
    SUM(o.revenue) AS total_revenue,
    COUNT(o.order_id) AS total_orders

FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id

GROUP BY c.region,c.customer_id
)

SELECT *,

DENSE_RANK()
OVER(PARTITION BY region
ORDER BY total_revenue DESC)
AS customer_rank

FROM temp;
-- BUSINESS INTERPRETATION:
-- The report identifies top-performing
-- customers within each region, helping
-- businesses optimize regional CRM
-- and customer retention strategies.

-- =====================================================
-- CONCEPT 5 — REVENUE TREND & GROWTH ANALYSIS
-- =====================================================

-- CONCEPT OVERVIEW:
-- Analyze monthly revenue trends, business growth,
-- and revenue performance over time.

-- BUSINESS GOALS:
-- • Monitor revenue growth trends
-- • Identify seasonal business performance
-- • Analyze order growth patterns
-- • Support strategic business planning

-- SQL CONCEPTS USED:
-- • LAG()
-- • Window Functions
-- • CTEs
-- • DATE FUNCTIONS
-- • Revenue Analytics
-- • Growth Analysis
-- =====================================================

-- =====================================================
-- QUERY 1 — MONTHLY REVENUE PERFORMANCE
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to monitor monthly
-- revenue and order performance trends.

-- OBJECTIVE:
-- Analyze monthly revenue, orders,
-- and average order value.

SELECT
    YEAR(order_date) AS year_,
    MONTH(order_date) AS month_,
    SUM(revenue) AS total_revenue,
    COUNT(order_date) AS total_orders,

    ROUND(
        (SUM(revenue)/NULLIF(COUNT(order_date),0)),2
    ) AS avg_order_value

FROM orders
GROUP BY YEAR(order_date),MONTH(order_date)
ORDER BY YEAR(order_date),MONTH(order_date);

-- BUSINESS INTERPRETATION:
-- The report tracks monthly revenue
-- and order performance trends, helping
-- businesses identify growth periods
-- and seasonal demand patterns.

-- =====================================================
-- QUERY 2 — MONTH-OVER-MONTH REVENUE GROWTH
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to analyze revenue
-- growth consistency over time.

-- OBJECTIVE:
-- Measure month-over-month revenue growth
-- using previous revenue comparison.

WITH temp AS(
SELECT
    YEAR(order_date) AS year_,
    MONTH(order_date) AS month_,
    SUM(revenue) AS total_revenue

FROM orders
GROUP BY YEAR(order_date),MONTH(order_date)
),

ranked AS(
SELECT *,

LAG(total_revenue)
OVER(ORDER BY year_,month_)
AS prev_revenue

FROM temp
)

SELECT *,

ROUND(
((total_revenue-prev_revenue)
/NULLIF(prev_revenue,0))*100,2
) AS revenue_growth

FROM ranked;

-- BUSINESS INTERPRETATION:
-- The report analyzes month-over-month
-- revenue growth trends and helps
-- businesses monitor growth consistency
-- and revenue performance changes over time.

-- =====================================================
-- CONCEPT 6 — PRODUCT PERFORMANCE & CATEGORY ANALYSIS
-- =====================================================

-- CONCEPT OVERVIEW:
-- Analyze product category performance
-- based on revenue, orders, and customer demand.

-- BUSINESS GOALS:
-- • Identify high-performing product categories
-- • Measure product revenue contribution
-- • Analyze customer demand trends
-- • Improve inventory and marketing strategy

-- SQL CONCEPTS USED:
-- • DENSE_RANK()
-- • Window Functions
-- • Aggregations
-- • GROUP BY
-- • Revenue Contribution Analysis
-- • Product Analytics
-- =====================================================

-- =====================================================
-- QUERY 1 — PRODUCT CATEGORY PERFORMANCE RANKING
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify product categories
-- generating the highest revenue contribution.

-- OBJECTIVE:
-- Rank product categories based on
-- total revenue performance.

WITH temp AS(
SELECT
    product_category,
    SUM(revenue) AS total_revenue,
    COUNT(order_id) AS total_orders,

    ROUND(
        (SUM(revenue)/NULLIF(COUNT(order_date),0)),2
    ) AS avg_order_value

FROM orders
GROUP BY product_category
)

SELECT *,

DENSE_RANK()
OVER(ORDER BY total_revenue DESC)
AS performance_rank

FROM temp;

-- BUSINESS INTERPRETATION:
-- The report ranks product categories
-- based on revenue contribution and
-- customer demand, helping businesses
-- optimize inventory and marketing strategy.

-- =====================================================
-- QUERY 2 — PRODUCT REVENUE CONTRIBUTION ANALYSIS
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to measure how much
-- each product category contributes
-- to total business revenue.

-- OBJECTIVE:
-- Analyze revenue contribution percentage
-- across product categories.

WITH temp AS(
SELECT
    product_category,
    SUM(revenue) AS category_revenue

FROM orders
GROUP BY product_category
),

overall AS(
SELECT *,

SUM(category_revenue)
OVER() AS total_revenue,

ROUND(
(category_revenue/
NULLIF(SUM(category_revenue) OVER(),0))*100,2
) AS contribution_pct

FROM temp
)

SELECT *,

DENSE_RANK()
OVER(ORDER BY contribution_pct DESC)
AS performance_rnk

FROM overall;

-- BUSINESS INTERPRETATION:
-- The report identifies product categories
-- contributing the highest business revenue.
-- Businesses can prioritize high-performing
-- categories for inventory planning,
-- promotions, and customer targeting.

-- =====================================================
-- CONCEPT 7 — CUSTOMER RETENTION & PURCHASE BEHAVIOR
-- =====================================================

-- CONCEPT OVERVIEW:
-- Analyze customer purchase frequency,
-- repeat buying behavior, and retention patterns.

-- BUSINESS GOALS:
-- • Identify repeat customers
-- • Analyze purchase frequency
-- • Improve customer retention
-- • Detect customer engagement patterns

-- SQL CONCEPTS USED:
-- • CASE WHEN
-- • Aggregations
-- • GROUP BY
-- • DENSE_RANK()
-- • Customer Retention Analytics
-- • Behavioral Segmentation
-- =====================================================

-- =====================================================
-- QUERY 1 — CUSTOMER PURCHASE TYPE ANALYSIS
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify whether customers
-- are one-time buyers or repeat customers.

-- OBJECTIVE:
-- Classify customers based on
-- purchase frequency behavior.

SELECT
    customer_id,
    COUNT(order_id) AS total_orders,

CASE
    WHEN COUNT(order_id) = 1
    THEN 'One-Time Customer'

    ELSE 'Repeat Customer'
END AS customer_type

FROM orders
GROUP BY customer_id;

-- BUSINESS INTERPRETATION:
-- The report identifies repeat customers
-- and one-time buyers, helping businesses
-- improve retention and repeat purchase strategies.

-- =====================================================
-- QUERY 2 — CUSTOMER PURCHASE FREQUENCY RANKING
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify customers
-- placing orders frequently.

-- OBJECTIVE:
-- Rank customers based on
-- order frequency and purchase activity.

WITH temp AS(
SELECT
    customer_id,
    SUM(revenue) AS total_revenue,
    COUNT(order_id) AS total_orders,

    ROUND(
        SUM(revenue)/NULLIF(COUNT(order_id),0),2
    ) AS avg_order_value

FROM orders
GROUP BY customer_id
ORDER BY COUNT(order_id) DESC
)

SELECT *,

DENSE_RANK()
OVER(ORDER BY total_orders DESC)
AS frequency_rnk

FROM temp;

-- BUSINESS INTERPRETATION:
-- The report identifies highly active customers
-- with strong purchase frequency, helping businesses
-- strengthen loyalty and customer retention programs.

-- =====================================================
-- CONCEPT 8 — CUSTOMER ACTIVITY & CHURN ANALYSIS
-- =====================================================

-- CONCEPT OVERVIEW:
-- Analyze customer activity status,
-- churn risk, and engagement behavior
-- using recency and purchase patterns.

-- BUSINESS GOALS:
-- • Identify inactive customers
-- • Detect churn risk customers
-- • Analyze customer engagement
-- • Improve retention strategies

-- SQL CONCEPTS USED:
-- • CASE WHEN
-- • DATEDIFF()
-- • Aggregations
-- • GROUP BY
-- • Customer Churn Analytics
-- • Behavioral Segmentation
-- =====================================================

-- =====================================================
-- QUERY 1 — CUSTOMER ACTIVITY STATUS ANALYSIS
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify active,
-- inactive, and at-risk customers.

-- OBJECTIVE:
-- Analyze customer activity based on
-- recent purchase behavior.

SELECT
    customer_id,
    MAX(order_date) AS last_order_date,

    DATEDIFF(
        CURDATE(),
        MAX(order_date)
    ) AS days_since_last_order,

CASE
    WHEN DATEDIFF(CURDATE(),MAX(order_date)) > 90
    THEN 'Inactive'

    WHEN DATEDIFF(CURDATE(),MAX(order_date)) > 30
    THEN 'At Risk'

    ELSE 'Active'
END AS activity_status

FROM orders
GROUP BY customer_id;

-- BUSINESS INTERPRETATION:
-- The report identifies customer activity levels
-- and helps businesses detect customers
-- requiring retention and reactivation campaigns.

-- =====================================================
-- QUERY 2 — CUSTOMER CHURN & RETENTION ANALYSIS
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify churned customers
-- and loyal customers using behavioral analysis.

-- OBJECTIVE:
-- Classify customers based on recency,
-- order frequency, and retention behavior.

SELECT
    customer_id,
    SUM(revenue) AS total_revenue,
    COUNT(order_id) AS total_orders,
    MAX(order_date) AS last_order_date,

    DATEDIFF(
        CURDATE(),
        MAX(order_date)
    ) AS days_since_last_order,

CASE
    WHEN DATEDIFF(CURDATE(),MAX(order_date)) > 180
    THEN 'Churned'

    WHEN DATEDIFF(CURDATE(),MAX(order_date)) > 90
    THEN 'At Risk'

    WHEN DATEDIFF(CURDATE(),MAX(order_date)) <= 30
         AND COUNT(order_id) > 10
    THEN 'Loyal Customer'

    WHEN DATEDIFF(CURDATE(),MAX(order_date)) <= 90
         AND COUNT(order_id) > 5
    THEN 'Active Customer'
END AS FR_status

FROM orders
GROUP BY customer_id
ORDER BY DATEDIFF(CURDATE(),MAX(order_date));

-- BUSINESS INTERPRETATION:
-- The report identifies loyal, active,
-- at-risk, and churned customers.
-- Businesses can use this analysis
-- to improve customer retention
-- and reduce customer churn.

-- =====================================================
-- CONCEPT 9 — CUSTOMER LIFETIME VALUE (CLV) ANALYSIS
-- =====================================================

-- CONCEPT OVERVIEW:
-- Analyze long-term customer value,
-- profitability, and lifetime revenue contribution.

-- BUSINESS GOALS:
-- • Identify profitable customers
-- • Measure customer lifetime value
-- • Improve retention strategy
-- • Optimize customer profitability

-- SQL CONCEPTS USED:
-- • DENSE_RANK()
-- • Window Functions
-- • Aggregations
-- • GROUP BY
-- • Profitability Analytics
-- • CLV Analysis
-- =====================================================

-- =====================================================
-- QUERY 1 — CUSTOMER LIFETIME VALUE ANALYSIS
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify customers
-- generating strong long-term value
-- and profitability.

-- OBJECTIVE:
-- Analyze customer lifetime revenue,
-- profitability, and purchase activity.

WITH temp AS(
SELECT
    customer_id,
    SUM(revenue) AS total_revenue,
    COUNT(order_id) AS total_orders,
    SUM(gross_margin) AS lifetime_profit,
    SUM(net_revenue) AS lifetime_value,

    ROUND(
        SUM(revenue)/NULLIF(COUNT(order_id),0),2
    ) AS avg_order_value

FROM orders
GROUP BY customer_id
)

SELECT *,

DENSE_RANK()
OVER(ORDER BY lifetime_profit DESC)
AS clv_rank

FROM temp;

-- BUSINESS INTERPRETATION:
-- The report identifies customers
-- generating high lifetime revenue
-- and profitability. Businesses can
-- target these customers using
-- premium memberships and retention programs.

-- =====================================================
-- QUERY 2 — CUSTOMER RECENCY-FREQUENCY-MONETARY (RFM)
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to analyze customer
-- engagement and purchase behavior
-- using RFM metrics.

-- OBJECTIVE:
-- Segment customers based on
-- recency, frequency, and monetary value.

WITH temp AS(
SELECT
    customer_id,
    MAX(order_date) AS last_date,

    DATEDIFF(
        CURDATE(),
        MAX(order_date)
    ) AS recency,

    COUNT(order_date) AS frequency,
    SUM(revenue) AS monetary

FROM orders
GROUP BY customer_id
)
SELECT *,
CASE
    WHEN recency <= 30
         AND frequency > 15
         AND monetary > 30000
    THEN 'Champion'

    WHEN recency <= 60
         AND frequency > 10
    THEN 'Regular'

    WHEN recency > 60
    THEN 'Lost Customer'
END AS cust_activity
FROM temp;

-- BUSINESS INTERPRETATION:
-- The report segments customers
-- based on purchase behavior and engagement.
-- Businesses can use RFM analysis
-- to improve customer targeting,
-- retention, and personalized marketing strategies.

-- =====================================================
-- CONCEPT 10 — ROW_NUMBER() & PURCHASE BEHAVIOR ANALYSIS
-- =====================================================

-- CONCEPT OVERVIEW:
-- Analyze customer purchase behavior
-- using ROW_NUMBER() to identify
-- first and latest customer purchases.

-- BUSINESS GOALS:
-- • Analyze customer onboarding behavior
-- • Monitor latest customer activity
-- • Understand customer engagement trends
-- • Improve retention strategies

-- SQL CONCEPTS USED:
-- • ROW_NUMBER()
-- • Window Functions
-- • PARTITION BY
-- • ORDER BY
-- • Customer Behavioral Analytics
-- =====================================================

-- =====================================================
-- QUERY 1 — FIRST PURCHASE ANALYSIS
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to identify
-- the first order placed by each customer.

-- OBJECTIVE:
-- Analyze customer onboarding
-- and first purchase behavior.

WITH temp AS(
SELECT
    customer_id,
    order_id,
    order_date,
    revenue,

    ROW_NUMBER()
    OVER(PARTITION BY customer_id
    ORDER BY order_date)
    AS rnk

FROM orders
)

SELECT *
FROM temp
WHERE rnk = 1;

-- BUSINESS INTERPRETATION:
-- The report identifies the first purchase
-- made by each customer and helps businesses
-- analyze customer acquisition
-- and onboarding effectiveness.

-- =====================================================
-- QUERY 2 — LATEST PURCHASE ANALYSIS
-- =====================================================

-- BUSINESS PROBLEM:
-- Businesses need to monitor
-- the latest purchase activity
-- of customers.

-- OBJECTIVE:
-- Identify the most recent order
-- placed by each customer.

WITH temp AS(
SELECT
    customer_id,
    order_id,
    order_date,
    revenue,

    ROW_NUMBER()
    OVER(PARTITION BY customer_id
    ORDER BY order_date DESC)
    AS rnk

FROM orders
)

SELECT *
FROM temp
WHERE rnk = 1;

-- BUSINESS INTERPRETATION:
-- The report identifies recent customer
-- purchase activity and helps businesses
-- monitor engagement, retention,
-- and customer behavior trends.

-- =====================================================
-- PART 2 COMPLETED
-- =====================================================
