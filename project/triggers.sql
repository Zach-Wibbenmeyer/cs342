-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Project 4

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