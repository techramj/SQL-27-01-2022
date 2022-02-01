DECLARE
   a number := 10;   
   b number  default 5;
   c number;
BEGIN
   -- a := 100;
    --b := 200;
    dbms_output.put_line('a='||a||'  b='||b);
    c :=  a**b;
      dbms_output.put_line('c='||c);
END;
/



DECLARE
   today date; 
   tomorrow  today%type;
   c number;
BEGIN
  null;
END;
/



declare
  v_sal number;
  id    number := &id;
begin
    select salary  into v_sal
    from employees where employee_id=id;
    
    dbms_output.put_line(v_sal);
end;
/

Rule: the select should fetch only one record, if using in plsql



declare
  v_sal number;
  name    varchar2(200) := '&name';
begin
    select salary  into v_sal
    from employees where last_name =name;
    
    dbms_output.put_line(v_sal);
end;
/

--Type of datatype :=>Scalar  and Composite

declare
 -- v_sal number(9,2);
 v_sal employees.salary%type;
  name    varchar2(200) := '&name';
begin
    select salary  into v_sal
    from employees where last_name =name;
    
    dbms_output.put_line(v_sal);
end;
/

--diff b/w char and varchar2

declare
  a  char(10) := 'ABC';
  b varchar2(10) := 'ABC';
begin
    dbms_output.put_line(length(a));
    dbms_output.put_line(length(b));
end;
/



declare
  a  char(5) := 'ABC';
  b varchar2(5) := 'ABC';
begin
    dbms_output.put_line(length(a));
    dbms_output.put_line(length(b));
     dbms_output.put_line(length('ABC'));

     if a = 'ABC' then
         dbms_output.put_line('both are equals');
     end if;
end;
/

create or replace procedure print(str varchar2)
is
begin
    dbms_output.put_line(str);
end;
/

--IF   ELSIF  ELSE  END IF;
declare
   a  number:=&num1;
   b number := &num2;
   c number := &num3;
begin
   if a>b  and  a>c then
       print(a||' is greatest');
   elsif b>c then
      print(b||' is greater');
  else
      print(c||' is greater');
  end if;
end;
/

--enter the mark: 1 to 100
if mark  >=80  => GRADE A
if mark>=60  and <80  => GRADE B
if mark>=40  and <60  => GRADE C
if mark>=0  and <40  => GRADE FAIL


declare
   mark number := &mark;
begin
   if mark>=80   and mark<=100 then
      print('GRADE A');
  end if;
  
   if mark>=60   and mark<80 then
      print('GRADE B');
  end if;
  
   if mark>=40   and mark<60 then
      print('GRADE C');
  end if;
  
   if mark>=0   and mark<40 then
      print('GRADE FAIL');
  end if;
end;
/

if mark>80


declare
   mark number := &mark;
begin
   if mark>=80   then
      print('GRADE A');
  elsif mark>=60   then
      print('GRADE B');
 elsif mark>=40  then
      print('GRADE C');
  else
      print('GRADE FAIL');
  end if;
end;
/



declare
   mark number := &mark;
   grade varchar2(10);
begin
   if mark>=80   then
       grade := 'A';
  elsif mark>=60   then
       grade := 'B';
 elsif mark>=40  then
        grade := 'C';
  else
       grade := 'FAIL';
  end if;
  
  print('GRADE : '||grade);
end;
/






--nested if else

if  x>100 then
  if a >1 then
  
  else
  
  
  end if;

end if;



#LOOP
while => while
for=> for
do while => simple loop

1.. simple loop

declare
   a number := 1;
begin
   loop
     print(a);
     a:= a+1;
     exit when a>10;
   end loop;
end;

2. 1.. while loop

declare
   a number := 1;
begin
   while(a<=10) loop
     print(a);
     a:= a+1;
   end loop;
end;

3. for loop

begin
  for i in 1..10 loop 
    print(i);
  end loop;
end ;

begin
  for i in reverse 1..10 loop 
    print(i);
  end loop;
end ;


#nested loop

begin
      for i in 1.. 10 loop
         for j in 1..i loop
           dbms_output.put(j);
         end loop;
         print('');
      end loop
end;

--exit from current loop
begin
      for i in 1.. 10 loop
         for j in 1..i loop
           dbms_output.put(j);
           exit when j=5;
         end loop;
         print('');
      end loop;
end;
/

--exit from all the loop

begin
<<outer>>
      for i in 1.. 10 loop
       <<inner>>
         for j in 1..i loop
           dbms_output.put(j);
           exit outer when j=5;
         end loop;
         print('');
      end loop;
      print('');
end;
/


begin
  for i in 1..10 loop
    if i=5 then
      continue;
    end if;
end loop;
end;
/


declare
  v_sal   employees.salary%type;
  name employees.last_name%type;
begin
  for  i in 100..120 loop
     select last_name, salary 
     into name, v_sal
     from employees
     where employee_id = i;
     
     print(i||'   '||name||'  '||v_sal);
  end loop;
end;
/


--select rule
declare
  v_salary   employees.salary%type;
  v_employee_id   number := &id;
begin
  select salary into v_salary
  from employees
  where employee_id= v_employee_id;
  
  print(salary);
end;
/

grant select on emp123 to system;

begin
--ddl
--create table t111(id number);  --DDL not allowed in plsql block
--grant select on emp123 to system;  --DCL is not allowed

end;


create table emp123(id number, name varchar2(20), salary number);
insert into emp123(id,name,salary)


Rule: when dml is executed inside plsql block then implicit cursor named SQL is referencing to active area.
Attribute of cursor.
1. %FOUND
2. %NOTFOUND
3. %ROWCOUNT



begin
    update emp123 set name='Jack' where id=1;
    commit;
    print(sql%rowcount||' row updated');
    if sql%found then
      print(' row update');
   end if;
   
   if sql%notfound then
     print('no row updated');
    end if;
end;
/




Rule:  single row function can be used in plsql except nvl2, decode
Rule : group function ins not allowed in plsql


declare
  a varchar2(100);
begin
  a := upper('apple');
  print(a);
  a := nvl(null,'cat');
  print(a);
  
 -- a := nvl2('a','apple','cat');
 select  nvl2('a','apple','cat') into a from dual;
 print(a);
 
-- a := decode(1,2,3,4);
select decode(1,2,3,4) into a from dual;
 print(a);
end;
/

Query: write a program to display the manager_name for the id prompted by the user

declare
   v_last_name   employees.last_name%type;
   v_manager_name   v_last_name%type;
   v_id    employees.employee_id%type := &id;
   v_mgr_id  v_id%type;
begin
  select last_name,manager_id into v_last_name,v_mgr_id 
  from employees 
  where employee_id = v_id;
  
  select last_name into v_manager_name 
  from employees 
  where employee_id = v_mgr_id;
  
  print('The manager of '||v_last_name||'  is '||v_manager_name);
  
end;
/


declare
   v_last_name   employees.last_name%type;
   v_manager_name   v_last_name%type;
   v_id    employees.employee_id%type := &id;
   v_mgr_id  v_id%type;
begin
  select e.last_name,e.manager_id,m.last_name into v_last_name,v_mgr_id ,v_manager_name
  from employees e join employees m
  on e.manager_id = m.employee_id
  where e.employee_id = v_id;

  print('The manager of '||v_last_name||'  is '||v_manager_name);
  
end;
/



begin
       <<outer>>
        declare
                   a number := 10;
                   b number :=20;
                   c number;
        begin
                  <<inner>>
                   declare
                     a   number:=1000;
                   begin
                      c := outer.a+b;
                   end;
                   
                   print('c='||c);
        end;
end;
  



void main(){}


