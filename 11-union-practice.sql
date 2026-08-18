-- ============================================
-- UNION & UNION ALL Practice
-- Table: parks_and_recreation
-- ============================================

-- UNION: combine results from two tables, automatically removing duplicate rows
select first_name, last_name
from parks_and_recreation.employee_demographics
union
select first_name, last_name
from parks_and_recreation.employee_salary;

-- UNION ALL: same as above, but keeps duplicate rows instead of removing them
select first_name, last_name
from parks_and_recreation.employee_demographics
union all
select first_name, last_name
from parks_and_recreation.employee_salary;

-- UNION with custom labels: combine 3 different filtered queries into one labeled result set
select first_name, last_name, "Old Man" as label
from parks_and_recreation.employee_demographics
where age > 40 and gender = 'Male'
union
select first_name, last_name, "Old Lady" as label
from parks_and_recreation.employee_demographics
where age > 40 and gender = 'Female'
union
select first_name, last_name, "Highly paid employee" as label
from parks_and_recreation.employee_salary
where salary > 70000
order by first_name, last_name;