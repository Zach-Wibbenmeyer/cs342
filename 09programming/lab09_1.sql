-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Lab 09

SET AUTOTRACE ON; 
SET SERVEROUTPUT ON;
SET TIMING ON;

-- a

DECLARE
	temp INTEGER;
BEGIN
	FOR i IN 1..100 LOOP
		SELECT COUNT(*) INTO temp FROM Actor;
	END LOOP;
END;
/

-- Elapsed: 00:00:01.23

DECLARE
	temp INTEGER;
BEGIN
	FOR i IN 1..100 LOOP
		SELECT COUNT(1) INTO temp FROM Actor;
	END LOOP;
END;
/

 -- Elapsed: 00:00:01.21
 
DECLARE
	temp INTEGER;
BEGIN
	FOR i IN 1..100 LOOP
		SELECT SUM(1) INTO temp FROM Actor;
	END LOOP;
END;
/

-- Elapsed: 00:00:02.43

-- There is a little bit of benefit of using COUNT(*) and COUNT(1) over SUM(1) but only by about a second


-- b
SET AUTOTRACE OFF;

SELECT COUNT(*) FROM Movie M
	INNER JOIN Role R ON M.id = R.movieID
	INNER JOIN Actor A ON A.id = R.actorID;
/

-- Elapsed: 00:00:00.07

SELECT COUNT(*) FROM Actor A
	INNER JOIN Role R ON A.id = R.actorID
	INNER JOIN Movie M ON R.movieID = M.id;
/

-- Elapsed: 00:00:00.07

SELECT COUNT(*) FROM Role R
	INNER JOIN Movie M ON R.movieID = M.id
	INNER JOIN Actor A ON R.actorID = A.id;
/

-- Elapsed: 00:00:00.06

-- There seems to be no differences in times

-- c

DECLARE
	temp INTEGER;
BEGIN
	FOR i IN 1..100 LOOP
		SELECT COUNT(*) INTO temp FROM Actor A
			INNER JOIN Role R ON A.id = R.actorID;
	END LOOP;
END;
/

-- Elapsed: 00:00:05.40

DECLARE
	temp INTEGER;
BEGIN
	FOR i IN 1..100 LOOP
		SELECT COUNT(*) INTO temp FROM Actor A
			INNER JOIN Role R ON A.id + 1 = R.actorID + 1;
	END LOOP;
END;
/

-- Elapsed: 00:01:01.15

-- Using addition requires quite a bit of more time to execute

-- d

DECLARE
	temp INTEGER;
BEGIN
	FOR i IN 1..100 LOOP
		SELECT COUNT(*) INTO temp FROM Movie M
			INNER JOIN Actor A ON M.id = A.id;
	END LOOP;
END;
/

-- Elapsed: 00:00:14.33

DECLARE
	temp INTEGER;
BEGIN
	FOR i IN 1..100 LOOP
		SELECT COUNT(*) INTO temp FROM Movie M
			INNER JOIN Actor A ON M.id = A.id;
	END LOOP;
END;
/

-- Elapsed: 00:00:14.30

DECLARE
	temp INTEGER;
BEGIN
	FOR i IN 1..100 LOOP
		SELECT COUNT(*) INTO temp FROM Movie M
			INNER JOIN Actor A ON M.id = A.id;
	END LOOP;
END;
/

-- Elapsed: 00:00:14.31

-- Not too much of time differences

-- e


SELECT COUNT(*) FROM Actor A
	INNER JOIN Role R ON A.id = R.actorID
	INNER JOIN Movie M ON M.id = R.movieID
	WHERE A.id = 1234 and M.id = 2634;
	
-- Elapsed: 00:00:00.06 without index

DROP INDEX lab09;
CREATE INDEX lab09 ON Role(actorID, movieID);


SELECT COUNT(*) FROM Actor A
	INNER JOIN Role R ON A.id = R.actorID
	INNER JOIN Movie M ON M.id = R.movieID
	WHERE A.id = 1234 and M.id = 2634;

-- ERROR at line 1:
-- ORA-01652: unable to extend temp segment by 128 in tablespace SYSTEM

-- Elapsed: 00:00:01.76 with index