# 📊 SQL Data Analysis Project: Data Scientist Job Market

## Introduction

This project explores the **Data Scientist job market** using SQL by analyzing job postings, salaries, and required skills. The objective is to uncover valuable insights that can help aspiring and professional Data Scientists understand:

* 💰 Which Data Scientist jobs offer the highest salaries?
* 🛠️ Which skills are required for top-paying jobs?
* 📈 Which skills are most in demand?
* 💵 Which skills command the highest salaries?
* 🎯 Which skills provide the best balance of demand and salary?

The analysis was performed using SQL on the Data Jobs dataset by joining multiple tables and applying filtering, aggregation, and Common Table Expressions (CTEs). [project_files](/sql_project_files/)

---

# Background

With the rapid growth of Artificial Intelligence and Data Science, it has become increasingly difficult to identify which skills truly provide the best career opportunities.

This project answers five practical questions:

1. What are the highest-paying remote Data Scientist jobs?
2. What skills are required for these top-paying jobs?
3. Which skills are most in demand?
4. Which skills have the highest average salaries?
5. Which skills are both highly demanded and highly paid?

These insights can help job seekers prioritize their learning roadmap based on real job market data rather than assumptions.

---

# Tools Used

* **SQL** – Data querying and analysis
* **PostgreSQL** – Database management system
* **CTEs (Common Table Expressions)** – Simplified complex queries
* **JOINs** – Combined data across multiple tables
* **Aggregate Functions**

  * `COUNT()`
  * `AVG()`
  * `ROUND()`
* **Filtering**

  * `WHERE`
  * `HAVING`
* **Sorting & Limiting**

  * `ORDER BY`
  * `LIMIT`

---

# Analysis & Findings

---

## 1️⃣ Top 10 Highest Paying Remote Data Scientist Jobs

### SQL Goal

Identify the highest-paying remote Data Scientist jobs where salary information is available.

```sql
select job_title, 
       company_dim.name as company_name, 
       job_location,
       job_via,
       job_schedule_type,
       salary_year_avg
FROM job_postings_fact
left JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

where job_title_short = 'Data Scientist' AND
    salary_year_avg is not null AND
    job_location= 'Anywhere'
order by salary_year_avg desc
limit 10;
```

### Top Salaries

| Company            | Role                                         |       Salary |
| ------------------ | -------------------------------------------- | -----------: |
| Selby Jennings     | Staff Data Scientist / Quant Researcher      | **$550,000** |
| Selby Jennings     | Staff Data Scientist - Business Analytics    | **$525,000** |
| Algo Capital Group | Data Scientist                               | **$375,000** |
| Demandbase         | Head of Data Science                         | **$351,500** |
| Demandbase         | Head of Data Science                         | **$324,000** |
| Teramind           | Director - Product Management (Data Science) | **$320,000** |
| Reddit             | Director of Data Science & Analytics         | **$313,000** |
| Storm5             | Principal Data Scientist                     | **$300,000** |
| Storm4             | Director of Data Science                     | **$300,000** |
| Walmart            | Distinguished Data Scientist                 | **$300,000** |

### Salary Comparison

```
$550K ██████████████████████████████
$525K ████████████████████████████
$375K ████████████████████
$351K ██████████████████
$324K ████████████████
$320K ███████████████
$313K ██████████████
$300K █████████████
```

### Insights

* Executive and leadership positions dominate the highest salary range.
* Selby Jennings offered the two highest-paying remote roles.
* Every job in the top 10 is a **full-time remote opportunity**.
* Salaries range from **$300K to $550K**, highlighting the premium placed on experienced Data Scientists.

---

## 2️⃣ Skills Required for Top Paying Jobs

```sql
WITH top_paying_jobs as (

select job_id,
        job_title, 
       company_dim.name as company_name, 

       salary_year_avg
FROM job_postings_fact
left JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

where job_title_short = 'Data Scientist' AND
    salary_year_avg is not null AND
    job_location= 'Anywhere'
order by salary_year_avg desc
limit 10
)

select top_paying_jobs.job_title, 
       top_paying_jobs.company_name, 
       top_paying_jobs.salary_year_avg,
       skills_dim.skills
from top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
order by top_paying_jobs.salary_year_avg desc;
```

### Frequently Appearing Skills

| Skill      | Frequency |
| ---------- | --------: |
| Python     |     ⭐⭐⭐⭐⭐ |
| SQL        |     ⭐⭐⭐⭐⭐ |
| Java       |       ⭐⭐⭐ |
| Spark      |       ⭐⭐⭐ |
| TensorFlow |        ⭐⭐ |
| PyTorch    |        ⭐⭐ |
| AWS        |        ⭐⭐ |
| Tableau    |         ⭐ |
| Hadoop     |         ⭐ |
| Pandas     |         ⭐ |
| NumPy      |         ⭐ |
| Kubernetes |         ⭐ |

### Visual Overview

```
Python      █████
SQL         █████
Java        ███
Spark       ███
TensorFlow  ██
PyTorch     ██
AWS         ██
Others      █
```

### Insights

* **Python** and **SQL** are the most common skills among the highest-paying jobs.
* Machine Learning frameworks such as **TensorFlow**, **PyTorch**, and **Scikit-learn** frequently appear in senior-level roles.
* Cloud platforms (**AWS**, **Azure**, **GCP**) are commonly requested.
* Big Data technologies like **Spark** and **Hadoop** are valuable for premium positions.

---

## 3️⃣ Most In-Demand Skills

```sql
select skills, count(job_postings_fact.job_id) as job_count
FROM skills_dim
inner join skills_job_dim on skills_dim.skill_id = skills_job_dim.skill_id
inner join job_postings_fact on skills_job_dim.job_id = job_postings_fact.job_id
where job_title_short = 'Data Scientist'
group by skills
order by job_count desc
limit 5;
```

| Skill   | Job Count |
| ------- | --------: |
| Python  |   114,016 |
| SQL     |    79,174 |
| R       |    59,754 |
| SAS     |    29,642 |
| Tableau |    29,513 |

### Demand Visualization

```
Python   ████████████████████████████
SQL      ███████████████████
R        ██████████████
SAS      ███████
Tableau  ███████
```

### Insights

* Python is by far the most demanded Data Scientist skill.
* SQL remains a core requirement across the industry.
* R continues to have strong demand, especially in statistics and research-oriented roles.
* Tableau demonstrates the importance of data visualization skills.

---

## 4️⃣ Highest Paying Skills

```sql
select skills, round(avg(salary_year_avg),0) as avg_salary
FROM skills_dim
inner join skills_job_dim on skills_dim.skill_id = skills_job_dim.skill_id
inner join job_postings_fact on skills_job_dim.job_id = job_postings_fact.job_id
where job_title_short = 'Data Scientist' AND
      salary_year_avg is not null
group by skills
order by avg_salary desc
limit 50;
```

### Top Paying Skills

| Skill         | Avg Salary |
| ------------- | ---------: |
| Asana         |   $215,477 |
| Airtable      |   $201,143 |
| Red Hat       |   $189,500 |
| Watson        |   $187,417 |
| Elixir        |   $170,824 |
| Lua           |   $170,500 |
| Slack         |   $168,219 |
| Solidity      |   $166,980 |
| Ruby on Rails |   $166,500 |
| RShiny        |   $166,436 |

### Insights

* Specialized enterprise and niche technologies command the highest salaries.
* AI-related skills like **Watson** and **Hugging Face** receive premium compensation.
* General programming languages such as Python do not appear in the top salary rankings because they are required across all experience levels, reducing their average salary.

---

## 5️⃣ Most Optimal Skills (High Demand + High Salary)

```sql
    SELECT
        s.skill_id,
        s.skills,
        COUNT(j.job_id) AS job_count,
        ROUND(AVG(j.salary_year_avg), 0) AS avg_salary
    FROM skills_dim s
    JOIN skills_job_dim sj
        ON s.skill_id = sj.skill_id
    JOIN job_postings_fact j
        ON sj.job_id = j.job_id
    WHERE
        j.job_title_short = 'Data Scientist'
        AND j.salary_year_avg IS NOT NULL
    GROUP BY
        s.skill_id
    HAVING COUNT(j.job_id) > 10
    ORDER BY
        avg_salary DESC,
        job_count DESC
    LIMIT 10;
```

A minimum demand threshold (`HAVING COUNT(job_id) > 10`) was applied to remove outliers and identify skills that are both valuable and reasonably common.

| Skill        | Job Count | Avg Salary |
| ------------ | --------: | ---------: |
| Watson       |        14 |   $187,417 |
| Slack        |        17 |   $168,219 |
| RShiny       |        17 |   $166,436 |
| Notion       |        11 |   $165,636 |
| Neo4j        |        32 |   $163,971 |
| dplyr        |        16 |   $163,111 |
| Hugging Face |        18 |   $160,868 |
| DynamoDB     |        12 |   $160,581 |
| Airflow      |       144 |   $155,878 |
| Theano       |        25 |   $153,133 |

### Insights

* **Airflow** stands out as the strongest combination of demand and salary.
* **Neo4j** and **Hugging Face** indicate growing demand for Graph Databases and Generative AI.
* Specialized skills generally offer higher salaries than foundational programming skills.
* Applying a demand threshold produces more reliable results by filtering extremely rare skills.

---

# What I Learned

This project strengthened my understanding of SQL while providing practical experience with real-world data analysis.

Throughout the project, I learned how to:

* Write complex SQL queries using **JOINs** across multiple tables.
* Use **Common Table Expressions (CTEs)** to simplify multi-step analysis.
* Apply aggregate functions such as `COUNT()` and `AVG()` for business insights.
* Filter data effectively using `WHERE` and `HAVING`.
* Rank and compare results using `ORDER BY` and `LIMIT`.
* Analyze salary trends alongside job demand.
* Transform raw job posting data into actionable insights for career planning.

More importantly, I learned that interpreting results is just as important as writing SQL queries.

---

# Conclusions

This analysis provides several key insights into today's Data Scientist job market:

* **Python** and **SQL** remain the most essential skills due to their overwhelming demand.
* Senior leadership and specialized Data Scientist roles can exceed **$500,000** in annual salary.
* High-paying jobs frequently require expertise in **Machine Learning**, **Cloud Computing**, and **Big Data** technologies.
* Specialized tools such as **Watson**, **Neo4j**, **Airflow**, and **Hugging Face** offer excellent earning potential.
* The best long-term strategy is to build a strong foundation in Python and SQL, then expand into advanced technologies like Spark, Airflow, TensorFlow, PyTorch, and cloud platforms.

Overall, this project demonstrates how SQL can be used not only to query data but also to uncover meaningful insights that support career decisions and identify emerging trends in the Data Science job market.

