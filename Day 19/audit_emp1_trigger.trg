CREATE OR REPLACE TRIGGER audit_emp1_trigger
BEFORE INSERT OR UPDATE OF salary OR DELETE ON emp1
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
