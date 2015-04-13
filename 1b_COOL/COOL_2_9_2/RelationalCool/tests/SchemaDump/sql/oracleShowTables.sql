set pagesize 1000;
select object_name table_name from all_objects 
where object_type='TABLE'
and owner='&1' and object_name like '&2%'
order by last_ddl_time, table_name;
exit;
