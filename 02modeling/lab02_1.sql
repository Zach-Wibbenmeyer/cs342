-- This command file loads a simple movies database, dropping any existing tables
-- with the same names, rebuilding the schema and loading the data fresh.
--
-- CS 342, Spring, 2015
-- kvlinden

-- Drop current database
DROP TABLE Casting;
DROP TABLE Movie;
DROP TABLE Performer;

-- Create database schema
CREATE TABLE Movie (
	id integer,
	title varchar(70) NOT NULL, 
	year decimal(4), 
	score float,
	PRIMARY KEY (id),
	CHECK (year > 1900)
	);

CREATE TABLE Performer (
	id integer,
	name varchar(35),
	PRIMARY KEY (id)
	);

CREATE TABLE Casting (
	movieId integer,
	performerId integer,
	status varchar(6),
	FOREIGN KEY (movieId) REFERENCES Movie(Id) ON DELETE CASCADE,
	FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL,
	CHECK (status in ('star', 'costar', 'extra'))
	);

-- Load sample data
INSERT INTO Movie VALUES (1,'Star Wars',1977,8.9);
INSERT INTO Movie VALUES (2,'Blade Runner',1982,8.6);

INSERT INTO Performer VALUES (1,'Harrison Ford');
INSERT INTO Performer VALUES (2,'Rutger Hauer');
INSERT INTO Performer VALUES (3,'The Mighty Chewbacca');
INSERT INTO Performer VALUES (4,'Rachael');

INSERT INTO Casting VALUES (1,1,'star');
INSERT INTO Casting VALUES (1,3,'extra');
INSERT INTO Casting VALUES (2,1,'star');
INSERT INTO Casting VALUES (2,2,'costar');
INSERT INTO Casting VALUES (2,4,'costar');

-- Exercise 2.1

-- a

--i

INSERT INTO Movie VALUES (1, 'The Movie of Jahn Davis', 1901, 7.4);

-- Got a key violation error because you cannot have duplicate primary keys

-- ii

INSERT INTO Movie VALUES (NULL, 'Dahn Javis', 2408, 9.9);

-- Got an error because you cannot have a NULL primary key

-- iii

INSERT INTO Movie VALUES (3, 'Nahhhhh', 1776, 9.8);

-- Got a check constraint error because the year is less than 1900

-- iv

INSERT INTO Movie VALUES (4, 'WHAT????', 1946, 'LOL');

-- Got an error for entering a string into a decimal datatype

-- v 

INSERT INTO Movie VALUES (5, 'WHO???', 1950, -3.3);

-- You can add a movie with a negative score because the score is not specified whether it should be negative or positive



-- b 

-- i

INSERT INTO Casting VALUES (NULL, 1, 'Nah');

-- Received a check constraint error because you cannot have a NULL foreign key

-- ii

INSERT INTO Casting VALUES (2, 5, 'extra');

-- Received an integrity constraint error because a performerId of 5 does not exist

-- iii

INSERT INTO Performer VALUES (9, 'costar');

-- Query worked because you are creating a new entry for the parent. If you created an entry for the child
-- and the primary key in the parent table didn't exist, then you would have a problem.

-- c

-- i

DELETE FROM Performer
WHERE id = 1
AND name = 'Harrison Ford';

-- This worked because there are no violations

-- ii

DELETE FROM Casting
WHERE movieId = 1
AND status = 'star';

-- This worked because there are no violations

-- iii

UPDATE Movie SET id = 9
WHERE title = 'Blade Runner';

-- Received an integrity constraint error because you cannot modifify the primary key of a parent that is referencing a child

