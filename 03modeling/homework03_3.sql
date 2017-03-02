-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Homework 03

-- drop tables if previous data exists
DROP TABLE OrdPart;
DROP TABLE Ord;
DROP TABLE Part;
DROP TABLE Customer;
DROP TABLE Employee;

-- create the tables
CREATE TABLE Employee (
	id int PRIMARY KEY,
	firstName varchar(32) NOT NULL,
	lastName varchar(32) NOT NULL,
	zip varchar(16) NOT NULL
);

CREATE TABLE Customer (
	id int PRIMARY KEY,
	firstName varchar(32) NOT NULL,
	lastName varchar(32) NOT NULL,
	zip varchar(16) NOT NULL
);

CREATE TABLE Part (
	id int PRIMARY KEY,
	name varchar(32) NOT NULL,
	price number(*,2) NOT NULL,
	stockQuantity int NOT NULL
);

CREATE TABLE Ord (
	id int PRIMARY KEY,
	employeeID int,
	customerID int,
	purchaseDate date,
	expectedShipDate date,
	actualShipDate date,
	FOREIGN KEY (employeeID) REFERENCES Employee(id) ON DELETE SET NULL,
	FOREIGN KEY (customerID) REFERENCES Customer(id) ON DELETE SET NULL
);

CREATE TABLE OrdPart (
	orderID int,
	partID int,
	quantity int,
	FOREIGN KEY (orderID) REFERENCES Ord(id) ON DELETE SET NULL,
	FOREIGN KEY (partID) REFERENCES Part(id) ON DELETE SET NULL
);

-- Create some sample data

INSERT INTO Employee VALUES (0, 'Summer', 'Smith', '20013');
INSERT INTO Employee VALUES (1, 'Mr.', 'Needful', '20013');
INSERT INTO Employee VALUES (2, 'Mr.', 'Meseeks', '51263');

INSERT INTO Customer VALUES (0, 'Rick', 'Sanchez', '12345');
INSERT INTO Customer VALUES (1, 'Morty', 'Smith', '12345');
INSERT INTO Customer VALUES (2, 'Krombopulos', 'Michael', '78945');

INSERT INTO Part VALUES (0, 'Anti-matter Gun', 3000, 1);
INSERT INTO Part VALUES (1, 'Murder Generating Typewriter', 0, 1);
INSERT INTO Part VALUES (2, 'Gearhead(s) Gearsticles', 500, 2);

INSERT INTO Ord VALUES (0, 0, 0, SYSDATE, SYSDATE, SYSDATE);
INSERT INTO Ord VALUES (1, 1, 1, SYSDATE, SYSDATE, SYSDATE);
INSERT INTO Ord VALUES (2, 2, 2, SYSDATE, SYSDATE, SYSDATE);

INSERT INTO OrdPart VALUES (0, 0, 1);
INSERT INTO OrdPart VALUES (1, 1, 1);
INSERT INTO OrdPart VALUES (2, 2, 2);