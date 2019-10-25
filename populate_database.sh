#!/bin/bash
psql -f create_tables.sql -U $USER -d project
psql -f generate_drop_constraint.sql > drop_constraint.sql -U $USER -d project
psql -f generate_add_constraint.sql > add_constraint.sql -U $USER -d project
psql -f drop_constraint.sql -U $USER -d project
psql -f copy_tables.sql -U $USER -d project
psql -f add_constraint.sql -U $USER -d project