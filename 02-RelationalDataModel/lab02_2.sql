-- Exercise 2.2

-- a

ALTER TABLE Movie
	ADD CONSTRAINT scorevote 
	CHECK (score IS NULL or votes > 1000);

-- b

-- You could separate a constraint from the table it modifies whenever you wish to use the constraint at a certain time, or you wish to reuse it in the future without having to rewrite the constraint.
-- An example is if an employer only wishes to add employees during a specific time of the year (during when the busy period of the year starts).
-- The employer could then turn the constraint off at the designated time instead of having to turn it off every time.