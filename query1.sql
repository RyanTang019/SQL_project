/*
question: what are the top-paying data analyst roles
-identify the top 10 highest-pauing data analyst roles that are available remotely
-focuse on job postings with specific salaries
-why? hugh the top-paying opportunites for data analyst, offering insights into 
*/


SELECT 
    job_id,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name
from job_postings_fact jpf
left JOIN company_dim cd on jpf.company_id = cd.company_id
where 
    job_title_short = 'Data Analyst' and 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
order by salary_year_avg DESC
limit 10;


