-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342

-- Create the user
DROP USER project CASCADE;
CREATE USER project 
		IDENTIFIED BY fakedoorsdotcom35;
GRANT 
		CREATE SESSION, 
		CREATE TABLE, 
		CREATE VIEW,
  		CREATE MATERIALIZED VIEW, 
  		UNLIMITED TABLESPACE, 
  		CREATE SEQUENCE 
  		TO project;

-- Connect to the account and schema
CONNECT project/fakedoorsdotcom35;

-- Create the database
@load