-- Task Silver
CREATE OR REPLACE TASK task_load_silver_orders
  WAREHOUSE = COMPUTE_WH
  after task_load_bronze_orders
AS 
    call sp_load_silver_orders()
;