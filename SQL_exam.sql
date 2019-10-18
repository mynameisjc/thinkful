--1. Inspect the naep table
SELECT *
FROM naep;

--2. Limit to 50 results
SELECT *
FROM naep
LIMIT 50;

--3. Summarizing data with averages
SELECT state, AVG(avg_math_4_score)
FROM naep
GROUP BY state
ORDER BY state;

--4. 
WITH scores AS
(
	SELECT state, MAX(avg_math_4_score)-MIN(avg_math_4_score) >30 AS diff
	FROM naep
	GROUP BY state)
SELECT state, diff
FROM scores
WHERE diff IS TRUE
GROUP BY state, scores.diff;

--5. Bottom 10 in year 2000
SELECT state, avg_math_4_score
FROM naep
WHERE year = 2000
ORDER BY avg_math_4_score ASC
LIMIT 10;

--6. List averages per state in 2000
SELECT ROUND(AVG(avg_math_4_score),2), state
FROM naep
WHERE year = 2000
GROUP BY state
ORDER BY state;

--7. Show only the underperforming states
SELECT state, ROUND(AVG(avg_math_4_score),2)>SUM(avg_math_4_score)/COUNT(avg_math_4_score) AS below_average_states_y2000
FROM naep
WHERE year = 2000
GROUP BY state
HAVING ROUND(AVG(avg_math_4_score),2)>SUM(avg_math_4_score)/COUNT(avg_math_4_score)
ORDER BY state;

--8. Find all states with NULL values
SELECT state, AVG(avg_math_4_score) IS NULL as scores_missing_y2000
FROM naep
WHERE year = 2000
GROUP BY state
HAVING AVG(avg_math_4_score) IS NULL
ORDER BY state;

--9.
SELECT naep.state, ROUND(AVG(avg_math_4_score),2), finance.total_expenditure
FROM naep LEFT OUTER JOIN finance
ON naep.id = finance.id
WHERE naep.year = 2000
GROUP BY naep.state, finance.total_expenditure
HAVING ROUND(AVG(avg_math_4_score),2) IS NOT NULL
ORDER BY 2 DESC;