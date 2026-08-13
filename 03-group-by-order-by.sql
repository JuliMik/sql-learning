-- ============================================
-- GROUP BY & ORDER BY Practice
-- Table: parks_and_recreation
-- ============================================

-- View all raw data before grouping (baseline reference)
select * 
from parks_and_recreation.employee_demographics;

-- GROUP BY with AVG: average age per gender
select gender, avg(age)
from parks_and_recreation.employee_demographics
group by gender;

-- View all raw salary data before grouping (baseline reference)
select *
from parks_and_recreation.employee_salary;

-- GROUP BY with multiple columns: unique occupation + salary combinations
select occupation, salary
from parks_and_recreation.employee_salary
group by occupation, salary;

-- GROUP BY with multiple aggregate functions at once
select gender, avg(age), max(age), min(age), count(age) 
from parks_and_recreation.employee_demographics
group by gender;

-- ORDER BY: sort results by first name, descending (Z to A)
select * 
from parks_and_recreation.employee_demographics
order by first_name desc;

-- ORDER BY multiple columns: gender ascending, then age descending within each gender
select * 
from parks_and_recreation.employee_demographics
order by gender, age desc;

-- ORDER BY multiple columns: age ascending, then gender ascending. 
-- Note: gender has no visible effect here since ages are unique — 
-- the second sort key only matters when there are ties in the first column
select * 
from parks_and_recreation.employee_demographics
order by age, gender;

-- ORDER BY using column position instead of name (5th column, then 4th column).Bad practice example
select * 
from parks_and_recreation.employee_demographics
order by 5, 4;