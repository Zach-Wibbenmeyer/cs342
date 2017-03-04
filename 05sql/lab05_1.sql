-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Lab 05

-- a


-- This returns 128 rows
SELECT * FROM Person, Household;

-- You could also SQL to compute this number
SELECT COUNT(*) FROM Person, Household;

-- b

SELECT * FROM Person
WHERE birthdate IS NOT NULL
ORDER BY TO_CHAR(birthdate, 'DDD');