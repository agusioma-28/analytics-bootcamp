/*
=========================================================
HR BUSINESS CASE 2
Title : Top 3 Highest paid Employees in Each Department
Author: Isaac Agusioma
Database: Analytics Bootcamp
Date: 2026-07-20
=========================================================

Business Request:
The HR Director wants a report showing top 3 employees who
are highest paid in each department .

Solution:
Window Function inside a CTE.

Reason:
Reason:
- Uses ROW_NUMBER() to rank employees within each department.
- PARTITION BY restarts the ranking for every department.
- The CTE makes the query easy to read and allows filtering on salary_rank.
- The solution is easy to maintain and extend.
*/

WITH salary_ranked AS (
    SELECT
        e.employee_id,
        e.first_name || ' ' || e.last_name AS employee_name,
        e.department_id,
        d.department_name,
        e.salary,
        ROW_NUMBER() OVER (
            PARTITION BY e.department_id
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM employees e
    JOIN departments d
        ON e.department_id = d.department_id
)

SELECT
    employee_id,
    employee_name,
    department_id,
    department_name,
    salary,
    salary_rank
FROM salary_ranked
WHERE salary_rank <= 3
ORDER BY department_name, salary_rank;


/*
=========================================================
Business Insight
=========================================================

This report helps HR identify the highest-paid employees
within each department.

Business Uses:
- Promotion discussions
- Salary benchmarking
- Bonus allocation
- Talent retention
- Compensation planning

Prepared by:
Isaac Agusioma
*/