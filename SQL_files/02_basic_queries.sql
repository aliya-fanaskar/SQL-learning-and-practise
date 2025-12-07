/*
-------------------------------------------------------------------------------------------------------------------------------
Filename         : 02_basic_queries.sql
Level            : Basic
Concepts covered : Basic SELECT, LIMIT-OFFSET, Aliasing, WHERE clause, Logical Operators, 
                   IN, NOT, IN, DISTINCT, ORDER BY clause, LIKE, NOT LIKE.
-------------------------------------------------------------------------------------------------------------------------------
*/

USE company;         -- select the database

SHOW TABLES;         -- list of all tables in database
/*  Practising mostly from 'employee' table and 'employee_info' table in this section.*/

DESC employee;       -- give details about a table


-- --------------------------------------------------------------------------------------------------------------------------------
# 1 - Basic SELECT statement 
-- --------------------------
/* The SQL SELECT statement returns a result set of rows, from one or more tables. 
It retrieves zero or more rows from one or more database tables or database views. */

-- Display all rows of a table
SELECT * FROM employee;
SELECT * FROM employee_info;
SELECT * FROM bonus;

-- Display specific columns of a table
SELECT first_name, last_name, job_title, salary FROM employee;
SELECT emp_id, city, dob FROM employee_info;     -- can rearrange the columns however you want


-- --------------------------------------------------------------------------------------------------------------------------------
# 2 - LIMIT, OFFSET 
-- -------------------
/* 'LIMIT' and 'OFFSET' clauses are used to control the number of rows 
returned by a SELECT query and to specify the starting point for retrieving those rows.
- The 'LIMIT' clause restricts the maximum number of rows returned by a query.
- The 'OFFSET' clause specifies the number of rows to skip from the beginning of the result set before starting to return rows.*/

-- Display first 5 Records of table
SELECT * FROM employee LIMIT 5;

-- Display first 5 Records of table from the second row
SELECT * FROM employee LIMIT 5 OFFSET 1;


-- --------------------------------------------------------------------------------------------------------------------------------
# 3 - ALIASING 
-- -------------------
/* Aliasing refers to providing a short name to tables, columns, etc.*/

SELECT first_name AS employee_name from employee;

SELECT
	emp_id AS col_1,
    first_name AS col_2,
    last_name AS col_3,
    job_title AS col_4,
    salary AS col_5,
    joining_date AS col_6,
    dept_id AS col_7,
    manager_id AS col_8,
    project_id AS col_9
FROM
	employee;


-- --------------------------------------------------------------------------------------------------------------------------------
# 4 - WHERE clause 
-- -------------------
/* used to filter records based on specified conditions to only those that satisfy the given criteria.*/

SELECT * FROM employee WHERE dept_id = 2;
SELECT * FROM employee_info WHERE city = 'Mumbai';
SELECT * FROM employee WHERE project_id IS NULL;
/*
Note: 
The `=` operator is standard comparison operator used to check for equality between two non-NULL values.
The `IS` operator is specificaly designed for evaluating 'NULL' values.
*/

-- --------------------------------------------------------------------------------------------------------------------------------
# 5 - Logical Operators for multiple conditions (AND, OR, NOT)
-- -------------------------------------------------------------

SELECT * FROM employee WHERE dept_id = 3 AND project_id IS NOT NULL;   -- employees of dept 03 and working under some project
SELECT * FROM employee WHERE manager_id IS NULL AND salary > 40000;    -- employees with no manager and salary more than 40000
SELECT * FROM employee_info WHERE city = 'Mumbai' OR city = 'Delhi';   -- employees from Mumbai city or Delhi city 


-- --------------------------------------------------------------------------------------------------------------------------------
# 6 - IN, NOT IN 
-- -------------------
/* The SQL 'IN' and 'NOT IN' operators are used to filter results 
based on whether a value matches or does not match any value in a specified list or subquery.*/

SELECT * FROM employee WHERE last_name IN ('Sharma', 'Kapoor', 'Singh', 'Khan', 'Mehra', 'Joshi');
SELECT * FROM employee WHERE last_name NOT IN ('Sharma', 'Kapoor', 'Singh', 'Khan', 'Mehra', 'Joshi');
SELECT * FROM employee_info WHERE city IN ('Mumbai', 'Delhi', 'Bangalore');


-- --------------------------------------------------------------------------------------------------------------------------------
# 7 - DISTINCT 
-- -------------
/* return only unique or distinct values from one or more columns, eliminating duplicate rows from the result set.*/ 

-- Display Unique City Values
SELECT DISTINCT city FROM employee_info;

-- Counting Distinct Projects
-- the COUNT() function counts the number of rows or non-NULL values in a specified column
SELECT COUNT(project_id) AS project_workers FROM employee;            -- will simply count the no. of rows in the table causing count of repetitions as well
SELECT COUNT(DISTINCT project_id) AS unique_projects FROM employee;   -- will give a count of unique project_id's.

-- Counting Distinct last names
SELECT COUNT(DISTINCT last_name) AS unique_lastnames FROM employee;


-- --------------------------------------------------------------------------------------------------------------------------------
# 8 - ORDER BY clause 
-- -------------------
/* used to sort the result set of a SELECT statement based on one or more columns 
in a specific order, either ascending (ASC) or descending (DESC). Default is ASC*/

-- order table records by employee first name
SELECT * FROM employee ORDER BY first_name;

-- Display only last 5 Records of a Table.
SELECT * FROM employee ORDER BY emp_id DESC LIMIT 5;

-- Display last record of the table.
SELECT * FROM employee ORDER BY emp_id DESC LIMIT 1;

-- Display second-last record of the table.
SELECT * FROM employee ORDER BY emp_id DESC LIMIT 1 OFFSET 1;


-- --------------------------------------------------------------------------------------------------------------------------------
# 9 - LIKE, NOT LIKE 
-- -------------------
/* The 'LIKE' operator in SQL is used in a WHERE clause to search for a specified string pattern in a column.*/

SELECT * FROM employee WHERE last_name LIKE 'Jain';
SELECT * FROM employee_info WHERE city NOT LIKE 'Mumbai';

/*
# Difference between `last_name = 'Jain'` and `last_name LIKE 'Jain'`?

In MySQL, the difference between these two when used in a WHERE clause 
lies primarily in their function and how the database engine processes them:

- last_name = 'Jain'
This is a standard equality comparison and the most direct way to check for an exact match.
It tests if the value in the last_name column is exactly equal to the string 'Kumar'

- last_name LIKE 'Jain'
This is a string pattern matching operation.
It tests if the value in the last_name column matches the specified pattern.

'LIKE' operator is usually used with wildcards for partial string pattern matching 
When used without any wildcard characters, as in this example, LIKE 'Jain' behaves identically to name = 'Jain'
...Wildcards are discussed in another file dedicated for the topic
*/
