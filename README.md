# end2end-snowflake-sql-cicd

Short summary
-------------
Project for end-to-end SQL pipelines on Snowflake using Bronze/Silver/Gold layers, migrations and automated tasks. Organisation is by DDLs, stored procedures and task scripts to demonstrate an ingestion and transformation cycle suitable for CI/CD.

What it is
----------
- SQL scripts implementing a layered pipeline (bronze → silver → gold) for Snowflake.
- Includes DDLs, stored procedures, views and migration/task scripts.

Problem it solves
-----------------
Standardises and versions database provisioning and job workflows on Snowflake by providing a reusable set of artefacts for:
- Provisioning objects (schemas, tables, stages)
- Initial load and layered transformations
- Orchestration using tasks

High-level architecture
-----------------------
- Raw data lands in an external stage (e.g. S3/Parquet).
- `bronze` layer: ingestion and raw records (`layers/envs/bronze`).
- `silver` layer: cleansing and intermediate transformations (`layers/envs/silver`).
- `gold` layer: curated models for analytics (`layers/envs/gold`).
- Migrations and tasks in `migrations/` apply infrastructure and jobs.

Key technologies
----------------
- Snowflake (SQL, Stored Procedures, Tasks)
- File format: Parquet (see `migrations/002_file_parquet.sql`)
- Cloud storage (e.g. S3 — `migrations/003_bucket_s3.sql`)

How it works (quick)
--------------------
1. Run migration scripts to create database, schemas and stages.
2. Create/populate Bronze tables using scripts in `layers/envs/bronze`.
3. Run stored procedures to build Silver and Gold datasets.
4. Schedule or trigger `tasks` in `migrations/tasks/` for automation.

Folder structure
----------------
- `layers/envs/bronze/` : `ddl/`, `procedures/`, `views/` for the bronze layer
- `layers/envs/silver/` : DDLs and procedures for the silver layer
- `layers/envs/gold/` : DDLs and procedures for the gold layer
- `migrations/` : sequential scripts to create DB/schema/resources
- `migrations/tasks/` : scripts to create/execute tasks (orchestration)

Key files
---------
- `migrations/000_createDB.sql` — creates the main database
- `migrations/001_createSchema.sql` — creates schemas and initial roles
- `layers/envs/bronze/ddl/bronze_customers.sql` — bronze table DDL
- `layers/envs/bronze/procedures/sp_load_bronze_customers.sql` — ingestion procedure

Variables / Secrets for GitHub Actions
-------------------------------------
To run workflows that apply migrations or invoke `snowsql` via GitHub Actions, configure the following repository secrets (Settings → Secrets & variables → Actions):

- `SNOWSQL_ACCOUNT`: Snowflake account identifier (e.g. xy12345.us-east-1)
- `SNOWSQL_USER`: user with permissions to run migrations/tasks
- `SNOWSQL_PWD`: user credential (prefer private key when possible)
- `SNOWSQL_DB`: target database used in migrations
- `SNOWSQL_AWS_KEY_ID`: (if using S3 stages)
- `SNOWSQL_AWS_SECRET_KEY`: (if using S3 stages)

Example usage in a workflow:

```yaml
env:
  SNOWSQL_ACCOUNT: ${{ secrets.SNOWSQL_ACCOUNT }}
  SNOWSQL_USER: ${{ secrets.SNOWSQL_USER }}
  SNOWSQL_PWD: ${{ secrets.SNOWSQL_PWD }}
  SNOWSQL_DB: ${{ secrets.SNOWSQL_DB }}
  SNOWSQL_AWS_KEY_ID: ${{ secrets.SNOWSQL_AWS_KEY_ID }}
  SNOWSQL_AWS_SECRET_KEY: ${{ secrets.SNOWSQL_AWS_SECRET_KEY }}
```

Next steps and improvements
--------------------------
- Infrastructure as Code (Terraform) for provisioning accounts, stages and S3 integrations.
- Integrate dbt for modelling and data-quality tests in the Silver/Gold layers.