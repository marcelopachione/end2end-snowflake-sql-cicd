CREATE OR REPLACE PROCEDURE sp_load_bronze_orders()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    TRUNCATE TABLE bronze_orders;

    INSERT INTO bronze_orders
        SELECT 
            CAST($1 AS VARIANT) as raw,
            metadata$filename as filename,                     
            CURRENT_TIMESTAMP() as created_at                  
        FROM @SNOWSQL_DB.PUBLIC.NORTH/orders/ (FILE_FORMAT => 'PARQUET_FORMAT');
    RETURN 'Load Bronze Orders table successfully';
END;
$$;