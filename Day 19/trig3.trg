CREATE OR REPLACE TRIGGER trig3
BEFORE INSERT OR UPDATE OR DELETE ON emp1
CALL p1
/
