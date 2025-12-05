/*
---------------------------------------------------------------------------------------------------------------------------
Filename       : 01_create_tables.sql
Level          : Basic
Focus          :
 Creation of the following 3 tables with respective columns and linked on the basis of 'employee ID'
  1. `employee` Table (main table) - emp_id, first_name, last_name, salary, joining_date, department, city
  2. `bonus` Table - emp_ref_id, bonus_amount, bonus_date
  3. `title` Table - emp_ref_id, emp_title, affect_from
---------------------------------------------------------------------------------------------------------------------------
*/

SHOW DATABASES;                             -- display the list of existing databases
CREATE DATABASE IF NOT EXISTS company;      -- create a database  (good practise to use 'IF NOT EXISTS' to avoid issues)
USE company;                                -- select the database

SHOW TABLES;            -- display the list of tables in that database


-- --------------------------------------------------------------------------------------------------------
# TABLE 1 - Employee details Table
-- ------------------------------
CREATE TABLE employee(
	emp_id INT PRIMARY KEY NOT NULL,
    first_name CHAR(25),
    last_name CHAR(25),
    salary INT,
    joining_date DATETIME,
    department CHAR(25),
    city CHAR(25)
);

-- inserting values into table (25 rows)
INSERT INTO employee (emp_id, first_name, last_name, salary, joining_date, department, city) VALUES
	(001, 'Monika', 'Arora', 100000, '2024-02-01 09:00:00', 'HR', 'Mumbai'),
	(002, 'Neha', 'Khan', 80000, '2024-06-10 09:00:00', 'Admin', 'Bangalore'),
	(003, 'Vishal', 'Singh', 300000, '2022-09-20 09:00:00', 'Operations', 'Pune'),
	(004, 'Anand', 'Shinde', 500000, '2020-02-20 09:00:00', 'Accounts', 'Mumbai'),
	(005, 'Vivek', 'Chaudhari', 90000, '2025-05-05 09:00:00', 'IT', 'Hyderabad'),
	(006, 'Aman', 'Sharma', 120000, '2025-05-05 09:00:00', 'Operations', 'Hyderabad'),
	(007, 'Rajesh', 'Kumar', 75000, '2025-01-20 09:00:00', 'Accounts', 'Pune'),
	(008, 'Jessica', 'Dsouza', 350000, '2023-04-05 09:00:00', 'IT', 'Mumbai'),
	(009, 'Niharika', 'Shetty', 120000, '2024-01-10 09:00:00', 'Sales', 'Bangalore'),
	(010, 'Vidya', 'Pillai ', 550000, '2020-02-20 09:00:00', 'Operations', 'Chennai'),
	(011, 'Aman', 'Khan', 75000, '2025-05-20 09:00:00', 'Accounts', 'Bangalore'),
	(012, 'Monika', 'Dsouza', 200000, '2023-02-01 09:00:00', 'Sales', 'Chennai'),
	(013, 'Suman', 'Chaudhari', 95000, '2024-05-20 09:00:00', 'IT', 'Pune'),
	(014, 'John', 'Francis', 80000, '2024-04-22 09:00:00', 'Operations', 'Hyderabad'),
	(015, 'Rajesh', 'Sharma', 200000, '2022-01-11 09:00:00', 'Operations', 'Mumbai'),
	(016, 'Venkat', 'Iyer', 450000, '2022-09-20 09:00:00', 'Operations', 'Chennai'),
	(017, 'Raj', 'Prasad', 420000, '2020-06-19 09:00:00', 'Sales', 'Pune'),
	(018, 'Satish', 'Singh', 120000, '2022-06-08 09:00:00', 'Accounts', 'Pune'),
	(019, 'Arjun', 'Shetty', 80000, '2024-09-11 09:00:00', 'IT', 'Bangalore'),
	(020, 'Gita', 'Naik', 400000, '2020-09-22 09:00:00', 'Operations', 'Mumbai'),
	(021, 'Nikhil', 'Yadav', 100000, '2023-01-11 09:00:00', 'Admin', 'Mumbai'),
	(022, 'Jonathan', 'Fernandez', 120000, '2023-06-20 09:00:00', 'IT', 'Mumbai'),
	(023, 'Usha', 'Pai', 600000, '2020-04-11 09:00:00', 'IT', 'Bangalore'),
	(024, 'Sara', 'Hussain', 95000, '2025-01-20 09:00:00', 'HR', 'Hyderabad'),
	(025, 'Vipul', 'Nair', 200000, '2023-06-13 09:00:00', 'IT', 'Pune');


-- --------------------------------------------------------------------------------------------------------
# TABLE 2 - Employee BONUS Table
-- ------------------------------
CREATE TABLE bonus(
	emp_ref_id INT,
    bonus_amount INT,
    bonus_date DATETIME,
    FOREIGN KEY (emp_ref_id) REFERENCES employee(emp_id) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO bonus (emp_ref_id, bonus_amount, bonus_date) VALUES
    (005, 5000, '2025-02-20'),
    (002, 3000, '2025-10-11'),
    (011, 4000, '2025-02-20'),
    (018, 4500, '2025-02-20'),
    (009, 3000, '2025-10-11'),
    (007, 4500, '2025-02-20'),
    (012, 3500, '2025-10-11'),
    (010, 3500, '2025-10-11'),
    (019, 4500, '2025-10-20'),
    (017, 5000, '2025-10-11');


-- --------------------------------------------------------------------------------------------------------
# TABLE 3 - Employee TITLE Table
-- ------------------------------
CREATE TABLE title(
	emp_ref_id INT,
    emp_title CHAR(25),
    affect_from DATETIME,
    FOREIGN KEY (emp_ref_id) REFERENCES employee(emp_id) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO title (emp_ref_id, emp_title, affect_from) VALUES
    (001, 'Manager', '2025-02-01 00:00:00'),
    (002, 'Asst. Manager', '2025-02-01 00:00:00'),
    (018, 'Executive', '2025-09-15 00:00:00'),
    (006, 'Lead', '2025-02-01 00:00:00'),
    (014, 'Asst. Manager', '2025-09-15 00:00:00'),
    (007, 'Executive', '2025-02-01 00:00:00'),
    (016, 'Manager', '2025-09-15 00:00:00'),
    (013, 'Lead', '2025-09-15 00:00:00'),
    (002, 'Manager', '2025-09-15 00:00:00'),
    (004, 'Lead', '2025-02-01 00:00:00'),
    (017, 'Executive', '2025-09-15 00:00:00'),
    (006, 'Manager', '2025-02-01 00:00:00'),
    (003, 'Manager', '2025-09-15 00:00:00');
