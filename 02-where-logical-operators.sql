-- ============================================
-- WHERE Clause & Logical Operators Practice
-- Table: parks_and_recreation
-- ============================================

-- Filter by exact text match (first name)
select *
from parks_and_recreation.employee_salary
where first_name = "Leslie";

-- Filter by numeric condition (salary threshold)
select *
from parks_and_recreation.employee_salary
where salary >= 50000;

-- Filter using "not equal" operator
select * 
from parks_and_recreation.employee_demographics
where gender != "Female";

-- Filter by date comparison (born after a specific date)
select *
from parks_and_recreation.employee_demographics
where birth_date > "1985-01-01";

-- Combine conditions using OR and NOT (Logical Operators)
select *
from parks_and_recreation.employee_demographics
where birth_date > "1985-01-01"
or not gender = "male";

-- Combine conditions using AND inside parentheses, plus OR
select *
from parks_and_recreation.employee_demographics
where (first_name = "Leslie" and age = 44) or age > 50;


-- LIKE Statement: pattern matching (birth years starting with 1989)
select *
from parks_and_recreation.employee_demographics
where birth_date like "1989%";