/*
Question: What are the highest-paying skills for data engineers in major Western European markets?
- Calculate annualized median salary per skill
- Normalize hourly salaries to annual equivalents
- Filter for skills with meaningful frequency (>100 postings)
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities.
*/
Select
    sd.skills as skill,
    count(jpf.job_id) as skill_demand,
    round(median(coalesce(salary_year_avg,salary_hour_avg * 2080))) as median_salary
From job_postings_fact as jpf
    inner join skills_job_dim as sjd on jpf.job_id = sjd.job_id
    inner join skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short like ('%Data Engineer')
    and job_country In('United Kingdom','Netherlands','France','Germany','Poland','Sweden','Ireland')
group by
    sd.skills
having
    skill_demand > 100
order by median_salary desc, skill_demand desc
limit 25;

/*
Here's the breakdown of the highest-paying skills for data engineers in Western Europe (minimum 100 postings):

Distributed and NoSQL database technologies lead compensation. Cassandra, DynamoDB, Redis, and Neo4j share the highest median salary (~$171,500), indicating strong pay premiums for large-scale data storage expertise.
Mongo and SAS follow, suggesting that both modern NoSQL systems and legacy enterprise analytics tools retain financial value.
MySQL and FastAPI sit in the mid–upper salary tier, showing that backend and API-layer skills contribute to compensation strength.
High-demand cloud and data platform tools (Databricks, Snowflake, Airflow, Terraform, BigQuery) cluster around ~$147,500, combining strong demand with upper salary band alignment.
Business intelligence tools (Power BI, Tableau, Looker, DAX) also appear in the upper salary cluster, reflecting overlap between analytics engineering and data engineering responsibilities.
A noticeable salary band compression occurs around ~$147,500, suggesting standardized compensation ranges within Western European markets.

Key takeaways:
- Distributed database expertise commands the highest median salaries
- NoSQL systems show stronger salary premiums than traditional cloud tools
- Backend and API-layer technologies correlate with higher compensation
- Cloud data platforms provide strong demand but similar salary bands
- Western European compensation appears more banded than highly differentiated
- The strongest career strategy balances salary potential with demand volume

┌───────────────┬──────────────┬───────────────┐
│     skill     │ skill_demand │ median_salary │
│    varchar    │    int64     │    double     │
├───────────────┼──────────────┼───────────────┤
│ cassandra     │         2377 │      171500.0 │
│ dynamodb      │         1475 │      171500.0 │
│ redis         │         1157 │      171500.0 │
│ neo4j         │          655 │      171500.0 │
│ macos         │          106 │      170545.0 │
│ mongo         │          474 │      165300.0 │
│ sas           │         3052 │      159750.0 │
│ spss          │          107 │      157000.0 │
│ mysql         │         3839 │      151500.0 │
│ fastapi       │          603 │      150500.0 │
│ databricks    │        17415 │      147500.0 │
│ snowflake     │        13672 │      147500.0 │
│ airflow       │        13556 │      147500.0 │
│ power bi      │        11220 │      147500.0 │
│ terraform     │         8490 │      147500.0 │
│ bigquery      │         7153 │      147500.0 │
│ tableau       │         6863 │      147500.0 │
│ postgresql    │         5977 │      147500.0 │
│ go            │         4534 │      147500.0 │
│ gitlab        │         3218 │      147500.0 │
│ jira          │         3150 │      147500.0 │
│ looker        │         2577 │      147500.0 │
│ elasticsearch │         2495 │      147500.0 │
│ confluence    │         1411 │      147500.0 │
│ dax           │         1365 │      147500.0 │
├───────────────┴──────────────┴───────────────┤
│ 25 rows                            3 columns │
└──────────────────────────────────────────────┘
*/

