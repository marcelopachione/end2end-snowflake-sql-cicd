!set variable_substitution=true  -- habilita &{VAR} no SnowSQL

USE SCHEMA PUBLIC;

-- Create stage for S3 bucket North
-- CREATE STAGE IF NOT EXISTS North 
-- 	URL = 's3://snowflake-arruda-s3/north/' 
-- 	CREDENTIALS = ( AWS_KEY_ID = '**********' AWS_SECRET_KEY = '*******' ) 
-- 	DIRECTORY = ( ENABLE = true ) 
-- 	COMMENT = 'Project - end2end-snowflake-sql-cicd';


CREATE STAGE IF NOT EXISTS North
  URL = 's3://snowflake-arruda-s3/north/'
  CREDENTIALS = (
    AWS_KEY_ID     = '&{SNOWSQL_AWS_KEY_ID}'
    AWS_SECRET_KEY = '&{SNOWSQL_AWS_SECRET_KEY}'
  )
  DIRECTORY = (ENABLE = TRUE)
  COMMENT = 'Project - end2end-snowflake-sql-cicd';