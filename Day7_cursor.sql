--explicit cursor
declare
  cursor cur1 is  select * from departments;
  --dept_rec    cur1%rowtype;
begin
  for rec in cur1 loop
     print('dept Name: '||rec.department_name);
	 exit when cur1%rowcount=5;
  end loop;
end;
/


--implicit cursor
begin
  for rec in (select * from departments)
  loop
     print('dept Name: '||rec.department_name);
	 exit when 
  end loop;
end;
/


--cursor with paramters
declare
  cursor cur1 is  select * from departments;
  cursor emp_cur_dept30 is select * from employees where department_id=30;
  cursor emp_cur_dept_40 is select * from employees where department_id=40;
begin
  for rec in emp_cur_dept30 loop
     print('Last Name: '||rec.last_name);
  end loop;
  print('----------------------------------');
  for rec in emp_cur_dept_40 loop
     print('Last Name: '||rec.last_name);
  end loop;
end;
/


declare
  cursor cur1 is  select * from departments;
  cursor emp_cur(p_did number) is select * from employees where department_id=p_did;

begin
  for drec in cur1 loop
      print('Department_id: '||drec.department_id||'  Dname: '||drec.department_name);
	  for rec in emp_cur(drec.department_id) loop
		 print('Last Name: '||rec.last_name||' did: '||rec.salary);
	  end loop;
	  print('--------------------------------');
  end loop;
 
end;
/


--attribute of CURSOR
%rowcount
%found
%notfound
%isopen




