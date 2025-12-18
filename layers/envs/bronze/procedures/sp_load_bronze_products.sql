CREATE OR REPLACE PROCEDURE sp_load_bronze_products()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    TRUNCATE TABLE bronze_products;

    INSERT INTO bronze_products
    SELECT 
        CAST($1 AS VARIANT) as raw,                   -- ← CAST para VARIANT
        metadata$filename as filename,                     
        CURRENT_TIMESTAMP() as created_at                  
    FROM @SNOWSQL_DB.PUBLIC.NORTH/products/ (FILE_FORMAT => 'PARQUET_FORMAT');
    RETURN 'Load Bronze products table successfully';
END;
$$;