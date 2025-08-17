USE ProjectDB

--==========================================================================
--1. Temporary Table

	--1: Local Temporary Table (#Temp)
		--#TempDemo exists only while your SSMS session is open.
		--If you open a new query window, you won’t see it.

CREATE TABLE #TempDemo(
	id INT, 
	name VARCHAR(50),
	price DECIMAL(5, 2)
)

INSERT INTO #TempDemo (id, name, price)
SELECT id, name, price
FROM DEMO
WHERE price IS NOT NULL

SELECT * FROM #TempDemo

DROP TABLE #TempDemo


	--2: Global Temporary Table (#Temp)
		--Visible across all sessions until last session using it is closed.
		--If you open another SSMS query window (new session), you can still see it.

CREATE TABLE ##TempDemo (
    id INT,
    category VARCHAR(50),
    qty INT
)

INSERT INTO ##TempDemo (id, category, qty)
SELECT id, category, qty
FROM DEMO
WHERE qty IS NOT NULL

SELECT * FROM ##TempDemo

DROP TABLE ##TempDemo


--==========================================================================
--2. CTEs (Common Table Expressions)
	--A CTE is a temporary result set defined within the execution scope of a single query.
	--It disappears right after the query finishes (unlike temp tables).


	--1. Simple CTE
WITH PriceCTE AS (
	SELECT id, name, price, category
	FROM DEMO
	WHERE price>15
)
SELECT * FROM PriceCTE
WHERE price>50


	--2. CTE with Aggregation
WITH AvgPriceCTE AS (
    SELECT category, AVG(price) AS AvgPrice
    FROM DEMO
    GROUP BY category
)
SELECT category, AvgPrice FROM AvgPriceCTE


	--3. CTE with ROW_NUMBER()
WITH RankCTE AS (
	SELECT id, name, category, price,
		ROW_NUMBER() OVER (PARTITION BY category ORDER BY price DESC) AS RowNum
	FROM DEMO
)
SELECT * FROM RankCTE
WHERE RowNum = 1


	--4. Multiple CTEs
WITH Expensive AS (
	SELECT * FROM DEMO WHERE PRICE > 100
),
Cheap AS (
	SELECT * FROM DEMO WHERE price < 5
)
SELECT * FROM Expensive 
UNION
SELECT * FROM Cheap


--==========================================================================
--1. Sets
SELECT * FROM DEMO WHERE price>10
SELECT * FROM DEMO WHERE price<100

	--1. UNION
		--Combines results of two queries.
		--Removes duplicates automatically.
SELECT * FROM DEMO WHERE price>10
UNION
SELECT * FROM DEMO WHERE price<100

	--1. UNION
		--Combines results of two queries.
		--Removes duplicates automatically.
SELECT * FROM DEMO WHERE price>10
UNION
SELECT * FROM DEMO WHERE price<100


	--2. UNION ALL
		--Same as UNION but keeps duplicates.
SELECT * FROM DEMO WHERE price>10
UNION ALL
SELECT * FROM DEMO WHERE price<100

	--3. INTERSECT
		--Returns rows that are common to both queries.
SELECT * FROM DEMO WHERE price>10
INTERSECT
SELECT * FROM DEMO WHERE price<100

	--4. EXCEPT
		--Returns rows from the first query that are not in the second.
SELECT * FROM DEMO WHERE price>10
EXCEPT
SELECT * FROM DEMO WHERE price<100