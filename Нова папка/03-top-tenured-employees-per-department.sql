-- ============================================
-- Employees Database Practice
-- Business Task: Top 3 Longest-Tenured Employees per Department
-- ============================================

-- Management wants to see the top 3 longest-tenured current employees in each department,
-- with their name, tenure in years, and their rank within the department.
--
-- Key considerations:
-- - Same JOINs as previous tasks (dept_emp, departments, employees), same tenure 
--   calculation via TIMESTAMPDIFF, same "current employees" filter (to_date = '9999-01-01')
-- - Used a CTE to wrap the Window Function, since MySQL doesn't allow filtering a window 
--   function's result directly in WHERE at the same query level — the outer query filters 
--   on the CTE's output instead (WHERE top <= 3)
-- - Ranked by tenure_months (not tenure_years) for precision — ranking by whole years alone 
--   produced far too many ties, since many employees share the same year-level tenure
--
-- DESIGN DECISION: Used DENSE_RANK() instead of ROW_NUMBER() intentionally. Many employees 
-- share identical tenure (due to a narrow hire-date range in this sample dataset — see 
-- Task 02 finding). ROW_NUMBER() would arbitrarily pick exactly 3 specific people, which 
-- could misrepresent "top 3" if this data were used for real decisions (e.g. raises, 
-- promotions). DENSE_RANK() honestly surfaces every employee tied for the top 3 tenure 
-- values, making the ambiguity visible instead of hiding it. A secondary tie-breaker 
-- (e.g. current salary, birth date) would be needed to narrow this down to exactly 3 
-- named individuals per department, if that were the actual business requirement.

with RankedEmployees as(
	select 
		dep.dept_name, 
		emp.first_name, 
		emp.last_name,
		TIMESTAMPDIFF(MONTH, emp.hire_date, CURDATE()) AS tenure_months,
		ROUND(TIMESTAMPDIFF(MONTH, emp.hire_date, CURDATE()) / 12, 1) AS tenure_years,
		DENSE_RANK() over(
			partition by dep.dept_name 
			order by timestampdiff(MONTH, emp.hire_date, curdate()) desc
		) top
	from employees.dept_emp as dep_e
	join employees.departments as dep
		on dep.dept_no = dep_e.dept_no
	join employees.employees as emp
		on dep_e.emp_no = emp.emp_no
	where dep_e.to_date = '9999-01-01')
select 
	dept_name, 
	first_name, 
	last_name,
	tenure_months,
	tenure_years,
	top
from RankedEmployees
where top <= 3;