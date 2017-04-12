-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Lab/Homework 08

CREATE TABLE SequelsTemp (
	id INTEGER,
	name VARCHAR2(100),
	PRIMARY KEY (id)
 );
 
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE getSequels (movie_id IN Movie.id%type) AS
	CURSOR sequels IS
		SELECT sequelID FROM Movie WHERE id = movie_id;
BEGIN
	DELETE FROM SequelsTemp;
	FOR seq IN sequels LOOP
		getSequels(seq.sequelID);
		INSERT INTO SequelsTemp
			(SELECT id, name FROM Movie WHERE id = seq.sequelID);
	END LOOP;
END;
/

SHOW ERRORS;

BEGIN getSequels(238071);
END;
/
SELECT * FROM SequelsTemp;

BEGIN getSequels(238075);
END;
/
SELECT * FROM SequelsTemp;

DROP TABLE SequelsTemp;