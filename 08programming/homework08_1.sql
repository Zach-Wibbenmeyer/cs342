-- Zach Wibbenmeyer
-- Professor Vanderlinden
-- CS342 - Homework 08

SET SERVEROUTPUT ON;

DROP TABLE RankLog;

CREATE TABLE RankLog ( 
	userID VARCHAR(32),
	dateChanged DATE,
	original NUMBER(10,2),
	modified NUMBER(10,2)
);

CREATE OR REPLACE TRIGGER RankLogTrigger 
AFTER UPDATE ON Movie 
FOR EACH ROW
BEGIN
	INSERT INTO RankLog VALUES (USER, SYSDATE, :OLD.RANK, :NEW.RANK);
	dbms_output.put_line('User: ' || USER || ', Original: ' || :OLD.RANK || ' ,Modified: ' || :NEW.RANK);
END;
/

SHOW ERRORS;