--find the top skill to learn based on pay

with top_paying_jobs as (
SELECT 
    job_id,
    job_title_short,
    salary_year_avg
FROM job_postings_fact jpf
where
    salary_year_avg is not NULL AND
    --job_title_short = 'Data Analyst'
ORDER by salary_year_avg desc

)

SELECT 
    skills,
    count(skills) skill_demand,
    round(avg(top_paying_jobs.salary_year_avg),2 ) average_salary
FROM top_paying_jobs
INNER JOIN skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills
ORDER BY average_salary DESC
limit 25
;