USE ProjectDB

--==========================================================================
--1. Numeric Functions

	--1. ABS() – Absolute Value
SELECT ABS(34.53) AS Value
SELECT ABS(-34.53) AS Value

	--2. CEILING() – Smallest integer ≥ value
SELECT CEILING(12.34) AS Value
SELECT CEILING(-12.34) AS Value

	--3. FLOOR() – Largest integer ≤ value
SELECT FLOOR(12.34) AS Value
SELECT FLOOR(-12.34) AS Value

	--4. ROUND() – Round to given decimals
SELECT ROUND(12.34, 0) AS Value
SELECT ROUND(12.34, 1) AS Value
SELECT ROUND(12.34, -1) AS Value

	--5. POWER() – Raise to a power
SELECT POWER(5, 2) AS Value
SELECT POWER(25, 1.0/2) AS Value

	--6. SQRT() – Square Root
SELECT SQRT(25) AS Value
SELECT SQRT(95) AS Value

	--7. SIGN() – Returns -1, 0, 1 depending on sign
SELECT SIGN(25) AS Value
SELECT SIGN(0) AS Value
SELECT SIGN(-95) AS Value

	--8. RAND() – Random number between 0 and 1
SELECT RAND() AS Value

	--9. LOG() and LOG10() – Natural log & log base 10
SELECT LOG(25) AS Value
SELECT LOG10(1000) AS Value

	--10. EXP() – Exponential
SELECT EXP(1) AS Value
SELECT EXP(10) AS Value

	--11. PI() – Constant value of π
SELECT PI() AS Value


--==========================================================================
--1. String Functions

	--1. LEN() – Returns length of string
SELECT LEN('Hello World') AS Value
SELECT LEN('SQL') AS Value

	--2. LTRIM() – Removes leading spaces
SELECT LTRIM('    Hello') AS Value

	--3. RTRIM() – Removes trailing spaces
SELECT RTRIM('Hello    ') AS Value

	--4. TRIM() – Removes both leading and trailing spaces
SELECT TRIM('    Hello    ') AS Value

	--5. LOWER() – Converts to lowercase
SELECT LOWER('HELLO SQL') AS Value

	--6. UPPER() – Converts to uppercase
SELECT UPPER('hello sql') AS Value

	--7. REVERSE() – Reverses string
SELECT REVERSE('SQL') AS Value

	--8. LEFT() – Extracts leftmost characters
SELECT LEFT('Database', 4) AS Value

	--9. RIGHT() – Extracts rightmost characters
SELECT RIGHT('Database', 4) AS Value

	--10. SUBSTRING() – Extracts substring
SELECT SUBSTRING('Database', 2, 4) AS Value

	--11. CHARINDEX() – Returns index of the string
SELECT CHARINDEX( 'SQL','Database SQL Server') AS Value

	--12. REPLACE() – Replace substring
SELECT REPLACE('SQL Server', 'Server', 'Database') AS Value

	--13. REPLACE() – Reverse a string
SELECT REVERSE('Database') AS Value

	--14. REPLICATE() – Repeat string multiple times separated with space
SELECT REPLICATE('SQL ', 3) AS Value

	--15. SPACE() – Returns spaces
SELECT 'Hello' + SPACE(5) + 'World' AS Value

	--16. CHAR() – Returns character from ASCII code
SELECT CHAR(65) AS Value

	--17. ASCII() – Returns ASCII code of character
SELECT ASCII('A') AS Value

	--18. CONCAT() – Concatenates strings
SELECT CONCAT('SQL', ' ', 'Server') AS Value

	--19. CONCAT_WS() – Concatenates with separator
SELECT CONCAT_WS('-', '2025', '08', '17') AS Value

	--20. FORMAT() – Formats values
SELECT FORMAT(1234567, 'N2') AS Value


--==========================================================================
--1. Date Functions

	--1. GETDATE() – Returns current date and time
SELECT GETDATE() AS CurrentDateTime

	--2. DAY(), MONTH(), YEAR() – Extracts day, month, year
SELECT DAY(GETDATE()) AS DayVal
SELECT MONTH(GETDATE()) AS MonthVal
SELECT YEAR(GETDATE()) AS YearVal

	--3. DATENAME() – Returns a part of date as string
SELECT DATENAME(month, GETDATE()) AS MonthName
SELECT DATENAME(weekday, GETDATE()) AS DayName

	--4. DATEPART() – Returns integer part of date
SELECT DATEPART(year, GETDATE()) AS YearPart
SELECT DATEPART(month, GETDATE()) AS MonthPart
SELECT DATEPART(day, GETDATE()) AS DayPart

	--5. DATEADD() – Add interval to a date
SELECT DATEADD(day, 10, GETDATE()) AS Plus10Days
SELECT DATEADD(month, -2, GETDATE()) AS Minus2Months

	--6. DATEDIFF() – Difference between dates
SELECT DATEDIFF(day, '2025-01-01', GETDATE()) AS DaysDiff
SELECT DATEDIFF(month, '2024-01-01', '2025-01-01') AS MonthsDiff

	--7. ISDATE() – Checks if valid date
SELECT ISDATE('2025-08-17') AS ValidCheck   -- 1 = valid
SELECT ISDATE('2025-99-99') AS ValidCheck   -- 0 = invalid

	--8. CAST() / CONVERT() – Format date
SELECT CAST(GETDATE() AS DATE) AS OnlyDate
SELECT CONVERT(VARCHAR(10), GETDATE(), 103) AS FormattedDate


--==========================================================================
--1. Misc Functions

	--1. IIF() – Shorthand for IF-ELSE (returns value based on condition)
SELECT IIF(10 > 5, 'True', 'False') AS Result

	--2. CHOOSE() – Returns element from a list by index (1-based)
SELECT CHOOSE(2, 'SQL', 'Server', 'Database') AS Value

	--3. CAST() – Converts value from one data type to another
SELECT CAST(123.45 AS INT) AS Value  
SELECT CAST(GETDATE() AS DATE) AS OnlyDate

	--4. CONVERT() – Converts data type with style (commonly for dates)
SELECT CONVERT(VARCHAR(10), GETDATE(), 103) AS UKFormat

	--5. EXISTS() – checks if a subquery returns any rows.
IF EXISTS (SELECT 1)
    PRINT 'There are user tables'
ELSE
    PRINT 'No user tables'

	--6. CASE() – Returns a value based on conditions.
SELECT 'HP' AS Device,
    CASE 
        WHEN 1<5 THEN 'Laptop'
        WHEN 7<5 THEN 'Mobile'
        ELSE 'Other'
    END AS ProductType