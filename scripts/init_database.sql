/*
===========================================================
 Script Name: init_database.sql
 Description: Creates the Data Warehouse database and schemas.
 Warning: Running this script will DROP the database if it exists.
 Author: Ahmed
 Date: 2025-10-03
===========================================================
*/

USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    DROP DATABASE DataWarehouse;
END
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
