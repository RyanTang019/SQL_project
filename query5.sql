--most optimal skills to learn (aka high demand and high paying)

WITH skills_demand as(
SELECT 
    skills_dim.skills,
    skills_dim.skill_id,
    count(skills_job_dim.job_id) demand
from job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    --job_title_short like '%Data%Scientist%' and
    job_title_short = 'Data Analyst' and
    salary_year_avg is not null and
    job_work_from_home = TRUE
GROUP BY skills_dim.skill_id
),
top_paying_skills as(
SELECT 
    skills_job_dim.skill_id,
    --count(skills) skill_demand,
    round(avg(job_postings_fact.salary_year_avg),2) average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
    job_title_short = 'Data Analyst' and
    salary_year_avg is not null and
    job_work_from_home = TRUE
GROUP BY skills_job_dim.skill_id
)




SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand,
    top_paying_skills.average_salary
from skills_demand
INNER join top_paying_skills on  skills_demand.skill_id = top_paying_skills.skill_id
where demand > 10
order by average_salary desc, demand DESC
limit 25
;
