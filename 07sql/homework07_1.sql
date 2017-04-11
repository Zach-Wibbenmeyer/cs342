-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Homework 07

DROP VIEW zdw3;
CREATE OR REPLACE VIEW zdw3 AS
	SELECT E.employee_id AS id, E.first_name || ' ' || E.last_name AS name, E.email, E.hire_date, D.department_name AS department
	FROM Employees E
	INNER JOIN Departments D ON E.department_id = D.department_id;
	
-- a
SELECT * FROM
	(SELECT name, id, hire_date FROM zdw3 WHERE department = 'Executive' ORDER BY hire_date DESC)
WHERE rownum < 2;

-- b
UPDATE zdw3 SET department = 'Bean Counting' WHERE department = 'Administration';

-- I received the error "cannot modify a column which maps to a non key-preserved table".
-- The department table is the actual table that needs to be updated, but it is not key-preserved in this view.

-- c 

UPDATE zdw3 SET name = 'Manuel' WHERE name = 'Jose Manuel';

-- This query does not work because I have created the view in a specific way.

-- d

DELETE FROM zdw3 WHERE id = 1234;
INSERT INTO zdw3 VALUES (1234, 'Krombopulos Michael', 'kmich', SYSDATE, 'Payroll');

-- This also does not work because of the name column that I created.