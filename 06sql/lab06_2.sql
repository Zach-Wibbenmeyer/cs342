-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Lab 06

-- 6.2
-- a

SELECT TRUNC((MONTHS_BETWEEN(SYSDATE, MIN(birthdate)) - MONTHS_BETWEEN(SYSDATE, MAX(birthdate))) / 12) AS AverageAge FROM Person;

-- Query is not using groups; just finding the min and max and computing the result

-- b

SELECT H.ID, count(P.ID) FROM Household H
	INNER JOIN Person P ON H.ID = P.householdID
	WHERE H.city = 'Grand Rapids'
	GROUP BY H.ID
	HAVING count(P.ID) >= 2
	ORDER BY count(P.ID) DESC;

-- c

SELECT H.ID, H.phoneNumber, count(P.ID) FROM Household H
	INNER JOIN Person P ON H.ID = P.householdID
	WHERE H.city = 'Grand Rapids'
	GROUP BY H.ID, H.phoneNumber
	HAVING count(P.ID) >= 2
	ORDER BY count(P.ID) DESC;