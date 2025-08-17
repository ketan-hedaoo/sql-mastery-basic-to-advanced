USE ProjectDB

--==========================================================================
--1. Triggers
	--A trigger is a special stored procedure that runs automatically when an event (INSERT, UPDATE, DELETE) happens on a table or view.

	--1: AFTER INSERT Trigger : Operation after inserting a row
		--Create table to log operation details
CREATE TABLE DEMO_LOG (
log_id INT IDENTITY PRIMARY KEY, 
action VARCHAR(50),
item_id INT,
action_time DATETIME DEFAULT GETDATE()
)

		--create trigger
CREATE TRIGGER tgr_after_insert_demo
ON DEMO
AFTER INSERT
AS
BEGIN
	INSERT INTO DEMO_LOG(action, item_id)
	SELECT 'INSERTED', id FROM inserted
END

		--test trigger
INSERT INTO DEMO (id, name, qty, price, category, added_date)
VALUES (1, 'Laptop', 10, 55000, 'Electronics', GETDATE())
SELECT * FROM DEMO_LOG


	--2: AFTER UPDATE Trigger :Operation after updating a row
		--create trigger
CREATE TRIGGER tgr_after_update_demo
ON DEMO
AFTER UPDATE
AS
BEGIN
	INSERT INTO DEMO_LOG(action, item_id)
	SELECT 'UPDATED', id FROM inserted
END

		--test trigger
UPDATE DEMO SET price = 90 WHERE id = 2
SELECT * FROM DEMO_LOG


	--3: AFTER DELETE Trigger : Operation after deleting a row
		--create trigger
CREATE TRIGGER tgr_after_delete_demo
ON DEMO
AFTER DELETE
AS
BEGIN
	INSERT INTO DEMO_LOG(action, item_id)
	SELECT 'DELETED', id FROM deleted
END

		--test trigger
DELETE FROM DEMO WHERE id = 1
SELECT * FROM DEMO_LOG


	--4: INSTEAD OF Trigger : replace the operation with custom logic.
CREATE TRIGGER trg_instead_of_delete_demo
ON DEMO
INSTEAD OF DELETE
AS
BEGIN
    INSERT INTO DEMO_LOG(action, item_id)
    SELECT 'DELETE BLOCKED', id FROM deleted
    PRINT 'Deletion is not allowed!'
END

DELETE FROM DEMO WHERE id = 2
SELECT * FROM DEMO_LOG


--==========================================================================
--1. Views
	--A view in SQL is basically a saved query that behaves like a virtual table.
	--It doesn’t store the actual data instead, it stores the definition of a query.
	--Whenever you query a view, SQL Server runs the underlying query and shows the result as if it were a table.

	--1. Basic View
CREATE VIEW vw_DemoBasic
AS
SELECT id, name, price FROM DEMO

	--2. View with WHERE condition
CREATE VIEW vw_DemoOffice
AS
SELECT id, name, price FROM DEMO
WHERE category = 'Office'

	--3. View with Aggregation (GROUP BY)
CREATE VIEW vw_DemoCategorySummary
AS
SELECT category, COUNT(*) AS total_items, AVG(price) AS avg_price FROM DEMO
GROUP BY category

	--4. Updating through a View
UPDATE vw_DemoBasic 
SET price = price + 10
WHERE id = 2

	--5. Altering a View
ALTER VIEW vw_DemoBasic
AS
SELECT id, name, qty, price FROM DEMO

SELECT * FROM vw_DemoBasic