--We are working on a dataset from NBA games.
--Finding all allstar MVP players

SELECT allstar_mvps.player_id, players.name
FROM allstar_mvps LEFT JOIN players
ON allstar_mvps.player_id=players.id

--Finding all players born in New York

SELECT name
FROM players
WHERE birth_place LIKE '%New York%'
ORDER BY name

--Finding which players born in New York hold a MVP title

SELECT DISTINCT ny.name, ny.id
FROM (SELECT players.name as name, players.id as id
FROM players
WHERE birth_place LIKE '%New York%') as ny
INNER JOIN allstar_mvps
ON ny.id=allstar_mvps.player_id

--Finding which players have the same height

SELECT A.name AS name_A, B.name AS players_B, A.height
FROM players as A, players as B
WHERE A.id <> B.id
AND A.height = B.height
ORDER BY A.height desc

--Making a list of the top 10 of the players having the most Player of the Month Awards

select  COUNT(monthly_player_awards.season), MAX(players.full_name), monthly_player_awards.player_id
from monthly_player_awards
INNER JOIN players on monthly_player_awards.player_id=players.id
Group By player_id
ORDER BY count DESC
LIMIT 10

--Using table teams, we create a new column that writes the messages "More than 2000 wins", "2000 wins" or "Less than 2000 wins" depending the nr of wins it has,
--and also print the name and the number of wins for each team.

SELECT team_name, total_wins,
CASE
   WHEN total_wins > 2000 THEN 'More than 2000 wins'
   WHEN total_wins = 2000 THEN '2000 wins'
   ELSE 'Less than 2000 wins'
END AS WinsCategory
FROM teams

--Creating a view with the team id, team name and number of championships

CREATE VIEW Wins AS
SELECT teams.team_id, teams.team_name, most_wins.count
FROM teams INNER JOIN
(Select champions.team_id, count(champions.team_id)
FROM champions
Group By team_id) as most_wins
ON teams.team_id=most_wins.team_id
ORDER BY count desc

--Display our view

SELECT * from Wins

--Printing from the view all the teams from Miami or Milwaukee that have a championship

SELECT *
FROM Wins
Where team_name like 'Miami%' OR team_name like 'Mil%'


--Updating view with total wins and total loses

CREATE OR REPLACE VIEW Wins AS
SELECT teams.team_id, teams.team_name, most_wins.count, teams.total_wins,teams.total_losses
FROM teams INNER JOIN
(Select champions.team_id, count(champions.team_id)
FROM champions
Group By team_id) as most_wins
ON teams.team_id=most_wins.team_id
ORDER BY count DESC;

Select * from Wins

--Finding all players that have both awards and other awards and print the name of the award as well

SELECT players.id, name, height, player_awards.award, other_player_awards.award
FROM players
INNER JOIN player_awards ON players.id=player_awards.player_id
INNER JOIN other_player_awards ON players.id=other_player_awards.payer_id

