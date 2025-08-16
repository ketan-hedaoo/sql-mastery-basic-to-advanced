USE ProjectDB
SELECT * FROM DEMO

--==========================================================================
--1. IS NULL : Used to check if a value is NULL in a WHERE clause.
	-- Find products where quantity is NULL
SELECT * 
FROM DEMO
WHERE qty IS NULL;


--2. ISNULL() : Replaces NULL with a specified value.
	-- Replace NULL quantity with 0
SELECT id, name, ISNULL(qty, 0) AS qty
FROM DEMO;

	-- Replace NULL price with 1.0
SELECT id, name, ISNULL(price, 1.0) AS price
FROM DEMO;


--3. COALESCE() : Returns the first non-NULL value in a list of expressions.
	-- Replace qty with 0 if NULL, otherwise use qty
SELECT id, name, COALESCE(qty, 0) AS qty
FROM DEMO;

	-- Multiple fallback options
SELECT id, name, COALESCE(price, qty, 0) AS value_used
FROM DEMO;


--4. NULLIF() : Returns NULL if two expressions are equal, otherwise returns the first expression.
	-- Return NULL if qty equals 0 (or is missing)
SELECT id, name, NULLIF(qty, 0) AS qty_check
FROM DEMO;

-- Example: Avoid division by zero
SELECT name, price / NULLIF(qty, 0) AS price_per_item
FROM DEMO;