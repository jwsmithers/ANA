set pagesize 1000;
select table_name from all_tables where owner='&1' and table_name like '&2%';
exit;
