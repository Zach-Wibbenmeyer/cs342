-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342

CREATE TABLE Venue (
	ID integer PRIMARY KEY,
	name varchar(32),
	streetName varchar(64),
	city varchar(32),
	state varchar(2),
	zipcode varchar(5)
);

CREATE TABLE Room (
	ID integer PRIMARY KEY,
	venueID integer,
	name varchar(32),
	capacity integer,
	ticketsRemaining integer DEFAULT capacity,
	FOREIGN KEY (venueID) REFERENCES Venue(ID),
	CONSTRAINT CHK_Room CHECK (ticketsRemaining <= capacity AND ticketsRemaining >= 0)
);

CREATE TABLE Band (
	ID integer PRIMARY KEY,
	name varchar(64),
	hometownCity varchar(32),
	hometownState,varchar(2),
	genre varchar(16),
	members integer,
	inception integer,
	albums integer,
	CHECK (members > 0),
	CHECK (albums >= 0)
);

CREATE TABLE BandBooking (
	bandID integer,
	roomID integer,
	startDate date,
	endDate date
	FOREIGN KEY (bandID) REFERENCES Band(ID),
	FOREIGN KEY (roomID) REFERENCES Room(ID)
);

CREATE TABLE Employee (
	ID integer PRIMARY KEY,
	firstName varchar(16),
	lastName varchar(16),
	hireDate date,
	streetName varchar(64),
	city varchar(32),
	state varchar(2),
	zipcode varchar(5)
);

CREATE TABLE EmployeeBooking (
	employeeID integer,
	roomID integer,
	startDate date,
	endDate date,
	FOREIGN KEY (employeeID) REFERENCES Employee(ID),
	FOREIGN KEY (roomID) REFERENCES Room(ID)
);