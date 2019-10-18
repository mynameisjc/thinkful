--1. Inspect the naep table
SELECT table_name
FROM information_schema.tables
WHERE TABLE_NAME = 'naep' OR TABLE_NAME = 'finance';

SELECT table_name, column_name
FROM information_schema.columns
WHERE TABLE_NAME = 'naep' OR TABLE_NAME = 'finance';

--2. Limit to 50 results
SELECT *
FROM naep
LIMIT 50;

--3. Summarizing data 
SELECT state, ROUND(AVG(avg_math_4_score),2), MIN(avg_math_4_score),
	MAX(avg_math_4_score), COUNT(avg_math_4_score)
FROM naep
GROUP BY state
ORDER BY state;

--4. 
SELECT state, ROUND(AVG(avg_math_4_score),2), MIN(avg_math_4_score),
	MAX(avg_math_4_score), COUNT(avg_math_4_score)
FROM naep
GROUP BY state
HAVING MAX(avg_math_4_score)-MIN(avg_math_4_score) >30;

--5. Bottom 10 in year 2000
SELECT state, avg_math_4_score
FROM naep
WHERE year = 2000
ORDER BY avg_math_4_score ASC
LIMIT 10;

--6. List averages per state in 2000
SELECT ROUND(SUM(avg_math_4_score)/COUNT(avg_math_4_score),2)
FROM naep
WHERE year = 2000;
--224.80 average across all states

--7. Show only the underperforming states
SELECT state, ROUND(AVG(avg_math_4_score),2) AS below_average_states_y2000
FROM naep
WHERE year = 2000
GROUP BY state
HAVING AVG(avg_math_4_score) > 224.80
ORDER BY state;

--8. Find all states with NULL values
SELECT state, avg_math_4_score as scores_missing_y2000
FROM naep
WHERE year = 2000 AND avg_math_4_score IS NULL
GROUP BY state, avg_math_4_score
ORDER BY state;

--9.
SELECT naep.state, avg_math_4_score, finance.total_expenditure
FROM naep LEFT OUTER JOIN finance
ON naep.id = finance.id
WHERE naep.year = 2000 AND avg_math_4_score IS NOT NULL
GROUP BY naep.state, finance.total_expenditure, naep.avg_math_4_score
ORDER BY 3 DESC;