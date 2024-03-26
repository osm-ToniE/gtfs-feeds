#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-init /dev/null"

# Bus O7 has only 2 Stops, that's OK

sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_number_of_stops='' WHERE trip_id LIKE '%-O7-%';"

# Bus 99 has only 2 Stops, that's OK

sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_number_of_stops='' WHERE trip_id LIKE '%-99-%';"

# Bus N71 starts in GTFS with 2 times "Westfriedhof", that's OK, so deletion of comment in DB

sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_start='' WHERE trip_id IN (SELECT trip_id FROM stop_times JOIN stops ON stops.stop_id=stop_times.stop_id WHERE trip_id LIKE '%-N71-%' AND stop_name='Westfriedhof' AND stop_sequence=1);"
