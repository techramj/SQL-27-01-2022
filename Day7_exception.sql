Exception:
1. oracle pre defined exception
2. oracle non predefined exception
3. user defined exception
Note: EXCEPTION consist of two part. Error code and error message.  SQLCODE,  SQLERRM
Note: for custom exception the SQLCODE should be between -20000 to -20999

Declare
   v_sal  	employees.salary%type;
   v_name    varchar2(30) :='&name';
begin
  select salary into v_sal
  from employees where last_name=v_name;
  print('salary: '||v_sal);
  print('Program   end');
EXCEPTION
  when no_data_found THEN
     print('The is no employee with name: '||v_name);
	 print(SQLERRM);
	 print(SQLCODE);
  when too_many_rows THEN
     print('More than one employee with name: '||v_name);
	 print(SQLERRM);
	 print(SQLCODE);
end;
/

Declare
   v_sal  	employees.salary%type;
   v_name    varchar2(30) :='&name';
begin
  select salary into v_sal
  from employees where last_name=v_name;
  print('salary: '||v_sal);
  print('Program   end');
EXCEPTION
  when no_data_found THEN
     print('The is no employee with name: '||v_name);
	 print(SQLERRM);
	 print(SQLCODE);
  when too_many_rows THEN
     print('More than one employee with name: '||v_name);
	 print(SQLERRM);
	 print(SQLCODE);
  when others THEN
     print('Error.....');
end;
/



--2. Oracle non predifined EXCEPTION
DECLARE
  fk_exp   EXCEPTION;
  pragma exception_init(fk_exp,-2292);
BEGIN 
  delete departments d where department_id = &didd;
EXCEPTION
   when fk_exp then 
      print('child kkey found in employees TABLE');
	  print(SQLERRM);
	 print(SQLCODE)
END;
/


--3 user defined EXCEPTION
declare
  age number;
  invalid_age EXCEPTION;
begin
  age := &age;
  print('age: '||age);
  if  age>100 then
     raise invalid_age;
  end if;
  --
  --
  --
EXCEPTION
  when invalid_age THEN
    print('age cannot be greater than 100');
end;
/

declare
  v_id   number;
  invalid_id EXCEPTION;
begin
  delete emp where id = v_id;
  if  SQL%notfound then
     raise invalid_id;
  end if;

EXCEPTION
  when invalid_id THEN
    print('No employee with id: '||v_id);
	print(SQLCODE);
	print(sqlerrm);
end;
/

declare
  v_id   number:=1234;
begin
  delete emp where id = v_id;
  if  SQL%notfound then
     RAISE_APPLICATION_ERROR(-20001,'No employee with id: '||v_id);
  end if;

EXCEPTION
  when OTHERS THEN
    print('No employee with id: '||v_id);
	print(SQLCODE);
	print(sqlerrm);
end;
/



