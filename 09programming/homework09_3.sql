-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS 342 - Homework 09

SET AUTOTRACE ON; 
SET SERVEROUTPUT ON;
SET TIMING ON;


SELECT A.id, A.firstName, A.lastName, TRUNC(AVG(M.rank), 1) AS AverageRank, COUNT(1) AS NumberOfMovies
FROM Actor A 
	INNER JOIN Role R ON A.id = R.actorID
	INNER JOIN Movie M ON R.movieID = M.id
HAVING AVG(M.rank) > 8.5 AND COUNT(*) >= 10
GROUP BY A.id, A.firstName, A.lastName
ORDER BY AVG(M.rank) ASC;

-- Elapsed: 00:00:04.79

CREATE INDEX homework09 ON Actor(firstName, lastName);


SELECT A.id, A.firstName, A.lastName, TRUNC(AVG(M.rank), 1) AS AverageRank, COUNT(1) AS NumberOfMovies
FROM Actor A 
	INNER JOIN Role R ON A.id = R.actorID
	INNER JOIN Movie M ON R.movieID = M.id
HAVING AVG(M.rank) > 8.5 AND COUNT(*) >= 10
GROUP BY A.id, A.firstName, A.lastName
ORDER BY AVG(M.rank) ASC;

DROP INDEX homework09;

-- Elapsed: 00:00:02.78