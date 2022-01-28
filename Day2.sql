--Rule 0: sql query are not case sensitive but literals are case sensitive
select * from employees;

select employee_id, first_name, last_name ,salary from employees;

select employee_id, first_name||last_name, salary, salary*12 from employees;  --space  or any string is called as literal
--Rule 1: literal must be in single quotes

select employee_id, first_name||' '||last_name as name, salary, salary*12 as "annual salary" from employees;
--Rule 2: Don't give space in the alias name. if you  want space then use double quotes.

select employee_id, first_name||' '||last_name   name, salary, salary*12 as "annual salary" from employees;
/*
The salary of king is 24000   ==> King's salary is 24000
The salary of Kochhar is 17000; Kochhar's salary is 17000
*/

select 'The salary of  '||last_name||' is '||salary from employees;

select last_name||'''s salary is '||salary from employees;

select last_name||q'['s salary is ]'||salary from employees;


Rule 3: when you need to restrict the row then use where clause

select col1, col2,....coln
from <table_name>
where condtion;

conditonal operator: 
> 
>= 
< 
<= 
=
IN
Between and

To join the condition relation operator
NOT,  AND, OR


--Query 1: list of eployees whose salary >10000
select * from employees
where salary>10000;

select * 
from employees
where department_id=90;

--EXECUTION  from => where =>select

--Query 2: list of eployees working in dept 10 and 90
select * from employees
where department_id=10 or department_id=90;

select * from employees
where department_id in (10,90);


--Query 3: list of eployees working in dept 50 and 80
select * from employees
where department_id != 50  and  department_id != 80;

select * from employees
where department_id not in (50,80);


--Query 4: list of eployees working in dept 10 ,20,30 and 90
select * from employees
where department_id=10 or department_id=20 or department_id=30 or department_id=90;

select * from employees
where department_id in (10,20,30,90);

--Query 5: list of eployees whose salary<4000 and salary>12000
select * from employees 
where salary<4000 or  salary>12000;

select * from employees 
where salary  not between 4000 and  12000;


--Query 5: list of eployees whose salary>=9000 and salary<=12000
select * from employees 
where salary > =9000 and  salary<=12000;

select * from employees 
where salary  between 9000 and  12000;


--Null means 

select * from employees
where commission_pct = null;

--RUle 5:  Don't use any operator with null except is operator.

select * from employees
where commission_pct  is  null;


s--Query 6: List of employees not working in any departments;
select * from employees
where department_id  =  null;


select * from employees
where department_id in (10,20,null);

select * from employees
where department_id in (10,20)
or department_id is null;

select * from employees
where department_id  not in (58,80);

true or null => true
true and null => true,false(null);

select * from employees 
where salary not between 12000 and  9000;


select last_name,salary, salary*12 as ann_sal
from employees
where salary*12>120000;

--RULE 6: Don't user alias in where clause

--Query: list of eemployee whose name is King
select * from employees
where last_name = 'King';

select * from employees where employee_id=100;

Date format => DD- MON -RR

select * from employees
where hire_date ='17-jun-87';


--sort the data then use order by clause
select employee_id,last_name,salary ,department_id
from employees
where department_id not in (50,80)
order by salary desc ,department_id desc ;

-- Excution flow => from -> where -> select -> order by 

select last_name,salary*12 as ann_sal
from employees
where salary*12<36000
order by 1;


Query: To fetch the list of employees who is working in department10,20,30,40
and salary is less than 20000. Sort the data by asending order of job_id;


--Like operator
% 0 or many
_ 1
select last_name from employees
where last_name like '%y%';

select last_name from employees
where last_name like '___';

select last_name from employees
where length(last_name) =3;


select * from employees where lower(last_name) like '%a%e%' or lower(last_name) like '%e%a%';
select * from employees where lower(last_name) like '%a%' and lower(last_name) like '%e%';


select rownum, last_name from employees 
where  rownum<=2;


1. employees with last_name and first_name start with same character
select first_name, last_name
from employees
where substr(first_name,1,1)=substr(last_name,1,1);

select first_name, last_name
from employees
where substr(first_name,1,1) in ('J','K','L')



*
**
***
****
*****


    *
  ***
 *****
*******


select lpad('*',rownum,'*')
from  employees
where rownum<=5;


select lpad(' ',5-rownum,' ')|| lpad('*',2*rownum-1,'*')
from  employees
where rownum<=5;






