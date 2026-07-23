/*
What are the top paid skills for data scientist roles*/


select skills, round(avg(salary_year_avg),0) as avg_salary
FROM skills_dim
inner join skills_job_dim on skills_dim.skill_id = skills_job_dim.skill_id
inner join job_postings_fact on skills_job_dim.job_id = job_postings_fact.job_id
where job_title_short = 'Data Scientist' AND
      salary_year_avg is not null
group by skills
order by avg_salary desc
limit 50;