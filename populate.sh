#!/bin/bash
psql -f src/create_tables.sql -U $USER -d project
psql -f src/generate_drop_constraint.sql > drop_constraint.sql -U $USER -d project
psql -f src/generate_add_constraint.sql > add_constraint.sql -U $USER -d project
psql -f src/drop_constraint.sql -U $USER -d project
psql -f src/copy_tables.sql -U $USER -d project
psql -f src/add_constraint.sql -U $USER -d project