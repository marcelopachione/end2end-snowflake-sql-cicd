-- Task Bronze
CREATE OR REPLACE TASK task_load_gold_customers
  WAREHOUSE = COMPUTE_WH
  after task_load_silver_customers
AS 
    call sp_load_gold_dim_customers();

-- Enable the task
-- ALTER TASK task_load_gold_customers RESUME;

-- List tasks execution history
-- SHOW TASKS LIKE 'task_load_gold_customers';