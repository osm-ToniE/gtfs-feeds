#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-init /dev/null -batch -echo -csv -header"

#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-init /dev/null -batch -echo -csv -header"

if [ -f "$DB" ]
then
    echo "UPDATE routes SET route_type=109 WHERE route_type=0 AND route_id LIKE 'ddb-92-M%' AND route_short_name LIKE 'S%';" | sqlite3 $SQ_OPTIONS $DB

    # store this task's information in the 'comment' field of the table 'ptna'
    echo "UPDATE ptna SET comment='S-Bahnen wurde von \"Tram, Streetcar, Light rail\" auf \"Suburban Railway\" gesetzt';" | sqlite3 $SQ_OPTIONS $DB
fi
