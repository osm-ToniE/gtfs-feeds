#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-init /dev/null -batch -echo -csv -header"

if [ -f "$DB" ]
then
    echo "UPDATE routes SET route_type=9999 WHERE route_type=109 AND route_short_name LIKE 'S%';" | sqlite3 $SQ_OPTIONS $DB

    echo "UPDATE routes SET route_type=402 WHERE route_type=400 AND route_short_name LIKE 'U%';"  | sqlite3 $SQ_OPTIONS $DB

    # store this task's information in the 'comment' field of the table 'ptna'
    echo "UPDATE ptna SET comment='S-Bahnen wurde gemäß lokalem Mapping auf \"light_rail\" gesetzt. U-Bahnen wurden auf \"subway\" korrigiert.';" | sqlite3 $SQ_OPTIONS $DB
fi
