-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS 342 - Lab 08

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE actor_database (actor_id INTEGER, movie_id INTEGER, newRole VARCHAR) AS
	exist INTEGER := 0;
	roles INTEGER := 0;
BEGIN
	SELECT COUNT(*) INTO exist FROM Role R WHERE R.actorID = actor_database.actor_id AND R.movieID = actor_database.movie_id;
	SELECT COUNT(*) INTO roles FROM Role R WHERE R.movieID = actor_database.movie_id;
	IF exist > 0 THEN
		dbms_output.put_line('Actor ' || actor_id || ' has already been cast in movie ' || movie_id);
	ELSIF roles >= 230 THEN
		dbms_output.put_line('Too many actors have been cast in movie ' || movie_id);
	ELSE
		INSERT INTO Role VALUES (actor_id, movie_id, newRole);
		dbms_output.put_line('Actor ' || actor_id || ' has been cast as ' || newRole || ' in movie ' || movie_id);
	END IF;
END;
/

SHOW ERRORS;


EXECUTE actor_database(89558, 238072, 'Danny Ocean');
-- George Clooney has already been cast in this movie

EXECUTE actor_database(89558, 238073, 'Danny Ocean');
-- George Clooney was added to this movie

EXECUTE actor_database(89558, 167324, 'Danny Ocean');
-- Too many actors have already been cast in this movie