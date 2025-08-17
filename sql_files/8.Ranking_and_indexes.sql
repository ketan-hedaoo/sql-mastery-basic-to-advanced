USE ProjectDB

--==========================================================================
--1. Ranking

	--1. ROW_NUMBER() : Always gives unique numbers (no ties, just increments).

SELECT *, 
	ROW_NUMBER() OVER (ORDER BY price DESC) AS RowNum
FROM DEMO

SELECT *, 
	ROW_NUMBER() OVER (PARTITION BY category ORDER BY price DESC) AS RowNum
FROM DEMO


	--2. DENSE_RANK() : Gives same rank for ties, but no gaps.

SELECT *, 
	DENSE_RANK() OVER (ORDER BY price DESC) AS RowNum
FROM DEMO

SELECT *, 
	DENSE_RANK() OVER (PARTITION BY category ORDER BY price DESC) AS RowNum
FROM DEMO


	--3. RANK() : Gives same rank for ties, but leaves gaps.

SELECT *, 
	RANK() OVER (ORDER BY price DESC) AS RowNum
FROM DEMO

SELECT *, 
	RANK() OVER (PARTITION BY category ORDER BY price DESC) AS RowNum
FROM DEMO


--==========================================================================
--2. Indexes

	--1. Clustered Index
		--Physically sorts and stores data rows in order of the index key.
		--By default, if you create a Primary Key, SQL Server makes it clustered.
		--Only one clustered index per table (usually on id or a primary key).

CREATE CLUSTERED INDEX idx_demo_id ON DEMO(id)

EXEC sp_helpindex 'DEMO'            -- List all indexes on DEMO table
EXEC sp_help 'DEMO'					-- List all info on DEMO table

DROP INDEX idx_demo_id on DEMO


	--2. Non-Clustered Index
		--Stores a separate structure with pointers to actual rows.
		--You can have multiple non-clustered indexes on a table.

CREATE NONCLUSTERED INDEX idx_demo_price ON DEMO(price)

EXEC sp_helpindex 'DEMO'            -- List all indexes on DEMO table
EXEC sp_help 'DEMO'					-- List all info on DEMO table

DROP INDEX idx_demo_price on DEMO


	--3. Composite Index (Multiple Columns)

CREATE NONCLUSTERED INDEX idx_demo_categoryprice ON DEMO(category, price)

EXEC sp_helpindex 'DEMO'            -- List all indexes on DEMO table
EXEC sp_help 'DEMO'					-- List all info on DEMO table

DROP INDEX idx_demo_categoryprice on DEMO