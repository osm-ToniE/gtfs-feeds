#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS=""

# At least route_long_name="S7" and route_short_name="M07" (S7 of MVV) should be in the DB to make if valid

S7COUNT=$(sqlite3 $DB "SELECT COUNT(route_id) FROM routes WHERE route_long_name='S7' AND route_short_name='M07';")

if [ "$S7COUNT" -ne "1" ]
then
    echo "**********************************"
    echo
    echo " DB invalid, does not include S7 from MVV (and maybe others)"
    echo
    echo "**********************************"
    exit 1
fi

exit 0
