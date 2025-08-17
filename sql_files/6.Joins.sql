USE ProjectDB

--==========================================================================
--1. Inner Joins : 
	--Only returns rows where the join condition matches in both tables.

SELECT f.Date, p.Product, p.Product_Type, f.Sales, f.Profit
FROM Fact f 
INNER JOIN Product p
	ON f.ProductId = p.ProductId

SELECT f.Date, p.Product, l.State, f.Sales, f.Profit
FROM Fact f
INNER JOIN Product p
    ON f.ProductId = p.ProductId
INNER JOIN Location l
    ON f.Area_Code = l.Area_Code


--2. Left Join (Left Outer Join)
	--Keeps all rows from the left table and matches from the right (null if no match).

SELECT f.Date, p.Product, p.Product_Type, f.Sales
FROM Fact f
LEFT JOIN Product p
    ON f.ProductId = p.ProductId

--3. Right Join (Right Outer Join)
	--Keeps all rows from the right table and matches from the left (null if no match).

SELECT p.Product, p.Product_Type, f.Date, f.Sales
FROM Fact f
RIGHT JOIN Product p
    ON f.ProductId = p.ProductId


--4. Full Outer Join
--Keeps all rows from both tables, matching where possible.

SELECT f.Date, p.Product, p.Product_Type, f.Sales
FROM Fact f
FULL OUTER JOIN Product p
    ON f.ProductId = p.ProductId


--5. Cross Join
	--every row of one table with every row of the other.

SELECT p.Product, l.State
FROM Product p
CROSS JOIN Location l


--6. Self Join
	--Comparing rows within the same table.

SELECT 
	l1.State AS state1,
	l2.State AS state2,
	l1.Market
FROM Location l1
INNER JOIN Location l2
	ON l1.Market = l2.Market
	AND l1.State <> l2.State