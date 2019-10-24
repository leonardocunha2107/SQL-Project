psql -f create_tables.sql
psql -f generate_drop_constraint.sql > drop_constraint.sql
psql -f generate_add_constraint.sql > add_constraint.sql
psql -f drop_constraint.sql
psql -f copy_tables.sql
psql -f add_constraint.sql