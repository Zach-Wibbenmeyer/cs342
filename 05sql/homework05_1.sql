-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Homework 05

-- a

SELECT DISTINCT E.employee_id, E.first_name || ' ' || E.last_name AS fullname, JH.end_date from Employees E
	INNER JOIN Job_History JH ON E.employee_id = JH.employee_id
	WHERE JH.end_date IS NOT NULL;
	
	
	
-- b

SELECT DISTINCT E.employee_id AS EmployeeID, E.first_name || ' ' || E.last_name AS EmployeeFullName,
M.employee_id AS ManagerID, M.first_name || ' ' || M.last_name AS ManagerFullName FROM Employees E
	INNER JOIN Employees M ON M.employee_id = E.manager_id
	INNER JOIN Job_History JH ON E.employee_id = JH.employee_id
	WHERE E.hire_date < M.hire_date AND M.department_id = JH.department_id;

	
-- c

SELECT DISTINCT C.country_name FROM Countries C
	INNER JOIN Locations L ON C.country_id = L.country_id
	INNER JOIN Departments D ON L.location_id = D.location_id;