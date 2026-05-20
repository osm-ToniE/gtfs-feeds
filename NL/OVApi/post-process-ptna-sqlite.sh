#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-init /dev/null -batch -echo -csv -header"

if [ -f "$DB" ]
then

    sqlite3 $SQ_OPTIONS $DB "UPDATE routes SET route_type=9999 WHERE route_type=0 AND routes.agency_id IN (SELECT agency_id FROM agency WHERE agency_name='U-OV');"

    # store this task's information in the 'comment' field of the table 'ptna'
    sqlite3 $SQ_OPTIONS $DB "UPDATE ptna SET comment='Set \"tram\" of agency_name=\"U-OV\" to \"light_rail\"';"
fi
