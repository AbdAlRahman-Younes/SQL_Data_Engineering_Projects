/*
Question: What are the most in-demand skills for data engineers in western Europe?
- Identifying the top 10 in-demand skills for data engineers.
- Focusing on the top 5 biggest markets in western Europe.
- Why? Retrieves the top 10 skills with the highest demand in the western Europian market,
    providing insights into the most valuable transferrable skills for growing data engineers.
*/
explain analyze
Select
    sd.skills as skill,
    count(jpf.job_id) as skill_demand
From job_postings_fact as jpf
    inner join skills_job_dim as sjd on jpf.job_id = sjd.job_id
    inner join skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short like '%Data Engineer%'
    and job_country In('United Kingdom','Netherlands','France','Germany','Poland','Sweden','Ireland')
group by
    sd.skills
order by skill_demand desc
limit 10;

/*
Here's the breakdown of the most demanded skills for data engineers in Western Europe:
Python and SQL clearly dominate the market, with just over 46,000 job postings each — significantly higher than all other skills, confirming their role as core foundational technologies.
Cloud platforms are heavily demanded, with Azure leading at just shy of 40,000 postings, followed by AWS at ~31,900.
Apache Spark ranks fifth at ~25,000 postings, reinforcing the importance of distributed data processing and big data capabilities.
Databricks, Java, and Scala appear prominently, highlighting the continued relevance of the JVM ecosystem and lakehouse architectures in European data stacks.
Kafka rounds out the top 10, indicating that real-time data streaming is a growing expectation in modern data engineering roles.


Key takeaways:
- Python and SQL are the foundational skills for data engineers in Western Europe
- Azure shows stronger demand than AWS, reflecting regional cloud preferences
- Spark remains critical for distributed and large-scale data processing
- Databricks adoption is significant, signaling lakehouse architecture growth
- Java and Scala remain relevant in enterprise-heavy environments
- Kafka highlights the importance of streaming and real-time data systems

┌────────────┬──────────────┐
│   skill    │ skill_demand │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ python     │        59990 │
│ sql        │        57835 │
│ azure      │        39912 │
│ aws        │        31922 │
│ spark      │        25418 │
│ databricks │        17415 │
│ java       │        16721 │
│ gcp        │        15836 │
│ scala      │        14333 │
│ kafka      │        14165 │
├────────────┴──────────────┤
│ 10 rows         2 columns │
└───────────────────────────┘

*/
