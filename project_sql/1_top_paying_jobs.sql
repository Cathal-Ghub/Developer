/*
Question: what are the top paying jobs for Business/ Data Analyst?
-Identify the top 10 highest paying Data/Business analyst jobs that are available remotely or in the UK
-Focus on job postings with specified salaries. (remove any Nulls)
-WHY?? Highlighting the top paying jobs within these analyst roles identifying which is the more
lucradive field and offering insights to employment goals.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name
FROM    
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE   
    (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND
    (job_location = 'Anywhere' OR job_location = 'United Kingdom') AND
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10
