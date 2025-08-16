USE ProjectDB
SELECT * FROM DEMO

--==========================================================================
--1. WHERE CLAUSE
	--1. Comparison Operators

		-- Equal to
SELECT * FROM DEMO WHERE price = 15.00

		-- Not equal to
SELECT * FROM DEMO WHERE price != 5.25

		-- Greater than / Less than
SELECT * FROM DEMO WHERE price > 20
SELECT * FROM DEMO WHERE qty < 50

		-- Greater than or equal / Less than or equal
SELECT * FROM DEMO WHERE qty >= 50
SELECT * FROM DEMO WHERE price <= 10


	--2. Logical Operators
		-- AND
SELECT * FROM DEMO WHERE price < 20 AND qty > 30

		-- OR
SELECT * FROM DEMO WHERE qty > 100 OR price < 5

		-- NOT
SELECT * FROM DEMO WHERE NOT price > 50


	--3. BETWEEN … AND
		-- Numeric range
SELECT * FROM DEMO WHERE price BETWEEN 5 AND 50
SELECT * FROM DEMO WHERE qty BETWEEN 30 AND 100


	--4. IN Operator
		-- Check multiple values
SELECT * FROM DEMO WHERE id IN (1, 3, 5, 7)
SELECT * FROM DEMO WHERE price IN (2.50, 5.25, 15.00)


	--5. LIKE Operator (Pattern Matching)
		-- Starts with 'P'
SELECT * FROM DEMO WHERE name LIKE 'P%'

		-- Ends with 'e'
SELECT * FROM DEMO WHERE name LIKE '%e'

		-- Contains 'ar'
SELECT * FROM DEMO WHERE name LIKE '%ar%'

		-- Single character wildcard
SELECT * FROM DEMO WHERE name LIKE '_e%'

	
	--6. IS NULL / IS NOT NULL
SELECT * FROM DEMO WHERE qty IS NULL
SELECT * FROM DEMO WHERE price IS NOT NULL


==========================================================================
--2. GROUP BY CLAUSE
	-- Total quantity per category
SELECT category, SUM(qty) AS total_qty, COUNT(qty) AS count
FROM DEMO
GROUP BY category

-- Total quantity per category per name
SELECT category, name, SUM(qty) AS total_qty, COUNT(qty) AS count
FROM DEMO
GROUP BY category, name

-- Number of products in each category
SELECT category, COUNT(*) AS product_count
FROM DEMO
GROUP BY category

-- Count of products with price not NULL
SELECT category, COUNT(price) AS priced_items
FROM DEMO
GROUP BY category


==========================================================================
--3. HAVING CLAUSE

	-- Categories with total quantity greater than 150
SELECT category, name, SUM(qty) AS total_qty
FROM DEMO
GROUP BY category, name
HAVING SUM(qty) > 150

	-- Categories with average price greater than 50
SELECT category, name, SUM(price) AS total_qty
FROM DEMO
GROUP BY category, name
HAVING AVG(price) > 50

-- Categories as office
SELECT category, SUM(price) AS total_qty
FROM DEMO
GROUP BY category
HAVING category='Office'


==========================================================================
--4. ORDER BY CLAUSE

	-- Sort all products by price ascending
SELECT * 
FROM DEMO
ORDER BY price ASC;

-- Sort by category, then price descending within each category
SELECT * 
FROM DEMO
ORDER BY category ASC, price DESC;

-- Combine aggregation with ORDER BY
SELECT category, SUM(qty) AS total_qty
FROM DEMO
GROUP BY category
ORDER BY total_qty DESC