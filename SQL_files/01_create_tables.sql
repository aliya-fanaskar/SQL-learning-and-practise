/*
---------------------------------------------------------------------------------------------------------------------------
Filename       : 01_create_database.sql
Level          : Basic
Content        : Creating a Database from scratch consisting of the following Tables 
   having columns with relavant data types and connecting tables with KEYs wherever needed, 
   and then inserting values accordingly.
		1. department - dept_id, dept_name
		2. project - project_id, project_name, start_date, end_date 
		3. employee - emp_id, first_name, last_name, dept_id, job_title, salary, joining_date, manager_id, project_id
		4. employee_info - emp_id, email_id, phone, date_of_birth, city 
		5. bonus - emp_ref_id, bonus_amount, bonus_date
---------------------------------------------------------------------------------------------------------------------------
*/

SHOW DATABASES;                           -- display the list of existing databases

CREATE DATABASE IF NOT EXISTS company;    -- create a new database (good practise to use 'IF NOT EXISTS' to avoid issues)

USE company;                              -- select the database

SHOW TABLES;            -- display the list of tables in that database (none yet)


# =============================
# TABLE 1 - Departments Table
# =============================
-- Creating Table
CREATE TABLE department(
	dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Inserting Values into table
INSERT INTO department (dept_id, dept_name) VALUES
	(1, 'HR'),
	(2, 'Finance'),
	(3, 'IT'),
	(4, 'Marketing'),
	(5, 'Operations'),
	(6, 'Sales');


# ==========================
# TABLE 2 - Projects Table 
# ==========================
-- Creating Table
CREATE TABLE project(
	project_id INT PRIMARY KEY,
	project_name VARCHAR(100),
	start_date DATE,
	end_date DATE
);

-- Inserting Values into table
INSERT INTO project VALUES
(101,'Payroll Automation','2026-01-01','2026-12-31'),
(102,'E-commerce Platform','2024-05-01','2026-03-30'),
(103,'Product Alpha','2025-02-01','2025-09-30'),
(104,'Marketing CRM','2023-08-01','2025-05-15'),
(105,'Logistics Tracker','2025-03-10','2026-01-01');


# ================================
# TABLE 3 - Employee Table (Main)
# ================================
-- Creating Table
CREATE TABLE employee(
	emp_id INT PRIMARY KEY NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR (30) NOT NULL,
    dept_id INT,
    job_title VARCHAR(50) NOT NULL,
    salary INT NOT NULL,
    joining_date DATE,
    manager_id INT,
    project_id INT,
    
    FOREIGN KEY (dept_id) 
		REFERENCES department(dept_id) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE,
	
	FOREIGN KEY (project_id) 
		REFERENCES project(project_id) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

-- Inserting Values into table
DESC employee;    -- get a quick view of the schema of the table

INSERT INTO employee VALUES
	(1, 'Aarav','Sharma',1,'HR Executive',35000,'2021-01-05', NULL, 103),
	(2, 'Riya','Mehra',1,'HR Associate',30000,'2022-03-11',1, 103),
	(3, 'Kabir','Singh',2,'Accountant',42000,'2020-07-19', NULL, NULL),
	(4, 'Ishita','Khan',2,'Senior Accountant',60000,'2019-05-15',4, NULL),
	(5, 'Vihaan','Singh',3,'Software Engineer',55000,'2021-11-23', NULL, 102),
	(6, 'Aditi','Nair',3,'Junior Developer',30000,'2023-01-10',5, 102),
	(7, 'Rohan','Joshi',3,'Tech Lead',90000,'2018-08-08', NULL, 102),
	(8, 'Neha','Kapoor',4,'Marketing Specialist',45000,'2020-02-18', NULL, 104),
	(9, 'Tanvi','Joshi',4,'Marketing Analyst',38000,'2022-06-06',8, 104),
	(10,'Kunal','Iyer',5,'Operations Executive',35000,'2021-07-30', 11, 105),
	(11,'Sara','Kaur',5,'Operations Manager',75000,'2017-12-12', NULL, 105),
	(12,'Yash','Dubey',6,'Sales Executive',32000,'2023-04-09', NULL, NULL),
	(13,'Meera','Rathod',6,'Sales Analyst',40000,'2021-10-22',12, 104),
	(14,'Shruti','Chawla',3,'System Admin',50000,'2019-01-20',7, 102),
	(15,'Kunal','Seth',2,'Finance Analyst',48000,'2022-02-14',4, NULL),
	(16,'Priya','Singh',3,'QA Engineer',42000,'2021-09-17',7, NULL),
	(17,'Sahil','Gupta',3,'Backend Dev',52000,'2020-11-11',7, 102),
	(18,'Nidhu','Joshi',4,'Content Writer',30000,'2023-05-03',8, NULL),
	(19,'Harsh','Goel',1,'Recruiter',33000,'2022-12-01',1, NULL),
	(20,'Rohan','Shetty',5,'Logistics Exec',31000,'2023-01-26',11, 105),
	(21,'Jonathan','Dsouza',3,'Cloud Engineer',78000,'2020-03-03',7, NULL),
	(22,'Ritu','Arora',2,'Tax Specialist',65000,'2019-06-16',4, NULL),
	(23,'Manav','Jain',4,'SEO Analyst',36000,'2022-07-21',8, NULL),
	(24,'Shruti','Reddy',6,'Sales Lead',85000,'2018-09-09', NULL, 105),
	(25,'Aman','Khan',6,'Sales Intern',20000,'2023-08-01',24, NULL);


# ==================================
# TABLE 4 - Employee details Table
# ==================================
-- Creating Table
CREATE TABLE employee_info(
	emp_id INT NOT NULL,
    email_id VARCHAR(100),
    phone VARCHAR(10),
    dob DATE,
    city VARCHAR(50),
    
    FOREIGN KEY (emp_id) 
		REFERENCES employee(emp_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Inserting Values into table
INSERT INTO employee_info VALUES
	(1,'aarav.sharma@xyz.com','9876543210','1995-03-10','Mumbai'),
	(2,'riya.mehra@xyz.com','9988776611','1998-05-22','Pune'),
	(3,'kabir.singh@xyz.com','8899001122','1992-12-11','Delhi'),
	(4,'ishita.khan@xyz.com','9090909090','1990-07-19','Delhi'),
	(5,'vihaan.singh@xyz.com',NULL,'1996-01-15','Bangalore'),
	(6,'aditi.nair@xyz.com','9988223344','2000-08-08','Kochi'),
	(7,'rohan.joshi@xyz.com','8877665544','1989-02-27','Mumbai'),
	(8,'neha.kapoor@xyz.com','9123456780','1994-09-10','Chennai'),
	(9,'tanvi.joshi@xyz.com','9988991122','1999-04-04','Indore'),
	(10,'kunal.iyer@xyz.com',NULL,'1995-02-02','Hyderabad'),
	(11,'sara.kaur@xyz.com','9099887766','1988-11-30','Chandigarh'),
	(12,'yash.dubey@xyz.com','9001234567','1997-06-06','Jaipur'),
	(13,'meera.rathod@xyz.com',NULL,'1996-10-05','Surat'),
	(14,'shruti.chawla@xyz.com','7894561230','1991-03-19','Delhi'),
	(15,'kunal.seth@xyz.com','9123322110','1998-07-07','Lucknow'),
	(16,'priya.singh@xyz.com','7999888877','1995-09-29','Kolkata'),
	(17,'sahil.gupta@xyz.com','7001239876','1994-05-12','Mumbai'),
	(18,'nidhi.joshi@xyz.com','9112233445','2001-01-01','Nagpur'),
	(19,'harsh.goel@xyz.com','9555667788','2000-03-23','Pune'),
	(20,'rohan.shetty@xyz.com','9888112233','1997-12-12','Mangalore'),
	(21,'jonathan.dsouza@xyz.com','7333445566','1993-11-03','Bangalore'),
	(22,'ritu.arora@xyz.com','7999001122','1990-04-14','Gurgaon'),
	(23,'manav.jain@xyz.com',NULL,'1997-08-20','Delhi'),
	(24,'shruti.reddy@xyz.com','9111223344','1990-10-10','Chennai'),
	(25,'aman.khan@xyz.com','9000001111','2002-02-22','Indore');


# ==============================
# TABLE 5 - Bonus issued Table 
# ==============================
-- Creating Table
CREATE TABLE bonus(
	emp_ref_id INT,
	bonus_amount INT,
	bonus_date DATE,
    
	FOREIGN KEY (emp_ref_id) 
		REFERENCES employee(emp_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Inserting Values into table
INSERT INTO bonus VALUES
	(1,5000,'2024-03-01'),
	(2,3000,'2024-04-10'),
	(4,7000,'2024-01-20'),
	(5,4500,'2023-12-12'),
	(7,10000,'2024-06-06'),
	(9,3500,'2023-11-11'),
	(11,9000,'2024-02-14'),
	(13,4000,'2024-08-08'),
	(16,3800,'2024-01-01'),
	(17,4200,'2023-09-09'),
	(21,7500,'2023-10-05'),
	(24,8500,'2024-04-09');
