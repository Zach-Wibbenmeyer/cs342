-- This command file loads an experimental person database.
-- The data conforms to the following assumptions:
--     * People can have 0 or many team assignments.
--     * People can have 0 or many visit dates.
--     * Teams and visits don't affect one another.
--
-- CS 342, Spring, 2017
-- kvlinden

-- Finshed by: Zach Wibbenmeyer

DROP TABLE PersonTeam;
DROP TABLE PersonVisit;

CREATE TABLE PersonTeam (
	personName varchar(10),
    teamName varchar(10)
	);

CREATE TABLE PersonVisit (
	personName varchar(10),
    personVisit date
	);

-- Load records for two team memberships and two visits for Shamkant.
INSERT INTO PersonTeam VALUES ('Shamkant', 'elders');
INSERT INTO PersonTeam VALUES ('Shamkant', 'executive');
INSERT INTO PersonVisit VALUES ('Shamkant', '22-FEB-2015');
INSERT INTO PersonVisit VALUES ('Shamkant', '1-MAR-2015');

-- Query a combined "view" of the data of the form View(name, team, visit).
SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;


-- a
-- The schema is in BCNF because there are no non-trivial functional dependencies.
-- The schema is not in 4NF because there is a multivalued dependency.
-- personName -> teamName
-- personName is also not a superkey in the relation.

-- b
-- Here are the functional dependencies:
-- personName -> teamName, personVisit
-- This schema is in BCNF since there are no non-trivial functional dependencies.
-- This schema is not in 4NF because there is a multivalued dependency where personName is not a superkey.

-- c
-- No. They have the same number of records, but the View has redundant information, so these schemas are not equally appropriate.
-- The first schema is better because it doesn't have the multivalued dependency that the View has. Also, for each new relation in the schema, only one row must be added
-- whereas for each new relation in the View, multiple rows must be added.
