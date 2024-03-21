CREATE TABLE EMPLOYEES (
                            EMP_ID CHAR(9) NOT NULL, 
                            F_NAME VARCHAR(15) NOT NULL,
                            L_NAME VARCHAR(15) NOT NULL,
                            SSN CHAR(9),
                            B_DATE DATE,
                            SEX CHAR,
                            ADDRESS VARCHAR(30),
                            JOB_ID CHAR(9),
                            SALARY DECIMAL(10,2),
                            MANAGER_ID CHAR(9),
                            DEP_ID CHAR(9) NOT NULL,
                            PRIMARY KEY (EMP_ID));
                            
  CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL, 
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID));
 
 CREATE TABLE JOBS (
                            JOB_IDENT CHAR(9) NOT NULL, 
                            JOB_TITLE VARCHAR(30),
                            MIN_SALARY DECIMAL(10,2),
                            MAX_SALARY DECIMAL(10,2),
                            PRIMARY KEY (JOB_IDENT));

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL, 
                            DEP_NAME VARCHAR(15) ,
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9),
                            PRIMARY KEY (DEPT_ID_DEP));

CREATE TABLE LOCATIONS (
                            LOCT_ID CHAR(9) NOT NULL,
                            DEP_ID_LOC CHAR(9) NOT NULL,
                            PRIMARY KEY (LOCT_ID,DEP_ID_LOC));
                            
USE hr;


-- Sub-queries and Nested Selects ----------------------

-- 1. Retrieve all employee records whose salary is lower than the average salary. 
SELECT *
FROM employees
WHERE SALARY < (SELECT AVG(SALARY) FROM employees);

-- 2. Retrieve all employee records with EMP_ID, SALARY, and maximum salary as MAX_SALARY in every row. 
-- For this, the maximum salary must be queried and used as one of the columns. This can be done using the query below.
SELECT EMP_ID, SALARY, (SELECT MAX(SALARY) FROM employees) AS MAX_SALARY
FROM employees;

-- 3.  Extract the first and last names of the oldest employee. 
-- Since the oldest employee will be the one with the smallest date of birth:

SELECT F_NAME, L_NAME
FROM employees
WHERE B_DATE = (SELECT MIN(B_DATE) FROM employees);

-- 4. Retrieve the average salary of the top 5 earners in the company. 
-- You will first have to extract a table of the top five salaries as a table. 
-- From that table, you can query the average value of the salary.

SELECT AVG(SALARY)
FROM (SELECT SALARY
FROM employees
ORDER BY SALARY DESC LIMIT 5) AS SALARY_TABLE;


-- Practice problems
-- 1. Write a query to find the average salary of the five least-earning employees.
SELECT AVG(SALARY)
FROM (SELECT SALARY
FROM employees
ORDER BY SALARY LIMIT 5) AS SALARY_TABLE;

-- 2. Write a query to find the records of employees older than the average age of all employees.
SELECT *
FROM employees
WHERE YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE, B_DATE))) >
	(SELECT AVG(YEAR(FROM_DAYS(DATEDIFF(CURRENT_DATE, B_DATE))))
	FROM employees);
