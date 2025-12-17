# end2end-snowflake-sql-cicd

An end-to-end ELT pipeline implemented in SQL for Snowflake. The project organizes data into layers (Bronze → Silver → Gold) using DDL, stored procedures and tasks to ingest, transform and deliver data ready for consumption.

**Highlights**

- **Goal:** Demonstrate a simple CI/CD-style data workflow for Snowflake, including raw ingestion, transformation/cleansing and dimensional modeling.
- **Focus:** well-organized SQL by layers, automation via procedures/tasks, and DDL examples for each layer.

**Architecture (summary)**

- **Bronze:** raw ingestion — tables that store JSON/PARQUET without transformation (`layers/bronze/ddl`).
- **Silver:** cleaned and structured data (e.g. `layers/silver/ddl/silver_customers.sql`).
- **Gold:** consumption-ready modeling for BI (e.g. dimensions in `layers/gold/ddl`).

The repository includes scripts to create the database/schema, file formats and external storage stages, plus procedures and tasks to orchestrate loads.

**Repository contents**

- `database/` — scripts to create database and schema.
- `external_storage/` — examples for configuring storage stages (S3).
- `file_format/` — file format definitions (e.g. Parquet).
- `layers/bronze`, `layers/silver`, `layers/gold` — DDL, procedures and tasks per layer.

**Quick start**

1. Create the database and schema in Snowflake: run `database/createDB.sql` (and `createSchema.sql` if provided).
2. Configure `file_format` and `external_storage` if using external files — run the SQL files in those folders.
3. Create DDL tables by running files in `layers/*/ddl/` in the order Bronze → Silver → Gold.
4. Review and run procedures in `layers/*/procedures/` to transform and load data.
5. Enable or run tasks in `layers/*/tasks/` to schedule automated loads.

**CI/CD with GitHub Actions**

This project uses GitHub Actions to automate the deployment of SQL scripts to different environments in Snowflake:

- **DEV:** Runs scripts in the `DEV` schema on every push to any branch (except `main`).
- **QA:** Runs scripts in the `QA` schema only after a successful deploy to DEV.
- **PRD:** Runs scripts in the production schema (defined by the `SCHEMA_PRD` variable) after merging into the `main` branch.

**Pipeline Workflow**

1. **Create a development branch.**
2. **Add or modify `.sql` files and commit/push your changes.**
3. **The pipeline will automatically execute:**
	- First in DEV.
	- If DEV succeeds, then in QA.
4. **After review, merge into `main` to trigger deployment to PRD.**

**Required Secrets**

The following secrets must be configured in your repository settings:
- `SNOWSQL_ACCOUNT`
- `SNOWSQL_DB`
- `SNOWSQL_USER`
- `SNOWSQL_PWD`

**Running the Pipeline Manually**

You can manually trigger the pipeline from the "Actions" tab in GitHub.

**Adding New SQL Scripts**

- Add or modify `.sql` files in your repository.
- On commit and push, the pipeline will detect and execute only the changed `.sql` files.

**Example: Triggering the Pipeline**

```sh
git checkout -b feature/my-new-view
# Edit or add your .sql files
git add sql/views/my_new_view.sql
git commit -m "feat: add my new view script"
git push origin feature/my-new-view
```

Open a Pull Request to `main` when ready for production deployment.

**Note:**

- The pipeline ensures QA only runs after a successful DEV deploy.
- Production deploys only occur after merging into `main`.
- All jobs require the Snowflake secrets to be set in the repository.
