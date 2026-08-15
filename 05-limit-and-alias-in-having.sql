-- ============================================
-- LIMIT & Column Alias in HAVING Practice
-- Table: parks_and_recreation
-- ============================================

-- LIMIT with OFFSET: skip the first 2 rows, then return 1 row
select *
from parks_and_recreation.employee_demographics
order by age desc
limit 2, 1;

-- Using a column alias (avg_age) inside HAVING
select gender, avg(age) avg_age
from parks_and_recreation.employee_demographics
group by gender
having avg_age > 40;