-- Create bronze table customer
CREATE TABLE IF NOT EXISTS bronze_customers (
    raw VARIANT,           -- Raw JSON
    filename STRING,       -- Name file
    created_at TIMESTAMP   -- Timestamp of load
);