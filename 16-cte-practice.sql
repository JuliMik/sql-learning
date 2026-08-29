-- ============================================
-- CTE (Common Table Expressions) Practice
-- Table: parks_and_recreation
-- ============================================

-- Single CTE: pre-aggregate salary stats by gender, then average the group averages on top
with CTE_Example AS
(select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
	on dem.employee_id = sal.employee_id
    group by gender)
select avg(avg_sal)
from CTE_Example;

-- Multiple CTEs in one query: define two separate filtered CTEs, then JOIN them together
-- CTE_Example: employees born after 1985
-- CTE_Example2: employees earning over 50000
with CTE_Example as
(
select employee_id, gender, birth_date
from parks_and_recreation.employee_demographics
where birth_date > '1985-01-01'
),
CTE_Example2 as
(
select employee_id, salary
from parks_and_recreation.employee_salary
where salary > 50000
)
select *
from CTE_Example
join CTE_Example2
	on CTE_Example.employee_id = CTE_Example2.employee_id;
    
-- CTE with explicit column names declared upfront (instead of relying on aliases inside the SELECT)
-- Useful when you want clean, guaranteed column names regardless of how the inner query is written
with CTE_Example (Gender, AVG_Sal, Max_Sal, MIN_Sal, COUNT_Sal) AS
(select gender, avg(salary), max(salary), min(salary), count(salary)
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
	on dem.employee_id = sal.employee_id
    group by gender)
select *
from CTE_Example;