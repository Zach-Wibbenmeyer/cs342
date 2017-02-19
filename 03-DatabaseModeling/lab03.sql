-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Lab 03

-- Drop tables if previous data exists

DROP TABLE Request;
DROP TABLE PersonTeam;
DROP TABLE Team;
drop table Person;
drop table HouseHold;
DROP TABLE Homegroup;

-- Create tables

create table HouseHold (
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);

CREATE TABLE Homegroup (
	ID integer PRIMARY KEY,
	name varchar(32),
	description varchar(300)
);

create table Person (
	ID integer PRIMARY KEY,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
	mentorID integer,
	homegroupID integer,
	householdID integer,
	householdRole varchar(32) CHECK (householdRole IN ('Father', 'Mother', 'Child')),
	FOREIGN KEY (mentorID) REFERENCES Person(ID) ON DELETE SET NULL,
	FOREIGN KEY (homegroupID) REFERENCES Homegroup(ID) ON DELETE SET NULL,
	FOREIGN KEY (householdID) REFERENCES HouseHold(ID) ON DELETE SET NULL
	);

CREATE TABLE Team (
	ID integer PRIMARY KEY,
	name varchar(32)
);

CREATE TABLE PersonTeam (
	personID integer,
	teamID integer,
	role varchar(32),
	beginDate date NOT NULL,
	duration interval year (4) to month,
	FOREIGN KEY (personID) REFERENCES Person(ID) ON DELETE SET NULL,
	FOREIGN KEY (teamID) REFERENCES Team(ID) ON DELETE SET NULL
);

CREATE TABLE Request (
	ID integer PRIMARY KEY,
	requestorID integer,
	responderID integer,
	request varchar(300),
	response varchar(300),
	time date NOT NULL,
	FOREIGN KEY (requestorID) REFERENCES HouseHold(ID) ON DELETE SET NULL,
	FOREIGN KEY (responderID) REFERENCES Person(ID) ON DELETE SET NULL
);

-- Insert data

INSERT INTO Household VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');
INSERT INTO HouseHold VALUES (1,'150 Alger Street SE','Grand Rapids','MI','49507','159-357-2583');

INSERT INTO Homegroup VALUES (0, 'The Council of Ricks', 'Group of Rick(s) and Morty(s)');

INSERT INTO Person VALUES (0,'mr.','Keith','VanderLinden','m',NULL,0,0,'Father');
INSERT INTO Person VALUES (1,'ms.','Brenda','VanderLinden','m',NULL,NULL,0,'Mother');
INSERT INTO Person VALUES (2,'mr.','Morty','Smith','c',0,0,1,'Child');

INSERT INTO Team VALUES (0, 'Galactic Federation');
INSERT INTO Team VALUES (1, 'Rick(s) Team');
INSERT INTO Team VALUES (2, 'Snowball(s) Dog Army');

INSERT INTO PersonTeam VALUES (0, 0, 'Gromflomite Guard', sysdate, '2001-02');
INSERT INTO PersonTeam VALUES (1, 1, 'Morty Smith', sysdate, '2001-03');
INSERT INTO PersonTeam VALUES (2, 2, 'Dog', sysdate, '2001-04');

INSERT INTO Request VALUES (0, 0, 0, 'Destroy Emperor Snowball', NULL, sysdate);