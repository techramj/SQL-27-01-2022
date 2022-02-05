1. TRIGGER
    Application TRIGGER
    DATABASE TRIGGER
        SYSTEM TRIGGER
        DML TRIGGER
           STATEMENT TRIGGER
             BEFORE
             AFTER
           
           ROW TRIGGER
             BEFORE 
             AFTER


--statement trigger
CREATE OR REPLACE TRIGGER trig1
BEFORE INSERT OR DELETE OR UPDATE ON emp1
BEGIN
  print('trig1 is called');
  --COMMIT;
END;
/

--row trigger
CREATE OR REPLACE TRIGGER trig1
BEFORE UPDATE ON emp1
FOR EACH ROW
BEGIN
  print('trig1 is called');
END;
/


BEGIN
  UPDATE emp1
  SET salary =salary
  WHERE ROWNUM =3;
  print(SQL%ROWCOUNT||' row updated');
END;
/

--scenario no one cann perform dml operation after 7:oo PM


CREATE OR REPLACE TRIGGER trig2
BEFORE INSERT OR UPDATE OR DELETE ON emp1
BEGIN
  IF inserting OR updating THEN
    print('Trying to insert/update data at '||to_char(SYSDATE,'HH24:MI:SS'));
    IF to_char(SYSDATE,'hh24') >= 19 OR to_char(SYSDATE,'hh24')<9 THEN
      raise_application_error(-20001,'DML operation not allowed between 7 PM to 9 AM');
    END IF;
  ELSIF deleting THEN
    print('Trying to delete data at '||to_char(SYSDATE,'HH24:MI:SS'));
    IF to_char(SYSDATE,'hh24') >= 20 OR to_char(SYSDATE,'hh24')<9 THEN
      raise_application_error(-20001,'DML operation not allowed between 7 PM to 9 AM');
    END IF;
  END IF;
END;
/

UPDATE emp1
SET salary=salary;

INSERT INTO emp1 VALUES (8,'Sam',1000);

DELETE emp1 WHERE ID<=10;
SELECT * FROM emp1;

--row triggers
--audit;

SELECT * FROM emp1;

CREATE SEQUENCE seq_emp1_audit
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE TABLE emp1_audit
(sno  NUMBER DEFAULT seq_emp1_audit.nextval,
old_id NUMBER,
 new_id NUMBER,
 old_name VARCHAR2(20),
 new_name VARCHAR2(20),
 old_salary VARCHAR2(20),
 new_salary VARCHAR2(20),
 last_updated_date DATE DEFAULT SYSDATE,
 action  VARCHAR2(10)
 );


--disable trigger
ALTER TRIGGER trig1 DISABLE;
ALTER TABLE emp1 DISABLE ALL TRIGGERS;



CREATE OR REPLACE TRIGGER audit_emp1_trigger
BEFORE INSERT OR UPDATE OR DELETE ON emp1
FOR EACH ROW
WHEN (old.salary != new.salary)
DECLARE
  v_action VARCHAR2(20);
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  IF inserting THEN
    v_action := 'INSERT';
  ELSIF updating THEN 
    v_action := 'UPDATE';
  ELSE
    v_action := 'DELETE';
  END IF;
  
  INSERT INTO emp1_audit(old_id,new_id, old_name, new_name,
                         old_salary,new_salary,action)
  VALUES (:old.id, :new.id, :old.name, :new.name, :old.salary,:new.salary,v_action);
  COMMIT;

END;
/


INSERT => :NEW
DELETE  => :OLD
UPDATE => :NEW, :OLD;


SELECT * FROM emp1_audit;

UPDATE emp1 SET salary=5000 WHERE ID=8;
INSERT INTO emp1 (ID,NAME,salary)
SELECT employee_id,last_name,salary FROM employees WHERE employee_id>200;

UPDATE emp1 SET salary = salary+100 WHERE ID=100;
ROLLBACK;

SELECT * FROM User_Trigger_Cols;

SELECT * FROM user_triggers;


-- instead of

SELECT * FROM emp1;

CREATE OR REPLACE VIEW emp1_vw AS SELECT ID,NAME,salary*12 AS annsal FROM emp1;

SELECT * FROM emp1_vw;

INSERT INTO emp1 VALUES (1,'a',1000);

INSERT INTO emp1_vw VALUES (2,'b',24000);


CREATE OR REPLACE TRIGGER emp1_vw_trig
INSTEAD OF INSERT ON emp1_vw
FOR EACH ROW
BEGIN
  INSERT INTO emp1 VALUES (:new.id, :new.name, :new.annsal/12);
END;
/


CREATE OR REPLACE PROCEDURE p1
IS
BEGIN
   print('trig3 called');
END;

CREATE OR REPLACE TRIGGER trig3
BEFORE INSERT OR UPDATE OR DELETE ON emp1
CALL p1





