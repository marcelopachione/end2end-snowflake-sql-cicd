-- Task Bronze
CREATE OR REPLACE TASK snowDB.dev.task_load_bronze_customers
  WAREHOUSE = COMPUTE_WH
  SCHEDULE = 'USING CRON */5 * * * * Europe/Dublin' -- every 5 minutes
AS
  CALL snowDB.dev.sp_load_bronze_customers();

-- Enable the task
-- ALTER TASK task_load_bronze_customers RESUME;

-- Execute task
-- EXECUTE TASK task_load_bronze_customers;

-- List tasks execution history
-- SHOW TASKS LIKE 'task_load_bronze_customers';

-- Drop task
-- DROP TASK task_load_bronze_customers;