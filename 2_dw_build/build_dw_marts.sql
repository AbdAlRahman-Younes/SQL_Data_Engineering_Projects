-- Master build script for data warehouse and mart pipeline
-- This file runs all steps in sequence to build the complete warehouse and marts
-- This file expects running duckdb in the 2_dw_build folder, if not use absolute file paths before executing

-- Step 1: DW - Create star schema tables
.read 01_create_tables_dw.sql

-- Step 2: DW - Load data from CSV files into star schema
.read 02_load_schema_dw.sql

-- Step 3: Mart - Create flat mart (denormalized table)
.read 03_create_flat_mart.sql

-- Step 4: Mart - Create skills demand mart
.read 04_create_skills_mart.sql