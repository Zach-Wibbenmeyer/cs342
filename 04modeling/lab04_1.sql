-- This command file loads an experimental person relation.
-- The data conforms to the following assumptions:
--     * Person IDs and team names are unique for people and teams respectively.
--     * People can have at most one mentor.
--     * People can be on many teams, but only have one role per team.
--     * Teams meet at only one time.
--
-- CS 342
-- Spring, 2017
-- kvlinden

-- Finished by: Zach Wibbenmeyer

drop table AltPerson;

CREATE TABLE AltPerson (
	personId integer,
	name varchar(10),
	status char(1),
	mentorId integer,
	mentorName varchar(10),
	mentorStatus char(1),
    teamName varchar(10),
    teamRole varchar(10),
    teamTime varchar(10)
	);

INSERT INTO AltPerson VALUES (0, 'Ramez', 'v', 1, 'Shamkant', 'm', 'elders', 'trainee', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
INSERT INTO AltPerson VALUES (2, 'Jennifer', 'v', 3, 'Jeff', 'm', 'deacons', 'treasurer', 'Tuesday');
INSERT INTO AltPerson VALUES (3, 'Jeff', 'm', NULL, NULL, NULL, 'deacons', 'chair', 'Tuesday');


-- a
-- This table is poorly designed because there are multiple redundant values, NULL values,
-- and the naming of AltPerson is terrible.
-- This table does not utilize functional dependencies. It needs to be modeled into multiple tables instead of just one.
-- Here are the dependencies:
-- personID -> name, status, mentorID, mentorName, mentorStatus
-- mentorID -> mentorName, mentorStatus
-- teamName -> teamTime
-- teamName, personID -> teamRole
-- Candidate keys: teamName, personID

-- b
-- In order to be in BCNF and in 4NF, the schema should look something like this:
-- Person(personID (primary key), name, status, mentorID (foreign key))
-- Team(teamID (primary key), name, time)
-- PersonTeam(personID (foreign key), teamID, role)