-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Homework 09


SET AUTOTRACE ON; 
SET SERVEROUTPUT ON;
SET TIMING ON;

SELECT D.id, D.firstName, D.lastName, COUNT(1) AS NumberOfMovies
FROM Director D
	INNER JOIN MovieDirector MD ON D.id = MD.directorID
HAVING COUNT(*) > 200
GROUP BY D.id, D.firstName, D.lastName
ORDER BY COUNT(*) ASC;

-- Elapsed: 00:00:00.32

CREATE INDEX homework09 ON MovieDirector(directorID);


SELECT D.id, D.firstName, D.lastName, COUNT(1) AS NumberOfMovies
FROM Director D
	INNER JOIN MovieDirector MD ON D.id = MD.directorID
HAVING COUNT(*) > 200
GROUP BY D.id, D.firstName, D.lastName
ORDER BY COUNT(*) ASC;

-- Elapsed: 00:00:00.32