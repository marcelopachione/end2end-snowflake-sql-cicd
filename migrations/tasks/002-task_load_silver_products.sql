-- Task Silver
CREATE OR REPLACE TASK task_load_gold_products
  WAREHOUSE = COMPUTE_WH
  after task_load_bronze_products
AS 
    call sp_load_silver_products()
;