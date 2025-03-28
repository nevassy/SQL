-- Drop the PETRESCUE table in case it exists
drop table PETRESCUE;
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

-- Agregate Functions

-- 1. Enter a function that calculates the total cost of all animal rescues in the PETRESCUE table.
SELECT SUM(COST)
FROM petrescue;

-- 2. Enter a function that displays the total cost of all animal rescues in the PETRESCUE table in a column called 
-- SUM_OF_COST.
SELECT SUM(COST) AS SUM_OF_COST
FROM petrescue;

-- 3. Enter a function that displays the maximum quantity of animals rescued.
SELECT MAX(QUANTITY)
FROM petrescue;

-- 4. Enter a function that displays the average cost of animals rescued.
SELECT AVG(COST)
FROM petrescue;

-- 5. Enter a function that displays the average cost of rescuing a dog.
-- Hint - Bear the cost of rescuing one dog on one day, which is different from another day. So you will have to use an average of averages.
SELECT AVG(COST/QUANTITY)
FROM petrescue
WHERE ANIMAL = 'Dog';


-- Scalar and String Functions

-- 1. Enter a function that displays the rounded cost of each rescue.
SELECT ROUND(COST)
FROM petrescue;

-- 2. Enter a function that displays the length of each animal name.
SELECT LENGTH(ANIMAL)
FROM petrescue;

-- 3. Enter a function that displays the animal name in each rescue in uppercase.
SELECT UCASE(ANIMAL)
FROM petrescue;

-- 4. Enter a function that displays the animal name in each rescue in uppercase without duplications.
SELECT DISTINCT (UCASE(ANIMAL))
FROM petrescue;

-- 5. Enter a query that displays all the columns from the PETRESCUE table, where the animal(s) rescued are cats. Use cat in lower case in the query.
SELECT *
FROM petrescue
WHERE LCASE(ANIMAL) = 'cat';


-- Date and Time Functions

-- 1. Enter a function that displays the day of the month when cats have been rescued.
SELECT DAY(RESCUEDATE)
FROM petrescue
WHERE ANIMAL = 'Cat';

-- 2. Enter a function that displays the number of rescues on the 5th month.
SELECT SUM(QUANTITY)
FROM petrescue
WHERE MONTH(RESCUEDATE) = '05';

-- 3. Enter a function that displays the number of rescues on the 14th day of the month.
SELECT SUM(QUANTITY)
FROM petrescue
WHERE DAY(RESCUEDATE) = '14';

-- 4. Animals rescued should see the vet within three days of arrivals. Enter a function that displays the third day from each rescue.
SELECT DATE_ADD(RESCUEDATE, INTERVAL 3 DAY)
FROM petrescue;

-- 5. Enter a function that displays the length of time the animals have been rescued; the difference between todays date and the rescue date.
SELECT DATEDIFF(NOW(), RESCUEDATE)
FROM PETRESCUE;
