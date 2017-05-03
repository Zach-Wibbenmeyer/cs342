-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Project 4

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE AddRoomToVenue (room_id INTEGER, venue_id INTEGER, room_name VARCHAR, room_capacity INTEGER, tickets_remaining INTEGER) AS
	exist INTEGER := 0;
BEGIN
	SELECT COUNT(*) INTO exist FROM Room R WHERE R.ID = AddRoomToVenue.room_id AND R.venueID = AddRoomToVenue.venue_id;
	IF exist > 1 THEN
		dbms_output.put_line('Venue ' || venue_id || ' already has this room ' || room_id);
	ELSE
		INSERT INTO Room VALUES (room_id, venue_id, room_name, room_capacity, tickets_remaining);
		dbms_output.put_line('Venue ' || venue_id || ' now has another room ' || room_name);
	END IF;
END;
/

SHOW ERRORS;

-- Add a room to a venue

EXECUTE AddRoomToVenue(51, 50, 'Delmar Hall', 750, 120);