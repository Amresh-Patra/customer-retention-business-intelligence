# Customer retention & business intelligence
### End-to-End SQL Analytics Project | MySQL

---

## Project Overview

This project presents a complete end-to-end customer analytics solution built using MySQL on a real-world e-commerce dataset containing **50,000+ customer records** and **50,000+ transactions**.

The project covers the full analytics lifecycle â€” from marketing funnel performance and customer acquisition analysis to retention intelligence, churn detection, profitability reporting, and executive KPI dashboards.

This project was built to simulate real business analytics work done by a data analyst in a customer-focused organization.

---

## Business Objective

> *"Identify which customers are most valuable, why customers are churning, which marketing channels drive the best ROI, and how the business can improve profitability and retention."*

---

## Dataset

| File | Records | Description |
|------|---------|-------------|
| `customers.csv` | 50,000 rows | Customer profiles, acquisition channel, region, signup date, status |
| `orders.csv` | 50,000 rows | Transactions including revenue, cost, margin, refunds, product category |
| `marketing_spend.csv` | 960 rows | Monthly marketing spend, impressions, clicks, conversions by channel and region |

**Period Covered:** 2021 â€“ 2024

**Product Categories:** Beauty, Fashion, Electronics, Home, Grocery

**Regions:** North, South, East, West, Tier2

**Acquisition Channels:** Organic, Paid Ads, Referral, Influencer

---

## Key Business Metrics

| Metric | Value |
|--------|-------|
| Total Revenue | â‚¹10.29 Crore |
| Total Orders | 50,000 |
| Total Customers | 50,000 |
| Average Order Value | â‚¹2,059 |
| Repeat Customer Rate | 83.58% |
| Refund Rate | 7.42% |
| Total Marketing Spend | â‚¹1.23 Crore |
| Total Conversions | 1,00,843 |
| Top Revenue Category | Fashion |

---

## Project Structure

The project is divided into 4 parts, each covering a different layer of business analytics:

customer-acquisition-funnel-analytics/
|
|-- README.md
|
|-- data/
|   |-- customers.csv
|   |-- orders.csv
|   |-- marketing_spend.csv
|
|-- sql/
|   |-- part1_marketing_funnel_analytics.sql
|   |-- part2_advanced_customer_analytics.sql
|   |-- part3_business_dashboard_reporting.sql
|   |-- part4_business_intelligence_analytics.sql
|
|-- results/
    |-- (query output screenshots)

---

## Part 1 â€” Marketing & Funnel Analytics

**Business Focus:** Which marketing channels are performing? Where is the funnel leaking?

| Concept | Analysis Performed |
|---------|-------------------|
| Channel Performance | Highest spending and highest conversion channels |
| Funnel Conversion | Click-through rate, conversion rate by channel |
| Regional Performance | CTR and cost per conversion by region |
| Marketing ROI | Conversions per dollar, customer acquisition efficiency |
| Campaign Classification | High / Average / Low performing campaign segmentation |
| Spend Trend | Cumulative marketing spend growth over time |

**Key SQL Concepts:** `GROUP BY`, `SUM`, `NULLIF`, `ROUND`, `CTEs`, `Window Functions`, `CASE WHEN`

---

## Part 2 â€” Advanced Customer Analytics

**Business Focus:** Who are the customers? What is their value and behavior?

| Concept | Analysis Performed |
|---------|-------------------|
| Top Customer Revenue | Top 10 revenue-generating customers with region and status |
| Inactive Customer Detection | Customers with zero order activity using LEFT JOIN |
| Customer Segmentation | High Value, Medium Value, Low Value, VIP classification |
| Regional Revenue | Revenue and customer activity by region |
| Customer Ranking | DENSE_RANK on revenue contribution |
| Monthly Revenue Trend | Revenue and order performance month-over-month |
| MoM Revenue Growth | Month-over-month growth percentage using LAG |
| Product Category Ranking | Revenue contribution and ranking by category |
| Purchase Behavior | One-time vs repeat customer classification |
| Customer Churn Detection | Active, At Risk, Churned classification using DATEDIFF |
| Customer Lifetime Value | Lifetime revenue, profit, and CLV ranking |
| RFM Analysis | Recency, Frequency, Monetary segmentation |
| First and Latest Purchase | ROW_NUMBER to identify onboarding and recent activity |

**Key SQL Concepts:** `INNER JOIN`, `LEFT JOIN`, `LAG`, `DENSE_RANK`, `ROW_NUMBER`, `CTEs`, `DATEDIFF`, `CASE WHEN`, `NULLIF`

---

## Part 3 â€” Business Dashboard & Strategic Reporting

**Business Focus:** How is the business performing overall? What are the retention and churn patterns?

| Concept | Analysis Performed |
|---------|-------------------|
| Cohort Revenue Analysis | Revenue by acquisition cohort month using INNER and LEFT JOIN |
| Customer Loyalty Segmentation | Loyal, Moderate, One-time classification |
| Churn Activity Analysis | Churned, At Risk, Active customer detection |
| High-Value Churn Risk | Combined revenue + recency churn risk segmentation |
| Executive KPI Dashboard | Total revenue, orders, customers, repeat rate in one query |
| Monthly Revenue Dashboard | Monthly revenue with MoM growth percentage |
| Regional Performance Dashboard | Region-wise revenue, customers, orders, contribution % |
| Executive Business Snapshot | Full business summary using CROSS JOIN |
| Product Performance Dashboard | Revenue, margin, and contribution % by category |
| Customer Lifetime Value Dashboard | CLV ranking by lifetime revenue |

**Key SQL Concepts:** `CTEs`, `LAG`, `DENSE_RANK`, `CROSS JOIN`, `Window Functions`, `DATE_FORMAT`, `DATEDIFF`

---

## Part 4 â€” Business Intelligence Analytics

**Business Focus:** Executive-level intelligence on retention, profitability, and revenue leakage.

| Concept | Analysis Performed |
|---------|-------------------|
| Retention Intelligence Dashboard | Repeat customers, churn customers, active customers, retention rate |
| Revenue Leakage & Refund Analysis | Gross revenue, refunds, net revenue, refund %, profit margin % |
| Profitability vs Revenue Analysis | Revenue vs gross margin by category with profitability ranking |

**Key SQL Concepts:** `CTEs`, `CASE WHEN`, `NULLIF`, `DENSE_RANK`, `Window Functions`, `Financial Analytics`

---

## SQL Concepts Demonstrated

| Category | Concepts Used |
|----------|--------------|
| Joins | INNER JOIN, LEFT JOIN, CROSS JOIN |
| Aggregations | SUM, COUNT, AVG, MAX, MIN, ROUND |
| Window Functions | DENSE_RANK(), ROW_NUMBER(), LAG(), SUM() OVER() |
| CTEs | Single CTE, Chained CTEs (up to 4 levels) |
| Conditional Logic | CASE WHEN, NULLIF |
| Date Functions | DATEDIFF, DATE_FORMAT, CURDATE, YEAR, MONTH |
| Analytical Patterns | Cohort Analysis, RFM, Churn Detection, Funnel Analysis |
| Business KPIs | MoM Growth, CLV, CAC, Retention Rate, Refund Rate |

---

## Key Business Findings

1. **Fashion** is the highest revenue-generating category
2. **83.58% repeat customer rate** indicates strong customer retention
3. **7.42% refund rate** represents significant revenue leakage requiring attention
4. Significant customer activity falls under **churned or at-risk** segments indicating retention improvement opportunity
5. Marketing channel ROI varies significantly â€” some channels generate far more conversions per dollar than others
6. High-revenue product categories do not always generate the highest profit margins â€” profitability analysis reveals important pricing insights
7. Regional performance differs considerably â€” targeted regional strategies can improve overall business efficiency

---

## Business Recommendations

1. **Reduce refund rate** from 7.42% by improving product quality, delivery experience, and return policies
2. **Increase investment** in high-converting marketing channels with better conversion-per-dollar performance
3. **Launch win-back campaigns** for churned high-value customers identified through RFM and churn analysis
4. **Focus retention resources** on customers identified as At Risk before they fully churn
5. **Optimize product mix** by prioritizing high-margin categories over high-revenue but low-margin categories
6. **Regional marketing** should be personalized based on regional revenue contribution and customer engagement data

---

## Tools Used

- **MySQL** â€” Data analysis, querying, business reporting
- **MySQL Workbench** â€” Query execution and project documentation
- **MS Excel** â€” Dashboard visualization and reporting
- **GitHub** â€” Version control and portfolio presentation

---

## How To Run This Project

1. Clone this repository
2. Import the three CSV files into your MySQL database
3. Run SQL files in order: Part 1 â†’ Part 2 â†’ Part 3 â†’ Part 4
4. View results in MySQL Workbench output panel
5. Open Excel dashboard for visual summary

```sql
-- Create database and import data
CREATE DATABASE customer_retention_project;
USE customer_retention_project;
-- Import customers.csv, orders.csv, marketing_spend.csv
-- Then run SQL files in sequence
```

---

## About This Project

This project was built as part of a structured self-directed data analytics learning program covering MySQL, business analytics, and real-world data analysis skills.

The dataset contains 50,000+ real-scale records designed to simulate actual business analytics challenges faced by data analysts in e-commerce and customer-focused organizations.

---

## Connect

**LinkedIn:** [](https://www.linkedin.com/in/amresh-patra-952714262/)]  
**Email:** [amresh_patra@proton.me]  
**Portfolio:** [Your Portfolio Link]

---

*Built with MySQL | 50,000+ Records | 4-Part Analytics Project*

