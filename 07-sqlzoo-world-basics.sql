-- ============================================
-- SQLZoo Practice — World Tutorial Basics
-- Source: sqlzoo.net (world database)
-- ============================================

-- Q1: Basic SELECT — name, continent, and population of all countries
SELECT name, continent, population FROM world;

-- Q2: Filter with WHERE — countries with population of at least 200 million
SELECT name FROM world
WHERE population >= 200000000;

-- Q3: Calculate per capita GDP (GDP / population) for countries with population >= 200 million
SELECT name, GDP/population
FROM world
WHERE population >= 2E8;

-- Q4: Show population in millions for South America
SELECT name, population/1000000
FROM world
WHERE continent = "South America";

-- Q5: Filter by specific country names using IN
SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy');

-- Q6: Find countries with "United" in the name
SELECT name
FROM world
WHERE name LIKE '%United%';

-- Q7: OR condition — big by area (>3 million sq km) OR big by population (>250 million)
SELECT name, population, area
FROM world
WHERE area > 3000000 OR population > 250000000;

-- Q8: XOR — big by area OR big by population, but NOT both at the same time
-- (excludes countries that are big in both dimensions, e.g. China)
SELECT name, population, area
FROM world
WHERE area > 3000000 XOR population > 250000000;

-- Q9: ROUND — population in millions and GDP in billions, rounded to 2 decimal places, for South America
SELECT name, 
ROUND(population/1000000, 2), 
ROUND(GDP/1000000000, 2)
FROM world
WHERE continent = 'South America';

-- Q10: Trillion dollar economies — per-capita GDP rounded to the nearest 1000
-- Negative precision in ROUND (-3) rounds to the nearest thousand, not to 3 decimal places
SELECT name, ROUND(GDP/population, -3)
FROM world
WHERE GDP >= 1e12;

-- Q11: Countries where name and capital have the same number of characters (LENGTH)
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);

-- Q12: Countries where name and capital start with the same letter (LEFT), excluding identical name/capital
SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1) AND name <> capital;

-- Q13: Countries containing all 5 vowels (a, e, i, o, u) with no spaces in the name
-- Uses separate LIKE conditions joined with AND, since vowels don't need to appear in a fixed order
SELECT name
FROM world
WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' 
AND name LIKE '%o%' AND name LIKE '%u%' AND name NOT LIKE '% %';