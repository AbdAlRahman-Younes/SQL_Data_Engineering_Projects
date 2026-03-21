-- Step 1: DW - Create star schema tables (Data Warehouse)
-- Drop existing tables if they exist (for idempotency)
DROP TABLE IF EXISTS skills_job_dim;
DROP TABLE IF EXISTS job_postings_fact;
DROP TABLE IF EXISTS skills_dim;
DROP TABLE IF EXISTS company_dim;

-- Create company_dim table
CREATE TABLE company_dim
(
    company_id   INT PRIMARY KEY,
    name         TEXT,
    link         TEXT
);

-- Create skills_dim table
CREATE TABLE skills_dim
(
    skill_id     INT PRIMARY KEY,
    skills       TEXT,
    type         TEXT
);

-- Create job_postings_fact table (must be created before skills_job_dim)
CREATE TABLE job_postings_fact
(
    job_id                   INT PRIMARY KEY,
    company_id               INT,
    job_title_short          VARCHAR(255),
    job_title                TEXT,
    job_location             TEXT,
    job_via                  TEXT,
    job_schedule_type        TEXT,
    job_work_from_home       BOOLEAN,
    search_location          TEXT,
    job_posted_date          TIMESTAMP,
    job_no_degree_mention    BOOLEAN,
    job_health_insurance     BOOLEAN,
    job_country              TEXT,
    salary_rate              TEXT,
    salary_year_avg          NUMERIC,
    salary_hour_avg          NUMERIC,
    FOREIGN KEY (company_id) REFERENCES company_dim (company_id)
);

-- Create skills_job_dim table with a composite primary key and foreign keys (after job_postings_fact exists)
CREATE TABLE skills_job_dim
(
    skill_id INT,
    job_id   INT,
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES job_postings_fact (job_id),
    FOREIGN KEY (skill_id) REFERENCES skills_dim (skill_id)
);

-- Create indexes on foreign key columns for better performance
CREATE INDEX idx_company_id ON job_postings_fact (company_id);
CREATE INDEX idx_skill_id ON skills_job_dim (skill_id);
CREATE INDEX idx_job_id ON skills_job_dim (job_id);

-- Verify tables were created
Select *
from information_schema.columns
where table_schema = 'main';