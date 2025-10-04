/* ==========================================================================================
   Script Name : bronze_tables_creation.sql
   Layer       : Bronze
   Purpose     : This script creates all CRM and ERP source tables in the Bronze layer.
                 It ensures old versions are dropped (if exist) and then re-created.
                 These tables are used to store raw data loaded directly from source systems.
   
   Details:
     - CRM Tables:
         * crm_cust_info      → Stores customer master information.
         * crm_prd_info       → Stores product master information.
         * crm_sales_details  → Stores sales transactions.

     - ERP Tables:
         * erp_loc_a101       → Stores customer location (Country/Region).
         * erp_cust_az12      → Stores customer demographic info (Birthdate, Gender).
         * erp_px_cat_g1v2    → Stores product categories and maintenance info.

   Notes:
     - This script uses IF OBJECT_ID to drop tables if they already exist.
     - All tables are created in schema: bronze.
     - Data will be ingested later using Stored Procedures (ETL jobs).
========================================================================================== */

IF OBJECT_ID('bronze.crm_customer_info', 'U') IS NOT NULL
    DROP TABLE bronze.CRM_customer_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_material_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);


IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_ID INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME
);

-- 3) Sales Details
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

---------------------------
-- ERP Tables
---------------------------

IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erd_loc_a101;
GO

CREATE TABLE bronze.erd_loc_a101 (
    cid NVARCHAR(50),
    cntry NVARCHAR(50)
);



IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erd_cust_az12;
GO

CREATE TABLE bronze.erd_cust_az12 (
    cid NVARCHAR(50),
    bdate Date,
    gen NVARCHAR(50)
);


IF OBJECT_ID('bronze.erd_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erd_px_cat_g1v2;
GO

CREATE TABLE bronze.erd_px_cat_g1v2 (
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);
