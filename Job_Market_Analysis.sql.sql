-- 1. DATABASE CONNECTION AND DATA RETRIEVAL

USE project_job_market_analysis;

SHOW TABLES;

DESCRIBE Market;

SELECT * FROM Market;

SELECT COUNT(*) AS Total_Records
FROM Market;




-- 2. STATES WITH MOST NUMBER OF JOBS

SELECT
    TRIM(SUBSTRING_INDEX(Location, ',', -1)) AS State,
    COUNT(*) AS Total_Jobs
FROM Market
WHERE Location IS NOT NULL
GROUP BY State
ORDER BY Total_Jobs DESC;


-- 3. AVERAGE MINIMUM AND MAXIMUM SALARIES IN DIFFERENT STATES

SELECT
    TRIM(SUBSTRING_INDEX(Location, ',', -1)) AS State,
    ROUND(AVG(NULLIF(`Lower_Salary`, -1)), 2) AS Average_Min_Salary,
    ROUND(AVG(NULLIF(`Upper_Salary`, -1)), 2) AS Average_Max_Salary
FROM Market
WHERE Location IS NOT NULL
GROUP BY State
ORDER BY Average_Min_Salary DESC;

-- 4. AVERAGE SALARY IN DIFFERENT STATES

SELECT
    TRIM(SUBSTRING_INDEX(Location, ',', -1)) AS State,
    ROUND(AVG(NULLIF(`Avg_Salaryk`, -1)), 2) AS Average_Salary
FROM Market
WHERE Location IS NOT NULL
GROUP BY State
ORDER BY Average_Salary DESC;


-- 5. TOP 5 INDUSTRIES WITH MAXIMUM NUMBER OF DATA SCIENCE JOBS

SELECT
    Industry,
    COUNT(*) AS Total_Jobs
FROM Market
WHERE Industry IS NOT NULL
  AND Industry <> '-1'
GROUP BY Industry
ORDER BY Total_Jobs DESC
LIMIT 5;


-- 6. COMPANIES WITH MAXIMUM NUMBER OF JOB OPENINGS

SELECT
    `Company_Name`,
    COUNT(*) AS Total_Openings
FROM Market
WHERE `Company_Name` IS NOT NULL
GROUP BY `Company_Name`
ORDER BY Total_Openings DESC
LIMIT 10;


-- 8. JOB TITLES WITH MOST NUMBER OF JOBS

SELECT
    `Job_Title`,
    COUNT(*) AS Total_Jobs
FROM Market
WHERE `Job_Title` IS NOT NULL
GROUP BY `Job_Title`
ORDER BY Total_Jobs DESC
LIMIT 10;


-- 9. SALARY OF JOB TITLES WITH MOST NUMBER OF JOBS

SELECT
    `Job_Title`,
    COUNT(*) AS Total_Jobs,
    ROUND(AVG(NULLIF(`Lower_Salary`, -1)), 2) AS Average_Min_Salary,
    ROUND(AVG(NULLIF(`Upper_Salary`, -1)), 2) AS Average_Max_Salary,
    ROUND(AVG(NULLIF(`Avg_SalaryK`, -1)), 2) AS Average_Salary
FROM Market
WHERE `Job_Title` IS NOT NULL
GROUP BY `Job_Title`
ORDER BY Total_Jobs DESC
LIMIT 10;


-- 9. SKILLS REQUIRED BY COMPANIES FOR EACH JOB TITLE
-- ============================================================

SELECT DISTINCT
    `Company_Name`,
    `Job_Title`,
    CONCAT_WS(', ',
        IF(`python` = 1, 'Python', NULL),
        IF(`spark` = 1, 'Spark', NULL),
        IF(`aws` = 1, 'AWS', NULL),
        IF(`excel` = 1, 'Excel', NULL),
        IF(`sql_` = 1, 'SQL', NULL),
        IF(`sas` = 1, 'SAS', NULL),
        IF(`keras` = 1, 'Keras', NULL),
        IF(`pytorch` = 1, 'PyTorch', NULL),
        IF(`scikit` = 1, 'Scikit-learn', NULL),
        IF(`tensor` = 1, 'TensorFlow', NULL),
        IF(`hadoop` = 1, 'Hadoop', NULL),
        IF(`tableau` = 1, 'Tableau', NULL),
        IF(`bi` = 1, 'Power BI', NULL),
        IF(`flink` = 1, 'Flink', NULL),
        IF(`mongo` = 1, 'MongoDB', NULL),
        IF(`google_an` = 1, 'Google Analytics', NULL)
    ) AS Required_Skills
FROM Market
WHERE `Company_Name` IS NOT NULL
  AND `Job_Title` IS NOT NULL
ORDER BY `Job_Title`, `Company_Name`;


-- 10. RELATION BETWEEN AVERAGE SALARY AND EDUCATION

SELECT
    Degree,
    COUNT(*) AS Total_Jobs,
    ROUND(AVG(NULLIF(`Avg_SalaryK`, -1)), 2) AS Average_Salary
FROM Market
WHERE Degree IS NOT NULL
  AND Degree <> '-1'
GROUP BY Degree
ORDER BY Average_Salary DESC;
