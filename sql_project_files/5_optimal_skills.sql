/*
What are the most optimal skills for Data Scientists roles?
    optimal: high paying and high demanding
*/

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