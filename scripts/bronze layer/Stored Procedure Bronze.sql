/* ==========================================================================================
   Procedure Name : bronze.load_bronze
   Layer          : Bronze
   Purpose        : Loads raw data from CSV files into Bronze layer tables (CRM & ERP).
                    This procedure truncates existing tables and bulk loads fresh data.

   Process Details:
     1. CRM Tables:
        - crm_cust_info      → Loads customer master data.
        - crm_prd_info       → Loads product master data.
        - crm_sales_details  → Loads sales transactions.

     2. ERP Tables:
        - erp_loc_a101       → Loads customer location (country/region).
        - erp_cust_az12      → Loads customer demographics (birthdate, gender).
        - erp_px_cat_g1v2    → Loads product categories & maintenance info.

   Key Notes:
     - Uses BULK INSERT from local CSV files.
     - Truncates target tables before loading.
     - Execution time for each table and batch is printed in seconds.
     - TRY...CATCH block is implemented to handle errors gracefully.
     - Paths are currently local (C:\Users\Ahmed\...), should be parameterized or 
       adapted for production environments.

   Author        : Ahmed
   Created On    : 2025-10-04
   Version       : 1.0
========================================================================================== */

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME,@BatchStartTime DATETIME,@BatchEndTime DATETIME;

    SET @BatchStartTime = GETDATE();
    BEGIN TRY
        PRINT '============================================';
        PRINT '>>> Loading Bronze Layer...';
        PRINT '============================================';

        PRINT '--------------------------------------------';
        PRINT '>>> Loading CRM Tables...';
        PRINT '--------------------------------------------';
        -- 1) CRM Customer Info
        SET @start_time = GETDATE();
        PRINT '>> Truncating table bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Inserting data into bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\Ahmed\Desktop\Data Engineering ITI\Baraa Project\datasets\bronze date\bronze.crm_cust_info.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------------------';

        -- 2) CRM Product Info
        SET @start_time = GETDATE();
        PRINT '>> Truncating table bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Inserting data into bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\Ahmed\Desktop\Data Engineering ITI\Baraa Project\datasets\bronze date\bronze.crm_prd_info.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------------------';

        -- 3) CRM Sales Details
        SET @start_time = GETDATE();
        PRINT '>> Truncating table bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Inserting data into bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\Ahmed\Desktop\Data Engineering ITI\Baraa Project\datasets\bronze date\bronze.crm_sales_details.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------------------';
 

        PRINT '--------------------------------------------';
        PRINT '>>> Loading ERP Tables...';
        PRINT '--------------------------------------------';

        -- 4) ERP Location (loc_a101)
        SET @start_time = GETDATE();
        PRINT '>> Truncating table bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT '>> Inserting data into bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\Ahmed\Desktop\Data Engineering ITI\Baraa Project\datasets\bronze date\bronze.erp_loc_a101.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------------------';

        -- 5) ERP Customers (cust_az12)
        SET @start_time = GETDATE();
        PRINT '>> Truncating table bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;
        PRINT '>> Inserting data into bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\Ahmed\Desktop\Data Engineering ITI\Baraa Project\datasets\bronze date\bronze.erp_cust_az12.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------------------';

        -- 6) ERP Categories (px_cat_g1v2)
        SET @start_time = GETDATE();
        PRINT '>> Truncating table bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        PRINT '>> Inserting data into bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\Ahmed\Desktop\Data Engineering ITI\Baraa Project\datasets\bronze date\bronze.erp_px_cat_g1v2.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------------------';

        SET @BatchEndTime = GETDATE();
        PRINT '============================================';
        PRINT '>>> Loading Bronze Layer COMPLETED!';
        PRINT '>>> Total Load Duration: ' + CAST(DATEDIFF(SECOND,@BatchStartTime,@BatchEndTime) AS NVARCHAR) + ' seconds';
    End TRY

    BEGIN CATCH 
        PRINT '============================================';
        PRINT '!!! ERROR occurred while loading Bronze Layer !!!';
        PRINT 'Error Number   : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message  : ' + ERROR_MESSAGE();
        PRINT 'Error Severity : ' + CAST(ERROR_SEVERITY() AS NVARCHAR);
        PRINT 'Error State    : ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '============================================';  
    END CATCH
End

