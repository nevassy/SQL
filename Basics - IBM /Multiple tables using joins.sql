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

-- Accessing multiple tables with sub-queries

-- 1. Retrieve only the EMPLOYEES records corresponding to jobs in the JOBS table.
SELECT *
FROM employees 
WHERE JOB_ID IN (SELECT JOB_IDENT FROM jobs);

-- 2. Retrieve JOB information for employees earning over $70,000.

SELECT *
FROM jobs
WHERE JOB_IDENT IN (SELECT JOB_ID FROM employees WHERE SALARY > 70000);


-- Accessing multiple tables with Implicit Joins

-- 1. Retrieve only the EMPLOYEES records corresponding to jobs in the JOBS table.
SELECT *
FROM employees, jobs
WHERE employees.JOB_ID = jobs.JOB_IDENT;

-- 2. Redo the previous query using shorter aliases for table names.
SELECT *
FROM employees E, jobs J
WHERE E.JOB_ID = J.JOB_IDENT;

-- 3.In the previous query, retrieve only the Employee ID, Name, and Job Title.
SELECT EMP_ID, F_NAME, L_NAME, JOB_TITLE
FROM employees E, jobs J
WHERE E.JOB_ID = J.JOB_IDENT;

-- 4. Redo the previous query, but specify the fully qualified column names with aliases in the SELECT clause.
SELECT E.EMP_ID, E.F_NAME, E.L_NAME, J.JOB_TITLE
FROM employees E, jobs J
WHERE E.JOB_ID = J.JOB_IDENT;

-- Practce problems

-- 1. Retrieve only the list of employees whose JOB_TITLE is Jr. Designer.
-- using sub-queries
SELECT *
FROM employees E
WHERE JOB_ID IN (SELECT JOB_IDENT FROM jobs 
	WHERE JOB_TITLE = 'Jr. designer');
    
-- using implicit Joins
SELECT *
FROM employees E, jobs J
WHERE E.JOB_ID = J.JOB_IDENT AND J.JOB_TITLE = 'Jr. Designer';


-- 2. Retrieve JOB information and a list of employees whose birth year is after 1976.
-- using sub-queries
SELECT F_NAME, L_NAME, B_DATE, JOB_IDENT, JOB_TITLE, MAX_SALARY, MIN_SALARY
FROM employees, jobs
WHERE JOB_IDENT IN (SELECT JOB_ID
                    FROM employees
                    WHERE YEAR(B_DATE)>1976 );

-- using implicit joins
SELECT E.F_NAME, E.L_NAME, E.B_DATE, J.JOB_IDENT, J.JOB_TITLE, J.MAX_SALARY, J.MIN_SALARY
FROM employees E, jobs J
WHERE E.JOB_ID = J.JOB_IDENT AND YEAR(E.B_DATE) > 1976;























