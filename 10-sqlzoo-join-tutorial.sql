-- ============================================
-- SQLZoo Practice — JOIN Tutorial (goal/team/player/game)
-- Source: sqlzoo.net (soccer database)
-- ============================================

-- Q1: Basic filter — all goals scored by a specific player
SELECT game, team, player, gtime
FROM goal 
WHERE player = 'Leandro Trossard';

-- Q2: Look up team details by team code (id)
SELECT id, teamname, coach
FROM team
WHERE id LIKE 'BEL';

-- Q3: JOIN goal + team — show player, gtime, teamname for goals under 8 minutes
SELECT player, gtime, teamname
FROM goal JOIN team ON goal.team = team.id
WHERE gtime < 8;

-- Q4: JOIN goal + team, filter by coach name
SELECT player, teamname, coach
FROM goal
JOIN team ON goal.team = team.id
WHERE coach LIKE 'Sébastien%';

-- Q5: JOIN goal + team + game — player, game id, and city for a specific player's goals
SELECT player, game.id, city
FROM goal 
JOIN team ON goal.team = team.id
JOIN game ON goal.game = game.id
WHERE player = 'Harry Edward Kane';

-- Q6: JOIN goal + team + game — player and team code for goals scored in a specific city
SELECT player, team
FROM goal
JOIN team ON goal.team = team.id
JOIN game ON goal.game = game.id
WHERE city = 'Vancouver';

-- Q7: Same as Q6 but showing full teamname instead of team code
SELECT player, teamname
FROM goal
JOIN team ON goal.team = team.id
JOIN game ON goal.game = game.id
WHERE city = 'Vancouver';

-- Q8: JOIN game + team using OR condition — returns 2 rows per game (one per team)
-- This pattern is specifically for listing both teams in a match, not for goal-scorer queries
SELECT city, teamname
FROM game
JOIN team ON team.id = game.team1 OR team.id = game.team2
WHERE played = '2026-07-01';

-- Q9: JOIN goal + team + game via goal.game = game.id (NOT team1/team2 OR — 
-- that pattern doesn't apply here since we're tracing a specific goal to its specific game)
SELECT teamname, player
FROM goal
JOIN team ON goal.team = team.id
JOIN game ON goal.game = game.id
WHERE played = '2026-07-02';

-- Q10: JOIN game + goal + player — date, player, and position for goals scored in Mexico City
SELECT played, player, pos
FROM game
JOIN goal ON game.id = goal.game
JOIN player ON goal.player = player.playername
WHERE city = 'Mexico City';

-- Q11: Defenders who scored — JOIN via player.team (not goal.team), 
-- because goal.team reflects the team CREDITED with the goal (can differ on own-goals),
-- while the question asks for "their teamname" = the scoring player's own team
SELECT player, teamname
FROM goal
JOIN player ON goal.player = player.playername
JOIN team ON player.team = team.id
WHERE pos = 'DEF'
ORDER BY playername;

-- Q12: Extra time goals (gtime 91-120) — same own-goal distinction as Q11 applies:
-- joined via player.team, not goal.team, to get the scoring player's actual team
SELECT player, pos, teamname, city
FROM goal
JOIN player ON goal.player = player.playername
JOIN team ON player.team = team.id
JOIN game ON goal.game = game.id
WHERE gtime BETWEEN 91 AND 120;