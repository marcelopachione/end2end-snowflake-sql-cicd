CREATE OR REPLACE PROCEDURE sp_load_bronze_orders_details()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    TRUNCATE TABLE bronze_orders_details;

    INSERT INTO bronze_orders_details
SELECT 
    CAST($1 AS VARIANT) as raw,                   -- ← CAST para VARIANT
    metadata$filename as filename,                     
    CURRENT_TIMESTAMP() as created_at                  
FROM @SNOWSQL_DB.PUBLIC.NORTH/orders_datails/ (FILE_FORMAT => 'PARQUET_FORMAT');
    RETURN 'Load Bronze Orders Details table successfully';
END;
$$;