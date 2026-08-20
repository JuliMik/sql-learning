-- ============================================
-- CASE Statement Practice
-- Table: parks_and_recreation
-- ============================================

-- CASE WHEN: categorize employees into age brackets
select first_name, last_name, age,
case
	when age <= 30 then 'Young'
    when age between 31 and 50 then 'Good'
    when age >= 50 then "Old"
end as Age_Bracket
from parks_and_recreation.employee_demographics;

-- CASE WHEN: calculate a salary raise tier + a conditional bonus based on department
select first_name, last_name, salary,
case
	when salary < 50000 then salary * 1.05
    when salary > 50000 then salary * 1.07
    else salary
end as new_salary,
case
	when department_name = 'Finance' then salary * .10
    else salary = 0
end as Bonus
from parks_and_recreation.employee_salary as emp
join parks_and_recreation.parks_departments as dep
	on emp.dept_id = dep.department_id;