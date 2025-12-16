USE DATABASE snowDB;
USE SCHEMA PUBLIC;

-- Create stage for S3 bucket North
CREATE STAGE North 
	URL = 's3://snowflake-arruda-s3/north/' 
	CREDENTIALS = ( AWS_KEY_ID = '**********' AWS_SECRET_KEY = '*******' ) 
	DIRECTORY = ( ENABLE = true ) 
	COMMENT = 'Project - end2end-snowflake-sql-cicd';

-- List files in the stage
LIST @North;