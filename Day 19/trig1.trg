CREATE OR REPLACE TRIGGER trig1
BEFORE UPDATE ON emp1
BEGIN
  print('trig1 is called');

END;
/
