-- Create a new database
CREATE DATABASE ProjectDB

-- Switch to the new database
USE ProjectDB

-- Load csv into Tables
--1) Databases --> ProjectDB --> Tasks --> Import Flat File

-- Check Data
SELECT TOP 10 * FROM Fact
SELECT TOP 10 PERCENT * FROM Location
SELECT * FROM Product

--==============================================================================
--SYSTEM INFO

	--GET INSTANCE NAME
SELECT @@SERVERNAME AS ServerName

	--GET INSTANCE NAME
SELECT SERVERPROPERTY('InstanceName') AS InstanceName

	--GET LOGIN NAME, CURRENT SESSION ID
SELECT login_name, session_id
FROM sys.dm_exec_sessions
WHERE session_id = @@SPID

	--GET CURRENT DATABASE NAME
SELECT DB_NAME() AS DatabaseName

	--Tables in database
SELECT name FROM sys.tables