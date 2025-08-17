USE ProjectDB

--==========================================================================
--1. DDL — Data Definition Language

	--1.CREATE
CREATE TABLE DEMO (
    id INT,
    name VARCHAR(50),
    qty INT,
    price DECIMAL(10,2),
    category VARCHAR(50),
    added_date DATE
)


	--2.ALTER
		-- Add a new column
ALTER TABLE DEMO ADD Description VARCHAR(255) 

		-- Drop a column
ALTER TABLE DEMO DROP COLUMN Description

		-- Modify an existing column’s data type
ALTER TABLE DEMO ALTER COLUMN qty INT


	--3.RENAME
		-- Rename the table
EXEC sp_rename 'DEMO', 'DEMO_TABLE'

		-- Rename a column
EXEC sp_rename 'DEMO_TABLE.qty', 'quantity'


	--4.DROP
		--Remove the table permanently
DROP TABLE DEMO_TABLE


	--5.TRUNCATE
		--Remove all rows but keep structure
TRUNCATE TABLE DEMO_TABLE

--==========================================================================
-- CREATE TABLE AGAIN FOR NEW OPERATIONS AFTER DROPPING
--2. DML — Data Manipulation Language

	--1.INSERT
		--Insert a single row 
INSERT INTO DEMO (id, name, qty, price, category, added_date)
VALUES (1, 'Pen', 50, 5.25, 'Stationery', '2023-01-10')

		-- Insert multiple rows in one statement
INSERT INTO DEMO (id, name, qty, price, category, added_date)
VALUES 
(2, 'Pencil', 100, 2.50, 'Stationery', '2023-02-15'),
(3, 'Notebook', 30, 45.00, 'Stationery', '2023-03-01'),
(4, 'Eraser', NULL, NULL, 'Stationery', '2023-01-20'),
(5, 'Marker', 60, 15.00, 'Office', '2023-04-10'),
(6, 'Chalk', 200, 1.25, 'School', '2023-01-05'),
(7, 'Ruler', 75, NULL, 'Stationery', '2023-02-28'),
(8, 'Stapler', 25, 120.00, 'Office', '2023-05-01'),
(9, 'Tape', NULL, 25.00, 'Office', '2023-03-15'),
(10, 'Notes', 25, 2.5, 'Office', '2023-05-01'),
(11, 'Stand', 25, 45.00, 'Office', '2023-05-01'),
(12, 'Sharpner', 25, 15.00, 'Stationery', '2023-05-01'),
(13, 'Holder', 25, 25.00, 'Office', '2023-05-01'),
(14, 'Pin', 25, 1.25, 'Office', '2023-05-01')

		-- Insert using only specific columns (others will be NULL)
INSERT INTO DEMO (id, name, category, added_date)
VALUES (15, 'Glue', 'Office', '2023-02-25')

		-- Insert from another table (or query)
INSERT INTO DEMO(id, name, qty, price)
SELECT id, name, tqy, price
FROM <SomeOtherTable>


	--2.UPDATE
		-- Update a single row
UPDATE DEMO
SET price = 6.00
WHERE id = 1

		-- Update multiple columns
UPDATE DEMO
SET qty = 120, price = 2.75
WHERE name = 'Pencil'

		-- Update all rows
UPDATE DEMO
SET price = price * 1.10  


	--3.DELETE
		-- Delete a specific row
DELETE FROM DEMO
WHERE id = 4

		-- Delete based on a condition
DELETE FROM DEMO
WHERE qty < 40

		-- Delete all rows (but keep table structure)
DELETE FROM DEMO

--==========================================================================
--3. DQL — Data Query Language

	--1.SELECT
		-- Select all columns from all rows
SELECT * FROM DEMO

		-- Select specific columns
SELECT name, qty FROM DEMO

		--Select with column aliases
SELECT id AS ProductID, name AS ProductName, price AS UnitPrice FROM DEMO

		--Select with constant values
SELECT 'Stationery' AS Category, name FROM DEMO

		--Select with expressions
SELECT name, qty * price AS TotalValue FROM DEMO

		--Select distinct values
SELECT DISTINCT price FROM DEMO

		--Select Top N Rows
SELECT TOP 2 * FROM DEMO

		-- First 50% of rows
SELECT TOP 50 PERCENT * FROM DEMO

		--Copy from one table to another
SELECT * INTO new_table FROM DEMO

==========================================================================
--4. TCL (Transaction Control Language)
	
	-- Transaction + Commit 
BEGIN TRANSACTION
UPDATE DEMO SET price = 99.99 WHERE id = 1
COMMIT

	-- Transaction + Rollback 
BEGIN TRANSACTION
UPDATE DEMO SET price = 11.11 WHERE id = 1
ROLLBACK

	-- Transaction + Savepoint
BEGIN TRANSACTION 
INSERT INTO DEMO (id, name, qty, price) VALUES (6, 'Chalk', 200, 1.25)
SAVE TRANSACTION step1
INSERT INTO DEMO (id, name, qty, price) VALUES (7, 'Crayon', 50, 5.00)
ROLLBACK TRANSACTION step1
COMMIT


==========================================================================
--5. DCL (Data Control Language)

	--Get your username
SELECT SYSTEM_USER

	--Get list of users
SELECT name, type_desc 
FROM sys.database_principals
WHERE type IN ('S','U')

	--Check grant permission for your user
SELECT * FROM fn_my_permissions('DEMO', 'OBJECT')


	-- Give user 'guest' permission to read the table
GRANT SELECT ON DEMO TO guest

	-- Allow user to add rows
GRANT INSERT ON DEMO TO guest

	-- Allow user to update only the price column
GRANT UPDATE (price) ON DEMO TO guest

	-- Allow user to SELECT, INSERT, and UPDATE
GRANT SELECT, INSERT, UPDATE, DELETE ON DEMO TO guest

	-- Remove INSERT permission from user
REVOKE INSERT ON DEMO FROM guest

	-- Remove all granted permissions
REVOKE SELECT, INSERT, UPDATE ON DEMO FROM guest

	-- Allow user to give permissions to others as well
GRANT SELECT ON DEMO TO guest WITH GRANT OPTIONs