/*
Question: What are the most in demand skills for a data analyst?
- Join job posting to inner join table similar to question 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- WHY?? Retrieves the top 5 skills with the highest demand in the job market,
providing insights into the most valuable skills for job seekers.
*/

SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count 
FROM job_postings_fact
    
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
 -- Remove/ Add the comment syntax below to filter other criteria 
    AND job_location = 'Anywhere'
    --job_location = 'United Kingdom' (For UK Jobs)
    --AND salary_year_avg > 70000 (To include higher pay scaling)
GROUP BY
    skills
ORDER BY 
    demand_count DESC
LIMIT 5