DROP TABLE IF EXISTS EMPLOYEES;
DROP TABLE IF EXISTS JOB_HISTORY;
DROP TABLE IF EXISTS JOBS;
DROP TABLE IF EXISTS DEPARTMENTS;
DROP TABLE IF EXISTS LOCATIONS;



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
                          PRIMARY KEY (EMP_ID)
                        );

CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL,
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID)
                          );

CREATE TABLE JOBS (
                    JOB_IDENT CHAR(9) NOT NULL,
                    JOB_TITLE VARCHAR(30) ,
                    MIN_SALARY DECIMAL(10,2),
                    MAX_SALARY DECIMAL(10,2),
                    PRIMARY KEY (JOB_IDENT)
                  );

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL,
                            DEP_NAME VARCHAR(15) ,
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9),
                            PRIMARY KEY (DEPT_ID_DEP)
                          );

CREATE TABLE LOCATIONS (
                          LOCT_ID CHAR(9) NOT NULL,
                          DEP_ID_LOC CHAR(9) NOT NULL,
                          PRIMARY KEY (LOCT_ID,DEP_ID_LOC)
                        );
                        
-- Task 1: Create a View
-- In this exercise, you will create a View and show a selection of data for a given table.
-- 1. Create a view called EMPSALARY to display salary along with some basic sensitive data of employees from the HR database. 

CREATE VIEW EMPSALARY AS
SELECT EMP_ID, F_NAME, L_NAME, B_DATE, SEX, SALARY
FROM EMPLOYEES;

-- To retrieve all the records
SELECT * FROM EMPSALARY;

-- Task 2: Update a View
-- Update a View to combine two or more tables in meaningful ways.
-- Assume that the EMPSALARY view we created in Task 1 doesn't contain enough salary information, such as max/min salary 
-- and the job title of the employees. For this, we need to get information from other tables in the database. 
-- You need all columns from EMPLOYEES table used above, except for SALARY. 
-- You also need the columns JOB_TITLE, MIN_SALARY, MAX_SALARY of the JOBS table.

CREATE OR REPLACE VIEW EMPSALARY AS
SELECT EMP_ID, F_NAME, L_NAME, B_DATE, SEX, JOB_TITLE, MIN_SALARY, MAX_SALARY
FROM EMPLOYEES, JOBS
WHERE EMPLOYEES.JOB_ID = JOBS.JOB_IDENT;

SELECT * FROM EMPSALARY;

-- Task 3: Drop a View
-- drop the created View EMPSALARY

DROP VIEW EMPSALARY;

SELECT * FROM EMPSALARY;

-- Practice Problems --------
-- 1. Create a view “EMP_DEPT” which has the following information.
-- EMP_ID, FNAME, LNAME and DEP_ID from EMPLOYEES table

CREATE VIEW EMP_DEPT
AS SELECT EMP_ID, F_NAME, L_NAME, DEP_ID
FROM EMPLOYEES;

SELECT * FROM EMP_DEPT;

-- 2. Modify “EMP_DEPT” such that it displays Department names instead of Department IDs. For this, we need to combine information from EMPLOYEES and DEPARTMENTS as follows.
-- EMP_ID, FNAME, LNAME from EMPLOYEES table and
-- DEP_NAME from DEPARTMENTS table, combined over the columns DEP_ID and DEPT_ID_DEP.

CREATE OR REPLACE VIEW EMP_DEPT AS
SELECT EMP_ID, F_NAME, L_NAME, DEP_NAME
FROM EMPLOYEES, DEPARTMENTS
WHERE EMPLOYEES.DEP_ID = DEPARTMENTS.DEPT_ID_DEP;

SELECT * FROM EMP_DEPT;

-- 3. Drop the view “EMP_DEPT”.

DROP VIEW EMP_DEPT;

SELECT * FROM EMP_DEPT;

