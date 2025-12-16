-- Create procedure to load data from bronze_customers table to silver_customers table
CREATE OR REPLACE PROCEDURE snowDB.dev.sp_load_silver_customers()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    TRUNCATE TABLE snowDB.dev.silver_customers;

  INSERT INTO snowDB.dev.silver_customers
    SELECT 
        COALESCE(UPPER($1:"customer_id"::string),'N/A') as customer_id,
        COALESCE(UPPER($1:"company_name"::string),'N/A') as company_name,
        COALESCE(UPPER($1:"contact_name"::string),'N/A') as contact_name,
        COALESCE(UPPER($1:"contact_title"::string),'N/A') as contact_title,
        COALESCE(UPPER($1:"country"::string),'N/A') as country,
        COALESCE(UPPER($1:"city"::string),'N/A') as city,
        COALESCE(UPPER($1:"address"::string),'N/A') as address,
        COALESCE(UPPER($1:"postal_code"::string),'N/A') as postal_code,
        COALESCE(UPPER($1:"phone"::string),'N/A') as phone,
        COALESCE(UPPER($1:"fax"::string),'N/A') as fax,
        current_timestamp as created_at
    FROM snowDB.dev.bronze_customers;

    RETURN 'Load Silver Customers table successfully';
END;
$$;

-- Execute the procedure
-- CALL sp_load_silver_customers();