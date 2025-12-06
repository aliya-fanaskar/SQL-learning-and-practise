/*
-------------------------------------------------------------------------------------------------------------------------------
Filename         : 02_basic_queries.sql
Level            : Basic
Concepts covered : Basic SELECT, LIMIT-OFFSET, Aliasing, WHERE clause, Logical Operators, 
                   IN, NOT, IN, DISTINCT, ORDER BY clause, LIKE, NOT LIKE.
-------------------------------------------------------------------------------------------------------------------------------
*/

SHOW DATABASES;       -- display the list of existing databases
USE company;          -- select the database
SHOW TABLES;          -- display the list of tables in that database
DESC employee;        -- give details about a table

# 1 - Basic SELECT ------------------------------------------------------------------------------------------------------------
-- Display full table
SELECT * FROM employee;
SELECT * FROM bonus;

-- Count no. of rows in a table.
SELECT COUNT(*) FROM employee;

-- Display specific columns
SELECT first_name, last_name, department FROM employee;
SELECT department, last_name, first_name, city FROM employee;     -- can rearrange the columns however you want


# 2 - LIMIT, OFFSET -----------------------------------------------------------------------------------------------------------
/* 'LIMIT' and 'OFFSET' clauses are used to control the number of rows 
returned by a SELECT query and to specify the starting point for retrieving those rows.
- The 'LIMIT' clause restricts the maximum number of rows returned by a query.
- The 'OFFSET' clause specifies the number of rows to skip from the beginning of the result set before starting to return rows.*/
-- Display first 5 Records of table
SELECT * FROM employee LIMIT 5;

-- Display first 5 Records of table from the second row
SELECT * FROM employee LIMIT 5 OFFSET 1;


# 3 - ALIASING ----------------------------------------------------------------------------------------------------------------
SELECT first_name AS employee_name from employee;

SELECT
	emp_id AS col_1,
    first_name AS col_2,
    last_name AS col_3,
    salary AS col_4,
    joining_date AS col_5,
    department AS col_6,
    city AS col_7
FROM
	employee;


# 4 - WHERE clause ------------------------------------------------------------------------------------------------------------
/* used to filter records based on specified conditions to only those that satisfy the given criteria.*/
SELECT * FROM employee WHERE first_name = 'Nikhil'; 
SELECT * FROM employee WHERE department = 'HR';


# 5 - Logical Operators for multiple conditions (AND, OR, NOT)-----------------------------------------------------------------
SELECT * FROM employee WHERE city = 'Bangalore' AND department = 'Accounts';   -- employees from Bangalore city working in Accounts dept
SELECT * FROM employee WHERE city = 'Mumbai' OR department = 'IT';            -- employees either from Mumbai city or in IT dept or both
SELECT * FROM employee WHERE NOT city = 'Pune' AND NOT department  = 'Admin'; -- employees neither from Pune city nor in Admin dept
SELECT * FROM employee WHERE department = 'IT' AND salary >= 200000;          -- employees of IT dept with salary more than or equal to 2 Lakhs
SELECT * FROM employee WHERE city = 'Mumbai' AND department IN ('HR', 'IT');  -- employees from Mumbai city but only of HR and IT dept 


# 6 - IN, NOT IN --------------------------------------------------------------------------------------------------------------
/* The SQL 'IN' and 'NOT IN' operators are used to filter results 
based on whether a value matches or does not match any value in a specified list or subquery.*/
SELECT * FROM employee WHERE first_name IN ('Amitabh', 'Rajesh', 'Satish', 'Raj', 'Gita');
SELECT * FROM employee WHERE first_name NOT IN ('Amitabh', 'Rajesh', 'Satish', 'Raj', 'Gita');


# 7 - DISTINCT ----------------------------------------------------------------------------------------------------------------
/* return only unique or distinct values from one or more columns, eliminating duplicate rows from the result set.*/ 
-- Display Unique Department Values
SELECT DISTINCT department FROM employee;

-- Display Unique City Values
SELECT 
	DISTINCT city AS name_of_emp
FROM employee;

-- Counting Distinct departments
-- the COUNT() function counts the number of rows or non-NULL values in a specified column
SELECT COUNT(department) AS depts FROM employee;          -- will simply count the no. of rows in the table causing count of repetitions as well
SELECT COUNT(DISTINCT(department)) AS unique_depts FROM employee;

-- Counting Distinct last names
SELECT COUNT(DISTINCT last_name) AS unique_lastnames FROM employee;


# 8 - ORDER BY clause --------------------------------------------------------------------------------------------------------
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


# 9 - LIKE, NOT LIKE ----------------------------------------------------------------------------------------------------------
/* The 'LIKE' operator in SQL is used in a WHERE clause to search for a specified string pattern in a column.*/
SELECT * FROM employee WHERE last_name LIKE 'Kumar';
SELECT * FROM employee WHERE city NOT LIKE 'Mumbai';

-- Difference between `last_name = 'Kumar'` and `last_name LIKE 'Kumar'`?
/* In MySQL, the difference between these two when used in a WHERE clause 
lies primarily in their function and how the database engine processes them:

last_name = 'Kumar'
This is a standard equality comparison and the most direct way to check for an exact match.
It tests if the value in the last_name column is exactly equal to the string 'Kumar'

last_name LIKE 'Kumar'
This is a pattern matching operation.
It tests if the value in the last_name column matches the specified pattern.
'LIKE' operator is primarily designed for partial matching using wildcards
When used without any wildcard characters, as in this example, LIKE 'Kumar' behaves identically to name = 'Kumar'

...Wildcards are discussed in another file dedicated for the topic
*/
