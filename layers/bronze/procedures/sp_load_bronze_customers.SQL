-- Create procedure to load data from S3 to bronze_customers table
CREATE OR REPLACE PROCEDURE sp_load_bronze_customers()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    TRUNCATE TABLE bronze_customers;

    INSERT INTO bronze_customers
        SELECT 
            CAST($1 AS VARIANT) as raw,
            metadata$filename as filename,                     
            CURRENT_TIMESTAMP() as created_at                  
        FROM @snowDB.PUBLIC.NORTH/customers (FILE_FORMAT => 'PARQUET_FORMAT');
    RETURN 'Load Bronze Customers table successfully';
END;
$$;

-- Execute the procedure
-- CALL sp_load_bronze_customers();