-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Homework 05

-- a

SELECT DISTINCT P.lastName || ', ' || P.firstName || ' and ' || Y.firstName || ' - ' || H.phoneNumber || ' - ' || H.street as PhoneBookEntry
	FROM Household H
	INNER JOIN Person P ON H.ID = P.householdID
	INNER JOIN Person Y ON H.ID = Y.householdID
	WHERE P.householdRole = 'husband' and Y.householdRole = 'wife'
	ORDER BY PhoneBookEntry;

-- b

SELECT DISTINCT P.lastName || ', ' || P.firstName || ' and ' || Y.firstName || ' - ' || 
(CASE WHEN P.lastName = Y.lastName THEN '' ELSE Y.lastName END)
|| ' - ' || H.phoneNumber || ' - ' || H.street as PhoneBookEntry
	FROM Household H
	INNER JOIN Person P ON H.ID = P.householdID
	INNER JOIN Person Y ON H.ID = Y.householdID
	WHERE P.householdRole = 'husband' and Y.householdRole = 'wife'
	ORDER BY PhoneBookEntry;

-- c

SELECT DISTINCT P.lastName || ', ' || P.firstName ||
  (CASE WHEN P.householdRole = 'single' THEN '' ELSE
    (' and ' || Y.firstName || ' ' ||
      (CASE WHEN P.lastName = Y.lastName THEN '' ELSE Y.lastName END)
    )
  END)
  || ' - ' || H.phoneNumber || ' - ' ||  H.street AS PhoneBookEntry
	FROM Household H
	INNER JOIN Person P ON H.ID = P.householdID
	INNER JOIN Person Y ON H.ID = Y.householdID
	WHERE (P.householdRole = 'husband' and Y.householdRole = 'wife')
		OR P.householdRole = 'single'
	ORDER BY PhoneBookEntry;	