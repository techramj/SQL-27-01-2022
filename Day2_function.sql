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


3. date function


4. conversion function



5 .general function



