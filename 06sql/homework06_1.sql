-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Homework 06

-- a

SELECT * FROM
	(SELECT E.employee_id AS ManagerID, E.first_name || ' '|| E.last_name AS Manager, count(Z.employee_id) AS NumberOfEmployees FROM Employees E
		INNER JOIN Employees Z ON E.employee_id = Z.manager_id
		GROUP BY E.employee_id, E.first_name, E.last_name
		ORDER BY count(Z.employee_id) DESC)
	WHERE rownum <= 10;
	
	
-- b

SELECT * FROM
	(SELECT D.department_name, count(E.employee_id) AS NumberOfEmployees, SUM(E.salary) FROM Departments D
		INNER JOIN Locations L ON L.location_id = D.location_id
		INNER JOIN Employees E ON D.department_id = E.department_id
		WHERE L.country_id = 'US'
		GROUP BY D.department_name)
	WHERE NumberOfEmployees < 100;
	
-- c

SELECT D.department_name, E.first_name || ' ' || E.last_name AS Manager, J.job_title FROM Departments D 
	LEFT OUTER JOIN Employees E ON D.department_id = E.department_id
	INNER JOIN Jobs J ON J.job_id = E.job_id;
	

-- d

SELECT D.department_name, AVG(E.salary) AS AverageSalary FROM Departments D
	LEFT OUTER JOIN Employees E ON D.department_id = E.department_id
	GROUP BY D.department_name
	ORDER BY AverageSalary, D.department_name;