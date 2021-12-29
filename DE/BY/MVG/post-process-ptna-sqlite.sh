#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-csv -header"

# Bus O7 has only 2 Stops, that's OK

sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_number_of_stops='' WHERE trip_id LIKE '%-O7-%';"

# Bus 99 has only 2 Stops, that's OK

sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_number_of_stops='' WHERE trip_id LIKE '%-99-%';"
