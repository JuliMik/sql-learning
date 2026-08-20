-- ============================================
-- Subqueries Practice (in WHERE, SELECT, and FROM)
-- Table: parks_and_recreation
-- ============================================

-- Subquery in WHERE: filter demographics table using IDs found in a separate query on salary table
select *
from parks_and_recreation.employee_demographics
where employee_id in 
						(select employee_id
						from parks_and_recreation.employee_salary
                        where dept_id = 1);
                        
-- Subquery in SELECT: add a column showing the overall average salary next to each individual salary
-- (this scalar subquery runs once and returns the same value for every row)
select first_name, salary,
(select round(avg(salary))
from parks_and_recreation.employee_salary) as AVG_Salary
from parks_and_recreation.employee_salary; 

-- Baseline aggregation: average, max, min, and count of age, grouped by gender
select gender, avg(age), max(age), min(age), count(age)
from parks_and_recreation.employee_demographics
group by gender;

-- Subquery in FROM (derived table): treat the grouped result above as its own table,
-- then aggregate further on top of it — here, averaging the max_age across genders
select avg(max_age)
from
(select gender, 
avg(age) as avg_age, 
max(age) as max_age, 
min(age) as min_age, 
count(age) as count_age
from parks_and_recreation.employee_demographics
group by gender) as agg_table;