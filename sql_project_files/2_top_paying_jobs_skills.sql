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





