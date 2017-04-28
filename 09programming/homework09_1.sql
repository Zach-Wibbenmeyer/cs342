-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Homework 09

SET AUTOTRACE ON; 
SET SERVEROUTPUT ON;
SET TIMING ON;


SELECT M.id, M.name, M.rank, M.year FROM Movie M
	INNER JOIN MovieDirector MD ON M.id = MD.movieID
	INNER JOIN Director D ON MD.directorID = D.id
WHERE D.firstName = 'Clint'
	AND D.lastName = 'Eastwood';
	
-- Elapsed: 00:00:00.03

CREATE INDEX homework09 ON MovieDirector(directorID)

SELECT M.id, M.name, M.rank, M.year FROM Movie M
	INNER JOIN MovieDirector MD ON M.id = MD.movieID
	INNER JOIN Director D ON MD.directorID = D.id
WHERE D.firstName = 'Clint'
	AND D.lastName = 'Eastwood';
	
DROP INDEX homework09;

-- Elapsed: 00:00:00.01

CREATE INDEX homework09 ON Director(firstName, lastName);


SELECT M.id, M.name, M.rank, M.year FROM Movie M
	INNER JOIN MovieDirector MD ON M.id = MD.movieID
	INNER JOIN Director D ON MD.directorID = D.id
WHERE D.firstName = 'Clint'
	AND D.lastName = 'Eastwood';
	
DROP INDEX homework09;

-- Elapsed: 00:00:00.03