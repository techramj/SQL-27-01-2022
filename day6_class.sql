--composite type
1. Record
2. Associative array /plsql table
3. nested table
3. varray

Cursor


Number
varchar2
Date
char


declare
  v_lname           employees.last_name%type;
  v_salary          employees.last_name%type;
  v_hire_date    employees.last_name%type;
  v_id                    employees.employee_id%type := &id1;
  
  v_lname1           employees.last_name%type;
  v_salary1          employees.last_name%type;
  v_hire_date1    employees.last_name%type;
  v_id1                    employees.employee_id%type := &id2;
begin
    
    select last_name,salary, hire_date
    into v_lname, v_salary, v_hire_date
    from employees 
    where employee_id = v_id;
     print('----------------Details of '||v_id1||'------------------------------------');
    print('Last Name: '||v_lname);
    print('Salary: '||v_salary);
    print('Hire Date: '||v_hire_date);
    

    
    select last_name,salary, hire_date
    into v_lname1, v_salary1, v_hire_date1
    from employees 
    where employee_id = v_id;
      print('----------------Details of '||v_id1||'------------------------------------');
    print('Last Name: '||v_lname1);
    print('Salary: '||v_salary1);
    print('Hire Date: '||v_hire_date1);
end;
/


--==> alternative of above using record

declare
  v_id1                    employees.employee_id%type := 100;
   type  emp_rec_type is record (last_name varchar2(30),
                                                     salary  number,
                                                     hire_date date
                                                     );

   emp_rec    emp_rec_type;
  emp_rec1    emp_rec_type;
begin
      
    select last_name, hire_date, salary
    into emp_rec.last_name,  emp_rec.hire_date, emp_rec.salary
    from employees 
    where employee_id = 120;
     print('----------------Details of '    ||v_id1||'------------------------------------');
    print('Last Name: '||emp_rec.last_name);
    print('Salary: '||emp_rec.salary);
    print('Hire Date: '||emp_rec.hire_date);
    
     select last_name,salary, hire_date
    into emp_rec1
    from employees 
    where employee_id = v_id1;
     print('----------------Details of '||v_id1||'------------------------------------');
    print('Last Name: '||emp_rec1.last_name);
    print('Salary: '||emp_rec1.salary);
    print('Hire Date: '||emp_rec1.hire_date);
end;
/



declare
    rec   employees%rowtype;
begin
    select last_name, hire_date, salary
    into rec.last_name,  rec.hire_date, rec.salary
    from employees 
    where employee_id = 120;

    print('Last Name: '||rec.last_name);
    print('Salary: '||rec.salary);
    print('Hire Date: '||rec.hire_date);
    
end;
/
  
  
declare
    rec   employees%rowtype;
begin
    select *
    into rec
    from employees 
    where employee_id = 120;

    print('Last Name: '||rec.last_name);
    print('Salary: '||rec.salary);
    print('Hire Date: '||rec.hire_date);
    
end; 
/



declare
    rec   emp%rowtype;
begin
    select *
    into rec
    from emp 
    where id = 120;

    print('Last Name: '||rec.name);
    print('Salary: '||rec.salary);
    
end; 
/


--syntax to create record type
type emp_rec_type is record( col1 type,
                                                 col2 type,
                                                 ..
                                                 );
rec           emp_rec_type;  --declaring the variable


--Use of record in DML



declare
    rec   emp%rowtype;
begin
    select *
    into rec
    from emp 
    where id = 120;
    
    if rec.salary>7000 then
      rec.salary := rec.salary+1000;
      rec.name :='Mr '||rec.name;
    end if;
    
    update emp
    set row = rec
    where id = rec.id;
    
    print(sql%rowcount||' row updated');

    print('Last Name: '||rec.name);
    print('Salary: '||rec.salary);
    
end; 
/


declare
    rec   emp%rowtype;
begin
    select *
    into rec
    from emp 
    where id = 130;
    
    --rec.id := emp_seq.nextval; --in 10G this is not allowed
    select emp_seq.nextval into rec.id
    from dual;
    
    insert into emp values rec;
    print(sql%rowcount||'  row inserted');
    commit;

end; 
/


create sequence emp_seq;
select emp_seq.nextval from dual;


select * from emp where id=120;



//create two table emp1 and emp2. Assuming emp table exist

drop table emp;

create table emp
as
select employee_id as id, last_name as name, salary 
from employees;

create table emp1 as select * from emp where 1=2;
create table emp2 as select * from emp where 1=2;

select * from emp;

100 to 130
if salary>12000 then insert data into emp1 else into emp2.

declare
  rec emp%rowtype;
begin
   for i in 100 .. 130 loop
      select * into rec from emp where id=i;
          if rec.salary>12000 then
            insert into emp1 values rec;
          else
           insert into emp2 values rec;
         end if;
   end loop;
end;
/


--  PLSQL table
--Attribute of Associative array/netsted table/varrays
1. count
2. first
3. last
4. next
5. prior
6. exists
7. delete(m)
8. delete(m,n)

declare
  type emp_tab_type is table of varchar2(40) index by pls_integer;
  emp_tab     emp_tab_type;
begin
   emp_tab(1):='Kochhar';
   emp_tab(2) := 'King';
  emp_tab(3) := 'John';
  emp_tab(4) := 'Jessica';
  emp_tab(-4) := 'Jackson';
  
  print(emp_tab(4));
  print('total element: '||emp_tab.count);
  print('first element: '||emp_tab.first);
  print('last element: '||emp_tab.last);
  print('next index of 3: '||emp_tab.next(3));
  print('prior index of 3: '||emp_tab.prior(3));
  

  
  print('-------------------------------');
  
  for i in  emp_tab.first   .. emp_tab.last loop
     if emp_tab.exists(i) then
      print(i||' > '||emp_tab(i));
    end if;
  end loop;

end;
/


declare
  type emp_tab_type is table of varchar2(40) index by varchar2(20);
  emp_tab     emp_tab_type;
  idx   varchar2(20);
begin
   emp_tab('a'):='Kochhar';
   emp_tab('x') := 'King';
  emp_tab('J') := 'John';
  emp_tab('A') := 'Jessica';
  emp_tab('B') := 'Jackson';
  
  print(emp_tab('J'));
  print('total element: '||emp_tab.count);
  print('first element: '||emp_tab.first);
  print('last element: '||emp_tab.last);
  print('next index of 3: '||emp_tab.next('b'));
  print('prior index of 3: '||emp_tab.prior('d'));
  
  print('-------------------------------');
  
  idx := emp_tab.first;
  
  loop
      print(i||' > '||emp_tab(idx));
      idx :=  emp_tab.next(idx);
     exit when idx is  null;
  end loop;

end;
/



#2. Nested table/Associative array

declare
  type name_tab_type is table of varchar2(40);
  name_tab  name_tab_type;
begin
  select last_name bulk collect into name_tab   
  from employees
  where salary>12000;
  
  for i in 1..name_tab.count loop
     print(i||'  '||name_tab(i));
  end loop;
  
  print('----------------------------------');
  
  for i in name_tab.first ..name_tab.last loop
     print(i||'  '||name_tab(i));
  end loop;
end;
/
  
#3. varray 

declare
  type name_tab_type is table of varchar2(40);
  name_tab  name_tab_type;
begin
  select last_name bulk collect into name_tab   
  from employees
  where rownum<=5;
  
  for i in 1..name_tab.count loop
     print(i||'  '||name_tab(i));
  end loop;
  
end;
/


--enter data manually
store top 5 salary

declare
  type salary_tab_type is table of number;
  salary_tab     salary_tab_type;
begin
 select salary  bulk collect into salary_tab from 
  (select distinct salary  
  from employees
  order by salary desc
  )
  where rownum<=5
  
  for i in 1..salary_tab.count loop
     print(i||'  '||salary_tab(i));
  end loop;
  
end;
/



declare
  type emp_tab_type is table of employees%rowtype;
  emp_tab     salary_tab_type;
begin
 select * bulk collect into emp_tab from employees
  where rownum<=5;
  
  for i in 1..salary_tab.count loop
     print(i||'  '||emp_tab(i).first_name  || ' '||emp_tab(i).last_name );
  end loop;
  
end;
/



--Explicit Cursor

select salary, last_name  from employees;

syntax of cursor:

cursor cur_name is subquery;

1. delcare the cursor
2.  open the cursor
3. fetch the cursor
4. check the cursor 
5. close the cursor

declare
   --delcare the cursor
   cursor emp_cursor is 
   select salary, last_name  from employees
   where salary>12000;
   
   v_sal number;
   v_name  varchar2(30);
begin
    --open the cursor
    open emp_cursor;
    loop
      --fethc the cursor
      fetch emp_cursor into v_sal, v_name;
      print(v_sal||'   '||v_name);
      --check the cursor
      exit when emp_cursor%notfound;
    end loop;
    
    --close the cursor
    close emp_cursor;
end;
/



declare
   --delcare the cursor
   cursor emp_cursor is 
   select salary, last_name  from employees
   where salary>12000;
   
   rec emp_cursor%rowtype;
begin
    --open the cursor
    open emp_cursor;
    loop
      --fethc the cursor
      fetch emp_cursor into rec;
      print(rec.salary||'   '||rec.last_name);
      --check the cursor
      exit when emp_cursor%notfound;
    end loop;
    
    --close the cursor
    close emp_cursor;
end;
/



declare
   --delcare the cursor
   cursor emp_cursor is 
   select salary, last_name  from employees
   where salary>12000;
begin
    for rec in emp_cursor loop
      print(rec.salary||'   '||rec.last_name);
    end loop;
end;
/





