-- migrations/snowflake/001_bucket_s3.sql
!set variable_substitution=true

USE SCHEMA PUBLIC;

CREATE STAGE IF NOT EXISTS North
  URL = 's3://snowflake-arruda-s3/north/'
  CREDENTIALS = (
    AWS_KEY_ID     = '&{SNOWSQL_AWS_KEY_ID}'
    AWS_SECRET_KEY = '&{SNOWSQL_AWS_SECRET_KEY}'
  )
  DIRECTORY = (ENABLE = TRUE)
  COMMENT = 'Project - end2end-snowflake-sql-cicd';
