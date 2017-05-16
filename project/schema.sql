-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342

CREATE TABLE Venue (
	ID integer PRIMARY KEY,
	name varchar(64),
	streetName varchar(64),
	city varchar(32),
	state varchar(2),
	zipcode varchar(5)
);

CREATE TABLE Room (
	ID integer PRIMARY KEY,
	venueID integer,
	name varchar(64),
	capacity integer,
	ticketsRemaining integer,
	FOREIGN KEY (venueID) REFERENCES Venue(ID),
	CONSTRAINT CHK_Room CHECK (ticketsRemaining <= capacity AND ticketsRemaining >= 0)
);

CREATE TABLE Band (
	ID integer PRIMARY KEY,
	name varchar(256),
	hometownCity varchar(32),
	hometownState varchar(2),
	genre varchar(32),
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
	endDate date,
	FOREIGN KEY (bandID) REFERENCES Band(ID),
	FOREIGN KEY (roomID) REFERENCES Room(ID),
	PRIMARY KEY (bandID, roomID),
	CONSTRAINT CHK_Band_Date CHECK (startDate < endDate)
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
	FOREIGN KEY (roomID) REFERENCES Room(ID),
	PRIMARY KEY (employeeID, roomID),
	CONSTRAINT CHK_Employee_Date CHECK (startDate < endDate)
);
