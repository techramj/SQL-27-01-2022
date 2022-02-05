SELECT * FROM employees;

--nth highest salary
--1.

SELECT MIN(salary) FROM
(
SELECT DISTINCT salary FROM employees
ORDER BY salary DESC
)
WHERE ROWNUM<=5; --17

--2
SELECT *
  FROM (SELECT ROWNUM AS RANK, salary
          FROM (SELECT DISTINCT salary FROM employees ORDER BY salary DESC))
 WHERE RANK = 5;  --22
 
 --3.
 SELECT MAX(salary) FROM employees
 WHERE salary<(
 SELECT MAX(salary) FROM employees
 WHERE salary < (SELECT MAX(salary) FROM employees)); --18+
 
 --4.
 /*8000  2nd
 7000 3rd
 9000  1st
 3000 
 1000
 */
 
 SELECT * FROM employees e
 WHERE 5-1 = (SELECT COUNT(DISTINCT salary) FROM employees x WHERE x.salary>e.salary); --51
 
 
 --4: window function
 SELECT * FROM (
 SELECT employee_id, last_name, salary, dense_rank() OVER (ORDER BY salary DESC) AS RANK,
 rank() OVER (ORDER BY salary DESC) AS RANK1
 FROM employees)
 WHERE RANK=5; --15
 
 --name of manager  who is having second highest no. of subordinate
 101  20
 100  24
 104  2
 106  1
 
 
 
 
 
