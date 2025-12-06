/*
---------------------------------------------------------------------------------------------------------------------------
Filename         : 03_basic_function_types.sql
Level            : Intermediate
Concepts covered :
  1. Text Functions
  2. Numeric Functions
  3. Date and Time Fumctions
  4. Aggregate Functions
---------------------------------------------------------------------------------------------------------------------------
*/

-- ---------------------------------------------------------------------------------------------------------------------------------------------
# 1 - TEXT Functions - to manipulate textual data
-- -----------------------------------------------
-- LENGTH(str) - Returns the number of bytes in a string (for most text, same as number of characters)
SELECT LENGTH('MySQL Practise');   -- 14

-- CHAR_LENGTH(str) / CHARACTER LENGTH(str) - Returns the number of characters in a string
SELECT CHAR_LENGTH('MySQL Practise');   -- 14

-- UPPER(str) / UCASE(str) and LOWER(str) / LCASE(str) - Converts all characters in a string to uppercase and lowercase respectively
SELECT UPPER('data science');  -- 'DATA SCIENCE'
SELECT LOWER('HELLO WORLD');   -- 'hello world'

-- CONCAT(str1, str2, str3, ...) - Joins two or more strings together
SELECT CONCAT('Data', ' ', 'Science');  -- 'Data Science'

-- CONCAT_WS(seperator, str1, str2, ...) - Concatenates strings with a specified separator
SELECT CONCAT_WS('-', '2025', '11', '02');   -- 2025-11-02

-- LEFT(str, n), RIGHT(str, n) - Returns the first or last n characters from the string respectively
SELECT LEFT('DataScience', 4);   -- 'Data'
SELECT RIGHT('DataScience', 7);  -- 'Science'
 
-- SUBSTRING(str, start, length) - Extracts a portion of the string starting at a specific position (indexing from 1)
SELECT SUBSTRING('Analytics', 2, 4);  -- 'naly'

-- LOCATE(substr, str) / POSITION(substr IN str) - Finds the position of a substring within another string
SELECT LOCATE('a', 'Data');  -- 2

-- INSTR(str, substr) - Returns the position of the first occurrence of substr in str
SELECT INSTR('Database', 'base');  -- 5

-- REPLACE(str, from_str, to_str) - Replaces all occurrences of a substring with another substring
SELECT REPLACE('SQL Basics', 'Basics', 'Functions');  -- 'SQL Functions'

-- TRIM(str) - Removes spaces (or specified characters) from both ends of a string
SELECT TRIM('   MySQL   ');  -- 'MySQL'
SELECT TRIM(BOTH 'x' FROM 'xxxDataxxx');  -- 'Data'


-- LTRIM(str) / RTRIM(str) - Removes spaces from the left or right side of a string
SELECT LTRIM('   SQL');    -- 'SQL'
SELECT RTRIM('MySQL   ');  -- 'MySQL'

-- REVERSE(str) - Reverses the order of characters in a string
SELECT REVERSE('SQL');   -- 'LQS'

-- REPEAT(str, count) - Repeats a string a specified number of times
SELECT REPEAT('Hi ', 3);  -- 'Hi Hi Hi '

-- SPACE(n) - Returns a string of n spaces
SELECT CONCAT('MySQL', SPACE(3), 'Course');   -- 'MySQL   Course'

-- LPAD(str, len, padstr) / RPAD(str, len, padstr) - Pads a string to a certain length from the left or right
SELECT LPAD('7', 3, '0');    -- '007'
SELECT RPAD('SQL', 6, '!');  -- 'SQL!!!'


-- ---------------------------------------------------------------------------------------------------------------------------------------------
# 2 - NUMERIC Functions - work with numeric data and=perform arithmetic operations
-- --------------------------------------------------------------------------------
-- ABS() - Returns the absolute (positive) value of a number
SELECT ABS(-25);   -- 25

-- CEIL(x) / CEILING(x) - Returns the smallest integer greater than or equal to x
SELECT CEIL(4.3);   -- 5

-- FLOOR(x) - Returns the largest integer less than or equal to x
SELECT FLOOR(4.7);  -- 4

-- ROUND(x, d) - Rounds the number x to d decimal places
SELECT ROUND(3.1253, 2);   -- 3.13
SELECT ROUND(3.1223, 2);   -- 3.12
SELECT ROUND(25.5657, 0);  -- 26
SELECT ROUND(25.3657, 0);  -- 25

-- TRUNCATE(x, d) - Truncates a number x to d decimal places without rounding. Unlike ROUND(), it just cuts off digits beyond the specified decimal point
SELECT TRUNCATE(3.1253, 2);  -- 3.12

-- MOD(x, y) / x % y - Returns the remainder when x is divided by y
SELECT MOD(10, 3);  -- 1

-- POWER(x, y) / POW(x, y) - Returns x raised to the power of y
SELECT POWER(2, 3);  -- 8
SELECT POW(5, 2);    -- 25
SELECT POWER(10, 5); -- 100000

-- SQRT(x) - Returns the square root of x
SELECT SQRT(25);  -- 5

-- SIGN(x) - Returns the sign of a number, useful for identifying whether values are positive or negative.
/* 1 if x is positive
   0 if x is zero
  -1 if x is negative */
SELECT SIGN(-45);  -- -1
SELECT SIGN(26);   -- 1
SELECT SIGN(0);    -- 0

-- RAND() - Generates a random floating-point number between 0 and 1
SELECT RAND();

-- Can be combined with ROUND() to generate random integers
SELECT ROUND(RAND(), 2);
SELECT ROUND(RAND() * 10);  -- Random integer between 0 and 10

-- RAND(n) - Returns same random number each time (seeded)
SELECT RAND(10);

# combining multiple mathematical functions to calculate Hypotenuse.
SELECT ROUND(SQRT(POWER(3, 2) + POWER(4, 2)), 2) AS Hypotenuse;   -- 5


-- ---------------------------------------------------------------------------------------------------------------------------------------------
# 3 - DATE and TIME Functions - work with dates and timestamps
-- ------------------------------------------------------------
-- NOW() - Returns the current date and time of the system
SELECT NOW();

-- CURDATE() / CURRENT_DATE() - Returns the current date only
SELECT CURDATE();

-- CURTIME() / CURRENT_TIME() - Returns the current time only
SELECT CURTIME();

-- SYSDATE() - Returns the time at the exact moment the query is executed
-- NOW() and SYSDATE() differ slightly when used multiple times in the same statement — NOW() is constant, SYSDATE() updates dynamically.
SELECT SYSDATE();

-- DATE(expr) - Extracts and returns the date part from a datetime value
SELECT DATE('2025-11-02 15:30:00');   -- 2025-11-02

-- TIME(expr) - Extracts and returns the time part from a datetime value
SELECT TIME('2025-11-02 15:30:00');   -- 15:30:00

-- YEAR(date), MONTH(date), DAY(date) - Extracts year, month, or day components from a date
SELECT YEAR('2025-11-02');   -- 2025
SELECT MONTH('2025-11-02');  -- 11
SELECT DAY('2025-11-02');    -- 2

-- HOUR(time), MINUTE(time), SECOND(time) - Extracts time components from a time or datetime value
SELECT HOUR('15:45:22');    -- 15
SELECT MINUTE('15:45:22');  -- 45
SELECT SECOND('15:45:22');  -- 22

-- DATE_FORMAT(date, format) - Formats a date or datetime into a specific string pattern
/* Common format specifiers:
%Y = year (4 digits), 
%m = month (2 digits), 
%M = month name, 
%d = day, 
%H = hour (24h), 
%i = minute, 
%s = second*/
SELECT DATE_FORMAT('2025-11-02', '%M %d, %Y');     -- November 02, 2025
SELECT DATE_FORMAT('2025-11-02', '%d-%m-%y');      -- 02-11-25
SELECT DATE_FORMAT('2025-11-02', '%d %M, %Y');     -- 02 November, 2025
SELECT DATE_FORMAT('2025-11-02', 'Date is %d, Month is %M and Year is %Y') AS statement;

-- DAYNAME(date) / MONTHNAME(date) - Returns the weekday or month name
SELECT DAYNAME('2025-11-02');    -- Sunday
SELECT MONTHNAME('2025-11-02');  -- November

-- STR_TO_DATE(str, format) - Parses a string into a date using a specific format
SELECT STR_TO_DATE('02-11-2025', '%d-%m-%Y');    -- 2025-11-02
SELECT STR_TO_DATE('02-11-2025', '%m-%d-%Y');    -- 2025-02-11

SELECT MONTHNAME(STR_TO_DATE('02-11-2025', '%m-%d-%Y'));  -- February
SELECT MONTHNAME(STR_TO_DATE('02-11-2025', '%d-%m-%Y'));  -- November

-- DATEDIFF(date1, date2) - Returns the difference (in days) between two dates
SELECT DATEDIFF('2025-11-10', '2025-11-02');     -- 8

-- TIMEDIFF(time1, time2) - Returns the difference between two time or datetime values
SELECT TIMEDIFF('15:30:00', '14:00:00');     -- 01:30:00

-- ADDDATE(date, INTERVAL n unit) / DATE_ADD(date, INTERVAL n unit) - Adds a time interval to a date
SELECT ADDDATE('2025-11-02', INTERVAL 5 DAY);    -- 2025-11-07
SELECT ADDDATE('2025-11-02', INTERVAL 2 MONTH);  -- 2026-01-02

-- SUBDATE(date, INTERVAL n unit) / DATE_SUB(date, INTERVAL n unit) - Subtracts a time interval from a date
SELECT SUBDATE('2025-11-02', INTERVAL 10 DAY);   -- 2025-10-23

-- EXTRACT(unit FROM date) - Extracts specific part (unit) from a date or datetime
SELECT EXTRACT(YEAR FROM '2025-11-02');    -- 2025
SELECT EXTRACT(MONTH FROM '2025-11-02');   -- 11

-- LAST_DAY(date) - Returns the last day of the month for a given date
SELECT LAST_DAY('2025-11-02');     -- 2025-11-30

-- MAKEDATE(year, day_of_year) - Returns a date based on the year and day number
SELECT MAKEDATE(2025, 60);   -- 2025-03-01
SELECT MAKEDATE(2025, 365);  -- 2025-12-31

-- MAKETIME(hour, minute, second) - Creates a time value from hour, minute, and second
SELECT MAKETIME(10, 30, 45);   -- 10:30:45

-- UTC_DATE() / UTC_TIME() / UTC_TIMESTAMP() - Returns the current date/time in UTC (Coordinated Universal Time)
SELECT UTC_DATE();
SELECT UTC_TIME();
SELECT UTC_TIMESTAMP();


-- ---------------------------------------------------------------------------------------------------------------------------------------------
# 4 - AGGREGATE Functions - summarize groups of records i.e. perform calculations on a set of rows and return a single summary value
-- ----------------------------------------------------------------------------------------------------------------------------------
USE company;          -- select the database

-- COUNT() - Counts the number of rows or non-NULL values in a specified column
SELECT COUNT(*) FROM employee;
SELECT COUNT(DISTINCT(department)) FROM employee;

-- MAX() - Retrieves the maximum value from a specified column
SELECT MAX(salary) AS highest FROM employee;

-- MIN() - Retrieves the minimum value from a specified column
SELECT MIN(salary) AS lowest FROM employee;

-- SUM() - Calculates the total sum of values in a numerical column
SELECT SUM(salary) AS total_salary FROM employee;

-- AVG() - Calculates the average value of a numerical column
SELECT AVG(salary) AS avg_salary FROM employee;
SELECT ROUND(AVG(salary), 1) AS avg_salary FROM employee;


-- ---------------------------------------------------------------------------------------------------------------------------------------------
# using Basic Functions in table queries

-- Get the list of Distinct Cities and count the number of characers in each city word.
SELECT DISTINCT(city), LENGTH(city) AS characters FROM employee ORDER BY characters;

-- Display firstnames and lastnames of employees in Uppercase and city names in lower case
SELECT 
	upper(first_name) AS F_Name, 
    upper(last_name) AS L_Name,
    lower(city) AS dept
FROM employee;

-- Join the firstname and lastname of employees (First five rows)
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employee LIMIT 5;

-- Join the firstname, lastname and city with '-' and joining seperator. (First five rows)
SELECT CONCAT_WS('-', first_name, last_name, city) FROM employee LIMIT 5;

-- Display the first 3 characters of employee firstnames (First five rows)
SELECT LEFT(first_name, 3) FROM employee LIMIT 5;

-- Display the last 3 characters of unique city names (First five rows)
SELECT RIGHT(CITY, 3) FROM employee LIMIT 5;

-- Display only 3 characters from the 4th character of employee lastnames 
SELECT SUBSTR(last_name, 4, 3) FROM employee LIMIT 5;

-- Get the position of the letter 'a' from employee firstnames (First five rows)
SELECT first_name, INSTR(first_name, 'a') FROM employee LIMIT 5;     -- give position of first occurence in case of repetition
SELECT first_name, POSITION('a' IN first_name) FROM employee LIMIT 5;

-- Replace the letter 'a' with '@' from employee firstnames (First five rows)
SELECT REPLACE(first_name, 'a', '@') FROM employee LIMIT 5;

-- Replace the letter 'i' with '-!-' from employee firstnames (First five rows)
SELECT REPLACE(first_name, 'i', '-!-') FROM employee LIMIT 5;

-- Reverse the employee firstnames (First five rows)
SELECT REVERSE(first_name) FROM employee LIMIT 5;

-- Get the total sum of salaries of all employees
SELECT SUM(salary) AS Total_Salary FROM employee;

-- Get the sum of salaries of all employees in HR dept
SELECT department, SUM(salary) AS HR_cost FROM employee WHERE department = 'HR';

-- Get the sum of salaries of all Mumbai employees
SELECT city, MAX(salary) AS Mumbai_highest FROM employee WHERE city = 'Mumbai';

-- Write SQL Query to Show Only Even Rows from a Table.
SELECT * FROM employee WHERE emp_id % 2 = 0;

-- Write SQL Query to Show Only Odd Rows from a Table.
SELECT * FROM employee WHERE emp_id % 2 != 0;
SELECT * FROM employee WHERE emp_id % 2 <> 0;

-- Display employees info whose Salary is between 200000 & 400000
SELECT * FROM employee WHERE salary BETWEEN 200000 AND 400000;

-- Fetch employee full names  and their salaries whose Salaries is between 50000 to 100000
SELECT CONCAT(first_name, ' ', last_name) AS employee_name, salary
FROM employee
WHERE salary BETWEEN 50000 AND 100000
ORDER BY salary;

-- employees who joined in Jan 2025.
SELECT * FROM employee WHERE YEAR(joining_date) = 2025 AND MONTH(joining_date) = 1;

-- employees who joined before 2024.
SELECT * FROM employee WHERE YEAR(joining_date) < 2024 ORDER BY joining_date;


# giving the table a cleaner look using these basic functions
SELECT * FROM employee LIMIT 10;

SELECT 
	LPAD(emp_id, 3, '0') AS id,                            -- padded the id number to 3 digits
    CONCAT(first_name, ' ', last_name) AS emp_fullname,    -- combined first name and last name
    DAY(joining_date) AS j_date,                           -- extracted date from joining date
    LEFT(MONTHNAME(joining_date),3) AS j_month,            -- extracted month from joining date
    YEAR(joining_date) AS j_year,                          -- extracted year from joining date
    ROUND((salary / 100000), 2) AS pay_in_lakhs,           -- converted salary figures in lakhs
    department AS area,
    UPPER(city) AS origin,
	CONCAT(TRUNCATE((DATEDIFF(CURDATE(), joining_date)/365),1), ' years') AS experience  -- new experience column
FROM employee
LIMIT 10;
