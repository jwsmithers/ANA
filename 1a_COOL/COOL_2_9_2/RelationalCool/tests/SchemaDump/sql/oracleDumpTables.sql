define owner  = "&1";
define dbname = "&2";

--column table_name format a30;
--column ddl_date format a15;

select object_name table_name --, last_ddl_time ddl_date
from all_objects
where object_type='TABLE'
and owner = '&owner' 
and object_name like '&dbname%'
order by last_ddl_time, object_name;
