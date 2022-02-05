CREATE OR REPLACE TRIGGER emp1_vw_trig
INSTEAD OF INSERT ON emp1_vw
FOR EACH ROW
BEGIN
  INSERT INTO emp1 VALUES (:new.id, :new.name, :new.annsal/12);
END;
/
