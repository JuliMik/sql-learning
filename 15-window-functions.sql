-- ============================================
-- Window Functions Practice (PARTITION BY, ROW_NUMBER, RANK, DENSE_RANK)
-- Table: parks_and_recreation
-- ============================================

-- PARTITION BY with AVG: average salary per gender, shown next to each individual row
-- Unlike GROUP BY, this keeps every row visible instead of collapsing into one row per group
select dem.first_name, dem.last_name, avg(salary) over(partition by gender)
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
	on dem.employee_id = sal.employee_id;
    
-- PARTITION BY + ORDER BY with SUM: running (rolling) total of salary within each gender group,
-- accumulating row by row in employee_id order
select dem.first_name, dem.last_name, salary,
sum(salary) over(partition by gender order by dem.employee_id) as Rolling_Total
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
	on dem.employee_id = sal.employee_id;
    
-- Comparing three ranking functions within each gender group, ordered by salary (highest first):
-- ROW_NUMBER: always unique, sequential (1,2,3,4...) even if salaries tie
-- RANK: ties share the same rank, but leaves a gap afterward (1,2,2,4...)
-- DENSE_RANK: ties share the same rank, with no gap afterward (1,2,2,3...)
select dem.employee_id, dem.first_name, dem.last_name, salary,
row_number() over(partition by gender order by salary desc) row_num,
rank() over(partition by gender order by salary desc) rank_num,
dense_rank() over(partition by gender order by salary desc) dense_rank_num
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
	on dem.employee_id = sal.employee_id;