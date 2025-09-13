/*
Question: What are the most optimal skills to learn (High paying and in high demand skills?)
- Identify skills in high demand and associated with average high salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
WHY?? - Targets skills that offer jon security (High Demand) as well as financial security (High Pay)
Offering strategic insights for career development in data analysis
*/
WITH skills_demand AS (
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count 
FROM job_postings_fact
    
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
AND 
    job_work_from_home = TRUE 
AND 
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
),  average_salary AS  (
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    ROUND (AVG(salary_year_avg), 2) AS average_salary
FROM job_postings_fact
    
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_work_from_home = True
AND 
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_salary
FROM
    skills_demand
INNER JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
    
LIMIT 25