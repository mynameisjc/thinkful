--2. Write a query that returns the namefirst and namelast
--fields of the people table, along with the inducted field
--from the hof_inducted table. All rows from the people table
--should be returned, and NULL values for the fields from 
--hof_inducted should be returned when there is no match found.
SELECT namefirst, namelast, inducted
FROM people LEFT OUTER JOIN hof_inducted
ON people.playerid = hof_inducted.playerid;

--3. "Negro League" HOF induction
SELECT namefirst, namelast, birthyear, deathyear, birthcountry
FROM people LEFT OUTER JOIN hof_inducted
ON people.playerid = hof_inducted.playerid
WHERE yearid = 2006 AND votedby = 'Negro League';

--4. 
SELECT salaries.yearid, salaries.playerid, teamid, salary, category
FROM salaries INNER JOIN hof_inducted
ON salaries.playerid = hof_inducted.playerid;

--5.
SELECT salaries.playerid, salaries.yearid, teamid, lgid, salary, inducted
FROM hof_inducted FULL OUTER JOIN salaries
ON salaries.playerid = hof_inducted.playerid;

--6. 
SELECT * FROM hof_inducted
UNION ALL
SELECT * FROM hof_not_inducted;

SELECT playerid FROM hof_inducted
UNION
SELECT playerid FROM hof_not_inducted;

--7.
SELECT namelast, namefirst, SUM(salary)
FROM people RIGHT OUTER JOIN salaries
ON people.playerid = salaries.playerid
GROUP BY namelast, namefirst
ORDER BY namelast, namefirst;

--8.
SELECT hof_inducted.playerid, yearid, namefirst, namelast
FROM hof_inducted LEFT OUTER JOIN people
ON hof_inducted.playerid = people.playerid

UNION ALL

SELECT hof_not_inducted.playerid, yearid, namefirst, namelast
FROM hof_not_inducted LEFT OUTER JOIN people
ON hof_not_inducted.playerid = people.playerid

--9. 
SELECT concat(namelast,', ', namefirst) AS namefull, yearid, inducted
FROM hof_inducted LEFT OUTER JOIN people
ON hof_inducted.playerid = people.playerid
WHERE yearid >= 1980

UNION ALL

SELECT concat(namelast,', ', namefirst) AS namefull, yearid, inducted
FROM hof_not_inducted LEFT OUTER JOIN people
ON hof_not_inducted.playerid = people.playerid
WHERE yearid >= 1980

ORDER BY yearid, inducted DESC, namefull;

--10. 
SELECT yearid, teamid, salaries.playerid, namelast,namefirst, salary
FROM salaries LEFT OUTER JOIN people
ON salaries.playerid = people.playerid
WHERE salary IN
	(SELECT MAX(salary)
	 FROM salaries
	 GROUP BY yearid,teamid)
 ORDER BY salary DESC;
 
--11. 
SELECT birthyear, deathyear, namefirst, namelast
FROM people
WHERE birthyear > ANY
	(SELECT birthyear
	 FROM people
	 WHERE playerid = 'ruthba01')
ORDER BY birthyear;

--12.
SELECT namefirst, namelast,
		CASE
				WHEN birthcountry = 'USA' THEN 'USA'
				ELSE 'non-USA'
		END AS usaborn
FROM people
ORDER BY 3;

--13. 
SELECT
AVG(CASE WHEN throws = 'R' THEN height END) AS right_height,
AVG(CASE WHEN throws = 'L' THEN height END) AS left_height
FROM people;

--14.
WITH max_sal_by_team_by_year AS
(
SELECT teamid, yearid, MAX(salary) AS max_sal
FROM salaries
GROUP BY teamid, yearid
)
SELECT teamid, AVG(max_sal) AS avg_max_sal_since_2010
FROM max_sal_by_team_by_year
WHERE yearid > 2010
GROUP BY teamid;
