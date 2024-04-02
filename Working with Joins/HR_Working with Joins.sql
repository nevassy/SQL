-- Working with Joins in MySQL
-- Database Used in this Lab:
-- This HR database schema consists of five tables: EMPLOYEES, JOB_HISTORY, JOBS, DEPARTMENTS, and LOCATIONS.

USE HR;
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
 
 
-- Joins ------------------------------------------------------------------------
-- 1. Retrieve the names and job start dates of all employees who work for department number 5.

SELECT E.F_NAME, E.L_NAME, JH.START_DATE
FROM employees E
INNER JOIN job_history JH
ON E.EMP_ID = JH.EMPL_ID
WHERE E.DEP_ID = '5';

-- 2. Retrieve employee ID, last name, department ID, and department name for all employees.

SELECT E.EMP_ID, E.L_NAME, D.DEPT_ID_DEP, D.DEP_NAME
FROM employees E
LEFT OUTER JOIN departments D
ON E.DEP_ID = D.DEPT_ID_DEP;


-- 3. Retrieve the First name, Last name, and Department name of all employees.
 
SELECT E.F_NAME, E.L_NAME, D.DEP_NAME
FROM employees E
LEFT OUTER JOIN departments D
ON E.DEP_ID = D.DEPT_ID_DEP

UNION

SELECT E.F_NAME, E.L_NAME, D.DEP_NAME
FROM employees E
RIGHT OUTER JOIN departments D
ON E.DEP_ID = D.DEPT_ID_DEP;

-- Practice Problems -------------------------------
-- 1. Retrieve the names, job start dates, and job titles of all employees who work for department number 5.

SELECT E.F_NAME, E.L_NAME, JH.START_DATE, J.JOB_TITLE
FROM employees E
INNER JOIN job_history JH ON E.EMP_ID = JH.EMPL_ID
INNER JOIN jobs J ON E.JOB_ID = J.JOB_IDENT
WHERE E.DEP_ID = '5';

-- 2. Retrieve employee ID, last name, and department ID for all employees but department names for 
-- only those born before 1980.

SELECT E.EMP_ID, E.L_NAME, E.DEP_ID, D.DEP_NAME
FROM EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID = D.DEPT_ID_DEP
AND YEAR(E.B_DATE) < 1980;

-- 3. Retrieve the first name and last name of all employees but department ID and department names only 
-- for male employees.

SELECT E.F_NAME, E.L_NAME, D.DEPT_ID_DEP, D.DEP_NAME
FROM EMPLOYEES AS E
LEFT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID=D.DEPT_ID_DEP AND E.SEX = 'M'

UNION

SELECT E.F_NAME, E.L_NAME, D.DEPT_ID_DEP, D.DEP_NAME
from EMPLOYEES AS E
RIGHT OUTER JOIN DEPARTMENTS AS D
ON E.DEP_ID=D.DEPT_ID_DEP AND E.SEX = 'M';