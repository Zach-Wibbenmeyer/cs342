-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Lab07

DROP VIEW birthday_czar;
CREATE OR REPLACE VIEW birthday_czar AS
	SELECT P.firstName || ' ' || P.lastName AS fullName, TRUNC(months_between(SYSDATE, P.birthdate)/12) AS age, P.birthdate 
	FROM Person P;

SELECT * FROM birthday_czar
WHERE birthdate > '31-DEC-1960'
AND birthdate < '01-JAN-1976';

UPDATE Person SET birthdate = '11-JUL-1973' WHERE id = 4;


SELECT * FROM birthday_czar
WHERE birthdate > '31-DEC-1960'
AND birthdate < '01-JAN-1976';

-- Yes the results change. Since the view is not materialized, the view is changed every time a query is run.

INSERT INTO birthday_czar VALUES ('Morty Smith', 0, '26-AUG-2001');

-- I received an error of "virtual column now allowed here". In order to fix this, you would need to make the view to allow updates or be materialized.

DROP VIEW birthday_czar;

-- No, it does not affect the tables.