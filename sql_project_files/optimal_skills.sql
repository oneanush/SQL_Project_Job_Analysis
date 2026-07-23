/*
What are most optimal skills to learn?
    optimal: high demand and high paying skills
*/

with demanding_skills as (
    select 
        skills_dim.skill_id,
        skills_dim.skills,
        count(job_postings_fact.job_id) as job_count
FROM skills_dim
inner join skills_job_dim on skills_dim.skill_id = skills_job_dim.skill_id
inner join job_postings_fact on skills_job_dim.job_id = job_postings_fact.job_id
where job_title_short = 'Data Scientist' AND
        salary_year_avg is not null
group by skills_dim.skill_id

), avg_salary_skills as (
    select 
        skills_dim.skill_id,
        skills_dim.skills,
        round(avg(salary_year_avg),0) as avg_salary
FROM skills_dim
inner join skills_job_dim on skills_dim.skill_id = skills_job_dim.skill_id
inner join job_postings_fact on skills_job_dim.job_id = job_postings_fact.job_id
where job_title_short = 'Data Scientist' AND
      salary_year_avg is not null
group by skills_dim.skill_id

)

select demanding_skills.skill_id,
     demanding_skills.skills,job_count, avg_salary_skills.avg_salary
from demanding_skills
inner join avg_salary_skills on demanding_skills.skill_id = avg_salary_skills.skill_id
ORDER BY
    job_count desc,
    avg_salary_skills.avg_salary desc
limit 10;