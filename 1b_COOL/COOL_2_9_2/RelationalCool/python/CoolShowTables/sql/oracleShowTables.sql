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
select table_name from all_tables where owner='&1' and table_name like '&2%';
-- Exit
exit;
