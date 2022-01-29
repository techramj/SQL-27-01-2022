Function:
1. char function
lower(str), upper(str), initcap(str)
select  lower('ABC Def gHI') ,  upper('ABC Def gHI') ,  initcap('ABC Def gHI')    from dual;
select employee_id, lower(last_name) from employees where upper(last_name)='KING';

substr(str,start_pos,[length])
select substr('abcdefghi',3),  substr('abcdefghi',3,4),  substr('abcdefghi',-3), substr('abcdefghi',-3,2) from dual;

instr(str,searcg_str,[pos],[occurence])

select instr('abcde ab dc aca','d') from dual;--4
select instr('abcde ab dc aca','d',5) from dual;--10
select instr('abcde ab dc aca','c',4,2) from dual;--14
select instr('abcde ab dc aca','c',1,4) from dual;--14

lpad(str,length,padded_str), rpad(str,length,padded_str)

**ABC   ABC**
select lpad('apple',8,'*'), rpad('apple',8,'*') from dual;

length
select length('abcde') from dual;

--concat
select concat('a','b') from dual;

select length(trim(' a b ')) from dual;



2. number function
 a. mod(num1,num2)   ==> a%2
        select mod(22,4) from dual;
        
 b. round
     12845.4567
                
    select round(  12845.4267,3) from dual; --12845.427
    select round(  12845.4267,1) from dual; --12845.4
    select round(  12865.4267,-2) from dual;   --12900
    

 c. trunc
     12845.4567
                
    select round(  12845.4267,3) from dual; --12845.4
    select round(  12845.4267,1) from dual; --12845.4
    select round(  12865.4267,-2) from dual;   --12800
    
 d. ceil
           
    select ceil(  1.1) from dual; --2
    select ceil(  1.5) from dual; --2
    select ceil(  -1.9) from dual;   -- -1

e. floor


3. date function
a. add_months(date,no_of_month)
b. next_day(date,'sun')
c. last_day(date)
d. months_between(date1, date2)

Rule for the date:
Rule 0: date contain DD MM YYYY HH MM SS
Rule 1: Default format of date DD-Mon-RR
Rule 2: We can add or subtract number to/from the date.
             select sysdate-15000 from dual;
Rule 3: We can substract to date which give no of days between 2 date;

Select employee_id,last_name, hire_date,last_day(hire_date),
round( sysdate-hire_date) as no_of_days,
round(( sysdate-hire_date)/30) as no_of_months, round(months_between(sysdate,hire_date)),
round(months_between(sysdate,hire_date)/12) as year1,round(( sysdate-hire_date)/365) as year2
from employees;

Query: employees hired in the year 1996

select first_name,last_name from employees where hire_date in ('01-jan-96','31-dec-96');

select first_name,hire_date from employees where hire_date  between  '01-jan-96'  and  '31-dec-96';

select first_name,hire_date from employees where hire_date like '%96';

Query: employees hired in feb month of leap year
select last_name, hire_date, last_day(hire_date) 
from employees
where last_day(hire_date)  like '29%';

select next_day(sysdate,'sat') from dual;

--6 month from 2day and first sunday.

select next_day(add_months(sysdate,6),'sun') from dual;


4. conversion function

  number       char          date
  
TO_char
to_number
to_date
  
  
=>convert date to string using to_char
select to_char(sysdate,'DD/MM/YYYY hh:mi:ss AM') from dual;
DD      D       Day     Dy
12th of March,1995

select hire_date, to_char(hire_date,'ddth "of" Month, YYYY') from employees;
  
select hire_date from employees
where mod(to_char( hire_date,'yyyy'),4)=0;


=>convert number to string using to_char
select last_name,salary, to_char(salary,'$99,99,999.00') from employees;


select to_date('1-jan-22')+1 from dual;

select to_date('jan-22-2002', 'month-dd-yyyy')+1 from dual;

Query: employees hired in leap year.

select first_name,hire_date from employees where  last_day(to_date( '1-feb-'||to_char(hire_date,'yyyy'),'dd-mon-yyyy')) like '29%';


5 .general function
a. nvl(exp1, exp2)   => if exp1 is null then exp2 else exp1. Rule: exp1 and exp2 should be of same data type
b. nvl2
c. coalesce
d. decode
e. case

select nvl(10,20), nvl(null,20) from dual;

Query: employees workinging in dept 10,20 or not in any dept
select  * from employees
where nvl(department_id,-1) in (10,20,-1);

select last_name,salary, commission_pct , salary+ salary*nvl(commission_pct,0) as net_salary
from employees;

select last_name,salary,nvl( to_char(commission_pct) ,'No_comm') as comm,
nvl2(commission_pct,'Comm' ,'No_comm') as comm1,
salary+ salary*nvl(commission_pct,0) as net_salary
from employees;


NLV2(exp1, exp2, exp3)  => if exp1 is not null then exp2 else exp2.   Rule: exp2 and exp2 should be of same type

COALESCE(exp1, exp2,  exp2..... expn)  =>

select  coalesce(null,null,null, null,null,5) from dual; 

CASE .
salary>20000 A
salary>15000 B
salary>10000 C
else D

select last_name,salary,job_id, case  when salary>20000 then 'A'
                                                when salary>15000 then 'B'
                                                when salary>10000 then 'C'
                                                else 'D'
                                                end as Grade
from employees
order by  salary;

select distinct job_id from employees;

select last_name,salary,job_id, 
case when job_id='AD_VP' then salary*1.1
        when job_id='IT_PROG' then salary*1.2
        when job_id='SA_REP' then salary*1.3
        end as new_salary
from employees
where job_id in ('AD_VP' , 'IT_PROG' , 'SA_REP' );



select last_name,salary,job_id, 
case  job_id when 'AD_VP' then salary*1.1
        when'IT_PROG' then salary*1.2
        when 'SA_REP' then salary*1.3
        end as new_salary
from employees
where job_id in ('AD_VP' , 'IT_PROG' , 'SA_REP' );


select last_name,salary,job_id, 
decode(  job_id , 'AD_VP' , salary*1.1
        ,'IT_PROG' , salary*1.2
        , 'SA_REP' , salary*1.3
        ) as new_salary
from employees
where job_id in ('AD_VP' , 'IT_PROG' , 'SA_REP' );

select decode(4,     2,3,       4,5,         6,2,      3,4,     9) from dual;


decode(  job_id ,            'AD_VP' , salary*1.1  ,                   'IT_PROG' , salary*1.2 ,                   'SA_REP' , salary*1.3      ) as new_salary
;

nullif(exp1, exp2) => if exp1=exp2 then null else exp1
select nullif(1,   2345) from dual;



select abs(-1234) from dual;

Query: display last_name, salary, hire_date =>  Monday, 22nd June, 1995 and the sort it by the day they are hired.






--Group function

single row function
group function/aggregate/multiple row function
    1.  sum
    2. min
    3. max
    4. avg
    5. count
    
select sum(salary),min(salary), max(salary), trunc(avg(salary),4) as avg_sal, count(salary) from employees;

select sum(salary), avg(salary) as avg_sal, sum(salary)/107 from employees;

select sum(commission_pct), round(avg(nvl(commission_pct,0)),2) as avg_sal, round(sum(commission_pct)/107,2) from employees;

Rule: group function exclude null entries except coun(*)

create table abc(id number);


insert into abc values (null);

commit;

select department_id, sum(salary) 
from employees
group by department_id;

RULE : if there is any group function with the column then column must be in group by clause;

exuection => from  -> where -> group by ->having->select -> order by


select department_id, sum(salary) 
from employees
group by department_id
having  sum(salary)>50000;

select department_id, sum(salary) 
from employees
where department_id <=40
group by department_id












