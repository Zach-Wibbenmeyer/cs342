-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Project 4

/*
 * MaxAlbums - Trigger that raises an application error if a band has produce more than 12 albums... because they've obviously been in the music scene for too long...
 * But hey, if their good, then they should keep going right????? Nah.
 */
CREATE TRIGGER MaxAlbums BEFORE INSERT ON Band FOR EACH ROW
DECLARE
	maximum INTEGER;
	tooManyAlbums EXCEPTION;
BEGIN
	SELECT albums INTO maximum FROM Band WHERE Band.ID = :new.ID;
	IF maximum > 12 THEN
		RAISE tooManyAlbums;
	END IF;
	EXCEPTION
		WHEN tooManyAlbums THEN
			RAISE_APPLICATION_ERROR(-20000, 'Band has produced way too many albums... they need to quit');
END;
/

SHOW ERRORS;