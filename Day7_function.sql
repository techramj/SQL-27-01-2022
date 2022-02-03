

declare

BEGIN


end;
/


procedure :
create or REPLACE PROCEDURE procedure_name(paramter_name mode datatype,...)
is/AS
BEGIN

end;



create or replace PROCEDURE proc1
IS
BEGIN
  print('hello');
end;
/

--call  the PROCEDURE
BEGIN
  proc1;
end;
/

exec proc1



create or replace PROCEDURE proc1(p_name varchar2)
IS
BEGIN
  print('hello '||p_name);
end;
/
NOTE: dont pass the size of datatype in paramter

create or replace procedure add_num(a number, b number)
IS
  c NUMBER;
BEGIN
  c := a+b;
  print('result : '||c);
end;

create or replace procedure add_num(a number, b number, c number)
IS
BEGIN
--

end;
/

mode of paramters
1. IN
		a. we can pass value,exp as well as variable

2. OUT
        a. pass only variable



3. IN OUT
       a. pass the variable




create or replace PROCEDURE mode_test(a in number, b out number, c in out number)
IS
BEGIN
  print('a='||a);
  print('b='||b);
  print('c='||c);
  print('assign value inside PROCEDURE');
 -- a:= 1000;  --error IN mode cannot be used as assignment
  b := 2000;
  c := 3000;
end;
/

Note:if there is error in the procedure then execute the below commands
show errors

DECLARE
  x number := 10;
  y number := 20;
  z number := 30;
BEGIN
  --mode_test(1,2,3);  --error due to out and IN out paramter
  mode_test(x,y,z);
  print('after executing procedure...');
  print('x='||x);
  print('y='||y);
  print('z='||z);
end;
/

--calucate area or rectangle


create or replace function calc_area_of_rec(length number, width number) return number
IS
  res number;
begin
  res := LENGTH*WIDTH;
  return res;
end;
/

call  the PROCEDURE
declare
  a  number;
begin
  a := calc_area_of_rec(10,20);
  print(a);
end;
/

note : call function in the select query
 select calc_area_of_rec(10,20) from dual
 
 
 create or replace PROCEDURE calc_area_and_peri_of_rec(length number, width number, area out number, peri out number) 
IS
begin
  area := LENGTH*WIDTH;
  peri := 2*(LENGTH + WIDTH);
end;
/

DECLARE
  area  number;
  p     number;
BEGIN  
   calc_area_and_peri_of_rec(10,15, area, p);
   print('area='||area);
   prrint('Peri='||p);
end;


--4
function to validate department_id is valid or NOT

create or replace function validate_dept(p_did number) return boolean
is
BEGIN
   --logic
end;
/

create or replace procedure add_emp(P_id number, p_name varchar2, p_salary number)
IS
begin
  --insert query
  --dispaly how to row are inserted
end;
/

create or replace procedure update_salary( p_salary number, p_id number)
IS
begin
  --updatate query
  --dispaly how to row are update
end;
/


create or replace procedure display_emp_rec(rec emp%rowtype)
IS
BEGIN

end;

validate_dept(225) -> false