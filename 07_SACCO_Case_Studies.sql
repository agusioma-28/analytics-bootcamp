/*
=========================================================
SACCO CASE STUDIES
Author: Isaac Agusioma
Database: Analytics Bootcamp
=========================================================

Description:
This file contains practical SACCO business cases solved
using PostgreSQL. Each case represents a real business
request commonly encountered in Savings and Credit
Co-operative Societies (SACCOs).
*/




/*
=========================================================
SACCO BUSINESS CASE 1
Title : Members with Consistent Monthly Savings Increase
Author: Isaac Agusioma
Database: Analytics Bootcamp
Date: 2026-07-23
=========================================================

Business Request:
The Credit Committee wants to identify members who have
consistently increased their monthly savings over the
last three consecutive months.

Business Problem:
The savings table stores individual transactions.
A member can make multiple deposits within the same month,
so monthly totals must be calculated before trend analysis.

Solution:
1. Aggregate transactions into monthly savings totals.
2. Use LAG() to retrieve savings from the previous one
   and two months.
3. Classify each member's savings trend using CASE.

Business Insight:
Members with consistent savings growth demonstrate
improving financial discipline and may be considered
stronger candidates during loan assessment.
*/

-- Step 1: Aggregate individual transactions into monthly totals
WITH monthly_savings AS (

    SELECT
        member_id,
        DATE_TRUNC('month', transaction_date) AS month,
        SUM(amount) AS total_monthly_savings

    FROM savings

    GROUP BY
        member_id,
        DATE_TRUNC('month', transaction_date)
),

-- Step 2: Compare each month with the previous two months
savings_trend AS (

    SELECT
        member_id,
        month,
        total_monthly_savings,

        LAG(total_monthly_savings,1) OVER (
            PARTITION BY member_id
            ORDER BY month
        ) AS previous_month,

        LAG(total_monthly_savings,2) OVER (
            PARTITION BY member_id
            ORDER BY month
        ) AS two_months_ago

    FROM monthly_savings
)

-- Step 3: Classify members
SELECT

    member_id,
    month,
    total_monthly_savings,
    previous_month,
    two_months_ago,

    CASE

        WHEN two_months_ago IS NULL
            THEN 'Not Enough History'

        WHEN total_monthly_savings > previous_month
         AND previous_month > two_months_ago
            THEN 'Consistent Increase'

        ELSE 'Normal'

    END AS committee_status

FROM savings_trend

ORDER BY
    member_id,
    month;





/*
=========================================================
SACCO BUSINESS CASE 2
Title : Running Monthly Savings Balance
Author: Isaac Agusioma
Database: Analytics Bootcamp
Date: 2026-07-24
=========================================================

Business Request:
The Finance Manager wants a report showing each member's
cumulative savings after every month's deposits.

Business Problem:
The savings table records individual transactions.
Since members may deposit multiple times in a month,
monthly totals must first be calculated before computing
a running balance.

Solution:
1. Aggregate transactions into monthly totals.
2. Apply SUM() as a window function.
3. Calculate a cumulative running balance for each member.

Business Insight:
Running totals help the Finance Manager monitor
how each member's savings accumulate over time.

This report can be used to:
- Monitor savings growth.
- Produce member passbooks.
- Assess loan eligibility.
- Analyze member saving behaviour.
*/

-- Step 1: Aggregate transactions into monthly totals
WITH monthly_savings AS (

    SELECT

        member_id,
        DATE_TRUNC('month', transaction_date) AS month,
        SUM(amount) AS total_monthly_savings

    FROM savings

    GROUP BY

        member_id,
        DATE_TRUNC('month', transaction_date)

)

-- Step 2: Calculate cumulative savings
SELECT

    member_id,
    month,
    total_monthly_savings,

    SUM(total_monthly_savings) OVER (

        PARTITION BY member_id
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW

    ) AS running_total

FROM monthly_savings

ORDER BY
    member_id,
    month;