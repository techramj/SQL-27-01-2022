CREATE OR REPLACE PACKAGE pkg_manage_db
IS
  FUNCTION fetch_total_no_of_rows(p_table VARCHAR2) RETURN NUMBER;
  PROCEDURE drop_table(p_table_name VARCHAR2);
  FUNCTION fetch_no_of_columns(p_table_name VARCHAR2) RETURN NUMBER;
  FUNCTION fetch_no_of_columns1(p_table_name VARCHAR2) RETURN NUMBER;
  
  
END pkg_manage_db;
/
CREATE OR REPLACE PACKAGE BODY pkg_manage_db
IS
  FUNCTION fetch_total_no_of_rows(p_table VARCHAR2) RETURN NUMBER
    IS
     v_count NUMBER;
     vsql VARCHAR2(200):= 'SELECT COUNT(*)  FROM '||p_table;
  BEGIN
    EXECUTE IMMEDIATE vsql INTO v_count;
    RETURN v_count;
  END fetch_total_no_of_rows;
  
   PROCEDURE drop_table(p_table_name VARCHAR2)
     IS
   BEGIN
     EXECUTE IMMEDIATE 'drop table '||p_table_name;
   END drop_table;
   
   FUNCTION fetch_no_of_columns(p_table_name VARCHAR2) RETURN NUMBER
     IS
     v_count NUMBER;
     vsql VARCHAR2(200) := 'SELECT count(*) FROM user_tab_columns WHERE table_name = :table_name';
   BEGIN
     EXECUTE IMMEDIATE vsql  INTO v_count USING upper(p_table_name);
     RETURN v_count;
   
   END fetch_no_of_columns;
   
    FUNCTION fetch_no_of_columns1(p_table_name VARCHAR2) RETURN NUMBER
     IS
     v_count NUMBER;
     vsql VARCHAR2(200) := q'[SELECT count(*) FROM user_tab_columns WHERE table_name = ']'||upper(p_table_name)||q'[']';
   BEGIN
     EXECUTE IMMEDIATE vsql INTO v_count;
     print(vsql);
     RETURN v_count;
   
   END fetch_no_of_columns1;
   
END pkg_manage_db;
/
