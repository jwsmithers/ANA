define owner  = "&1";
define dbname = "&2";

--column table_name format a30;
--column index_name format a30;
--column ddl_date format a15;
--column uniqueness format a15;

select i.table_name, o.object_name index_name, 
--o.last_ddl_time ddl_date, 
i.uniqueness
from all_objects o, all_indexes i
where o.object_type='INDEX'
and o.object_name=i.index_name
and o.owner = '&owner'
and i.owner = '&owner'
and i.table_name like '&dbname%'
order by o.last_ddl_time, o.object_name;
