-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342

-- Create the user
DROP USER zachproject CASCADE;

CREATE USER zachproject IDENTIFIED BY fakedoorsdotcom35;

GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW,
  CREATE MATERIALIZED VIEW, UNLIMITED TABLESPACE, CREATE SEQUENCE TO zachproject;

-- Connect to the account and schema
CONNECT zachproject/fakedoorsdotcom35;

-- Create the database
@load
