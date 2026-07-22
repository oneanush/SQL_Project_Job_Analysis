/*
1. What are the top 10 high paying remote jobs for Data Scientist roles?
*/
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