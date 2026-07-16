/*
=========================================================
Topic : INNER JOIN, LEFT JOIN & SELF JOIN
Author: Isaac
Database: Analytics Bootcamp
=========================================================
*/

-- HR Employee Report
-- Displays employee, department, branch, manager, salary and hire date.

SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    d.department_name,
    b.branch_name,
    m.first_name || ' ' || m.last_name AS manager,
    e.salary,
    e.hire_date
FROM employees e
LEFT JOIN departments d
    ON e.department_id = d.department_id
LEFT JOIN branches b
    ON e.branch_id = b.branch_id
LEFT JOIN employees m
    ON e.manager_id = m.employee_id
ORDER BY e.employee_id;