-- ============================================
-- Employees Database Practice
-- Business Task: Department Salary Overview
-- ============================================

-- HR wants to understand the current company structure:
-- department name, current employee count, and average current salary per department,
-- ranked from highest to lowest average salary.
--
-- Key considerations before writing this query:
-- - dept_emp and salaries both hold historical records (one employee can have multiple rows
--   over time), so filtering on to_date = '9999-01-01' is required in BOTH joins to get 
--   only current department assignments and current salaries.
-- - Assumption: "average salary" means current salary only, not the full salary history —
--   without this filter, the average would be skewed toward older, lower historical salaries.

select dep.dept_name, avg(sal.salary) as AVERAGE_SALARY, count(dep_e.emp_no) as COUNT_EMPLOYEES
from employees.dept_emp as dep_e
join employees.departments as dep
	on dep.dept_no = dep_e.dept_no
join employees.salaries as sal
	on dep_e.emp_no = sal.emp_no
where dep_e.to_date = '9999-01-01'
and sal.to_date = '9999-01-01'
group by dep.dept_name
order by AVERAGE_SALARY desc;