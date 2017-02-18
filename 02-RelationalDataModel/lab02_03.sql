-- Exercise 2.4

CREATE SEQUENCE movieSeq START WITH 10 INCREMENT BY 1;

-- Insert into Movie table

INSERT INTO Movie VALUES (movieSeq.nextVal, 'White Chicks', 2003, 7.0, 2006);
INSERT INTO Movie VALUES (movieSeq.nextVal, 'Good Will Hunting', 1994, 9.5, 2010);

-- a
-- You would not need an additional sequence for the performers.

-- b
-- As long as you do not create rows with the same ID as the primary key you should be fine.
