--primary key
-- unique
--not null
--check
--foreign key

create table dept1234(
did number primary key,
 dname varchar2(10) unique not null
 );

select * from user_constraints where table_name ='DEPT1234';
 
 or
 
 create table dept123(
did number,
 dname varchar2(10) not null,
 primary key(did),
 unique(dname)
 );
 
 or
 
  create table dept123(
did number constraint dept123_did_pk primary key,
 dname varchar2(10)
 );
 
 
 


create table emp123(
id   number primary key,
name varchar2(10) not null,
salary number check(salary>0),
did number references dept123(did)
);

or

create table emp123(
id   number ,
name varchar2(10) not null,
salary number,
did number ,
primary key(id),
 check(salary>0),
 foreign key(did) references dept123(did) on delete set null
);





select * from dept123;

insert into dept123(did,dname) values (10,'IT');
insert into dept123(dname,did) values ('HR',20);




select * from emp123;

insert into emp123(id,name,salary, did) values (1,'Jack',1000,10);
insert into emp123
select employee_id,last_name,salary,department_id from employees where department_id in (10,20);


select * from emp123;


delete departments where department_id=10;

select * from emp123;
select * from dept123;

delete dept123 where did=20;


drop table dept123;
drop table emp123;








