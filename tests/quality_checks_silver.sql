/*
These are the tests that I used to perform various quality checks for
data consistency, accuracy, and standardization for the silver schema.
Such examples include:
- Checking for null or duplicate values
- Unwanted spaces.
- Data standardization and consistency
- Invalid date ranges and orders.
- Data consistency between related fields.
*/

-- Check for unwanted spaces
-- Expectation: No Results
SELECT
prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- Check for Nulls or Negative Numbers
-- Expectation: No Results
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

-- Check for Invalid Date Orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT
sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0
OR LEN() !=8

-- Check for Invalid Date Orders
SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt
