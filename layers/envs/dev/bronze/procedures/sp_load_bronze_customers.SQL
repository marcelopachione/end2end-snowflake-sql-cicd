-- Create procedure to load data from S3 to bronze_customers table
CREATE OR REPLACE PROCEDURE snowDB.dev.sp_load_bronze_customers()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    TRUNCATE TABLE snowDB.dev.bronze_customers;

    INSERT INTO snowDB.dev.bronze_customers
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