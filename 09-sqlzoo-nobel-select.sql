-- ============================================
-- SQLZoo Practice — SELECT from Nobel Tutorial
-- Source: sqlzoo.net (nobel database)
-- ============================================

-- Q1: Filter by year
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;

-- Q2: Filter by year AND subject
SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'literature';

-- Q3: Filter by winner name, return year and subject
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';

-- Q4: Filter by subject AND year range (>=)
SELECT winner
FROM nobel
WHERE subject = 'Peace'
AND yr >= 2000;

-- Q5: Filter by subject AND year range using BETWEEN
SELECT *
FROM nobel
WHERE subject = 'literature' 
  AND yr BETWEEN 1980 AND 1989;

-- Q6: Filter by a list of specific winners using IN
SELECT * 
FROM nobel
WHERE winner IN ('Theodore Roosevelt',
                  'Thomas Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama');

-- Q7: Filter using LIKE — winners whose first name is John
SELECT winner
FROM nobel
WHERE winner LIKE 'John%';

-- Q8: Combine two separate conditions with OR — physics 1980 OR chemistry 1984
-- Note: AND has higher precedence than OR, so no parentheses needed here,
-- but adding them improves readability
SELECT *
FROM nobel
WHERE subject = 'physics' AND yr = 1980
OR subject = 'chemistry' AND yr = 1984;

-- Q9: Exclude multiple subjects using NOT IN
SELECT *
FROM nobel
WHERE subject NOT IN ('chemistry', 'medicine') AND yr = 1980;

-- Q10: Combine two different subject/year conditions with OR
SELECT *
FROM nobel
WHERE subject = 'Medicine' AND yr < 1910
OR subject = 'Literature' AND yr >= 2004;

-- Q11: Umlaut — match a name containing a non-ASCII character (ü)
-- Solved using a hex literal X'C3BC', which represents the UTF-8 byte sequence for ü
-- (CHAR() with decimal codes and different collations caused mismatches — hex literal worked instead)
SELECT *
FROM nobel
WHERE winner = CONCAT('Peter Gr', X'C3BC', 'nberg');

-- Q12: Apostrophe in a name — use double quotes to safely wrap a string containing a single quote
SELECT *
FROM nobel
WHERE winner = "EUGENE O'NEILL";

-- Q13: Multi-column ORDER BY — winners starting with "Sir", most recent year first, then by name
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE "Sir%"
ORDER BY yr DESC, winner ASC;

-- Q14: Using a boolean expression (0/1) directly inside ORDER BY
-- subject IN ('chemistry','physics') evaluates to 1 (true) or 0 (false) per row;
-- sorting by this ascending pushes chemistry/physics (1) to the end, 
-- then subject and winner are used as secondary/tertiary sort keys
SELECT winner, subject
FROM nobel
WHERE yr = 1984
ORDER BY subject IN ('chemistry', 'physics'), subject, winner;