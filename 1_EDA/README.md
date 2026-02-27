# 🔍 Exploratory Data Analysis w/ SQL: Job Market Analytics

![EDA Project Overview](../images/eda1_EDA.png)

A SQL project analyzing the Western European Data Engineer job market using real-world job posting data. It demonstrates my ability to **write production-quality analytical SQL, design efficient queries, and turn business questions into data-driven insights**.

---

## 🧾 Executive Summary (For Hiring Managers)

- ✅ **Project scope:** Built **3 analytical queries** that answer key questions about the Western European data engineer job market (UK, Netherlands, France, Germany, Poland, Sweden, Ireland).
- ✅ **Data modeling:** Used **multi-table joins** across fact and dimension tables to extract insights.
- ✅ **Analytics:** Applied **aggregations, filtering, and sorting** to find top skills by demand, salary, and overall value.
- ✅ **Outcomes:** Delivered **actionable insights** on SQL/Python dominance, cloud trends, and salary patterns.

Key Queries:

1. [`01_top_demanded_skills.sql`](./01_top_demanded_skills.sql) – demand analysis with multi-table joins  
2. [`02_top_paying_skills.sql`](./02_top_paying_skills.sql) – salary analysis with aggregations  
3. [`03_optimal_skills.sql`](./03_optimal_skills.sql) – combined demand/salary optimization query  

---

## 🧩 Problem & Context

The job market analysis answers:

- 🎯 **Most in-demand:** *Which skills are most in-demand for data engineers?*  
- 💰 **Highest paid:** *Which skills command the highest salaries?*  
- ⚖️ **Best trade-off:** *What is the optimal skill set balancing demand and compensation?*  

### Geographic & Time Scope

- Region: United Kingdom, Netherlands, France, Germany, Poland, Sweden, Ireland.
- Role focus: Data Engineer.
- Timeframe: Job postings collected between January 2023 and June 2025.
- Dataset size: **~107,000** total job postings across selected countries and role.
- Salary disclosure filtering: Applied only in the optimal skills analysis.

This project analyzes a **data warehouse** built using a star schema design. The warehouse structure consists of:

![Data Warehouse Schema](../images/eda1_Data_Warehouse.png)

- **Fact Table:** `job_postings_fact` - Central table containing job posting details (job titles, locations, salaries, dates, etc.)
- **Dimension Tables:** 
  - `company_dim` - Company information linked to job postings
  - `skills_dim` - Skills catalog with skill names and types
- **Bridge Table:** `skills_job_dim` - Resolves the many-to-many relationship between job postings and skills

By querying across these interconnected tables, I extracted insights about skill demand, salary patterns, and optimal skill combinations for data engineering roles.  

---

## 🧰 Tech Stack

- 🐤 **Query Engine:** **DuckDB** for fast OLAP-style analytical queries.
- 📊 **Data Model:** Star schema with fact + dimension + bridge tables.
- 🛠️ **Development:** VS Codium in **WSL** for SQL editing + **Bash** terminal for DuckDB CLI.
- 📦 **Version Control:** Git/GitHub for versioned SQL scripts.

---

## 📂 Repository Structure

```text
1_EDA/
├── 01_top_demanded_skills.sql    # Demand analysis query
├── 02_top_paying_skills.sql      # Salary analysis query
├── 03_optimal_skills.sql         # Combined demand/salary optimization
└── README.md                     # You are here
```
---

## 🏗 Analysis Overview

### Query Structure

1. **[Top Demanded Skills](./01_top_demanded_skills.sql)** – Identifies the most in-demand skills for Data Engineer roles in selected Western European countries.
2. **[Top Paying Skills](./02_top_paying_skills.sql)** – Analyzes the 25 highest-paying skills with salary and demand metrics.
3. **[Optimal Skills](./03_optimal_skills.sql)** – Calculates an optimal score using log-transformed demand and median salary, focusing only on roles with disclosed compensation to ensure reliable salary aggregation and identifying the most valuable skills to learn.

### Key Insights

- 🧠 Core languages: SQL and Python each appear in ~57,000 job postings, making them the most demanded skills.
- ☁️ Cloud platforms: Azure and AWS are consistently present across the selected markets.
- 🧱 Databases: NoSQL systems exhibit higher median salaries within the salary-disclosed subset, though with lower overall demand.
- 🔥 Big data tools: Spark maintains strong demand with competitive compensation

---

## 💻 SQL Skills Demonstrated

### Query Design & Optimization

- **Complex Joins**: Multi-table `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim`.
- **Aggregations**: `COUNT()`, `MEDIAN()`, `ROUND()` for statistical analysis.
- **Filtering**: Boolean logic with `WHERE` clauses for role and geography filtering, with conditional salary filtering applied only in compensation-based analysis.
- **Sorting & Limiting**: `ORDER BY` with `DESC` and `LIMIT` for top-N analysis.

### Data Analysis Techniques

- **Grouping**: `GROUP BY` for categorical analysis by skill.
- **Mathematical Functions**: `LN()` for natural logarithm transformation to normalize demand metrics.
- **Calculated Metrics**: Derived optimal score combining log-transformed demand with median salary.
- **HAVING Clause**: Filtering aggregated results (skills with >= 100 postings) for the top-paying skills analysis.
- **NULL Handling**: Conditional salary filtering and aggregation for compensation-based analysis in the optimal-skills query.
