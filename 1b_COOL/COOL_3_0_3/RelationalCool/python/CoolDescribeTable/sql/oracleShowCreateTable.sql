-- NB An interesting alternative could be
-- select dbms_metadata.get_ddl('TABLE','&2','&1') from dual;
-- But this gives ORA-00904 for lcg_cool@cooldev (while it works for
-- avalassi@cooldev or lcg_cool@devdb10: missing privs? old s/w version?)

-- SELECT shows column values without column names
set heading off;
-- Suppress the display of each line before and after substitution
set verify off;
-- Suppress the display of the number of rows selected
set feedback off;
-- Make sure each table row fits in a single output line
set linesize 10000;
-- Make sure all table rows fit in a single page
set pagesize 1000;
-- Issue the SELECT statement
select name, replace(replace(type,',)',')'),'()') type from (
select column_name as name, 
data_type||'('||
decode(data_precision, null, null, 0, null, data_precision||',')||
decode(data_scale, null, null, 0, null, data_scale||',')||
decode(char_length, null, null, 0, null, char_length)||')' as type
from all_tab_columns where owner='&1' and table_name='&2')
order by name;
-- Exit
exit;
