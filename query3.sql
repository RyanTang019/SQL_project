--shorter version of query 2

SELECT 
    skills,
    count(skills) demand
from job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id=sjd.job_id
INNER JOIN skills_dim sd on sjd.skill_id = sd.skill_id
where job_title_short like '%Data%Scientist%'
GROUP BY skills
order by demand DESC
limit 10
;