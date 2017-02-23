-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Homework02

-- 1

-- Clear tables in case previous data exists
DROP TABLE Shipment;
DROP TABLE OrderItem;
DROP TABLE Ord;
DROP TABLE Customer;
DROP TABLE Item;
DROP TABLE Warehouse;

-- Drop sequences in case previous data exists

DROP SEQUENCE customerSequence;
DROP SEQUENCE orderSequence;
DROP SEQUENCE itemSequence;
DROP SEQUENCE warehouseSequence;

-- Create the tables

CREATE TABLE Customer(
	customerNumber integer,
	customerName varchar(32) NOT NULL,
	city varchar (32) NOT NULL,
	PRIMARY KEY (customerNumber)
);

CREATE TABLE Ord(
	orderNumber integer,
	customerNumber integer,
	orderDate date NOT NULL,
	orderAmount number(*,2),
	PRIMARY KEY (orderNumber),
	FOREIGN KEY (customerNumber) REFERENCES Customer(customerNumber) ON DELETE SET NULL,
	CHECK (orderAmount > 0)
);

CREATE TABLE Item(
	itemNumber integer,
	itemName varchar(32) NOT NULL,
	unitPrice number(*,2),
	PRIMARY KEY (itemNumber),
	CHECK (unitPrice > 0)
);

CREATE TABLE OrderItem(
	orderNumber integer,
	itemNumber integer,
	quantity integer,
	FOREIGN KEY (orderNumber) REFERENCES Ord(orderNumber) ON DELETE SET NULL,
	FOREIGN KEY (itemNumber) REFERENCES Item(itemNumber) ON DELETE SET NULL,
	CHECK (quantity > 0)
);

CREATE TABLE Warehouse(
	warehouseNumber integer,
	city varchar(32) NOT NULL,
	PRIMARY KEY (warehouseNumber)
);

CREATE TABLE Shipment(
	orderNumber integer,
	warehouseNumber integer,
	shipDate date NOT NULL,
	FOREIGN KEY (orderNumber) REFERENCES Ord(orderNumber) ON DELETE SET NULL,
	FOREIGN KEY (warehouseNumber) REFERENCES Warehouse(warehouseNumber) ON DELETE SET NULL
);

-- Create sequences

CREATE SEQUENCE customerSequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE orderSequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE itemSequence START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE warehouseSequence START WITH 1 INCREMENT BY 1;

-- Create sample data

INSERT INTO Customer VALUES (customerSequence.nextVal, 'Rick Sanchez', 'Earth C-137');
INSERT INTO Customer VALUES (customerSequence.nextVal, 'Bird Person', 'Bird World');
INSERT INTO Customer VALUES (customerSequence.nextVal, 'Squanchy', 'Planet Squanch');
INSERT INTO Customer VALUES (customerSequence.nextVal, 'Scary Terry', 'Dream World');

INSERT INTO Item VALUES (itemSequence.nextVal, 'Portal Gun', 1000);
INSERT INTO Item VALUES (itemSequence.nextVal, 'Debri', 5.00);
INSERT INTO Item VALUES (itemSequence.nextVal, 'Meseeks Box', 500.00);
INSERT INTO Item VALUES (itemSequence.nextVal, 'Dream Inceptor', 780.00);
INSERT INTO Item VALUES (itemSequence.nextVal, 'Juice Tooth', 675.00);

INSERT INTO Warehouse VALUES (warehouseSequence.nextVal, 'The Garage');
INSERT INTO Warehouse VALUES (warehouseSequence.nextVal, 'Highschool');
INSERT INTO Warehouse VALUES (warehouseSequence.nextVal, 'Jerry Daycare');
INSERT INTO Warehouse VALUES (warehouseSequence.nextVal, 'Galactic Federation Outpost');

INSERT INTO Ord VALUES (orderSequence.nextVal, 1, sysdate, 1000);
INSERT INTO Ord VALUES (orderSequence.nextVal, 2, sysdate, 1500);
INSERT INTO Ord VALUES (orderSequence.nextVal, 3, sysdate, 1200);
INSERT INTO Ord VALUES (orderSequence.nextVal, 4, sysdate, 1100);
INSERT INTO Ord VALUES (orderSequence.nextVal, 2, sysdate, 1600);

INSERT INTO OrderItem VALUES (1, 1, 1);
INSERT INTO OrderItem VALUES (2, 2, 10);
INSERT INTO OrderItem VALUES (3, 3, 2);
INSERT INTO OrderItem VALUES (4, 3, 1);
INSERT INTO OrderItem VALUES (5, 5, 1);

INSERT INTO Shipment VALUES (1, 1, sysdate);
INSERT INTO Shipment VALUES (2, 3, sysdate);
INSERT INTO Shipment VALUES (3, 4, sysdate);
INSERT INTO Shipment VALUES (4, 2, sysdate);
INSERT INTO Shipment VALUES (5, 4, sysdate);

-- 2

-- Surrogate keys should be fine for CIT to use. Their only purpose to be able to uniquely indetify a row in a table.
-- Since that is their only purpose, that means that they will also never change, which should make it perfectly acceptable for CIT to use.

-- 3

SELECT O.orderDate, O.orderAmount FROM Ord O
	INNER JOIN Customer C ON O.customerNumber = C.customerNumber
	WHERE C.customerName = 'Rick Sanchez'
	ORDER BY O.orderDate;

SELECT UNIQUE C.customerNumber FROM Customer C
	INNER JOIN Ord O ON C.customerNumber = O.customerNumber;

SELECT C.customerNumber, C.customerName FROM Customer C
	INNER JOIN Ord O ON C.customerNumber = O.customerNumber
	INNER JOIN OrderItem OI ON O.orderNumber = OI.orderNumber
	INNER JOIN Item I ON OI.itemNumber = I.itemNumber
	WHERE I.itemName = 'Meseeks Box';

