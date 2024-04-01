

DROP TABLE IF EXISTS PETSALE;
-- Stored Procedure --------------------------------------------------------


CREATE TABLE PETSALE (
	ID INTEGER NOT NULL,
	ANIMAL VARCHAR(20),
	SALEPRICE DECIMAL(6,2),
	SALEDATE DATE,
	QUANTITY INTEGER,
	PRIMARY KEY (ID)
	);


INSERT INTO PETSALE VALUES
(1,'Cat',450.09,'2018-05-29',9),
(2,'Dog',666.66,'2018-06-01',3),
(3,'Parrot',50.00,'2018-06-04',2),
(4,'Hamster',60.60,'2018-06-11',6),
(5,'Goldfish',48.48,'2018-06-14',24);



SELECT * FROM PETSALE;

-- Stored Procedure: --------------------------------------------------------
-- Exercise 1
-- 1. Create a stored procedure routine named RETRIEVE_ALL.
-- This RETRIEVE_ALL routine will contain an SQL query to retrieve all the records from the PETSALE table, 
-- so you don't need to write the same query over and over again. 
-- You just call the stored procedure routine to execute the query everytime.

DELIMITER //
CREATE PROCEDURE RETRIEVE_ALL()
BEGIN
	SELECT * FROM PETSALE;
END //
DELIMITER ;

-- 2. To call the RETRIEVE_ALL routine, open another SQL tab by clicking Open in new Tab
CALL RETRIEVE_ALL;

-- 3. You can view the created stored procedure routine RETRIEVE_ALL. On the left panel, 
-- expand the PETS database option and click on Procedures to view the procedure.

-- 4. To drop the stored procedure routine RETRIEVE_ALL

DROP PROCEDURE RETRIEVE_ALL;

CALL RETRIEVE_ALL;

-- Exercise 2
-- 1. Create a stored procedure routine named UPDATE_SALEPRICE with parameters Animal_ID and Animal_Health.
-- This UPDATE_SALEPRICE routine will contain SQL queries to update the sale price of the animals in the PETSALE table 
-- depending on their health conditions, BAD or WORSE.
-- This procedure routine will take animal ID and health conditon as parameters which will be used to update 
-- the sale price of animal in the PETSALE table by an amount depending on their health condition. Suppose that:

-- For animal with ID XX having BAD health condition, the sale price will be reduced further by 25%.
-- For animal with ID YY having WORSE health condition, the sale price will be reduced further by 50%.
-- For animal with ID ZZ having other health condition, the sale price won't change.

DELIMITER @
CREATE PROCEDURE UPDATE_SALEPRICE (IN Animal_ID INTEGER, IN Animal_Health VARCHAR(5))
BEGIN
	IF Animal_Health = 'BAD' THEN
		UPDATE PETSALE
        SET SALEPRICE = SALEPRICE - (SALEPRICE * 0.25)
        WHERE ID = Animal_ID;
	ELSEIF Animal_Health = 'WORSE' THEN
		UPDATE PETSALE
        SET SALEPRICE = SALEPRICE - (SALEPRICE * 0.5)
        WHERE ID = ANimal_ID;
	ELSE
		UPDATE PETSALE
        SET SALEPRICE = SALEPRICE
        WHERE ID = Animal_ID;
	END IF;
    END @
    
    DELIMITER ;

-- 2. Let's call the UPDATE_SALEPRICE routine. We want to update the sale price of animal with ID 1 having BAD health 
-- condition in the PETSALE table.

CALL RETRIEVE_ALL;

CALL UPDATE_SALEPRICE(1, 'BAD');

CALL RETRIEVE_ALL; 

-- 3. Let's call the UPDATE_SALEPRICE routine once again. We want to update the sale price of animal with ID 3 having 
-- WORSE health condition in the PETSALE table.

CALL RETRIEVE_ALL;

CALL UPDATE_SALEPRICE(3, 'WORSE');

CALL RETRIEVE_ALL;
 
-- 4. To drop the stored procedure routine UPDATE_SALEPRICE

DROP PROCEDURE UPDATE_SALEPRICE;

CALL UPDATE_SALEPRICE;