------------------------------------- Athlete_Events -------------------------------------------

# 1 How many olympics games have been held?
SELECT COUNT(DISTINCT Games) 
FROM athlete_events;

# 1 How many olympics games have been held?
SELECT DISTINCT Games
FROM athlete_events;

# 3. Mention the total no of nations who participated in each olympics game?
SELECT COUNT(DISTINCT NOC) AS Participated_Countries
FROM athlete_events;

# 4. Which year saw the highest and lowest no of countries participating in olympics?
SELECT Year, CountryCount
FROM (SELECT Year, COUNT(DISTINCT NOC) AS CountryCount
      FROM athlete_events
      GROUP BY Year) AS Subquery
ORDER BY CountryCount DESC
LIMIT 1;

SELECT Year, CountryCount
FROM (SELECT Year, COUNT(DISTINCT NOC) AS CountryCount
      FROM athlete_events
      GROUP BY Year) AS Subquery
ORDER BY CountryCount ASC
LIMIT 1;

#5. Which nation has participated in all of the olympic games?
SELECT NOC
FROM athlete_events
GROUP BY NOC
HAVING COUNT(DISTINCT games) = (SELECT COUNT(DISTINCT games) FROM athlete_events);


#6. Identify the sport which was played in all summer olympics.
SELECT DISTINCT Sport 
FROM athlete_events
where Season = "Summer";

#7. Which Sports were just played only once in the olympics?
SELECT DISTINCT Sport 
FROM athlete_events
GROUP BY Sport
HAVING COUNT(DISTINCT Games)=1;

#8. Fetch the total no of sports played in each olympic games.
SELECT Games, COUNT(DISTINCT Sport) AS total_sports_played
FROM athlete_events
GROUP BY Games
ORDER BY Games;

#9. Fetch details of the oldest athletes to win a gold medal.
SELECT Name, MAX(Age) AS max_age
FROM athlete_events
WHERE Medal = 'Gold'
GROUP BY Name
HAVING Age = max_age;

#10. Find the Ratio of male and female athletes participated in all olympic games.
SELECT
  SUM(CASE WHEN Sex = 'M' THEN 1 ELSE 0 END) / 
  SUM(CASE WHEN Sex = 'F' THEN 1 ELSE 0 END) AS gender_ratio
FROM athlete_events;

#11. Fetch the top 5 athletes who have won the most gold medals.
SELECT Name, COUNT(*) AS total_gold_medals
FROM athlete_events
WHERE Medal = 'Gold'
GROUP BY Name
ORDER BY total_gold_medals DESC
LIMIT 5;

#12. Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
SELECT Name, COUNT(*) AS total_gold_medals
FROM athlete_events
WHERE Medal in ('Gold','Silver','Bronze')
GROUP BY Name
ORDER BY total_gold_medals DESC
LIMIT 5;

#13. Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
SELECT NOC as Country , COUNT(*) as Total_Medals
FROM athlete_events
WHERE Medal in ('Gold','Silver','Bronze')
GROUP BY Country
ORDER BY Total_Medals DESC
LIMIT 5;

#14. List down total gold, silver and broze medals won by each country.
SELECT
	DISTINCT NOC AS Country,
    SUM(CASE WHEN Medal = 'Gold' THEN 1 ELSE 0 END) AS Gold_Medals,
    SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
    SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
FROM athlete_events
GROUP BY Country
ORDER BY Country;

#15. List down total gold, silver and broze medals won by each country corresponding to each olympic games
SELECT
    Games,
    NOC AS Country,
    SUM(CASE WHEN Medal = 'Gold' THEN 1 ELSE 0 END) AS Gold_Medals,
    SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
    SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
FROM athlete_events
GROUP BY Games, Country
ORDER BY Games, Country;

#16. Identify which country won the most gold, most silver and most bronze medals in each olympic games
SELECT
	Games,
    MAX(CASE WHEN Medal = 'Gold' THEN NOC END) AS most_gold_country ,
    SUM(CASE WHEN Medal = 'Gold' THEN 1 ELSE 0 END) AS Gold_Medals,
    MAX(CASE WHEN Medal = 'Silver' THEN NOC END) AS most_silver_country ,
    SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
    MAX(CASE WHEN Medal = 'Bronze' THEN NOC END) AS most_bronze_country,
    SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
FROM athlete_events
GROUP BY Games;

#17. Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.
SELECT
	Games,COUNT(*) as Total_Medals,
    MAX(CASE WHEN Medal = 'Gold' THEN NOC END) AS most_gold_country ,
    SUM(CASE WHEN Medal = 'Gold' THEN 1 ELSE 0 END) AS Gold_Medals,
    MAX(CASE WHEN Medal = 'Silver' THEN NOC END) AS most_silver_country ,
    SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
    MAX(CASE WHEN Medal = 'Bronze' THEN NOC END) AS most_bronze_country,
    SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
FROM athlete_events
WHERE Medal in ('Gold','Silver','Bronze')
GROUP BY Games;

#18. Which countries have never won gold medal but have won silver/bronze medals?
SELECT 
	NOC as Country , 
	COUNT(*) as Total_Medals,
    SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
    SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
FROM athlete_events
WHERE Medal not in ('Gold','NA')
GROUP BY Country
ORDER BY Total_Medals DESC;

#19. In which Sport/event, India has won highest medals.
SELECT Sport, Event, COUNT(*) AS Total_Medals
FROM athlete_events
WHERE NOC = 'IND' AND Medal != 'NA'
GROUP BY Sport, Event
ORDER BY Total_Medals DESC
LIMIT 1;

#20. Break down all olympic games where india won medal for Hockey and how many medals in each olympic games
SELECT Games, COUNT(*) AS Total_Medals
FROM athlete_events
WHERE NOC = 'IND' AND Medal IN ('Gold', 'Silver', 'Bronze') AND Sport = 'Hockey'
GROUP BY Games
ORDER BY Games;









