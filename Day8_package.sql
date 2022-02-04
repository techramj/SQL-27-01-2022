package contain of 2 part
1. specification
2. Body

--SPECIFICATION
create or replace package pkg1
is
  procedure greet;
  procedure greet_emp(name varchar2);
  function add(a number, b number) return number;
end;
/
--body
create or replace package body pkg1
is
  procedure greet
  is
  BEGIN
    print('hello');
  end;
  
  procedure greet_emp(name varchar2)
  is
  BEGIN
    print('hello '||name);
  end;
  
  function add(a number, b number) return number
  is
  BEGIN
   RETURN a+b;
  end;

end;
/

--call the procedure and function of a package
DECLARE
  res number;
BEGIN
  pkg1.greet;
  res := pkg1.add(10,20);
  dbms_output.put_line('res: '||res);
end;

create or replace package emp_pkg
is
  function validate_dept(p_did number) return boolean;
  
 procedure add_emp
	(p_id number,
	fname varchar2, 
	lname varchar2,
	p_hire_date date default SYSDATE,
	p_Job_id varchar2 default 'IT_PROG', 
	p_salary NUMBER,
	mgr_id number:=101,
	did number DEFAULT 20);
  
  procedure add_emp
	(fname varchar2, 
	lname varchar2,
	p_hire_date date default SYSDATE,
	p_Job_id varchar2 default 'IT_PROG', 
	p_salary NUMBER,
	mgr_id number:=101,
	did number DEFAULT 20);
	
	function delete_emp(id number) return number;
	
	procedure display_emp_details(rec emp%rowtype);
	
end;	



create or replace package  body emp_pkg
is
  function validate_dept(p_did number) return boolean;
  
 procedure add_emp
	(p_id number,
	fname varchar2, 
	lname varchar2,
	p_hire_date date default SYSDATE,
	p_Job_id varchar2 default 'IT_PROG', 
	p_salary NUMBER,
	mgr_id number:=101,
	did number DEFAULT 20);
  
  procedure add_emp
	(fname varchar2, 
	lname varchar2,
	p_hire_date date default SYSDATE,
	p_Job_id varchar2 default 'IT_PROG', 
	p_salary NUMBER,
	mgr_id number:=101,
	did number DEFAULT 20);
	
	function delete_emp(id number) return number;
	
	procedure display_emp_details(rec emp%rowtype);
	
end;	
	
