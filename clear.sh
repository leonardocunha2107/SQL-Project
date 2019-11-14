#!/bin/bash
psql -f src/drop_tables.sql -U $USER -d project