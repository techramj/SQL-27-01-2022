from -> where -> group by -> having -> select -> order by ;

select distinct salary from employees
where rownum<=10
order  by salary desc;

1000
1000
2000
2000
3000

select * from abc;

select distinct id from abc
where rownum<=3
order  by id desc;


select  substr(concat(upper(lower('ABCD')),'xyz'),1,6) from dual;

select min(sum(salary)) from employees;  --not feasible

select avg(sum(salary)) from employees
group by department_id;

desc employees
desc departments;

Join:

SELECT * FROM employees;

select * from departments;

select * from locations;

#Type of Join
1. Inner Join (Natural Join/Using clause/on clauase)
2. Outer JOin
     a. Left outer join
     b. right outer join
     c. Full outer Join
3. self join
4. equi/non equi join
5. Cross Join


select * from departments natural join locations;

select * from employees natural join departments;

select  employee_id, last_name, department_id, department_name ,employees.manager_id
from employees  join departments
using (department_id);

or

select  employee_id, last_name, department_id, department_name ,
d.manager_id as dept_manager, e.manager_id as emp_manager
from employees  e  join departments d
using (department_id);


select  employee_id, last_name, e.department_id, department_name 
from employees e  join departments d
on e.department_id = d.department_id;

or


select  e.employee_id, e. last_name, d.department_id, d.department_name 
from employees e  inner join departments d
on e.department_id = d.department_id;


Rules 1:Column available in both the tables required qualifier
Rule 2: column used in using clause don't require qualifier

#'Left outer Join

select  e.employee_id, e. last_name, d.department_id, d.department_name 
from employees e left outer join departments d
on e.department_id = d.department_id;


#Left outer Join

select  e.employee_id, e. last_name, d.department_id, d.department_name 
from employees e right outer join departments d
on e.department_id = d.department_id;


#full outer Join

select  e.employee_id, e. last_name, d.department_id, d.department_name 
from employees e full  outer join departments d
on e.department_id = d.department_id;

select e.employee_id, e.last_name, e.manager_id, m.last_name as manager_name 
from employees e left outer  join employees m
on e.manager_id = m.employee_id;


//wirte a query to find the colleage name

select last_name ,first_name from employees e join employees m on e.last_name = m.last_name;


select e.employee_id, e.last_name, e.department_id, 
c.employee_id as colleage_id, c.last_name as colleage_name
from employees e join employees c
on e.department_id= c.department_id
and e.employee_id != c.employee_id
where e.department_id not in (50,80);


#Non equi join
select * from job_grades;

create table job_grades(grade char,minsal number,maxsal number);

insert into job_grades values('A',20001,80000);
insert into job_grades values('B',15001,20000);
insert into job_grades values('C',10001,15000);
insert into job_grades values('D',5001,10000);
insert into job_grades values('E',0,5000);



select e.employee_id, e.last_name, e.salary, j.grade
from employees e join job_grades j
on e.salary between j.minsal and j.maxsal
order by e.salary;

select count(*) from employees e cross join departments cross join employees x cross join employees y cross join departments z;



Join with Ansi1999:

select  employee_id, last_name, e.department_id, department_name 
from employees e  , departments d
where e.department_id = d.department_id
;

#left outer join

select  employee_id, last_name, e.department_id, department_name 
from employees e  , departments d
where e.department_id = d.department_id (+);


#right outer join

select  employee_id, last_name, e.department_id, department_name 
from employees e  , departments d
where e.department_id (+)= d.department_id ;


#full outer join
select  employee_id, last_name, e.department_id, department_name 
from employees e  , departments d
where e.department_id (+)= d.department_id(+) ;



#join more 2 tables
select * from employees;
select * from departments;
select * from locations;
select * from countries;

--last_name, salary, department_name, city, country_name
select e.last_name, e.salary, d.department_name, l.city, c.country_name
from employees e join departments d
on e.department_id= d.department_id
join locations l
on d.location_id = l.location_id
join countries c on l.country_id = c.country_id;

or

select e.last_name, e.salary, d.department_name, l.city, c.country_name
from employees e , departments d,  locations l,  countries c
where e.department_id= d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id;


