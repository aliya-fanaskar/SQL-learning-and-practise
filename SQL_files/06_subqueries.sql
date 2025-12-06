/*
-------------------------------------------------------------------------------------------------------------------------------
Filename         : 06_subqueries.sql
Level            : Intermediate
Concepts covered : Introduction to Subquery, Handling ties with Subqueries, DENSE_RANK()
-------------------------------------------------------------------------------------------------------------------------------
*/

USE company;
SELECT * FROM employee LIMIT 5;

-- ---------------------------------------------------------------------------------------------------------------------------------------------
# Subquery
-- ---------
/* A subquery (also called an inner query or nested query) is a query inside another SQL query.
It is used to retrieve data that will be used by the main query (outer query) for further processing.
In simple words, it is a SELECT statement nested within another SQL statement.
The subquery executes first, and its result is then used by the outer query. 
Subqueries are enclosed in parentheses and can be used in various parts of a SQL statement,
including the SELECT, FROM, and WHERE clauses
*/
 
 # PROBLEM STATEMENT EXAMPLE
-- Find out the details of employees whose salary is more than the average salary.
SELECT * FROM employee WHERE salary > AVG(salary);  
/* this won't work because the aggregation functions can only be used in the SELECT or HAVING clause, 
not directly inside WHERE clause.
 
The WHERE clause filters rows before grouping or aggregation happens.
But AVG(salary) is an aggregate function that needs all rows to calculate the average —
so SQL cannot evaluate it before filtering.

That’s why MySQL doesn’t know what average you mean at that point. */

-- The Correct Way (with Subquery) - You need to compute the average first (in a subquery), and then use it to filter all the rows:
SELECT AVG(salary) FROM employee;   -- basic statement to compute the average salary

-- using subquery to the get the required result
SELECT * 
FROM employee 
WHERE salary > (
	SELECT AVG(salary)
    FROM employee
);

/* Now, the subquery runs first, finds the average salary value,
and then the outer query filters employees with salary above that value */

use company;
-- ---------------------------------------------------------------------------------------------------------------------------------------------
# Handling ties with Subqueries...
-- --------------------------------
-- Which department has the highest no. of employees?
SELECT department, COUNT(*) AS nos
FROM employee
GROUP BY department
ORDER BY nos DESC
LIMIT 1;

-- but if you check the count, there are ties... 
SELECT department, COUNT(*) FROM employee GROUP BY department ORDER BY COUNT(*) DESC;

-- to get the department(s) with the highest no. of employees, while also handling ties:

-- STEP 1: get the department-wise count. You will get a column list of count values
-- basic syntax: SELECT COUNT(*) FROM table GROUP BY col;
SELECT COUNT(*) AS dept_nos
FROM employee
GROUP BY department;

-- STEP 2: get the highest count from the column list of counts using max()
-- basic syntax: SELECT MAX(col) FROM table;
 SELECT MAX(dept_nos) 
 FROM (
	SELECT COUNT(*) AS dept_nos 
    FROM employee 
    GROUP BY department
    ) AS dept_count_table;  -- the column acts as 1D table so don't forget to ALIAS the derived-table

-- STEP 3: filter groups of rows from the entire employee table HAVING the max value.
-- basic syntax: SELECT cols FROM table GROUP BY col HAVING condtion;
SELECT department, count(*) AS nos 
FROM employee 
GROUP BY department
HAVING nos = (
	SELECT MAX(dept_nos)
    FROM (
		SELECT COUNT(*) AS dept_nos 
        FROM employee 
        GROUP BY department) AS dept_count_table
);


# MORE EXAMPLES --------------------------------------------------------------------------------------------------------------------------------

-- employee with lowest salary.
SELECT * FROM employee
ORDER BY salary
LIMIT 1;

-- employee with the lowest salary using subquery (handles ties)
SELECT MIN(salary) FROM employee;  -- minimum salary

SELECT * 
FROM employee
WHERE salary = (SELECT MIN(salary) FROM employee);


-- employee with highest salary from a specific department.
SELECT * 
FROM employee 
WHERE salary = (
	SELECT MAX(salary) 
    FROM employee 
    WHERE department = 'Admin'
);
/* You’ll get the employee(s) from the Admin department who earn the highest salary.
But, if multiple employees have that same top salary, all of them will be shown regardless of the department. 

If you want to make it more precise (i.e., show only Admin employees with that salary), you can modify it slightly */
SELECT * 
FROM employee 
WHERE department = 'Admin' 
AND salary = (
	SELECT MAX(salary) 
    FROM employee 
    WHERE department = 'Admin'
);


# Write SQL Query to List the Employee with the Second-Highest Salary.

-- Several ways to achieve this:

-- Method 1: using LIMIT, OFFSET - simple, works on all versions, doesn't handle ties
SELECT * FROM employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- Method 2: MAX() with subquery - reliable, works on all versions, handles ties, bit wordy
SELECT * FROM employee
WHERE salary = (
	SELECT MAX(salary)     -- highest salary
    FROM employee
    WHERE salary < (
		SELECT MAX(salary) -- 2nd highest salary
        FROM employee
	)
);

-- this method get lengthier as you increase the rank value.
-- so now if you want to get the 3rd highest salary, then there be an addition in the subquery level like this

-- 3rd highest salaried employee details
SELECT * FROM employee
WHERE salary = (
	SELECT MAX(salary)          -- highest salary
    FROM employee
    WHERE salary < (
		SELECT MAX(salary)      -- 2nd highest salary
        FROM employee
        WHERE salary < (
			SELECT MAX(salary)  -- 3rd highest salary
            FROM employee
		)
    )
);

-- thus, in cases like this, the DENSE_RANK() function comes to action

-- Method 3: DENSE_RANK()- modern and clean, works on MySQL 8 and above versions, handles ties
SELECT *
FROM (
	SELECT *, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employee
) AS ranked
WHERE rnk = 1;

-- you can enter any rank you want
SELECT *
FROM (
	SELECT *, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employee
) AS ranked
WHERE rnk = 9;

-- ----------------------------------------------------------------------------------------------------------------------
# more on DENSE_RANK()
/*
the MySQL DENSE_RANK() function assigns a rank to each row within a result set, 
or within partitions of a result set, without skipping ranks in case of ties.

Syntax : DENSE_RANK() OVER ( [PARTITION BY partition_expression, ...] ORDER BY sort_expression [ASC|DESC], ... )
Explanation:
- DENSE_RANK() - the window function itself, indicating that you want to calculate a dense rank.
- OVER() - defines the window or set of rows on which the function operates.
- PARTITION BY - (Optional) divides the rows into groups or partitions. ranking applied independently within each partition, and resets for each new partition.
- ORDER BY - specifies the order in which rows within each partition (or the entire result set)
*/
SELECT *, DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank FROM employee;

SELECT emp_id, first_name, salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank FROM employee;

-- using the PARTITION BY parameter...
SELECT 
	emp_id,
    first_name,
    salary,
    department,
	DENSE_RANK() OVER (PARTITION BY department ORDER BY salary) AS dept_salary_rank
FROM employee;

/* 
So, we know how to get the highest or nth highest salaried employee details using DENSE_RANK() by simply entering the rank value.
But what about getting lowest salaried employee details? since ties affect the rank count, lowest rank number ≠ number of rows.

There are a couple of ways doing this
*/

-- Option 1 : Reversing the order to ASC... simple and direct
SELECT *
FROM (
	SELECT *, DENSE_RANK() OVER (ORDER BY salary ASC) AS rnk
	FROM employee
) AS ranked
WHERE rnk = 1;

-- Option 2 : Keeping the Order DESC and making it Dynamic... more data- driven and analytical
SELECT * FROM (
    SELECT *, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employee
) AS ranked
WHERE rnk = (
    SELECT MAX(rnk)
    FROM (
        SELECT DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
        FROM employee
    ) AS rank_value
);
-- This version finds not just the lowest-salary employee(s), but also the actual rank number dynamically
