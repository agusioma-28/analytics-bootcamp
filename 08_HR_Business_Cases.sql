/*
=========================================================
HR BUSINESS CASE 1
Title : Employees earning above department average
Author: Isaac
Database: Analytics Bootcamp
Date: 2026-07-17
=========================================================

Business Request:
The HR Director wants a report showing employees whose
salary is greater than the average salary of their own
department.

Solution:
Window Function inside a CTE.

Reason:
- Calculates the department average once per partition.
- Avoids repeating the same calculation.
- Makes the query easier to read and maintain.
*/

WITH dept_avg AS (
    SELECT
        e.employee_id,
        e.first_name || ' ' || e.last_name AS employee_name,
        d.department_name,
        e.salary,
        AVG(e.salary) OVER (PARTITION BY e.department_id) AS dept_avg_salary
    FROM employees e
    JOIN departments d
        ON e.department_id = d.department_id
)

SELECT
    employee_id,
    employee_name,
    department_name,
    salary,
    ROUND(dept_avg_salary, 2) AS dept_avg_salary,
    ROUND(salary - dept_avg_salary, 2) AS diff_from_dept_avg
FROM dept_avg
WHERE salary > dept_avg_salary
ORDER BY department_name, salary DESC;