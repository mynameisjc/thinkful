SELECT *
FROM ksprojects;

--1. Write a query that returns a list of all the unique values in the 'country' field.
SELECT DISTINCT country
FROM ksprojects;

--2. How many unique values are there for the main_category field? What about for the category field?
SELECT COUNT (DISTINCT main_category), COUNT (DISTINCT category)
FROM ksprojects;
--15 unique values in main_category, 158 unique values in category

--3. Get a list of all the unique combinations of main_category and category fields, sorted A to Z by main_category.
SELECT DISTINCT main_category, category
FROM ksprojects
ORDER BY main_category;

--4. How many unique categories are in each main_category?
SELECT DISTINCT main_category, COUNT (DISTINCT category)
FROM ksprojects
GROUP BY main_category
ORDER BY main_category;
--"Art"	"13"
--"Comics"	"6"
--"Crafts"	"15"
--"Dance"	"5"
--"Design"	"7"
--"Fashion"	"9"
--"Film & Video"	"20"
--"Food"	"13"
--"Games"	"8"
--"Journalism"	"6"
--"Music"	"18"
--"Photography"	"7"
--"Publishing"	"15"
--"Technology"	"16"
--"Theater"	"7"

--5. Write a query that returns the average number of backers per main_category,
--rounded to the nearest whole number and sorted from high to low.
SELECT DISTINCT main_category, ROUND(AVG(backers),0) AS backers_avg
FROM ksprojects
GROUP BY main_category
ORDER BY backers_avg DESC;

--6. Write a query that shows, for each category, how many campaigns were successful
--and the average difference per project between dollars pledged and the goal.
SELECT category, AVG(usd_pledged - goal) as over_goal, COUNT(*)
FROM ksprojects
WHERE state = 'successful'
GROUP BY category;

--7.Write a query that shows, for each main category, how many projects had
--zero backers for that category and the largest goal amount for that category
--(also for projects with zero backers).
SELECT DISTINCT main_category, COUNT(*), MAX(goal)
FROM ksprojects
WHERE backers = 0
GROUP BY main_category;

--8.For each category, find the average USD per backer, and return only those
--results for which the average USD per backer is < $50, sorted high to low.
SELECT category, AVG(usd_pledged/NULLIF(backers,0)) AS usd_per_backer
FROM ksprojects
GROUP BY category
HAVING AVG(usd_pledged/NULLIF(backers,0)) < 50
ORDER BY usd_per_backer DESC;

--9. Write a query that shows, for each main_category, how many successful
--projects had between 5 and 10 backers.
SELECT main_category, COUNT(*)
FROM ksprojects
WHERE state = 'successful' AND backers BETWEEN 5 AND 10
GROUP BY main_category;

--10. Get a total of the amount ‘pledged’ for each type of currency grouped
--by its respective currency. Sort by ‘pledged’ from high to low.
SELECT SUM(pledged) AS total_pledged, currency
FROM ksprojects
GROUP BY currency
ORDER BY total_pledged DESC;

--11. Excluding Games and Technology records in the main_category field, 
--return the total of all backers for successful projects by main_category
--where the total was more than 100,000. Sort by main_category from A to Z.
SELECT main_category, SUM(backers)
FROM ksprojects
WHERE main_category NOT IN('Games', 'Technology') AND state = 'successful'
GROUP BY main_category
HAVING SUM(backers) > 100000
ORDER BY main_category DESC;