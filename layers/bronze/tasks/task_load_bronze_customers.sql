USE DATABASE snowDB;
USE SCHEMA DEV;

-- Task Bronze
CREATE OR REPLACE TASK task_load_bronze_customers
  WAREHOUSE = COMPUTE_WH
  SCHEDULE = 'USING CRON */5 * * * * Europe/Dublin' -- every 5 minutes
AS
  CALL load_bronze_customers();

-- Enable the task
-- ALTER TASK task_load_bronze_customers RESUME;

-- List tasks execution history
-- SHOW TASKS LIKE 'task_load_bronze_customers';

-- Drop task
-- DROP TASK TASK_BRONZE_CUSTOMERS;