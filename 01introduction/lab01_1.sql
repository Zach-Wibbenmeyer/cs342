-- List all of the rows from the departments table
DESCRIBE Departments;

-- find the number of employees in the database (nb., use the COUNT() aggregate function for this).
SELECT COUNT(*) FROM Employees;

-- Part c
--i
SELECT first_name, last_name FROM Employees
WHERE salary > 15000
ORDER BY last_name, first_name;

-- ii
SELECT first_name, last_name FROM Employees
WHERE hire_date BETWEEN '01-JAN-2002' AND '31-DEC-2004'
ORDER BY last_name, first_name;

-- iii
SELECT first_name, last_name FROM Employees
WHERE phone_number NOT LIKE '%515%'
ORDER BY last_name, first_name;

-- part d
SELECT E.first_name || ' ' || E.last_name FROM Employees E
	INNER JOIN Departments D ON E.department_id = D.department_id
	WHERE D.department_name = 'Finance'
	ORDER BY last_name, first_name;
	
-- part e
SELECT L.city, L.state_province, C.country_name FROM Locations L
	INNER JOIN Countries C ON L.country_id = C.country_id
	INNER JOIN Regions R ON C.region_id = R.region_id
   WHERE R.region_name = 'Asia';
   
 -- part find
 SELECT * FROM Locations
 WHERE state_province IS NULL;
