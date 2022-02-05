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
