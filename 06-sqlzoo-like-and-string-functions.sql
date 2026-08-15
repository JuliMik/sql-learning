-- ============================================
-- SQLZoo Practice — LIKE Operator & String Functions
-- Source: sqlzoo.net (world database)
-- ============================================

-- Q1: Find the country that starts with "Y"
SELECT name FROM world
WHERE name LIKE 'Y%';

-- Q2: Find the countries that end with "y"
SELECT name FROM world
WHERE name LIKE '%y';

-- Q3: Find the countries that contain the letter "x"
SELECT name FROM world
WHERE name LIKE '%x%';

-- Q4: Find the countries that end with "land"
SELECT name FROM world
WHERE name LIKE '%land';

-- Q5: Find the countries that start with "C" and end with "ia"
SELECT name FROM world
WHERE name LIKE 'C%ia';

-- Q6: Find the country that has "oo" in the name
SELECT name FROM world
WHERE name LIKE '%oo%';

-- Q7: Find the countries that have three or more "a" in the name
SELECT name FROM world
WHERE name LIKE '%a%a%a%';

-- Q8: Find the countries that have "t" as the second character
-- (underscore _ = single character wildcard)
SELECT name FROM world
WHERE name LIKE '_t%'
ORDER BY name;

-- Q9: Find the countries that have two "o" characters separated by exactly two other characters
SELECT name FROM world
WHERE name LIKE '%o__o%'
ORDER BY name;

-- Q10: Find the countries that have exactly four characters in the name
SELECT name FROM world
WHERE name LIKE '____';

-- Q11: Find the country where the name is the same as the capital city
SELECT name
FROM world
WHERE name LIKE capital;

-- Q12: Find the country where the capital is the country name plus "City"
-- (e.g. Mexico -> Mexico City)
SELECT name
FROM world
WHERE capital LIKE CONCAT(name, " City");

-- Q13: Find the capital and name where the capital includes the country name anywhere within it
SELECT capital, name
FROM world
WHERE capital LIKE CONCAT("%", name, "%");

-- Q14: Find the capital and name where the capital is an extension of the country name
-- Includes Mexico City (longer than Mexico), excludes Luxembourg (capital = country name exactly)
SELECT capital, name
FROM world
WHERE capital LIKE CONCAT(name, "_%");

-- Q15: Show the name and the "extension" part where the capital is a proper (non-empty) 
-- extension of the country name (e.g. Monaco -> Monaco-Ville -> extension "-Ville")
-- Logic: REPLACE removes the country name from the capital; 
-- filters out cases with no match (unchanged) and cases with no leftover text (empty)
SELECT name, REPLACE(capital, name, "") AS extension
FROM world
WHERE capital != REPLACE(capital, name, "")
AND REPLACE(capital, name, "") != "";