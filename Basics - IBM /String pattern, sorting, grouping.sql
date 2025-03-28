USE hr;
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
    

/*STRING PATTERNS*/
/*1. Retrieve the first names and last names of all employees who live in Elgin, IL*/
SELECT F_NAME, L_NAME
FROM employees
WHERE ADDRESS LIKE '%elgin%';

/*2. Identify the employees who were born during the 70s*/
SELECT F_NAME, L_NAME
FROM employees
WHERE B_DATE LIKE '197%';

/*3. Retrieve all employee records in department 5 where salary is between 60000 and 70000*/
SELECT *
FROM employees
WHERE DEP_ID = 5 AND (SALARY BETWEEN 60000 AND 70000);

/* SORTING*/
/*1. Retrieve a list of employees ordered by department ID*/
SELECT F_NAME, L_NAME, DEP_ID 
FROM employees
ORDER BY DEP_ID;

/*2. Ordered in descending alphabetical order by last name*/
SELECT F_NAME, L_NAME, DEP_ID 
FROM employees
ORDER BY DEP_ID DESC, L_NAME DESC;

/*GROUPING*/

/*1. Retrieve the number of employees in the department*/
SELECT DEP_ID, COUNT(*)
FROM employees
GROUP BY DEP_ID;

/*2. For each department, retrieve the number of employees in the department and the average employee salary in the department*/
SELECT DEP_ID, COUNT(*) AS Num_Employees, AVG(SALARY) AS Avg_salary
FROM employees
GROUP BY DEP_ID;

/*3. Sort the result of the previous query by average salary.*/
SELECT DEP_ID, COUNT(*) AS Num_Employees, AVG(SALARY) AS Avg_salary
FROM employees
GROUP BY DEP_ID
ORDER BY AVG_SALARY;

/*4. In the previous example, limit the result to departments with fewer than 4 employees*/
SELECT DEP_ID, COUNT(*) AS Num_Employees, AVG(SALARY) AS Avg_salary
FROM employees
GROUP BY DEP_ID
HAVING COUNT(*) < 4
ORDER BY Avg_salary;

/*5. Retrieve the list of all employees, first and last names, whose first names start with ‘S’*/
SELECT F_NAME, L_NAME
FROM employees
WHERE F_NAME LIKE 'S%';

/*6. Arrange all the records of the EMPLOYEES table in ascending order of the date of birth.*/
SELECT *
FROM employees
ORDER BY B_DATE;

/*7. Group the records in terms of the department IDs and filter them of ones that have average salary more than or equal to 60000. Display the department ID and the average salary.*/
SELECT DEP_ID, AVG(SALARY) AS avg_salary
FROM employees
GROUP BY DEP_ID
HAVING AVG(SALARY) >= 60000;

/*8. For the problem above, sort the results for each group in descending order of average salary.*/
SELECT DEP_ID, AVG(SALARY) AS avg_salary
FROM employees
GROUP BY DEP_ID
HAVING AVG(SALARY) >= 60000
ORDER BY AVG(SALARY) DESC;

