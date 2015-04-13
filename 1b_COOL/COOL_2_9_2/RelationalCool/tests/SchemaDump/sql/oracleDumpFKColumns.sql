define owner  = "&1";
define dbname = "&2";

--column table_name format a30;
--column constraint_name format a30;
--column r_constraint_name format a30;
--column ddl_date format a15;
--column col_name format a15;
--column r_col_name format a15;

select table_name, constraint_name, r_constraint_name, --ddl_date,
col_name, col_pos, r_col_name, r_col_pos
from (
select c.table_name, c.constraint_name, o.r_constraint_name, 
o.last_change ddl_date,
c.column_name col_name, c.position col_pos,
(select r.column_name from user_ind_columns r 
where r.index_name=o.r_constraint_name) r_col_name,
(select r.column_position from user_ind_columns r 
where r.index_name=o.r_constraint_name) r_col_pos
from all_cons_columns c, all_constraints o
where c.constraint_name=o.constraint_name
and o.owner = '&owner'
and c.owner = '&owner'
and c.table_name like '&dbname%'
and o.constraint_type like 'R'
) order by ddl_date,
table_name, constraint_name, col_pos;

