USE ProjectDB

--==========================================================================
--1. Stored Procedure
	--A Stored Procedure is a precompiled block of SQL code stored in the database that you can execute with parameters.

	--1. Simple Stored Procedure (no parameters)
CREATE PROCEDURE sp_GetAllSales
AS
BEGIN 
	SELECT f.Date, p.Product, l.State, f.Sales, f.Profit 
	FROM Fact f
	INNER JOIN Product p ON f.ProductId = p.ProductId
	INNER JOIN Location l ON f.Area_Code = l.Area_Code
END

EXEC sp_GetAllSales

	--2. Stored Procedure with Input Parameter
CREATE PROCEDURE sp_GetSalesByState @state VARCHAR(50)
AS
BEGIN
	SELECT f.Date, p.Product, l.State, f.Sales, f.Profit
    FROM Fact f
    JOIN Product p ON f.ProductId = p.ProductId
    JOIN Location l ON f.Area_Code = l.Area_Code
	WHERE l.State = @state
END

EXEC sp_GetSalesByState @state = 'California'

	--3. Stored Procedure with Multiple Parameters
CREATE PROCEDURE sp_GetProductSalesInRange
	@ProductId INT,
	@StartDate DATE, 
	@EndDate DATE
AS
BEGIN
	SELECT f.Date, p.Product, f.Sales, f.Profit
    FROM Fact f
    JOIN Product p ON f.ProductId = p.ProductId
    WHERE f.ProductId = @ProductId
    AND f.Date BETWEEN @StartDate AND @EndDate
END

EXEC sp_GetProductSalesInRange @ProductId = 5, @StartDate = '2010-01-01', @EndDate = '2011-01-12'

	--4. Stored Procedure with Default Parameter
CREATE PROCEDURE sp_GetSalesOptionalState
    @State NVARCHAR(50) = NULL
AS
BEGIN
    SELECT f.Date, p.Product, l.State, f.Sales, f.Profit
    FROM Fact f
    JOIN Product p ON f.ProductId = p.ProductId
    JOIN Location l ON f.Area_Code = l.Area_Code
    WHERE @State IS NULL OR l.State = @State
END

EXEC sp_GetSalesOptionalState @State = 'Washington'
EXEC sp_GetSalesOptionalState

	--5. Stored Procedure with Output Parameter
CREATE PROCEDURE sp_GetTotalSales
	@ProductId INT, 
	@TotalSales DECIMAL(10, 2) OUTPUT
AS
BEGIN
	SELECT @TotalSales = SUM(Sales)
	FROM Fact
	WHERE ProductId = @ProductId
END

DECLARE @Result DECIMAL(10, 2)
EXEC sp_GetTotalSales @ProductId = 5, @TotalSales = @Result OUTPUT
Print @Result

	--6. Stored Procedure with TRY…CATCH (Error Handling)
CREATE PROCEDURE sp_CalculateMargin
	@ProductId INT 
AS
BEGIN
	BEGIN TRY
		SELECT ProductId, Sales, Profit, (Profit*100.0/NULLIF(Sales, 0)) AS ProfitMargin
		FROM Fact
		WHERE Productid = @ProductId
	END TRY
	BEGIN CATCH
		PRINT 'Error Occured' + ERROR_MESSAGE()
	END CATCH
END

EXEC sp_CalculateMargin @ProductId = 5


--==========================================================================
--2. Functions
	--A function in SQL Server is a predefined or user-defined block of code that always returns a value (scalar or table).
	--Functions are used inside queries (e.g., SELECT, WHERE, JOIN) while procedures are usually executed with EXEC.

	--1. Scalar Function Example : Return total sales for a given ProductId
CREATE FUNCTION fn_GetTotalSales(@ProductId INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
	DECLARE @TotalSales DECIMAL(10, 2)

	SELECT @TotalSales = SUM(Sales)
	FROM Fact
	WHERE ProductId = @ProductId

	RETURN ISNULL(@TotalSales, 0)
END

SELECT dbo.fn_GetTotalSales(5) AS TotalSales

	--2. Inline Table-Valued Function : Return Fact records for a given State
CREATE FUNCTION fn_GetFactsByState(@State VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT f.Date, f.ProductId, f.Sales, f.Profit, l.State, l.Market
    FROM Fact f
    JOIN Location l ON f.Area_Code = l.Area_Code
    WHERE l.State = @State
)

SELECT * FROM dbo.fn_GetFactsByState('California')


	--3. Multi-Statement Table-Valued Function
CREATE FUNCTION fn_GetCategorySummary(@category VARCHAR(50))
RETURNS @Summary TABLE
(
    Category VARCHAR(50),
    TotalSales DECIMAL(18,2),
    TotalProfit DECIMAL(18,2)
)
AS
BEGIN
	INSERT INTO @Summary (category, TotalSales, TotalProfit)
	SELECT p.Product_Type, SUM(f.Sales) AS TotalSales, SUM(f.Profit) AS TotalProfit
	FROM Fact f
	INNER JOIN Product p
	ON f.ProductId = p.ProductId
	WHERE p.Product_Type = @Category
	GROUP BY p.Product_Type

	RETURN
END

SELECT * FROM dbo.fn_GetCategorySummary('Coffee')

	--4. UDF inside query
SELECT p.Product, dbo.fn_GetTotalSales(p.ProductId) AS TotalSales
FROM Product p
ORDER BY TotalSales DESC