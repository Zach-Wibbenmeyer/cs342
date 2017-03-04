-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Lab 05

-- a
-- This is not correlated because there is not an outer table to be correlated with the inner table
SELECT * FROM
(SELECT * FROM Person WHERE birthdate IS NOT NULL ORDER BY birthdate desc)
WHERE ROWNUM = 1;


-- b
-- Neither correlated or un-correlated because it does not have a sub-query
SELECT P.ID, P.firstName || ' ' || P.lastName AS fullName FROM Person P
INNER JOIN Person E ON P.firstName = E.firstName
WHERE E.ID <> P.ID
ORDER BY fullName;

INSERT INTO Person VALUES (20,'ms.','Jean','Sanchez','m','f',NULL,3,'single',2,'member');

-- you get duplicate entries if you have more than 3 people with the same name
-- to fix this, use distinct


SELECT DISTINCT P.ID, P.firstName || ' ' || P.lastName AS fullName FROM Person P
INNER JOIN Person E ON P.firstName = E.firstName
WHERE E.ID <> P.ID
ORDER BY fullName;

-- c
-- Neither correlated or un-correlated since there are no sub-queries

SELECT P.firstName || ' ' || P.lastName as fullName from Person P
	INNER JOIN PersonTeam PT on P.id = PT.personId
	WHERE PT.teamName = 'Music'
MINUS
SELECT P.firstName || ' ' || P.lastName as fullName from Person P
	INNER JOIN HomeGroup HG on HG.ID = P.homeGroupID
	WHERE HG.name = 'Byl';