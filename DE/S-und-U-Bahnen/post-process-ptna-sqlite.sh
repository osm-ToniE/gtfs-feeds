#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-init /dev/null"

if [ -f "$DB" ]
then
    # At least route_long_name="S7" and route_short_name="M07" (S7 of MVV) should be in the DB to make if valid

    S7COUNT=$(sqlite3 $SQ_OPTIONS $DB "SELECT COUNT(route_id) FROM routes WHERE route_long_name='S7' AND route_short_name='M07';")

    if [ "$S7COUNT" -ne "1" ]
    then
        echo "**********************************"
        echo
        echo " DB incomplete, does not include S7 from MVV (and maybe others)"
        echo
        echo "**********************************"
        # rm -f "$DB"
        #exit 1
    fi

fi

exit 0
