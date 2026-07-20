/*
=========================================================
SUBQUERIES
Title : Employees Earning Above Their Department Average
Author: Isaac Agusioma
Database: Analytics Bootcamp
Date: 2026-07-20
=========================================================

Business Request:
The HR Director wants a report showing employees whose
salary is greater than the average salary of their own
department.

Solution:
Correlated Subquery.

Reason:
- Uses a correlated subquery because the average salary
  depends on the employee's department.
- The subquery executes for each employee row.
- Demonstrates row-by-row comparison using a subquery.
*/

SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    d.department_name,
    e.salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE e.salary > (
    SELECT AVG(m.salary)
    FROM employees m
    WHERE m.department_id = e.department_id
)
ORDER BY d.department_name, e.salary DESC;

/*
=========================================================
Business Insight
=========================================================

This report identifies employees whose salaries exceed
their department's average salary.

Business Uses:
- Identify high-performing or highly compensated employees.
- Support promotion and compensation reviews.
- Assist HR in salary benchmarking across departments.

Prepared by:
Isaac Agusioma
*/