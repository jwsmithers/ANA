define owner  = "&1";
define dbname = "&2";

--column table_name format a30;
--column constraint_name format a30;
--column constraint_type format a10;
--column r_constraint_name format a30;
--column index_name format a30;

select table_name, constraint_name, --last_change ddl_date, 
constraint_type||'   ' type, r_constraint_name, index_name
from all_constraints
where owner = '&owner'
and table_name like '&dbname%'
order by constraint_type, last_change, constraint_name;
