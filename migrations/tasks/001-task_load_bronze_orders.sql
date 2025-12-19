-- Task Bronze
CREATE OR REPLACE TASK task_load_bronze_orders
  WAREHOUSE = COMPUTE_WH
  SCHEDULE = 'USING CRON */5 * * * * Europe/Dublin' -- every 5 minutes
AS
  CALL sp_load_bronze_orders();