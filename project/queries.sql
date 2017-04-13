-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Project 3



SELECT V.ID AS Venue, R.ID AS Room, B.name AS Band, E.firstName || ' ' || E.lastName AS Employee FROM Venue V
	JOIN Room R ON V.ID = R.venueID
	JOIN BandBooking BB ON R.ID = BB.roomID
	JOIN Band B ON BB.bandID = B.ID
	JOIN EmployeeBooking EB ON R.ID = EB.roomID
	JOIN Employee E ON EB.employeeID = E.ID
WHERE B.members > 2
ORDER BY V.ID ASC;


