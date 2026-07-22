/*
=========================================================
COMMON TABLE EXPRESSIONS (CTE)
Author: Isaac Agusioma
Database: Analytics Bootcamp
Date: 2026-07-22
=========================================================

Definition:
A Common Table Expression (CTE) is a temporary result set
that exists only during query execution.

Why Use CTEs:
- Improve readability
- Break complex queries into steps
- Avoid repeating calculations
- Make queries easier to debug
- Replace nested subqueries

Basic Syntax:

WITH cte_name AS (
    SELECT ...
)
SELECT *
FROM cte_name;
*/

/*
Example 1:
Show employees together with their department average salary.
*/

WITH dept_avg AS (
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)

SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    e.salary,
    d.avg_salary
FROM employees e
JOIN dept_avg d
    ON e.department_id = d.department_id;

/*
Example 2:
Employees earning above department average.
*/

WITH dept_avg AS (
    SELECT
        employee_id,
        first_name || ' ' || last_name AS employee_name,
        department_id,
        salary,
        AVG(salary) OVER (
            PARTITION BY department_id
        ) AS dept_avg_salary
    FROM employees
)

SELECT *
FROM dept_avg
WHERE salary > dept_avg_salary;

/*
=========================================================
Business Insight
=========================================================

CTEs help analysts solve complex business problems by
breaking large queries into smaller, understandable steps.

Common Uses:
- Financial reporting
- HR analysis
- Sales dashboards
- SACCO loan reports
- Data cleaning and transformations

Prepared by:
Isaac Agusioma
*/