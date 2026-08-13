#Basic SELECT: view all columns from a table
select*
from parks_and_recreation.employee_demographics;

#SELECT specific columns + calculated column (age + 10)
select employee_id, first_name, age, age + 10
from parks_and_recreation.employee_demographics;

#DISTINCT: get unique values only (no duplicates)
select distinct first_name, gender
from parks_and_recreation.employee_demographics;