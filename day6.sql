syntax of Record:
Type record_name_type is record(col1  datatype,
                                col2  datatype,
								col3  datatype ,....);
 record_name record_name_type;
 


PLSQL Table:
Type emp_tab_type is table of varchar2(n)/number/date index by pls_integer/varchar2(n); 
emp_tab   emp_tab_type;

Nested table:
Type emp_tab_type is table of varchar2(n)/number/date; 
emp_tab   emp_tab_type;


Nested table:
Type emp_tab_type is varray(n) of varchar2(n)/number/date; 
emp_tab   emp_tab_type;

Attribites of above three:
1.count
2.first
3.last
4.next
5.prior
6.delete
7.exists


4.explicit cursor
syntax:   cursor cursor_name is  <subquery>;
1. declare the cursor
2. open the cursor
3. fetch the cursor
4. check the cursor
5. close the cursor

for loop cursor hide last 4 step







