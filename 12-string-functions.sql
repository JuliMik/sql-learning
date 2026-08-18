-- ============================================
-- String Functions Practice (LENGTH, UPPER/LOWER, TRIM, LEFT/RIGHT, SUBSTRING, REPLACE, LOCATE, CONCAT)
-- Table: parks_and_recreation
-- ============================================

-- LENGTH: count the number of characters in a string
select length('skyfall');

-- LENGTH applied to a column, used to sort results by name length
select first_name, length(first_name) as len
from parks_and_recreation.employee_demographics
order by len;

-- UPPER / LOWER: change text case
select upper('sky');
select lower('SKY');

-- UPPER applied to a column
select first_name, upper(first_name)
from parks_and_recreation.employee_demographics;

-- TRIM: remove leading and trailing spaces from a string
select trim('        sky    ');

-- LEFT / RIGHT: extract a set number of characters from the start/end of a string
-- SUBSTRING: extract characters from a specific position (start, length)
-- Used here to pull the birth month (characters 6-7) out of a date stored as text
select first_name,
left(first_name, 4),
right(first_name, 4),
substring(first_name, 3, 2),
birth_date,
substring(birth_date, 6, 2) as birth_month
from parks_and_recreation.employee_demographics;

-- REPLACE: substitute all occurrences of one character/substring with another
select first_name, replace(first_name, 'a', 'z') 
from parks_and_recreation.employee_demographics;

-- LOCATE: find the position of a character/substring within a string (1-indexed)
select locate('l', 'Yuliia');

-- CONCAT: join first_name and last_name into a single full_name column, with a space between
select first_name, last_name,
concat(first_name, ' ', last_name) as full_name
from parks_and_recreation.employee_demographics;