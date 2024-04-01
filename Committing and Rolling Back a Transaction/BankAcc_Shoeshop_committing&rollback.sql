-- Committing and Rolling Back a Transaction ----------
-- Data Used:  BankAccounts and ShoeShop tables.

-- Sample Exercise:
-- Example of committing and rolling back a transaction.
-- Scenario: Rose is buying a pair of boots from ShoeShop. 
-- So we have to update Rose's balance as well as the ShoeShop balance in the BankAccounts table. 
-- Then we also have to update Boots stock in the ShoeShop table. 
-- After Boots, let's also attempt to buy Rose a pair of Trainers.

DROP TABLE IF EXISTS BankAccounts;


CREATE TABLE BankAccounts (
    AccountNumber VARCHAR(5) NOT NULL,
    AccountName VARCHAR(25) NOT NULL,
    Balance DECIMAL(8,2) CHECK(Balance>=0) NOT NULL,
    PRIMARY KEY (AccountNumber)
    );


    
INSERT INTO BankAccounts VALUES
('B001','Rose',300),
('B002','James',1345),
('B003','Shoe Shop',124200),
('B004','Corner Shop',76000);

-- Retrieve all records from the table

SELECT * FROM BankAccounts;


DROP TABLE IF EXISTS ShoeShop;


CREATE TABLE ShoeShop (
    Product VARCHAR(25) NOT NULL,
    Stock INTEGER NOT NULL,
    Price DECIMAL(8,2) CHECK(Price>0) NOT NULL,
    PRIMARY KEY (Product)
    );

INSERT INTO ShoeShop VALUES
('Boots',11,200),
('High heels',8,600),
('Brogues',10,150),
('Trainers',14,300);



SELECT * FROM ShoeShop;

-- 1. Once the tables are ready, create a stored procedure routine named TRANSACTION_ROSE that includes 
-- TCL commands like COMMIT and ROLLBACK.

DELIMITER //

CREATE PROCEDURE TRANSACTION_ROSE()
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
        RESIGNAL;
	END;
    START TRANSACTION;
    UPDATE BankAccounts
    SET Balance = Balance-200
    WHERE AccountName = 'Rose';
    
    UPDATE BankAccounts
    SET Balance = Balance+200
    WHERE AccountName = 'Shoe Shop';
    
    UPDATE ShoeShop
    SET Stock = Stock-1
    WHERE Product = 'Boots';
    
    UPDATE BankAccounts
    SET Balance = Balance-300
	WHERE AccountName = 'Rose';
    
    COMMIT;
END //

DELIMITER ;

-- 2. Check if the transaction can successfully be committed or not.

CALL TRANSACTION_ROSE;

SELECT * FROM BankAccounts;

SELECT * FROM ShoeShop;

-- Observe that the transaction has been executed. But when we observe the tables, no changes have permanently been 
-- saved through COMMIT. All the possible changes happened might have been undone through ROLLBACK since the whole 
-- transaction fails due to the failure of a SQL statement or more. 
-- Let's go through the possible reason behind the failure of the transaction and how COMMIT - ROLLBACK works on a 
-- stored procedure:

-- a. The first three UPDATEs should run successfully. Both the balance of Rose and ShoeShop should have been updated 
-- in the BankAccounts table. The current balance of Rose should stand at 300 - 200 (price of a pair of Boots) = 100. 
-- The current balance of ShoeShop should stand at 124,200 + 200 = 124,400. 
-- The stock of Boots should also be updated in the ShoeShop table after the successful purchase for Rose, 11 - 1 = 10.

-- b. The last UPDATE statement tries to buy Rose a pair of Trainers, but her balance becomes insufficient 
-- (Current balance of Rose: 100 < Price of Trainers: 300) after buying a pair of Boots. 
-- So, the last UPDATE statement fails. Since the whole transaction fails if any of the SQL statements fail, 
-- the transaction won't be committed.


-- Practice exercise -------
-- 1. Create a stored procedure TRANSACTION_JAMES to execute a transaction based on the following scenario: 
-- First buy James 4 pairs of Trainers ($300) from ShoeShop. Update his balance as well as the balance of ShoeShop. 
-- Also, update the stock of Trainers at ShoeShop. Then attempt to buy James a pair of Brogues ($150) from ShoeShop. 
-- If any of the UPDATE statements fail, the whole transaction fails. You will roll back the transaction. 
-- Commit the transaction only if the whole transaction is successful.

DELIMITER //
CREATE PROCEDURE TRANSACTION_JAMES()

BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	START TRANSACTION; 
	UPDATE BankAccounts
	SET Balance = Balance-1200
	WHERE AccountName = 'James';

	UPDATE BankAccounts
	SET Balance = Balance+1200
	WHERE AccountName = 'Shoe Shop';

	UPDATE ShoeShop
	SET Stock = Stock-4
	WHERE Product ='Trainers';

	UPDATE BankAccounts
	SET Balance = Balance-150
	WHERE AccountName = 'James';

	COMMIT;
END //

DELIMITER ;
