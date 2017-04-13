-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Homework 08

SET SERVEROUTPUT ON;
ALTER SYSTEM SET open_cursors = 500;

DROP TABLE BaconNumber;
CREATE TABLE BaconNumber (
	actor_id VARCHAR(32) PRIMARY KEY,
	bacon_number INTEGER
);

CREATE OR REPLACE PROCEDURE FindBaconNumber (bacon_id IN INTEGER, recursion_depth IN INTEGER) AS 
	CURSOR actors IS SELECT DISTINCT R.actorID FROM Role R WHERE R.movieID IN
		(SELECT movieID FROM Role WHERE actorID = bacon_id);
BEGIN
	DECLARE actor_does_exist INT DEFAULT 0;
	BEGIN
		FOR actor IN actors LOOP
			SELECT COUNT(*) INTO actor_does_exist FROM BaconNumber WHERE actor_id = actor.actorID;
			IF actor_does_exist = 0 and recursion_depth < 25 THEN
				INSERT INTO BaconNumber VALUES (actor.actorID, recursion_depth);
				FindBaconNumber(actor.actorID, recursion_depth + 1);
			ELSE
				UPDATE BaconNumber SET bacon_number = recursion_depth WHERE actor_id = actor.actorID AND bacon_number > recursion_depth;
			END IF;
		END LOOP;
	END;
END;
/

SHOW ERRORS;

CREATE OR REPLACE PROCEDURE ComputeBaconNumber (bacon_id IN INTEGER) AS
BEGIN
	dbms_output.put_line('Finding bacon numbers for all actors with id ' || bacon_id);
	INSERT INTO BaconNumber VALUES (bacon_id, 0);
	FindBaconNumber(bacon_id, 1);
END;
/

SHOW ERRORS;

BEGIN ComputeBaconNumber(22591);
END;
/
SHOW ERRORS;