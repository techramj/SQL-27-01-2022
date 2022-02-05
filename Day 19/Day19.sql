--  DDL
--  DCL
--  DML
--  TCL

CREATE TABLE emp AS SELECT * FROM employees;
CREATE TABLE dept AS SELECT * FROM departments;

BEGIN
   CREATE TABLE t1(ID NUMBER);
END;
/

--dynamic sql query

SELECT * FROM t1;

BEGIN
  EXECUTE IMMEDIATE 'CREATE TABLE t1(ID NUMBER)';
END;
/

BEGIN
  EXECUTE IMMEDIATE 'drop TABLE t1';
END;
/


DECLARE
  v_count NUMBER;
  v_table_name VARCHAR
BEGIN
  SELECT COUNT(*) INTO v_count FROM employees;
  print(v_count);
END;
/


DECLARE
  v_row_count NUMBER;
BEGIN
   v_row_count := pkg_manage_db.fetch_no_of_columns('employees');
  print('Employees cols='||v_row_count);
  
  print('departments cols='|| pkg_manage_db.fetch_no_of_columns('departments'));
END;
/

SELECT * FROM employees;
SELECT * FROM departments;

SELECT * FROM DICTIONARY;

SELECT * FROM user_tables;
SELECT * FROM user_tab_columns WHERE table_name ='EMPLOYEES';
SELECT * FROM user_tab_cols;


SELECT * FROM user_tab_columns WHERE table_name = 'EMPLOYEES'


BEGIN
   EXECUTE IMMEDIATE 'delete t1 where id= :id' USING 1 ;
   print(SQL%ROWCOUNT);
   ROLLBACK;
END;
/


BEGIN
  DELETE t1 WHERE ID=1;
  print(SQL%ROWCOUNT);
  ROLLBACK;
END;

Begin 
	EXECUTE IMMEDIATE'Update dept  set department_name= :dname where department_id= :did' USING 'Operations',200;
  print(SQL%ROWCOUNT);
end;
/

  
 
DECLARE
  TYPE emp_tab_type IS TABLE OF employees%ROWTYPE;
  tab   emp_tab_type;
BEGIN
  EXECUTE IMMEDIATE 'select * from employees'  BULK COLLECT INTO tab;
  
  print(tab.count);
  
  print(tab(1).last_name);
END;
/



SELECT * FROM emp1;

CREATE OR REPLACE PROCEDURE add_emp(p_ID NUMBER, p_NAME VARCHAR2, p_salary NUMBER)
IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   INSERT INTO emp1 VALUES (p_id, p_name, p_salary);
   print(SQL%ROWCOUNT||' row inserted');
   COMMIT;
END;
/


BEGIN
   DELETE emp1 WHERE ID=103;
   print(SQL%ROWCOUNT||' row deleted');
   add_emp(5,'Johnie',2000);
   add_emp(6,'Johnie',2000);
   ROLLBACK;
END;
/













