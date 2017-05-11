CREATE OR REPLACE PROCEDURE transferRank (from_movie IN INT, to_movie IN INT, delta IN FLOAT) AS
	negative_rank EXCEPTION;
	bad_update EXCEPTION;
BEGIN
	DECLARE
		from_rank FLOAT DEFAULT 0;
		to_rank FLOAT DEFAULT 0;
		new_from_rank FLOAT DEFAULT 0;
		new_to_rank FLOAT DEFAULT 0;

	BEGIN
		LOCK TABLE Movie IN EXCLUSIVE MODE;

		SELECT rank INTO from_rank FROM Movie WHERE id = from_movie;
		SELECT rank INTO to_rank FROM Movie WHERE id = to_movie;

		IF from_rank - delta < 0 THEN
			RAISE negative_rank;
		END IF;

		UPDATE Movie SET rank = rank - delta WHERE id = from_movie;
		UPDATE Movie SET rank = rank + delta WHERE id = to_movie;

		SELECT rank INTO new_from_rank FROM Movie WHERE id = from_movie;
		SELECT rank INTO new_to_rank FROM Movie WHERE id = to_movie;

		IF (new_from_rank <> from_rank - delta) THEN
			RAISE bad_update;
		END IF;

		IF (new_to_rank <> to_rank + delta) THEN
			RAISE bad_update;
		END IF;

		COMMIT;

	EXCEPTION
		WHEN negative_rank THEN
			dbms_output.put_line('This Movie cannot have a rank lower than 0');
			ROLLBACK;
		WHEN bad_update THEN
			dbms_output.put_line('This Movie rank was not updated correctly');
			ROLLBACK;
	END;
END;
/