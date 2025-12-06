/*
---------------------------------------------------------------------------------------------------------------------------
Filename         : 04_group_by_and_having.sql
Level            : Intermediate
Concepts covered : GROUP BY clause, GROUP_CONCAT function, HAVING clause
---------------------------------------------------------------------------------------------------------------------------
*/

USE company;          -- select the database
SELECT * FROM employee LIMIT 5;


-- ---------------------------------------------------------------------------------------------------------------------------------------------
# GROUP BY clause
-- ---------------
/*The GROUP BY clause in SQL is used to group rows that have the 
same values in one or more specified columns into summary rows. 
This is frequently used in conjunction with aggregate functions 
to perform calculations on these grouped data. */

-- For Example: To get the count of employees from Mumbai city, we write the following query
SELECT COUNT(*) AS Mumbai_based_emps FROM employee WHERE city = 'Mumbai';

-- similarly, To get the count of employees in the Admin department, we write the following query
SELECT count(*) AS admin_dept_count FROM employee WHERE department = 'Admin';

-- But what if we need the total count of employees from each city altogether? This is where the GROUP BY is used 
SELECT
	city,
    count(*)
FROM employee
GROUP BY city;

-- Keep in mind that all non-aggregated columns in the SELECT list must appear in the GROUP BY clause


-- Display the no. of employees in each department
SELECT
	department, 
    COUNT(*) 
FROM employee 
GROUP BY department;


-- count of employee last names
SELECT 
	last_name,
    COUNT(*) AS nos
FROM employee
GROUP BY last_name;


-- Good practise to alias columns and order the table rows according to counts for better readability
SELECT 
	department AS dept, 
    COUNT(*) AS No_of_employees
FROM employee
GROUP BY department
ORDER BY No_of_employees;


-- Count of employees in different departments from Mumbai city.
SELECT 
	department,
    COUNT(*) AS from_Mumbai
FROM employee
WHERE city = 'Mumbai'
GROUP BY department
ORDER BY from_Mumbai;


-- get each department's count of employees, total salaries and highest and lowest salary
SELECT 
	department AS dept, 
    COUNT(*) AS nos,
    SUM(salary) AS dept_cost,
    MAX(salary) AS highest_pay,
    MIN(salary) AS lowest_pay
FROM employee
GROUP BY department
ORDER BY nos;


-- From which city does the company have the highest number of employees?
SELECT 
	city,
    COUNT(*) AS nos
FROM employee
GROUP BY city
ORDER BY nos DESC
LIMIT 1;


-- From which city does the company have the lowest number of employees?
SELECT 
	city,
    COUNT(*) AS nos
FROM employee
GROUP BY city
ORDER BY nos
LIMIT 1;


-- Write a query to display the count of employees for every unique department and city pair. 
SELECT
	department,
    city,
    count(*) as nos
FROM employee
GROUP BY department, city
ORDER BY nos, department;


-- ---------------------------------------------------------------------------------------------------------------------------------------------
# GROUP_CONCAT
/* 
This function in MySQL is used to combine multiple values from different rows into a single string.
It’s especially useful when summarizing grouped data or displaying related values in one line.
In short, it concatenates values from a column into a single string, typically used with GROUP BY 

SYNTAX :- GROUP_CONCAT([DISTINCT] expression [ORDER BY expression ASC|DESC] [SEPARATOR separator])
	DISTINCT → Removes duplicate values before concatenation
    ORDER BY → Sorts values within each group
    SEPARATOR → Defines the string separator (default is a comma ,)
*/
-- get the names of employees from each list
SELECT 
	city,
    GROUP_CONCAT(first_name) 
FROM employee 
GROUP BY city;  -- group by discussed in another file

SELECT 
	city,
    GROUP_CONCAT(first_name ORDER BY first_name SEPARATOR ', ') 
FROM employee 
GROUP BY city;  -- group by discussed in another file


-- get the department-wise count of employees and their full names
SELECT 
	department,
    COUNT(*) AS frequency,
    GROUP_CONCAT(CONCAT(first_name, ' ', last_name) ORDER BY first_name SEPARATOR ', ') AS employee_names
FROM employee 
GROUP BY department
ORDER BY frequency;  -- group by discussed in another file


-- ---------------------------------------------------------------------------------------------------------------------------------------------
# HAVING Clause
-- -------------
/* The HAVING clause in SQL is used to filter groups of rows 
based on a specified condition, typically involving aggregate functions. 
It is used in conjunction with the GROUP BY clause.*/

-- For Example: To get the count of employees in each department, we write the following query
SELECT
	department,
    count(*)
FROM employee
GROUP BY department;

 -- However to get the count of employees from department(s) with only 2 employees.
SELECT 
	department,
    COUNT(*) AS frequency
FROM employee
GROUP BY department
HAVING frequency = 2;

/* Unlike the WHERE clause, which filters individual rows before grouping, 
HAVING filters the results after the GROUP BY clause has aggregated the data into groups.
Keep in mind that WHERE filters rows before grouping, while HAVING filters groups after aggregation*/

-- Display the number of employees from each city and filter only those cities having 5 or more employees.
SELECT
	city, 
    COUNT(*) AS employees
FROM employee 
GROUP BY city
HAVING employees >= 5;


-- Display the number of employees from each city and filter only those cities having employees between the range of 3 to 6.
SELECT
	city, 
    COUNT(*) AS employees
FROM employee 
GROUP BY city
HAVING employees BETWEEN 3 AND 6;


-- Department-wise total salaries
SELECT
	department, 
    SUM(salary) AS dept_cost
FROM employee 
GROUP BY department
ORDER BY dept_cost;

-- Department with total salary more than 1,000,000
SELECT
	department, 
    SUM(salary) AS dept_cost
FROM employee 
GROUP BY department
HAVING dept_cost > 1000000
ORDER BY dept_cost;


-- Write a query to display the number of employees working in each department and city.
-- Show only those department–city combinations where the count of employees is greater than 1. 
SELECT
	department,
    city,
    count(*) AS nos
FROM employee
GROUP BY department, city
HAVING nos > 1
ORDER BY department;


-- Query to find repeated last names and show how many employees share each one
SELECT 
	last_name,
    COUNT(*) AS frequency
FROM employee
GROUP BY last_name
HAVING frequency > 1;
