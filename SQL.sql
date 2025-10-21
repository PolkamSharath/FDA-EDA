-- 1. Identify the Top 10 Most Frequently Reported Drugs Across All Cases
SELECT TOP 10
drug_name,
COUNT(*) as total_reports
FROM drug_events
GROUP BY drug_name
ORDER BY COUNT(*) DESC;

-- 2. Show Gender Distribution Along with Percentage Contribution
SELECT 
patient_sex as gender,
COUNT(*) as total_reports,
ROUND((CAST(COUNT(*) as FLOAT) / (SELECT COUNT(*) FROM drug_events) * 100),2) as contribution
FROM
drug_events
GROUP BY patient_sex;

-- 3.Show Death Report Distribution by Age
SELECT
patient_age,
COUNT(*) as total_deaths
FROM 
drug_events
WHERE patient_age > 1 and outcome = 1
GROUP BY patient_age
ORDER BY patient_age;

-- 4. Retrieve the Most Frequently Reported Adverse Reactions
SELECT TOP 10
reaction,
count(*) as frequency
FROM 
drug_events
GROUP BY reaction
ORDER BY COUNT(*) DESC;

-- 5. Total Death Cases Reported
SELECT 
COUNT(*) as total_deaths
FROM
drug_events
WHERE outcome = 1;

-- 6. Categorize and Count Reports Based on Patient Age Groups
WITH age_group as (
SELECT 
CASE 
	WHEN patient_age BETWEEN 1 and 18 THEN '1-18'
	WHEN patient_age BETWEEN 19 and 35 THEN '19-35'
	WHEN patient_age BETWEEN 36 and 50 THEN '36-50'
	WHEN patient_age BETWEEN 51 and 75 THEN '51-75'
	ELSE '75+'
END AS age_group,
COUNT(report_id) as total_reports
FROM 
drug_events
WHERE patient_age != 1
GROUP BY patient_age
)

SELECT 
age_group,
COUNT(total_reports) as total_reports
FROM age_group
GROUP BY age_group;

-- 7.Drug-wise Death Reports
SELECT 
drug_name,
COUNT(*) as total_deaths
FROM
drug_events
WHERE outcome = 1
GROUP BY drug_name
ORDER BY COUNT(*) DESC;

-- 8. Reactions That Occur Most in Females
SELECT
reaction,
COUNT(*) as female_reactions
FROM drug_events
WHERE patient_sex = 'FEMALE'
GROUP BY reaction
ORDER BY COUNT(*) DESC;

-- 9. Reactions That Occur Most in Males
SELECT
reaction,
COUNT(*) as male_reactions
FROM drug_events
WHERE patient_sex = 'MALE'
GROUP BY reaction
ORDER BY COUNT(*) DESC;

-- 10. Top Drugs Reported by Male Patients
SELECT 
drug_name,
COUNT(*) as total_reports
FROM drug_events
WHERE patient_sex = 'Male'
GROUP BY drug_name
ORDER BY COUNT(*) DESC;

-- 11. Analyze Year-wise Trends in Drug Reports
SELECT
YEAR(receivedate) as report_year,
COUNT(*) as total_reports
FROM  drug_events
GROUP BY YEAR(receivedate);

-- 12. Drugs That Caused Multiple Reactions
SELECT TOP 10
drug_name as drug,
COUNT(DISTINCT reaction) as reactions
FROM drug_events
GROUP BY drug_name
ORDER BY reactions DESC;

-- 13. Find Patients With Unknown Age and Sex
SELECT
COUNT(*) as unknown_demographics
FROM drug_events
WHERE patient_age = -1 AND patient_sex = 'Unknown';
