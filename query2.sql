/*
1.what are the top-paying jobs for my role?
2.what are the skills required for these top-paying jobs
3.what are the most in-demand skills for my role?
4.what are the top skills based on salary for my role?
5.what are the most optimal skills to learn 
    -high demand and high paying
*/

with top_paying_jobs as (
SELECT 
    jpf.job_id,
    job_title_short,
    salary_year_avg
from job_postings_fact jpf
where
    salary_year_avg is not null AND
    job_title_short like '%Data%Scientist%'
ORDER BY salary_year_avg DESC
limit 100
)

SELECT
    sd.skills skill_name,
    count(skills) skill_count
from top_paying_jobs
INNER JOIN skills_job_dim sjd ON top_paying_jobs.job_id=sjd.job_id
INNER JOIN skills_dim sd on sjd.skill_id = sd.skill_id
GROUP BY skills
order BY skill_count DESC
limit 10
;



