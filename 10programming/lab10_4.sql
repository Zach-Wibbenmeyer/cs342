CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type, 
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	LOCK TABLE Movie IN EXCLUSIVE MODE;

	FOR i IN 1..50000 LOOP
		SELECT rank INTO x FROM Movie WHERE id=movieIdIn;
		UPDATE Movie SET rank=x+deltaIn WHERE id=movieIdIn;
	END LOOP;
	COMMIT;
END;
/

-- I added the lock on the Movie table to ensure that no other threads could access the table while the current thread was still using it
-- I also moved the commit right before the last END to eliminate the dirty read problems that were previously happening.