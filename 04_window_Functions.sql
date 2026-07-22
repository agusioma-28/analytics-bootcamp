/*
=========================================================
WINDOW FUNCTIONS
Author: Isaac Agusioma
Database: Analytics Bootcamp
Date: 2026-07-22
=========================================================

Definition:
Window functions perform calculations across a set of rows
related to the current row without collapsing the result set.

Why Use Window Functions?
- Keep all original rows
- Compare rows
- Create rankings
- Calculate running totals
- Calculate moving averages
- Compare previous and next records

Basic Syntax:

SELECT
    column_name,
    window_function() OVER (
        PARTITION BY column_name
        ORDER BY column_name
    )
FROM table_name;
*/

/*
Example 1:
Calculate the average salary for each department while
keeping every employee.
*/

SELECT
    employee_id,
    first_name,
    salary,
    department_id,
    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS dept_avg_salary
FROM employees;

/*
Example 2:
Assign a unique salary rank within each department.
*/

SELECT
    employee_id,
    first_name,
    salary,
    department_id,
    ROW_NUMBER() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

/*
Example 3:
Employees with the same salary receive the same rank.
*/

SELECT
    employee_id,
    first_name,
    salary,
    department_id,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

/*
Example 4:
Employees with the same salary receive the same rank,
without gaps in the ranking.
*/

SELECT
    employee_id,
    first_name,
    salary,
    department_id,
    DENSE_RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

/*
=========================================================
Business Insight
=========================================================

Window functions are essential for business analytics because
they allow analysts to calculate values across related rows
without losing detail.

Common Uses:
- Employee ranking
- Sales leaderboards
- Running totals
- Month-over-month growth
- Customer segmentation
- SACCO savings and loan trend analysis

Prepared by:
Isaac Agusioma
*/

/*
=========================================================
Key Takeaways
=========================================================

✓ Window functions do not collapse rows.
✓ OVER() defines the window.
✓ PARTITION BY creates groups.
✓ ORDER BY determines calculation order.
✓ ROW_NUMBER() returns unique rankings.
✓ RANK() allows ties and skips numbers.
✓ DENSE_RANK() allows ties without skipping numbers.
*/