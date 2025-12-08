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

-- For Example: To get the count of employees working under manager_id 7, we write the following query
SELECT COUNT(*) AS mgr_7_emps FROM employee WHERE manager_id = 7;

-- similarly, To get the count of employees working on project_id 105, we write the following query
SELECT COUNT(*) AS project105_emps FROM employee WHERE project_id = 105;

-- But what if we need the total count of employees working under each project altogether? This is where the GROUP BY is used 
SELECT
	project_id,
    count(*)
FROM employee
GROUP BY project_id;

-- to exclude the non-project workers count (i.e. NULL values count)
SELECT
	project_id,
    count(*)
FROM employee
WHERE project_id IS NOT NULL
GROUP BY project_id;

-- Keep in mind that all non-aggregated columns in the SELECT list must appear in the GROUP BY clause


-- Display the no. of employees from each city
SELECT
	city, 
    COUNT(*) 
FROM employee_info 
GROUP BY city;


-- count of employee last names
SELECT 
	last_name,
    COUNT(*) AS nos
FROM employee
GROUP BY last_name;


-- Good practise to alias columns and order the table rows according to counts for better readability
SELECT
	city, 
    COUNT(*) AS no_of_emps
FROM employee_info 
GROUP BY city
ORDER BY no_of_emps;


-- Count of employees in different departments from Mumbai city.
SELECT 
	salary,
    COUNT(*) AS pays
FROM employee
GROUP BY salary
ORDER BY pays;

select * from employee;

-- get each department's count of employees, total salaries and highest and lowest salary
SELECT 
	dept_id AS dept, 
    COUNT(*) AS nos,
    SUM(salary) AS dept_cost,
    MAX(salary) AS highest_pay,
    MIN(salary) AS lowest_pay
FROM employee
GROUP BY dept_id
ORDER BY nos;


-- From which city does the company have the highest number of employees?
SELECT 
	city,
    COUNT(*) AS nos
FROM employee_info
GROUP BY city
ORDER BY nos DESC
LIMIT 1;


-- From which city does the company have the lowest number of employees?
SELECT 
	city,
    COUNT(*) AS nos
FROM employee_info
GROUP BY city
ORDER BY nos
LIMIT 1;


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
    GROUP_CONCAT(emp_id) 
FROM employee_info
GROUP BY city;  

SELECT 
	city,
    GROUP_CONCAT(emp_id ORDER BY emp_id SEPARATOR ', ') 
FROM employee_info 
GROUP BY city;  


-- get the department-wise count of employees and their full names
SELECT 
	dept_id,
    COUNT(*) AS frequency,
    GROUP_CONCAT(CONCAT(first_name, ' ', last_name) ORDER BY first_name SEPARATOR ', ') AS employee_names
FROM employee 
GROUP BY dept_id
ORDER BY frequency;  

-- ---------------------------------------------------------------------------------------------------------------------------------------------
# HAVING Clause
-- -------------
/* The HAVING clause in SQL is used to filter groups of rows 
based on a specified condition, typically involving aggregate functions. 
It is used in conjunction with the GROUP BY clause.*/

-- For Example: To get the count of employees in each department, we write the following query
SELECT
	dept_id,
    count(*)
FROM employee
GROUP BY dept_id;

 -- However to get the count of employees from department(s) with only 3 employees.
SELECT 
	dept_id,
    COUNT(*) AS frequency
FROM employee
GROUP BY dept_id
HAVING frequency = 3;

/* Unlike the WHERE clause, which filters individual rows before grouping, 
HAVING filters the results after the GROUP BY clause has aggregated the data into groups.
Keep in mind that WHERE filters rows before grouping, while HAVING filters groups after aggregation*/

-- Display the number of employees from each city and filter only those cities having 2 or more employees.
SELECT
	city, 
    COUNT(*) AS employees
FROM employee_info 
GROUP BY city
HAVING employees >= 2;


-- Display the number of employees from each city and filter only those cities having employees between the range of 3 to 6.
SELECT
	city, 
    COUNT(*) AS employees
FROM employee_info 
GROUP BY city
HAVING employees BETWEEN 2 AND 3;


-- Department-wise total salaries
SELECT
	dept_id, 
    SUM(salary) AS dept_cost
FROM employee 
GROUP BY dept_id
ORDER BY dept_cost;

-- Department with total salary more than 1,00,000
SELECT
	dept_id, 
    SUM(salary) AS dept_cost
FROM employee 
GROUP BY dept_id
HAVING dept_cost > 100000
ORDER BY dept_cost;


-- Query to find repeated last names and show how many employees share each one
SELECT 
	last_name,
    COUNT(*) AS frequency
FROM employee
GROUP BY last_name
HAVING frequency > 1;

-- some more examples

SELECT 
	YEAR(dob) AS birth_year,
    COUNT(*) AS frequency
FROM employee_info
GROUP BY YEAR(dob)
ORDER BY birth_year;


SELECT 
	YEAR(joining_date) AS joined_in,
    COUNT(*) AS frequency
FROM employee
GROUP BY YEAR(joining_date);
