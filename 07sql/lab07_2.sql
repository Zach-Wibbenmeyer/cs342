-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Lab 07

DROP VIEW birthday_czar;

CREATE MATERIALIZED VIEW birthday_czar FOR UPDATE AS
	SELECT id, firstname || ' ' || lastname AS fullName, birthdate FROM Person;
	


SELECT * FROM birthday_czar WHERE birthdate > '31-DEC-1960' and birthdate < '01-JAN-1976';

UPDATE Person SET birthdate = '11-JUL-1974' WHERE id = 5;

SELECT * FROM birthday_czar WHERE birthdate > '31-DEC-1960' AND birthdate < '01-JAN-1976';

-- results of the query do not change because the view is materialized.

DELETE FROM birthday_czar WHERE id = 37;
INSERT INTO birthday_czar VALUES (37, 'Rick Sanchez', '15-MAR-1942');

-- I was able to insert a column into the view

DROP MATERIALIZED VIEW birthday_czar;

-- This does not alter the tables in any way.