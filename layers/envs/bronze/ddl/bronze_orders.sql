CREATE TABLE IF NOT EXISTS bronze_orders (
    raw VARIANT,           -- Raw JSON
    filename STRING,       -- Name file
    created_at TIMESTAMP   -- Timestamp of load
);
