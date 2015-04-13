define owner  = "&1";
define dbname = "&2";

--column table_name format a30;
--column index_name format a30;
--column ddl_date format a15;
--column col_name format a20;
--column descend format a10;

select table_name, index_name, --ddl_date, 
col_name, col_pos, descend
from (
select c.table_name, c.index_name, o.last_ddl_time ddl_date,
c.column_name col_name, c.column_position col_pos, c.descend
from all_ind_columns c, all_objects o
where c.index_name=o.object_name
and o.owner = '&owner'
and c.table_owner = '&owner'
and c.table_name like '&dbname%'
) order by ddl_date, table_name, index_name, col_pos;
