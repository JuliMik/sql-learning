-- ============================================
-- JOIN Practice (INNER, LEFT, RIGHT, Self-Join, Multiple JOINs)
-- Table: parks_and_recreation
-- ============================================

-- View raw data before joining (baseline reference)
select *
from parks_and_recreation.employee_demographics;

select *
from parks_and_recreation.employee_salary;

-- INNER JOIN: combine both tables, only matching employee_id rows on both sides
select * 
from parks_and_recreation.employee_demographics as dem
inner join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
-- INNER JOIN with specific columns selected instead of *
select dem.employee_id, age, occupation
from parks_and_recreation.employee_demographics as dem
inner join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
-- LEFT JOIN: keep all rows from employee_demographics (left table), 
-- even if there's no matching row in employee_salary
select *
from parks_and_recreation.employee_demographics as dem
left join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
-- RIGHT JOIN: keep all rows from employee_salary (right table), 
-- even if there's no matching row in employee_demographics
select *
from parks_and_recreation.employee_demographics as dem
right join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
-- SELF JOIN: join a table to itself using a custom condition (here, employee_id + 1)
-- Used for the "Secret Santa" pairing exercise — matches each employee to the next one
select *
from parks_and_recreation.employee_salary as emp1
join parks_and_recreation.employee_salary as emp2
	on emp1.employee_id + 1 = emp2.employee_id;
    
-- SELF JOIN with clearer column aliases to distinguish the two "roles" 
-- (Santa = giver, emp = receiver) instead of showing all columns from both sides
select emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_id,
emp2.first_name as first_name_emp,
emp2.last_name as last_name_emp
from parks_and_recreation.employee_salary as emp1
join parks_and_recreation.employee_salary as emp2
	on emp1.employee_id + 1 = emp2.employee_id;

-- MULTIPLE JOINS: chain three tables together in one query
-- demographics + salary (by employee_id) + departments (by dept_id)
select *
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
join parks_and_recreation.parks_departments as pd
	on sal.dept_id = pd.department_id;