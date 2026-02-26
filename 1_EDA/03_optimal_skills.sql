/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary in major Western European markets?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on positions with specified salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/
Select
    sd.skills as skill,
    count(coalesce(salary_year_avg,salary_hour_avg * 2080)) as skill_demand,
    round(median(coalesce(salary_year_avg,salary_hour_avg * 2080))) as median_salary,
    round(LN(count(coalesce(salary_year_avg,salary_hour_avg * 2080))) * median(coalesce(salary_year_avg,salary_hour_avg * 2080))/1_000_000, 2) as optimal_score
From job_postings_fact as jpf
    inner join skills_job_dim as sjd on jpf.job_id = sjd.job_id
    inner join skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short like ('%Data Engineer')
    and job_country In('United Kingdom','Netherlands','France','Germany','Poland','Sweden','Ireland')
    and coalesce(salary_year_avg,salary_hour_avg * 2080) is not null
group by
    sd.skills
order by optimal_score desc
limit 25;

/*
Key Takeaways:

Top Skills by Optimal Score:
- Python and SQL provide the strongest balance of demand and competitive median salaries (~$134K).
- Spark and AWS remain foundational high-value technologies.
- Azure shows strong positioning within selected European markets.

High Salary, Moderate Demand:
- Airflow, Snowflake, Databricks, and BigQuery display elevated median salaries (~$147K range).
- These likely reflect more specialized or mid-to-senior roles.

Programming Languages:
- Java and Scala maintain steady demand with solid compensation.
- Go appears as a higher-paying but lower-demand option.

Important Context:
- Demand reflects only salary-disclosed postings.
- Results apply to selected European countries.
- Repeated median values (e.g., 147,500) indicate limited salary variation for certain skills in the dataset.

┌────────────┬──────────────┬───────────────┬───────────────┐
│   skill    │ skill_demand │ median_salary │ optimal_score │
│  varchar   │    int64     │    double     │    double     │
├────────────┼──────────────┼───────────────┼───────────────┤
│ python     │          289 │      134241.0 │          0.76 │
│ sql        │          271 │      134241.0 │          0.75 │
│ spark      │          190 │      135000.0 │          0.71 │
│ aws        │          202 │      134241.0 │          0.71 │
│ azure      │          165 │      135588.0 │          0.69 │
│ airflow    │          100 │      147500.0 │          0.68 │
│ snowflake  │           86 │      147500.0 │          0.66 │
│ databricks │           80 │      147500.0 │          0.65 │
│ bigquery   │           71 │      147500.0 │          0.63 │
│ java       │          106 │      132911.0 │          0.62 │
│ scala      │           95 │      135000.0 │          0.61 │
│ kafka      │           83 │      135000.0 │           0.6 │
│ cassandra  │           29 │      171500.0 │          0.58 │
│ nosql      │           73 │      135000.0 │          0.58 │
│ gcp        │           94 │      126388.0 │          0.57 │
│ postgresql │           44 │      147500.0 │          0.56 │
│ terraform  │           45 │      147500.0 │          0.56 │
│ hadoop     │           59 │      133500.0 │          0.54 │
│ go         │           40 │      147500.0 │          0.54 │
│ redis      │           23 │      171500.0 │          0.54 │
│ mysql      │           36 │      151500.0 │          0.54 │
│ dynamodb   │           22 │      171500.0 │          0.53 │
│ kubernetes │           54 │      130575.0 │          0.52 │
│ docker     │           63 │      125000.0 │          0.52 │
│ git        │           56 │      129000.0 │          0.52 │
├────────────┴──────────────┴───────────────┴───────────────┤
│ 25 rows                                         4 columns │
└───────────────────────────────────────────────────────────┘

*/