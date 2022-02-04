Diff b/w procedure and function
1. function return the value but procedure doesnt 
2. function can be used in select query




create or replace procedure foo(a out number)
is
begin
  a := 10;
end;
/
  
  
create or replace function check_deptid(p_did number) return varchar2
IS
  v_count  number;
BEGIN
 select count(*) into v_count 
 from departments d 
 where department_id = p_did;
 
 if v_count = 0 then 
    return 'Invalid';
 ELSE
    return 'Valid';
 end if;
end;
/

-->How to execute function
--
DECLARE
  valid_flag varchar2(20); 
BEGIN
  valid_flag := check_deptid(10);
  print(valid_flag);
  
  valid_flag := check_deptid(11);
  print(valid_flag);
end;
/


select check_deptid(10) from dual;
  
create or replace function check_deptid(p_did number) return BOOLEAN
IS
  v_count  number;
BEGIN
 select count(*) into v_count 
 from departments d 
 where department_id = p_did;
 
 if v_count = 0 then 
    return false;
 ELSE
    return true;
 end if;
end;
/

-->How to execute function
--
DECLARE
  valid_flag BOOLEAN; 
BEGIN
  valid_flag := check_deptid(10);
   if valid_flag THEN
     print('valid did');
   else 
    print('Invalid did');
   end if;
  
  valid_flag := check_deptid(11);
  if valid_flag THEN
     print('valid did');
   else 
    print('Invalid did');
   end if;
  
end;
/


select check_deptid(10) from dual;

phone_no  VARCHAR2(20) :=  '1234512345';  --(+91) 12345 12345

create or replace PROCEDURE format_phone_number(phone_no in out varchar2)
IS
BEGIN
  phone_no := '(+91) '||SUBSTR(phone_no,1,5)||'  '||SUBSTR(phone_no,6,5);
end;

DECLARE
 phone_no  VARCHAR2(20) :=  '1234512345';
BEGIN
  format_phone_number(phone_no);
  print(phone_no);
end;
/


------------DEFAULT parameter


create or replace PROCEDURE foo(a number default 1,b number default 10,c number := 20)								
  IS
BEGIN
   print('a='||a);
   print('b='||b);
   print('c='||c);
end;
 /
 
 
create or replace PROCEDURE foo(a number default 1,b number,c number := 20)								
  IS
BEGIN
   print('a='||a);
   print('b='||b);
   print('c='||c);
end;
 /
 

no of ways paramter passed in plsql block.
1.positional   foo(1,2,3)
2.Named        foo(a=>1, b=>2, c=>3)
3.combinational foo(100, b=>20, c=>10);
                 -- foo(100, b=>20, 10);
				 
				 
create or replace procedure add_emp
(p_id number,
fname varchar2, 
lname varchar2,
p_hire_date date default SYSDATE,
p_Job_id varchar2 default 'IT_PROG', 
p_salary NUMBER,
mgr_id number:=101,
did number DEFAULT 20)
IS
  v_email emp.email%type;
BEGIN
   v_email := substr(fname,1,1)||substr(lname,1,7);
   if not validate_dept(did) then
     RAISE_APPLICATION_ERROR(-20001,'Invalid did: '||did);
   end if;
   
   insert into emp(employee_id, first_name, last_name, email,hire_date, job_id,
   salary,manager_id, department_id)
   values (p_id,fname,lname,v_email, p_hire_date,p_Job_id, p_salary, mgr_id,did);
   
   print(sql%rowcount||' row inserted');
   commit;

end;
/

create or replace procedure add_emp
(fname varchar2, 
lname varchar2,
p_hire_date date default SYSDATE,
p_Job_id varchar2 default 'IT_PROG', 
p_salary NUMBER,
mgr_id number:=101,
did number DEFAULT 20)
IS
  v_email emp.email%type;
BEGIN
   add_emp(emp_seq.NEXTVAL,fname,lname, p_hire_date,p_Job_id ,p_salary ,mgr_id ,did );
end;


BEGIN
  add_emp( fname=>'Jack', lname=>'Dehaan', p_salary =>4000, did=>11);
end;



function -> table t

create or replace function delete_emp(id number) return number
IS
  a number;
BEGIN
  delete emp where employee_id= id;
  a:= sql%rowcount;
  return a;
end;
/

Rule: if the function is using dml operation, then function cannot be used in select query


create or replace function max_sal(id number) return number
IS
  max_sal number;
BEGIN
  select max(salary) into max_sal from employees;  
 
  return max_sal;
end;
/	

DECLARE
  a number;
BEGIN
  a := max_sal(101);
  print(a);
end;
/

update EMP
set salary=max_sal(100)
where id=200;


update employees
set salary=max_sal(100)
where employee_id=200;

           *
ERROR at line 2:
ORA-04091: table HR.EMPLOYEES is mutating, trigger/function may not see it
ORA-06512: at "HR.MAX_SAL", line 5

if in a function , T table is used in select query, then dont use that funtion in the DML of t table.


create or replace funtion foo1 return NUMBER
IS
BEGIN
  select * into rec from T where rownum=1;
  return 1;
end;
/

delete EMP where id=foo1;
delete T  where id= foo1;  --mutating error


