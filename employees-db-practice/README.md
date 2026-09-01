# Employees Database Practice

Practicing business-style SQL queries on a large, realistic dataset (300,000+ employee records, 2.8M+ salary records) — moving beyond syntax practice into interpreting and solving business questions.

## Database Source
[MySQL Employees Sample Database](https://github.com/datacharmer/test_db) — a standard test database with employees, departments, salaries, and job titles, commonly used for MySQL practice and testing.

## Schema Overview
- `employees` — employee personal details (name, birth date, hire date)
- `departments` — department names and codes
- `dept_emp` — links employees to departments, with `from_date`/`to_date` (current employees have `to_date = '9999-01-01'`)
- `salaries` — salary history per employee, same date-range pattern as above
- `titles` — job title history per employee

## Tasks

### 01 — Department Salary Overview
`01-department-salary-overview.sql`

**Task:** The HR department wants to understand the current company structure. For each department, show the department name, the number of current employees, and the average salary in that department. Sort from the department with the highest average salary to the lowest.

**Notes:**
- Employee-department relationships are stored in a separate `dept_emp` table
- "Current" employees are identified by `to_date = '9999-01-01'` in `dept_emp` (the same logic applies to `salaries` for current salary records)
- Assumption: "average salary" refers to current salaries only, not the full historical record — clarified this before writing the query, since the ambiguity would otherwise skew results toward outdated, lower salaries

### 02 — Department Tenure Overview
`02-department-tenure-overview.sql`

**Task:** Management wants to understand team experience levels across departments. For each department, show the department name, the number of current employees, and the average tenure (in years) at the company among current employees in that department. Sort from the department with the highest average tenure to the lowest.

**Notes:**
- Tenure is calculated from `employees.hire_date` (date joined the company) to today's date, using `TIMESTAMPDIFF(YEAR, ...)`
- Initially used `dept_emp.from_date` by mistake (date joined the *department*, not the company) — corrected after noticing tenure looked implausibly high (~33 years) across all departments
- Same "current employees" filter applies as in Task 01 (`to_date = '9999-01-01'`)

**Finding:** After correcting the date field, average tenure still came out nearly identical (~36 years) across every department. Investigated by sampling `employees.hire_date` directly, which showed hire dates in this sample dataset are concentrated within a narrow historical window (1985–1994). This is a data characteristic of the sample dataset, not a query error — tenure doesn't vary meaningfully by department here, since nearly all employees were hired in the same era.

## Key Skill Practiced
Working with **slowly changing dimension** tables (date-ranged records) — distinguishing "current" vs "historical" data using `to_date`, and clarifying ambiguous business requirements (e.g. "average salary" = current only, not full history) before writing the query.