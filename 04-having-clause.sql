-- ============================================
-- HAVING Clause Practice
-- Table: parks_and_recreation
-- ============================================

-- HAVING filters groups AFTER aggregation
select gender, avg(age)
from parks_and_recreation.employee_demographics
group by gender
having avg(age) > 40;

-- Combine WHERE (filter rows first) + GROUP BY + HAVING (filter groups after)
select occupation, avg(salary)
from parks_and_recreation.employee_salary
where occupation like "%manager%"
group by occupation
having avg(salary) > 75000;