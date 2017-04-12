-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Homework 07

DROP MATERIALIZED VIEW departmentView;
CREATE MATERIALIZED VIEW departmentView AS
	(SELECT E.employee_id, E.first_name, E.last_name, E.email, E.hire_date, D.department_name AS department
	FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.department_id = D.department_id);

-- a	

SELECT * FROM
	(SELECT employee_id, first_name, last_name
	FROM departmentView
	WHERE department_name = 'Executive'
	ORDER BY hire_date DESC)
WHERE ROWNUM < 2;

-- b

UPDATE departmentView SET department = 'Bean Counting' WHERE department = 'Administration';

-- Received an illegal datamanipulation error
-- This view is not updateable since it is not key-preservered.

--c

INSERT INTO departmentView VALUES (1234, 'Zach', 'Wibbenmeyer', 'zdw3', SYSDATE, 'Payroll');

-- Returns the same error as the previous question.

-- d 

UPDATE departmentView SET first_name = 'Manuel' WHERE first_name = 'Jose Manuel';

-- Again, this returns the illegal data manipulation error.