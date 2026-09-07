-- ============================================
-- Employees Database Practice
-- Business Task: Department Tenure Overview
-- ============================================

-- Management wants to understand team experience levels across departments:
-- department name, current employee count, and average tenure (in years) at the 
-- company among current employees, ranked from highest to lowest average tenure.
--
-- Key considerations:
-- - Tenure must be calculated from employees.hire_date (date joined the COMPANY),
--   not dept_emp.from_date (date joined the specific DEPARTMENT) — an employee 
--   can transfer between departments, so these two dates are not the same.
-- - Used TIMESTAMPDIFF(YEAR, ...) instead of DATEDIFF, since TIMESTAMPDIFF can 
--   return the difference directly in years without manual conversion from days.
-- - Same "current employees" filter applies as in Task 01 (to_date = '9999-01-01').
--
-- FINDING: Average tenure came out nearly identical (~36 years) across every department.
-- Investigated by sampling employees.hire_date directly, which showed hire dates in this 
-- sample dataset are concentrated within a narrow historical window (1985-1994).
-- This is a data characteristic, not a query error — tenure doesn't vary meaningfully 
-- by department in this particular dataset, since almost everyone was hired in the same era.

select dep.dept_name,
count(dep_e.emp_no) as COUNT_EMPLOYEES,
round(avg(timestampdiff(year, emp.hire_date, curdate())), 1) as TENURE
from employees.dept_emp as dep_e
join employees.departments as dep
	on dep.dept_no = dep_e.dept_no
join employees.employees as emp
	on dep_e.emp_no = emp.emp_no
where dep_e.to_date = '9999-01-01'
group by dep.dept_name
order by TENURE desc;