# SQL Data Warehouse Project

**Short description:** Building a modern data warehouse with SQL Server using Medallion Architecture (Bronze / Silver / Gold).

## Structure
- `datasets/` - source CSV files
- `scripts/` - SQL scripts for DB, ETL, transformations
- `migrations/` - versioned schema changes
- `docs/` - architecture diagrams, requirements, notes
- `tests/` - data/tests

## How to run
1. Create the database: `scripts/database/create_database.sql`
2. Load Bronze: `scripts/bronze/*`
3. Clean/transform to Silver: `scripts/silver/*`
4. Build Gold views / models: `scripts/gold/*`

## Conventions
- Naming: `snake_case`
- Bronze tables: `source_entity` (e.g., `crm_customer_info`)
- Gold tables: `dim_`, `fact_`, `agg_`

## License
MIT
