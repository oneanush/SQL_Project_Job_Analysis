/*
What are the top 5 demanding skill for data scientist roles*/

select skills, count(job_postings_fact.job_id) as job_count
FROM skills_dim
inner join skills_job_dim on skills_dim.skill_id = skills_job_dim.skill_id
inner join job_postings_fact on skills_job_dim.job_id = job_postings_fact.job_id
where job_title_short = 'Data Scientist'
group by skills
order by job_count desc
limit 5;