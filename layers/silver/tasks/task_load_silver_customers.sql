USE DATABASE snowDB;

-- Task Silver
CREATE OR REPLACE TASK snowDB.dev.task_load_silver_customers
  WAREHOUSE = COMPUTE_WH
  after snowDB.dev.task_load_bronze_customers
AS 
    call snowDB.dev.sp_load_silver_customers()
;

-- Enable the task
-- ALTER TASK task_load_silver_customers RESUME;

-- List tasks execution history
-- SHOW TASKS LIKE 'task_load_silver_customers';