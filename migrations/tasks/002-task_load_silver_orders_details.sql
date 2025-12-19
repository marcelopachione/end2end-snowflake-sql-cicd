-- Task Silver
CREATE OR REPLACE TASK task_load_silver_orders_details
  WAREHOUSE = COMPUTE_WH
  after task_load_bronze_orders_details
AS 
    call sp_load_silver_orders_details()
;