-- Master build script for data warehouse and mart pipeline
-- This file runs all steps in sequence to build the complete warehouse and marts

-- Step 1: DW - Create star schema tables
.read 01_create_tables_dw.sql

-- Step 2: DW - Load data from CSV files into star schema
.read 02_load_schema_dw.sql