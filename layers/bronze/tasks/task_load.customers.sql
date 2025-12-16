USE DATABASE snowDB;
USE SCHEMA DEV;

-- Task Bronze
CREATE OR REPLACE TASK task_bronze_customers
  WAREHOUSE = COMPUTE_WH
  SCHEDULE = 'USING CRON */5 * * * * Europe/Dublin' -- every 5 minutes
AS
  CALL load_bronze_customers();

-- Enalble the task
-- ALTER TASK task_bronze_customers RESUME;

-- List tasks execution history
-- SHOW TASKS LIKE 'TASK_BRONZE_CUSTOMERS';