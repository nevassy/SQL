-- Create the PETRESCUE table 
create table PETRESCUE (
	ID INTEGER NOT NULL,
	ANIMAL VARCHAR(20),
	QUANTITY INTEGER,
	COST DECIMAL(6,2),
	RESCUEDATE DATE,
	PRIMARY KEY (ID)
	);
-- Insert sample data into PETRESCUE table
insert into PETRESCUE values 
	(1,'Cat',9,450.09,'2018-05-29'),
	(2,'Dog',3,666.66,'2018-06-01'),
	(3,'Dog',1,100.00,'2018-06-04'),
	(4,'Parrot',2,50.00,'2018-06-04'),
	(5,'Dog',1,75.75,'2018-06-10'),
	(6,'Hamster',6,60.60,'2018-06-11'),
	(7,'Cat',1,44.44,'2018-06-11'),
	(8,'Goldfish',24,48.48,'2018-06-14'),
	(9,'Dog',2,222.22,'2018-06-15')
	
;

USE hr;

-- Aggregation Functions
-- 1. Write a query that calculates the total cost of all animal 
-- rescues in the PETRESCUE table.
SELECT SUM(COST) AS Sum_of_Cost
FROM petrescue;

-- 2. Write a query that displays the minimum and maximum quantity of animals 
-- rescued (of any kind).
-- --Minimum--
SELECT MIN(QUANTITY)
FROM petrescue;

-- --Maximum--
SELECT MAX(QUANTITY)
FROM petrescue;

-- 3. Write a query that displays the average cost of animals rescued.
SELECT AVG(COST)
FROM petrescue;

-- Scalar Functions and String Functions --
-- 1.Write a query that displays the rounded integral cost of each rescue.
-- (round the value to 2 decimal places)
SELECT ROUND(COST, 2)
FROM petrescue;

-- 2. Write a query that displays the length of each animal name.
SELECT ANIMAL, LENGTH(ANIMAL)
FROM petrescue;

-- 3. Write a query that displays the animal name in each rescue in uppercase and in lowercase.
-- --Uppercase--
SELECT UCASE(ANIMAL)
FROM petrescue;

-- --Lowercase--
SELECT LCASE(ANIMAL)
FROM petrescue;


-- Date Functions

-- 1.a Write a query that displays the day of the month when cats have been rescued.
SELECT DAY(RESCUEDATE)
FROM petrescue
WHERE ANIMAL = 'Cat';

-- 1.b Write a query that displays the month when cats have been rescued.
SELECT MONTH(RESCUEDATE)
FROM petrescue
WHERE ANIMAL = 'Cat';

-- 1.c Write a query that displays the year when cats have been rescued.
SELECT YEAR(RESCUEDATE)
FROM petrescue
WHERE ANIMAL = 'Cat';

-- 2.a Animals rescued should see the vet within three days of arrival. Write a query that displays the third day of each rescue.
SELECT DATE_ADD(RESCUEDATE, INTERVAL 3 DAY)
FROM petrescue;

-- 2.b Animals rescued should see the vet within two months of arrival. Write a query that displays the third day of each rescue.
SELECT DATE_ADD(RESCUEDATE, INTERVAL 2 MONTH)
FROM petrescue;

-- 3. Write a query that displays the length of time the animals have been rescued, for example, the difference between the current date and the rescue date.
SELECT DATEDIFF(CURRENT_DATE, RESCUEDATE)
FROM petrescue;

-- Output in a YYYY-MM-DD format
SELECT FROM_DAYS(DATEDIFF(CURRENT_DATE, RESCUEDATE))
FROM petrescue;


-- Practice problems -------
-- 1. Write a query that displays the average cost of rescuing a single dog. Note that the cost per dog would not be the same in different instances.
SELECT AVG(COST/QUANTITY)
FROM petrescue
WHERE ANIMAL = 'Dog';

-- 2. Write a query that displays the animal name in each rescue in uppercase without duplications.
SELECT DISTINCT(UCASE(ANIMAL))
FROM petrescue;

-- 3. Write a query that displays all the columns from the PETRESCUE table where the animal(s) rescued are cats. Use cat in lowercase in the query.
SELECT *
FROM petrescue
WHERE LCASE(ANIMAL) = 'cat';

-- 4. Write a query that displays the number of rescues in the 5th month.
SELECT SUM(QUANTITY)
FROM petrescue
WHERE MONTH(RESCUEDATE) = '05';

-- 5. The rescue shelter is supposed to find good homes for all animals within 1 year of their rescue. Write a query that displays the ID and the target date.
SELECT ID, DATE_ADD(RESCUEDATE, INTERVAL 1 YEAR) AS Target_date
FROM petrescue;

