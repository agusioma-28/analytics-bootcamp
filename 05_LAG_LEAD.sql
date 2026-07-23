/*
=========================================================
LAG() AND LEAD()
Author: Isaac Agusioma
Database: Analytics Bootcamp
Date: 2026-07-23
=========================================================

Definition:
LAG() returns a value from a previous row.
LEAD() returns a value from a following row.

Why Use Them?
- Compare current and previous values
- Compare current and next values
- Detect trends
- Calculate month-over-month changes
- Build business reports

Basic Syntax:

LAG(column_name, offset, default_value)
OVER (
    PARTITION BY column_name
    ORDER BY column_name
)

LEAD(column_name, offset, default_value)
OVER (
    PARTITION BY column_name
    ORDER BY column_name
)
*/

/*
Example 1:
Show each member's previous month's savings.
*/

SELECT
    member_id,
    transaction_date,
    amount,
    LAG(amount) OVER (
        PARTITION BY member_id
        ORDER BY transaction_date
    ) AS previous_month_savings
FROM savings;

/*
Example 2:
Show each member's next month's savings.
*/

SELECT
    member_id,
    transaction_date,
    amount,
    LEAD(amount) OVER (
        PARTITION BY member_id
        ORDER BY transaction_date
    ) AS next_month_savings
FROM savings;

/*
Example 3:
Compare current savings with the amount from two months earlier.
*/

SELECT
    member_id,
    transaction_date,
    amount,
    LAG(amount,2) OVER (
        PARTITION BY member_id
        ORDER BY transaction_date
    ) AS savings_two_months_ago
FROM savings;

