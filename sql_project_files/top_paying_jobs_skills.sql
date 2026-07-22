/*
What are the skills required for these top paying remote jobs for Data Scientist roles?
*/

/*
1. What are the top 10 high paying remote jobs for Data Scientist roles?
*/
with top_paying_jobs as (

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





/*
[
  {
    "job_title": "Staff Data Scientist/Quant Researcher",
    "company_name": "Selby Jennings",
    "salary_year_avg": "550000.0",
    "skills": "sql"
  },
  {
    "job_title": "Staff Data Scientist/Quant Researcher",
    "company_name": "Selby Jennings",
    "salary_year_avg": "550000.0",
    "skills": "python"
  },
  {
    "job_title": "Staff Data Scientist - Business Analytics",
    "company_name": "Selby Jennings",
    "salary_year_avg": "525000.0",
    "skills": "sql"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "sql"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "python"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "java"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "cassandra"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "spark"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "hadoop"
  },
  {
    "job_title": "Data Scientist",
    "company_name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "tableau"
  },
  {
    "job_title": "Director Level - Product Management - Data Science",
    "company_name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "azure"
  },
  {
    "job_title": "Director Level - Product Management - Data Science",
    "company_name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "aws"
  },
  {
    "job_title": "Director Level - Product Management - Data Science",
    "company_name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "tensorflow"
  },
  {
    "job_title": "Director Level - Product Management - Data Science",
    "company_name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "keras"
  },
  {
    "job_title": "Director Level - Product Management - Data Science",
    "company_name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "pytorch"
  },
  {
    "job_title": "Director Level - Product Management - Data Science",
    "company_name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "scikit-learn"
  },
  {
    "job_title": "Director Level - Product Management - Data Science",
    "company_name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "datarobot"
  },
  {
    "job_title": "Principal Data Scientist",
    "company_name": "Storm5",
    "salary_year_avg": "300000.0",
    "skills": "sql"
  },
  {
    "job_title": "Principal Data Scientist",
    "company_name": "Storm5",
    "salary_year_avg": "300000.0",
    "skills": "python"
  },
  {
    "job_title": "Principal Data Scientist",
    "company_name": "Storm5",
    "salary_year_avg": "300000.0",
    "skills": "java"
  },
  {
    "job_title": "Principal Data Scientist",
    "company_name": "Storm5",
    "salary_year_avg": "300000.0",
    "skills": "c"
  },
  {
    "job_title": "Principal Data Scientist",
    "company_name": "Storm5",
    "salary_year_avg": "300000.0",
    "skills": "aws"
  },
  {
    "job_title": "Principal Data Scientist",
    "company_name": "Storm5",
    "salary_year_avg": "300000.0",
    "skills": "gcp"
  },
  {
    "job_title": "Head of Battery Data Science",
    "company_name": "Lawrence Harvey",
    "salary_year_avg": "300000.0",
    "skills": "python"
  },
  {
    "job_title": "Head of Battery Data Science",
    "company_name": "Lawrence Harvey",
    "salary_year_avg": "300000.0",
    "skills": "aws"
  },
  {
    "job_title": "Head of Battery Data Science",
    "company_name": "Lawrence Harvey",
    "salary_year_avg": "300000.0",
    "skills": "gcp"
  },
  {
    "job_title": "Distinguished Data Scientist",
    "company_name": "Walmart",
    "salary_year_avg": "300000.0",
    "skills": "scala"
  },
  {
    "job_title": "Distinguished Data Scientist",
    "company_name": "Walmart",
    "salary_year_avg": "300000.0",
    "skills": "java"
  },
  {
    "job_title": "Distinguished Data Scientist",
    "company_name": "Walmart",
    "salary_year_avg": "300000.0",
    "skills": "spark"
  },
  {
    "job_title": "Distinguished Data Scientist",
    "company_name": "Walmart",
    "salary_year_avg": "300000.0",
    "skills": "tensorflow"
  },
  {
    "job_title": "Distinguished Data Scientist",
    "company_name": "Walmart",
    "salary_year_avg": "300000.0",
    "skills": "pytorch"
  },
  {
    "job_title": "Distinguished Data Scientist",
    "company_name": "Walmart",
    "salary_year_avg": "300000.0",
    "skills": "kubernetes"
  }
]
*/