-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Project 3



/*
 * This query would be important for viewing basic information on bands and employees
 * that are playing and working at different venues.
 * a six table join
 */
SELECT V.ID AS Venue, R.ID AS Room, B.name AS Band, E.firstName || ' ' || E.lastName AS Employee 
FROM Venue V
	INNER JOIN Room R ON V.ID = R.venueID
	INNER JOIN BandBooking BB ON R.ID = BB.roomID
	INNER JOIN Band B ON BB.bandID = B.ID
	INNER JOIN EmployeeBooking EB ON R.ID = EB.roomID
	INNER JOIN Employee E ON EB.employeeID = E.ID
WHERE B.members > 2
ORDER BY V.ID ASC;

/*
 * This query is good for quickly viewing the main basic information about bands in the database
 * creates a view
 * The same view can be created for employees as well
 * Demonstrates a view
 */
CREATE OR REPLACE VIEW MainBandInformation AS
	SELECT B.ID, B.name, B.hometownCity, B.hometownState, B.genre
	FROM Band B
	WHERE B.members >= 5
	AND B.albums >= 3;
	
-- select from the view
SELECT * FROM mainBandInformation;


-- See all of the rooms and which venues they are attached to
-- a self join
SELECT R.ID, O.ID
FROM Room R
	INNER JOIN Room O ON R.ID = O.venueID;

/* This query would be good for viewing which employees are working in which state.
 * In case an employer wants to reach them they know which state to look up
 * This can also be done to see which bands are playing in which states
 * a nested query
 */
SELECT E.firstName || ' ' || E.lastName AS Name
FROM Employee E
WHERE E.ID IN
	(SELECT EB.employeeID FROM EmployeeBooking EB WHERE EB.roomID IN
		(SELECT R.ID FROM Room R WHERE R.venueID IN
			(SELECT V.ID FROM Venue V
			 WHERE V.state = 'OH')
		)
	);
	
/*
 * This query is important for keeping an eye on the ticket sales at each room in each venue.
 * left outer join
 */
SELECT R.ID as Room, V.ID AS Venue, R.ticketsRemaining, R.capacity
FROM Room R
	LEFT OUTER JOIN Venue V ON R.venueID = V.ID
ORDER BY R.ticketsRemaining DESC;

/*
 * This query would be good for displaying when and how long a band is performing at a specific Room
 * The same can be done for employees
 */
SELECT B.ID || ' ' || B.name AS Band, BB.startDate || ' ' || BB.endDate AS Dates, R.name AS Room
FROM Band B
	INNER JOIN BandBooking BB ON B.ID = BB.bandID
	INNER JOIN Room R ON BB.roomID = R.ID;
	

/*
 * This query is important for displaying which employees have not been specified an end date yet.
 * Often times employers will schedule their employees and not tell them the exact date they stop until a few days before.
 * This demonstrates handling NULL values
 */
	
SELECT E.firstName || ' ' || E.lastName AS Employee_Name
FROM Employee E
	INNER JOIN EmployeeBooking EB ON E.ID = EB.employeeID
WHERE EB.endDate IS NULL;


/*
 * This query is important for joining together the bands who may possibly have NULL start dates who are playing in each room
 * Displays the amount of tickets each band has sold in the room they are playing in
 * Demonstrates aggregation by grouping
 * Inner/Outer join
 */
SELECT SUM(R.capacity) - SUM(R.ticketsRemaining) AS Tickets_Sold, B.ID AS Band
FROM Room R
	RIGHT OUTER JOIN BandBooking BB ON R.ID = BB.roomID
	INNER JOIN Band B ON BB.bandID = B.ID
GROUP BY B.ID
ORDER BY Band;